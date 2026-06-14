import 'package:core/core.dart';

/// 能力注册表实现
///
/// 管理所有已注册的宿主能力
class CapabilityRegistryImpl implements CapabilityRegistry {
  final Map<String, Capability> _capabilities = {};

  @override
  void register(Capability capability) {
    _capabilities[capability.id] = capability;
  }

  @override
  void unregister(String capabilityId) {
    _capabilities.remove(capabilityId);
  }

  @override
  Capability? get(String capabilityId) => _capabilities[capabilityId];

  @override
  bool has(String capabilityId) => _capabilities.containsKey(capabilityId);

  @override
  List<Capability> getAll() => _capabilities.values.toList();

  @override
  void clear() {
    _capabilities.clear();
  }
}
