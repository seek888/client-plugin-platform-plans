# Flutter 功能复用与多团队接入规范

## 1. 背景与目标

除了运行时插件化之外，客户端还需要解决另一个问题：不同项目之间如何复用组件、页面、业务功能和能力模块。

当前客户端主要使用 Flutter，并采用 feature-first 的设计方式。feature-first 有利于按业务能力组织代码，但如果 feature 只存在于单个 App 的 `lib/features` 目录中，它仍然只是项目内部目录，不能天然支持跨项目复用。

因此需要把 feature-first 进一步升级为：

```text
Feature-first + Package-first + Contract-first
```

也就是：

- 每个可复用功能是一个独立 Flutter/Dart package。
- 每个功能只通过明确的公共 API 对外暴露。
- 功能之间通过 contract/interface 通信，而不是直接互相依赖。
- 宿主 App 负责组合、注册、依赖注入、路由挂载、权限控制和版本约束。

建设目标：

- 一个团队开发的功能可以快速接入另一个 App。
- 多团队并行开发时避免命名冲突、路由冲突、资源冲突、依赖冲突和状态冲突。
- 功能模块接入宿主时有统一标准和验收流程。
- 组件复用、页面复用、业务逻辑复用、Native 能力复用都能有清晰边界。
- 为后续 PC 端插件平台、移动端平台化能力提供统一工程基础。

---

## 2. 复用类型划分

Flutter 工程内的复用能力建议分为五类。

### 2.1 Design System 复用

Design System 是所有 App 和 Feature 的 UI 基础。

包括：

- 颜色。
- 字体。
- 间距。
- 图标。
- 按钮。
- 输入框。
- 表单组件。
- 弹窗。
- 列表。
- 空状态。
- 加载状态。
- 错误状态。
- 页面布局模板。

建议包名：

```text
company_design_system
```

所有业务 Feature 必须优先使用 Design System，不允许随意定义私有颜色、字号、按钮样式和通用交互模式。

### 2.2 Core Capability 复用

Core Capability 是跨业务共享的基础能力。

建议拆分：

```text
company_auth
company_network
company_router
company_permission
company_storage
company_telemetry
company_config
company_logger
company_i18n
company_platform_bridge
```

这些包不承载具体业务页面，只提供底层能力、接口定义和平台约束。

### 2.3 Feature Package 复用

Feature Package 是业务功能模块。

示例：

```text
approval_feature
contacts_feature
message_feature
calendar_feature
document_feature
meeting_feature
```

每个 Feature Package 应该可以被多个 App 引入，宿主只需要注入依赖并注册模块。

### 2.4 Contract Package 复用

当两个 Feature 需要协作时，不建议直接互相依赖。

不推荐：

```text
approval_feature -> contacts_feature
```

推荐：

```text
approval_feature -> contacts_contract
contacts_feature -> contacts_contract
```

Contract Package 只包含：

- 接口。
- DTO。
- 枚举。
- 事件定义。
- 路由参数定义。

不包含：

- 页面。
- 业务实现。
- HTTP 请求实现。
- 本地存储实现。

### 2.5 Platform Plugin 复用

Platform Plugin 是对 Native 能力的封装。

示例：

```text
company_clipboard_plugin
company_file_picker_plugin
company_notification_plugin
company_window_plugin
company_device_plugin
```

业务 Feature 不应直接写平台通道。Native 能力由平台插件统一封装，再通过 core capability 或宿主依赖注入给 Feature 使用。

---

## 3. 推荐工程结构

### 3.1 Monorepo 结构

建议使用 monorepo 管理多 App、多 package。

```text
workspace/
├─ apps/
│  ├─ office_mobile_app/
│  ├─ office_pc_app/
│  └─ crm_mobile_app/
├─ packages/
│  ├─ core/
│  │  ├─ company_auth/
│  │  ├─ company_network/
│  │  ├─ company_router/
│  │  ├─ company_permission/
│  │  ├─ company_storage/
│  │  └─ company_telemetry/
│  ├─ ui/
│  │  └─ company_design_system/
│  ├─ contracts/
│  │  ├─ contacts_contract/
│  │  └─ approval_contract/
│  ├─ features/
│  │  ├─ approval_feature/
│  │  ├─ contacts_feature/
│  │  └─ message_feature/
│  └─ platform/
│     ├─ company_notification_plugin/
│     └─ company_file_picker_plugin/
├─ tools/
│  ├─ feature_scaffold/
│  ├─ dependency_check/
│  └─ manifest_validator/
└─ docs/
```

