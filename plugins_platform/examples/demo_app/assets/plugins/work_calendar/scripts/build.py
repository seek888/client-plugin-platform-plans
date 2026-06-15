#!/usr/bin/env python3
from __future__ import annotations

import argparse
import hashlib
import json
import re
from pathlib import Path


ROOT = Path(__file__).resolve().parent.parent
ENTRY = "src/index.js"
ENTRY_FILE = ROOT / ENTRY
BUNDLE_FILE = ROOT / "dist" / "bundle.js"
MANIFEST_FILE = ROOT / "manifest.json"

RUNTIME_EXPORTS = [
    "onActivate",
    "onDeactivate",
    "renderPage",
    "renderCard",
    "handleApprovalAction",
    "handleChangeReminderMinutes",
    "handleCreateEvent",
    "handleDateClick",
    "handleDeleteEvent",
    "handleEditorChange",
    "handleEventDetail",
    "handleFilter",
    "handleGoToday",
    "handleNextMonth",
    "handlePickContacts",
    "handlePreviousMonth",
    "handleSaveEvent",
    "handleSwitchModule",
    "handleTaskAction",
    "handleToggleReminder",
    "handleToggleRepeat",
    "handleToggleLocale",
]

IMPORT_RE = re.compile(
    r"^\s*import\s+\{(?P<names>[^}]+)\}\s+from\s+['\"](?P<path>[^'\"]+)['\"];\s*$",
    re.MULTILINE,
)
EXPORT_DECL_RE = re.compile(
    r"^\s*export\s+(?P<kind>const|let|var|function)\s+(?P<name>[A-Za-z_$][A-Za-z0-9_$]*)",
    re.MULTILINE,
)
EXPORT_LIST_RE = re.compile(
    r"^\s*export\s*\{(?P<names>[^}]+)\}\s*(?:from\s+['\"](?P<path>[^'\"]+)['\"])?;?\s*$",
    re.MULTILINE,
)


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Build work_calendar/src into dist/bundle.js without npm.",
    )
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()

    modules = collect_modules(ENTRY_FILE)
    bundle = render_bundle(modules)
    manifest = render_manifest(bundle)

    if args.check:
        current_bundle = BUNDLE_FILE.read_text(encoding="utf-8") if BUNDLE_FILE.exists() else ""
        current_manifest = MANIFEST_FILE.read_text(encoding="utf-8") if MANIFEST_FILE.exists() else ""
        if current_bundle != bundle or current_manifest != manifest:
            print("work_calendar bundle is out of date. Run scripts/build.py")
            return 1
        return 0

    BUNDLE_FILE.parent.mkdir(parents=True, exist_ok=True)
    BUNDLE_FILE.write_text(bundle, encoding="utf-8")
    MANIFEST_FILE.write_text(manifest, encoding="utf-8")
    print(
        f"Built {BUNDLE_FILE.relative_to(ROOT)} "
        f"({len(bundle.encode('utf-8'))} bytes, sha256 {sha256(bundle)})"
    )
    return 0


def collect_modules(entry_file: Path) -> dict[str, str]:
    modules: dict[str, str] = {}
    visiting: set[str] = set()

    def visit(file_path: Path) -> None:
        module_id = module_id_for(file_path)
        if module_id in modules:
            return
        if module_id in visiting:
            raise RuntimeError(f"Circular import is not supported: {module_id}")
        visiting.add(module_id)

        source = file_path.read_text(encoding="utf-8")
        for dependency in imports_for(file_path, source):
            visit(dependency)

        modules[module_id] = transform_module(file_path, source)
        visiting.remove(module_id)

    visit(entry_file)
    return modules


def imports_for(file_path: Path, source: str) -> list[Path]:
    dependencies: list[Path] = []
    for match in IMPORT_RE.finditer(source):
        dependencies.append(resolve_import(file_path, match.group("path")))
    for match in EXPORT_LIST_RE.finditer(source):
        export_path = match.group("path")
        if export_path:
            dependencies.append(resolve_import(file_path, export_path))
    return dependencies