### 3.2 单个 Feature Package 结构

```text
approval_feature/
├─ lib/
│  ├─ approval_feature.dart
│  └─ src/
│     ├─ approval_feature_module.dart
│     ├─ approval_feature_config.dart
│     ├─ approval_dependencies.dart
│     ├─ presentation/
│     │  ├─ pages/
│     │  ├─ widgets/
│     │  └─ view_models/
│     ├─ domain/
│     │  ├─ models/
│     │  ├─ use_cases/
│     │  └─ repositories/
│     ├─ data/
│     │  ├─ services/
│     │  ├─ repositories/
│     │  └─ mappers/
│     ├─ routing/
│     ├─ permissions/
│     ├─ telemetry/
│     └─ assets/
├─ test/
├─ example/
├─ pubspec.yaml
├─ analysis_options.yaml
└─ README.md
```

### 3.3 公共入口规范

每个 package 只能通过根入口导出公共 API。

```dart
// lib/approval_feature.dart
export 'src/approval_feature_module.dart';
export 'src/approval_feature_config.dart';
export 'src/approval_dependencies.dart';
export 'src/routing/approval_routes.dart';
```

其他 App 或 Feature 禁止直接引用：

```dart
import 'package:approval_feature/src/presentation/pages/approval_page.dart';
```

原因：

- `src` 是内部实现。
- 直接 import 内部文件会破坏模块边界。
- 后续重构会影响其他项目。

---

## 4. 命名规范

多团队接入同一个宿主时，命名规范是避免冲突的基础。

### 4.1 Package 命名

建议使用统一前缀。

```text
company_<domain>_<type>
```

示例：

```text
company_approval_feature
company_approval_contract
company_contacts_feature
company_contacts_contract
company_design_system
company_network
company_router
```

规则：

- package 名称使用小写加下划线。
- 不使用缩写，除非是公司内统一术语。
- Feature 包以 `_feature` 结尾。
- Contract 包以 `_contract` 结尾。
- 平台插件包以 `_plugin` 结尾。
- Core 能力包不使用业务名称。

### 4.2 Dart 类型命名

所有 Feature 对外类型必须带业务前缀。

推荐：

```dart
ApprovalFeatureModule
ApprovalFeatureConfig
ApprovalDependencies
ApprovalRouteNames
ApprovalPermissionKeys
ApprovalTelemetryEvents
```

不推荐：

```dart
FeatureModule
Config
Dependencies
RouteNames
PermissionKeys
```

原因：

- 多个 Feature 同时接入时容易冲突。
- IDE 自动导入容易导错。
- 日志和错误堆栈不容易定位来源。

### 4.3 路由命名

路由必须带 feature 前缀。

推荐：

```text
/approval
/approval/detail
/approval/create
/contacts
/contacts/profile
```

不推荐：

```text
/detail
/create
/profile
```

路由 name 也必须带命名空间：

```dart
class ApprovalRouteNames {
  static const home = 'approval.home';
  static const detail = 'approval.detail';
  static const create = 'approval.create';
}
```

### 4.4 权限命名

权限采用点分命名。

```text
<domain>.<resource>.<action>
```

示例：

```text
approval.order.read
approval.order.write
approval.order.approve
contacts.user.read
message.chat.send
```

不推荐：

```text
read
write
approve
```

### 4.5 埋点命名

埋点事件采用点分命名。

```text
<feature>.<page>.<action>
```

示例：

```text
approval.list.open
approval.detail.approve_click
approval.create.submit_success
```

每个 Feature 需要提供自己的埋点事件清单。

### 4.6 资源命名

图片、字体、JSON、动画等资源必须带业务前缀。

推荐：

```text
assets/approval/icons/approval_empty.png
assets/approval/lottie/approval_loading.json
```

不推荐：

```text
assets/icons/empty.png
assets/loading.json
```

### 4.7 本地存储 Key 命名

本地存储必须带命名空间。

```text
approval.cache.todo_list
approval.preference.default_tab
contacts.cache.recent_users
```

禁止使用：

```text
token
user
config
cache
```

---

## 5. 模块边界规范

### 5.1 Feature 禁止依赖宿主 App

Feature Package 不能 import 具体 App。

禁止：

```dart
import 'package:office_mobile_app/app_config.dart';
import 'package:office_mobile_app/global_user.dart';
```

推荐通过依赖注入：

```dart
class ApprovalDependencies {
  final AuthProvider auth;
  final AppHttpClient httpClient;
  final AppRouter router;
  final Telemetry telemetry;
  final PermissionChecker permissionChecker;

  const ApprovalDependencies({
    required this.auth,
    required this.httpClient,
    required this.router,
    required this.telemetry,
    required this.permissionChecker,
  });
}
```

### 5.2 Feature 之间禁止直接依赖实现

禁止：

```text
approval_feature -> contacts_feature
```

推荐：

```text
approval_feature -> contacts_contract
contacts_feature -> contacts_contract
```

示例：

```dart
abstract interface class ContactsResolver {
  Future<ContactUser?> getUserById(String userId);
  Future<List<ContactUser>> searchUsers(String keyword);
}
```

宿主 App 负责绑定实现：

```dart
featureRegistry.registerContract<ContactsResolver>(
  ContactsResolverImpl(),
);
```

### 5.3 Feature 内部分层

Feature 内部仍然遵循分层架构：

```text
presentation -> domain -> data
```

规则：

- Widget 不直接调用 HTTP。
- Widget 不直接读写本地数据库。
- ViewModel 负责 UI 状态，不负责底层 API 细节。
- Repository 是业务数据入口。
- Service 只封装外部 API 或平台能力。
- Domain Model 不依赖 Flutter UI。

---

## 6. Feature Module 接入标准

### 6.1 统一模块接口

每个 Feature Package 必须提供一个模块类。

```dart
abstract interface class AppFeatureModule {
  String get id;
  String get name;
  String get version;

  List<AppRouteDefinition> get routes;
  List<AppMenuContribution> get menus;
  List<AppPermissionDefinition> get permissions;
  List<AppTelemetryDefinition> get telemetryEvents;

  Future<void> initialize();
  Future<void> dispose();
}
```

Feature 实现：

```dart
class ApprovalFeatureModule implements AppFeatureModule {
  final ApprovalFeatureConfig config;
  final ApprovalDependencies dependencies;

  ApprovalFeatureModule({
    required this.config,
    required this.dependencies,
  });

  @override
  String get id => 'approval';

  @override
  String get name => '审批';

  @override
  String get version => '1.0.0';

  @override
  List<AppRouteDefinition> get routes => ApprovalRoutes.all;

  @override
  List<AppMenuContribution> get menus => ApprovalMenus.all;

  @override
  List<AppPermissionDefinition> get permissions => ApprovalPermissions.all;

  @override
  List<AppTelemetryDefinition> get telemetryEvents => ApprovalTelemetryEvents.all;

  @override
  Future<void> initialize() async {}

  @override
  Future<void> dispose() async {}
}
```

### 6.2 宿主注册方式

宿主 App 统一注册 Feature。

```dart
featureRegistry.register(
  ApprovalFeatureModule(
    config: ApprovalFeatureConfig(
      enableCreate: true,
      enableBatchApprove: false,
    ),
    dependencies: ApprovalDependencies(
      auth: appAuth,
      httpClient: appHttpClient,
      router: appRouter,
      telemetry: appTelemetry,
      permissionChecker: appPermissionChecker,
    ),
  ),
);
```

宿主负责：

- 注入依赖。
- 注册路由。
- 注册菜单。
- 注册权限。
- 注册埋点。
- 执行初始化。
- 管理生命周期。
- 处理版本兼容。

### 6.3 Feature 配置

Feature 差异通过配置表达，不通过修改源码表达。

```dart
class ApprovalFeatureConfig {
  final bool enableCreate;
  final bool enableBatchApprove;
  final String defaultTab;
  final bool enableOfflineCache;

  const ApprovalFeatureConfig({
    this.enableCreate = true,
    this.enableBatchApprove = false,
    this.defaultTab = 'todo',
    this.enableOfflineCache = true,
  });
}
```

配置原则：

- 配置项必须有默认值。
- 配置项必须向后兼容。
- 不同 App 的差异优先通过配置解决。
- 不要用 `if (appName == 'xxx')` 判断宿主。