def transform_module(file_path: Path, source: str) -> str:
    export_names: list[str] = []

    def import_replacement(match: re.Match[str]) -> str:
        target = module_id_for(resolve_import(file_path, match.group("path")))
        bindings = import_bindings(match.group("names"))
        return f"const {{ {bindings} }} = require({json.dumps(target)});"

    def export_decl_replacement(match: re.Match[str]) -> str:
        export_names.append(match.group("name"))
        return f"{match.group('kind')} {match.group('name')}"

    def export_list_replacement(match: re.Match[str]) -> str:
        names = exported_names(match.group("names"))
        if match.group("path"):
            target = module_id_for(resolve_import(file_path, match.group("path")))
            bindings = ", ".join(names)
            return (
                f"const {{ {bindings} }} = require({json.dumps(target)});\n"
                + "\n".join(f"exports[{json.dumps(name)}] = {name};" for name in names)
            )
        return "\n".join(f"exports[{json.dumps(name)}] = {name};" for name in names)

    transformed = IMPORT_RE.sub(import_replacement, source)
    transformed = EXPORT_DECL_RE.sub(export_decl_replacement, transformed)
    transformed = EXPORT_LIST_RE.sub(export_list_replacement, transformed)

    if export_names:
        transformed += "\n"
        transformed += "\n".join(
            f"exports[{json.dumps(name)}] = {name};" for name in export_names
        )

    return transformed.strip()


def render_bundle(modules: dict[str, str]) -> str:
    lines = [
        "// Work calendar plugin runtime bundle.",
        "// Generated from src/*. Do not edit this file by hand.",
        "(function(globalThis) {",
        "  const modules = {};",
        "  const cache = {};",
        "  function define(id, factory) { modules[id] = factory; }",
        "  function require(id) {",
        "    if (cache[id]) return cache[id].exports;",
        "    if (!modules[id]) throw new Error('Module not found: ' + id);",
        "    const module = { exports: {} };",
        "    cache[id] = module;",
        "    modules[id](module, module.exports, require);",
        "    return module.exports;",
        "  }",
        "",
    ]

    for module_id, source in modules.items():
        lines.append(f"  define({json.dumps(module_id)}, function(module, exports, require) {{")
        for source_line in source.splitlines():
            lines.append(f"    {source_line}")
        lines.append("  });")
        lines.append("")

    lines.extend(
        [
            f"  const entry = require({json.dumps(ENTRY)});",
            f"  for (const name of {json.dumps(RUNTIME_EXPORTS)}) {{",
            "    if (typeof entry[name] === 'function') {",
            "      globalThis[name] = entry[name];",
            "    }",
            "  }",
            "})(globalThis);",
            "",
        ]
    )
    return "\n".join(lines)


def render_manifest(bundle: str) -> str:
    manifest = json.loads(MANIFEST_FILE.read_text(encoding="utf-8"))
    manifest.setdefault("engine", {})
    manifest["engine"]["bundle"] = "dist/bundle.js"
    manifest["engine"]["bundleSize"] = len(bundle.encode("utf-8"))
    manifest["engine"]["bundleHash"] = sha256(bundle)
    return json.dumps(manifest, ensure_ascii=False, indent=2) + "\n"


def resolve_import(from_file: Path, import_path: str) -> Path:
    resolved = (from_file.parent / import_path).resolve()
    if resolved.suffix == "":
        resolved = resolved.with_suffix(".js")
    if not resolved.exists():
        raise FileNotFoundError(f"Cannot resolve {import_path} from {from_file}")
    return resolved


def module_id_for(file_path: Path) -> str:
    return str(file_path.resolve().relative_to(ROOT).as_posix())


def import_bindings(raw: str) -> str:
    parts = []
    for name in exported_names(raw):
        if " as " in name:
            left, right = [item.strip() for item in name.split(" as ", 1)]
            parts.append(f"{left}: {right}")
        else:
            parts.append(name)
    return ", ".join(parts)


def exported_names(raw: str) -> list[str]:
    return [
        item.strip()
        for item in raw.replace("\n", " ").split(",")
        if item.strip()
    ]


def sha256(value: str) -> str:
    return hashlib.sha256(value.encode("utf-8")).hexdigest()


if __name__ == "__main__":
    raise SystemExit(main())