---

## 7. 依赖管理规范

不同团队使用的库不一样，是多 Feature 接入时最常见的冲突来源。

### 7.1 依赖分级

依赖分为三类。

#### 7.1.1 平台统一依赖

由平台统一选型和版本。

示例：

```text
state management
http client
router
logging
telemetry
storage
i18n
code generation
design system
```

Feature 应优先使用平台统一依赖，不自行引入替代库。

#### 7.1.2 Feature 私有依赖

Feature 可以引入，但必须满足：

- 不影响全局运行时。
- 不改变宿主行为。
- 不引入重复基础能力。
- 不引入高风险 Native 权限。
- 版本约束明确。

示例：

```text
date formatting utility
chart widget
markdown renderer
pdf preview component
```

#### 7.1.3 禁止私自引入的依赖

以下依赖必须平台评审：

- 状态管理框架。
- 路由框架。
- 网络库。
- 本地数据库。
- 加密库。
- 权限库。
- Native 插件。
- WebView 插件。
- 全局错误捕获库。
- 热更新或动态代码相关库。

### 7.2 版本约束

推荐：

```yaml
dependencies:
  company_network: ^1.2.0
  company_design_system: ^2.1.0
```

不推荐：

```yaml
dependencies:
  dio: any
  provider: any
```

规则：

- 禁止使用 `any`。
- 禁止随意使用 git 分支依赖。
- 破坏性升级必须发 major 版本。
- 宿主 App 需要锁定 `pubspec.lock`。
- 公共 package 必须声明清晰的版本范围。

### 7.3 依赖冲突处理

当两个 Feature 依赖不同版本时，处理顺序：

1. 优先升级到统一兼容版本。
2. 如果是平台统一依赖，由平台团队裁决。
3. 如果是私有依赖，Feature 团队负责适配。
4. 如果无法兼容，不允许接入宿主主线。

### 7.4 Native 插件依赖

Feature 不能直接引入新的 Native 插件并接入宿主。

必须流程：

```text
Feature 团队提出 Native 能力需求
→ 平台团队评审
→ 封装为 company_xxx_plugin
→ 加入权限模型
→ 接入宿主
→ Feature 通过依赖注入使用
```

---

## 8. 状态管理与生命周期规范

### 8.1 状态边界

Feature 只能管理自己的业务状态。

禁止：

- 修改宿主全局状态。
- 直接操作其他 Feature 的状态。
- 依赖全局静态变量保存业务状态。
- 在 Widget 中写业务全局单例。

推荐：

- Feature 内部维护 ViewModel/Controller。
- 跨 Feature 状态通过 Contract 或事件总线。
- 用户、组织、权限等全局状态由 Core Package 提供。

### 8.2 生命周期

Feature 必须支持：

- `initialize`
- `dispose`
- 页面进入。
- 页面退出。
- 登录态变化。
- 权限变化。
- 网络变化。

长期任务必须能取消。

示例：

```dart
abstract interface class FeatureLifecycle {
  Future<void> initialize();
  Future<void> onUserChanged();
  Future<void> onPermissionChanged();
  Future<void> dispose();
}
```

### 8.3 事件总线

如果需要事件通信，事件名称必须带命名空间。

```text
approval.order.created
approval.order.approved
contacts.user.updated
```

事件 payload 必须有类型定义，不允许传任意 Map。

---

## 9. 路由、菜单与权限注册规范

### 9.1 路由注册

Feature 不直接操作宿主路由表，而是声明路由贡献。

```dart
class ApprovalRoutes {
  static const home = AppRouteDefinition(
    name: 'approval.home',
    path: '/approval',
  );

  static const detail = AppRouteDefinition(
    name: 'approval.detail',
    path: '/approval/detail',
  );
}
```

宿主注册时检查：

- path 是否冲突。
- name 是否冲突。
- 参数是否符合规范。
- 是否有权限要求。

### 9.2 菜单注册

Feature 通过菜单贡献点声明入口。

```dart
class ApprovalMenus {
  static const workspace = AppMenuContribution(
    id: 'approval.workspace',
    title: '审批',
    routeName: 'approval.home',
    location: 'workspace.grid',
    permission: 'approval.order.read',
  );
}
```

菜单规则：

- `id` 必须全局唯一。
- 必须带 feature 前缀。
- 必须声明位置。
- 必须声明路由或动作。
- 涉及业务数据必须声明权限。

### 9.3 权限注册

Feature 必须声明自己需要的权限。

```dart
class ApprovalPermissions {
  static const read = AppPermissionDefinition(
    key: 'approval.order.read',
    description: '查看审批单',
  );

  static const approve = AppPermissionDefinition(
    key: 'approval.order.approve',
    description: '处理审批单',
  );
}
```

宿主负责：

- 校验权限命名。
- 根据用户权限决定入口可见性。
- 在运行时检查能力调用。
- 记录权限审计日志。

---

## 10. 资源、国际化与主题规范

### 10.1 资源规范

Feature 资源必须在自己的 package 内。

```yaml
flutter:
  assets:
    - assets/approval/icons/
    - assets/approval/images/
    - assets/approval/lottie/
```

资源命名必须带 feature 前缀。

### 10.2 国际化规范

Feature 不直接写死大量业务文案。

建议：

- 公共文案由宿主或 `company_i18n` 提供。
- Feature 自己维护业务文案 key。
- 文案 key 带命名空间。

示例：

```text
approval.title
approval.action.submit
approval.error.network_failed
```

### 10.3 主题规范

Feature 必须使用 Design System Token。

禁止：

```dart
Color(0xFF1677FF)
TextStyle(fontSize: 17)
```

推荐：

```dart
CompanyTheme.of(context).colors.primary
CompanyTheme.of(context).typography.bodyMedium
```

---

## 11. 网络、缓存与数据规范

### 11.1 网络规范

Feature 不直接创建网络客户端。

禁止：

```dart
final dio = Dio();
```

推荐：

```dart
final response = await dependencies.httpClient.get('/approval/orders');
```

原因：

- 统一鉴权。
- 统一日志。
- 统一超时。
- 统一重试。
- 统一错误处理。
- 统一接口耗时监控。

### 11.2 缓存规范

缓存 key 必须带 feature 命名空间。

```text
approval.todo_list.v1
approval.detail.<id>.v1
```

缓存必须声明：

- key。
- 数据结构版本。
- 过期时间。
- 清理策略。
- 登录态变化后的处理策略。

### 11.3 数据模型规范

建议：

- API DTO 与 Domain Model 分开。
- DTO 只在 data 层使用。
- UI 使用 ViewState，不直接使用 API DTO。
- 对外 Contract 使用稳定 DTO。

---

## 12. 测试与验收规范

### 12.1 Feature Package 必须包含的测试

最低要求：

- Domain Model 测试。
- Use Case 测试。
- Repository 测试。
- ViewModel 测试。
- 关键 Widget 测试。
- 路由注册测试。
- 权限声明测试。

### 12.2 Example App

每个 Feature Package 必须提供 `example/`。

作用：

- 独立开发。
- 独立调试。
- 演示接入方式。
- 验证依赖注入。
- 避免依赖具体宿主 App 才能运行。

### 12.3 接入验收清单

Feature 接入宿主前必须检查：

- package 命名符合规范。
- 公共 API 只从根入口导出。
- 没有 import 宿主 App。
- 没有直接依赖其他 Feature 实现。
- 路由无冲突。
- 菜单无冲突。
- 权限命名合规。
- 埋点命名合规。
- 资源命名合规。
- 没有私自引入禁止依赖。
- 没有使用 `any` 版本。
- 没有直接创建网络客户端。
- 没有未授权 Native 插件。
- 单元测试通过。
- example 可运行。
- 接入文档完整。

---

## 13. 开发、发布与版本规范

### 13.1 版本管理

所有 package 使用语义化版本：

```text
major.minor.patch
```

规则：

- `patch`：修复 bug，不改变 API。
- `minor`：新增兼容能力。
- `major`：破坏性变更。

破坏性变更必须提供：

- 变更说明。
- 迁移指南。
- 影响范围。
- 推荐升级窗口。

### 13.2 发布流程

```text
Feature 团队提交 MR
→ 自动执行 lint/test
→ 依赖检查
→ 命名冲突检查
→ 路由冲突检查
→ 权限检查
→ 平台团队评审
→ 发布 package 版本
→ 宿主 App 升级依赖
→ 集成测试
→ 灰度发布
```

### 13.3 文档要求

每个 Feature Package 必须有 README。

README 至少包含：

- 功能说明。
- 接入方式。
- 依赖说明。
- 配置项说明。
- 路由清单。
- 权限清单。
- 埋点清单。
- 资源说明。
- 版本兼容说明。
- example 运行方式。

---

## 14. 多团队协作治理

### 14.1 平台团队职责

平台团队负责：

- 制定工程规范。
- 维护 Design System。
- 维护 Core Packages。
- 维护 Feature Registry。
- 维护依赖版本基线。
- 评审高风险依赖。
- 评审 Native 插件。
- 提供脚手架和校验工具。
- 维护宿主 App 接入机制。

### 14.2 业务团队职责

业务团队负责：

- 按规范开发 Feature Package。
- 提供清晰公共 API。
- 提供 example。
- 提供测试。
- 提供接入文档。
- 声明权限、路由、菜单、埋点。
- 遵守依赖约束。

### 14.3 冲突处理机制

常见冲突及处理：

| 冲突类型 | 处理方式 |
|---|---|
| package 命名冲突 | 平台团队维护命名注册表 |
| 路由冲突 | 宿主注册时自动检测 |
| 菜单冲突 | 菜单 id 必须全局唯一 |
| 权限冲突 | 权限中心统一注册 |
| 依赖版本冲突 | 依赖基线统一裁决 |
| Native 插件冲突 | 平台团队统一封装 |
| 资源命名冲突 | package 内命名空间隔离 |
| 状态冲突 | 禁止跨 Feature 直接访问状态 |

---

## 15. 和运行时插件化的关系

工程级功能复用和运行时插件化不是同一件事。

| 类型 | 运行方式 | 适用场景 |
|---|---|---|
| Feature Package | 编译期引入 | 多 App 复用业务功能 |
| Design System Package | 编译期引入 | 多 App 复用 UI 体系 |
| Core Package | 编译期引入 | 多 App 复用基础能力 |
| PC Runtime Plugin | 运行时安装/启动 | PC 插件生态 |
| Mobile Server-driven UI | 远程配置/Schema | 移动端合规动态扩展 |

建议关系：

- App 内部核心功能优先做成 Feature Package。
- 多 App 复用功能优先走 Feature Package。
- PC 端需要运行时扩展时，再建设 Runtime Plugin。
- 移动端需要动态能力时，走 Schema 和远端插件服务。

---

## 16. 推荐落地路线

### 第一阶段：建立基础包和规范

- 建立 `company_design_system`。
- 建立 `company_auth`、`company_network`、`company_router`、`company_permission`、`company_telemetry`。
- 制定 package 命名、路由、权限、埋点、资源规范。
- 建立依赖版本基线。

### 第二阶段：建立 Feature Module 机制

- 定义 `AppFeatureModule`。
- 定义 Feature Registry。
- 定义路由贡献点。
- 定义菜单贡献点。
- 定义权限贡献点。
- 定义 Feature Config 和 Dependencies。

### 第三阶段：改造存量功能

- 选择一个低风险功能试点。
- 从 App 内 `lib/features` 拆为 package。
- 提供 example。
- 接入宿主 App。
- 验证路由、权限、依赖和性能。

### 第四阶段：多团队推广

- 提供 feature 脚手架。
- 提供自动校验工具。
- 建立发布流程。
- 建立接入验收清单。
- 建立平台评审机制。

### 第五阶段：与插件平台打通

- Feature Module 的 manifest 与 PC 插件 manifest 对齐。
- 公共能力桥与运行时插件能力桥对齐。
- 菜单、命令、权限、埋点使用同一套抽象。
- PC 端运行时插件和编译期 Feature Package 共享平台规范。

---

## 17. 推荐结论

Flutter 多项目功能复用的主路线应该是：

```text
Feature-first
+ Package-first
+ Contract-first
+ Design System
+ Core Capability
+ Feature Registry
+ 统一命名与依赖规范
```

最终效果：

- 功能像插件一样接入宿主。
- 运行方式仍是 Flutter package 编译期复用。
- 多团队可以独立开发。
- 宿主 App 可以统一管理路由、菜单、权限、埋点和生命周期。
- 通过规范避免命名、资源、依赖、状态和 Native 能力冲突。
