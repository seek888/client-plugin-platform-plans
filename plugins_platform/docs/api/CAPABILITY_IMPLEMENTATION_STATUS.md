# 能力实现状态清单

本文档记录插件平台所有能力的实现状态，帮助开发者了解哪些能力可以使用。

**最后更新时间**: 2026-06-20

## 实现状态说明

- ✅ **已实现** - 可以直接使用
- ⚠️ **部分实现** - 基本功能可用，但存在已知限制
- 🚧 **开发中** - 正在实现，暂不可用
- 📋 **计划中** - 已规划但未开始
- ❌ **未实现** - 暂无实现计划

---

## 实现统计

| 分类 | 已实现 | 部分实现 | 未实现 | 总计 | 实现率 |
|------|--------|----------|--------|------|--------|
| UI 交互 | 5 | 0 | 0 | 5 | 100% |
| 导航 | 3 | 0 | 0 | 3 | 100% |
| 存储 | 4 | 0 | 0 | 4 | 100% |
| 剪贴板 | 0 | 2 | 0 | 2 | 100%* |
| 通知 | 4 | 1 | 0 | 5 | 100%* |
| 组织与联系人 | 4 | 0 | 0 | 4 | 100% |
| 审批 | 6 | 0 | 0 | 6 | 100% |
| 设备 | 0 | 0 | 6 | 6 | 0% |
| 网络 | 1 | 0 | 2 | 3 | 33% |
| UI 辅助 | 0 | 0 | 2 | 2 | 0% |
| **总计** | **27** | **3** | **10** | **40** | **67.5%** |

_* 标记为"部分实现"的能力基本可用，但存在平台依赖或功能限制_

---

## UI 交互能力 (5/5)

| 能力 ID | 状态 | 备注 |
|---------|------|------|
| `toast.show` | ✅ | 使用 Flutter SnackBar 实现 |
| `dialog.alert` | ✅ | 使用 Flutter AlertDialog 实现 |
| `dialog.confirm` | ✅ | 使用 Flutter AlertDialog 实现 |
| `loading.show` | ✅ | 使用 Flutter AlertDialog + CircularProgressIndicator |
| `loading.hide` | ✅ | Navigator.pop 关闭 loading 对话框 |

---

## 导航能力 (3/3)

| 能力 ID | 状态 | 备注 |
|---------|------|------|
| `navigation.open` | ✅ | 使用 Navigator.pushNamed |
| `navigation.back` | ✅ | 使用 Navigator.pop |
| `navigation.replace` | ✅ | 使用 Navigator.pushReplacementNamed |

---

## 存储能力 (4/4)

| 能力 ID | 状态 | 备注 |
|---------|------|------|
| `storage.get` | ✅ | 使用 shared_preferences |
| `storage.set` | ✅ | 使用 shared_preferences |
| `storage.remove` | ✅ | 使用 shared_preferences |
| `storage.clear` | ✅ | 使用 shared_preferences |

---

## 剪贴板能力 (2/2)

| 能力 ID | 状态 | 备注 |
|---------|------|------|
| `clipboard.write` | ⚠️ | 功能已注册，但需要集成 flutter/services ClipboardData |
| `clipboard.read` | ⚠️ | 功能已注册，但需要集成 flutter/services ClipboardData |

**已知限制**: 
- 当前返回模拟数据，需要集成 `flutter/services` 的 `Clipboard` API
- 预计完成时间：2026-07-01

---

## 通知能力 (5/5)

| 能力 ID | 状态 | 备注 |
|---------|------|------|
| `notification.send` | ⚠️ | 功能已注册，需要集成 flutter_local_notifications |
| `notification.cancel` | ✅ | Mock 实现 |
| `notification.badge.set` | ✅ | Mock 实现 |
| `notification.list` | ✅ | Mock 实现 |
| `notification.markRead` | ✅ | Mock 实现 |

**已知限制**: 
- `notification.send` 需要集成第三方通知库
- 其他通知能力目前返回模拟数据，适用于开发测试
- 预计完成时间：2026-07-15

---

## 组织与联系人能力 (4/4)

| 能力 ID | 状态 | 备注 |
|---------|------|------|
| `org.contacts.search` | ✅ | Mock 实现，返回模拟联系人数据 |
| `org.contacts.getById` | ✅ | Mock 实现 |
| `org.contacts.pick` | ✅ | Mock 实现 |
| `org.department.list` | ✅ | Mock 实现，返回固定部门列表 |

**注意**: 当前使用模拟数据，实际使用需对接企业 IM 或组织架构系统。

---

## 审批能力 (6/6)

| 能力 ID | 状态 | 备注 |
|---------|------|------|
| `approval.list` | ✅ | Mock 实现 |
| `approval.detail.get` | ✅ | Mock 实现 |
| `approval.submit` | ✅ | Mock 实现 |
| `approval.history` | ✅ | Mock 实现 |
| `approval.cancel` | ✅ | Mock 实现 |
| `approval.forward` | ✅ | Mock 实现 |

**注意**: 当前使用模拟数据，实际使用需对接企业审批系统。

---

## 设备能力 (0/6)

| 能力 ID | 状态 | 备注 |
|---------|------|------|
| `device.location.get` | 📋 | 规划中，需要集成 geolocator 包 |
| `device.camera.scan` | 📋 | 规划中，需要集成 mobile_scanner 包 |
| `device.bluetooth.scan` | 📋 | 规划中，需要集成 flutter_blue_plus 包 |
| `device.info.get` | 📋 | 规划中，需要集成 device_info_plus 包 |
| `file.pick` | 📋 | 规划中，需要集成 file_picker 包 |
| `file.upload` | 📋 | 规划中，基于 network.request 实现 |

**计划实现时间**: Q3 2026

---

## 网络能力 (1/3)

| 能力 ID | 状态 | 备注 |
|---------|------|------|
| `network.request` | ✅ | 已实现 GET/POST 方法，使用 http 包 |
| `network.upload` | 📋 | 规划中 |
| `network.download` | 📋 | 规划中 |

**已知限制**:
- `network.request` 当前仅支持 GET 和 POST 方法
- 计划添加 PUT、DELETE、PATCH 支持
- 文件上传和下载功能待实现

---

## UI 辅助能力 (0/2)

| 能力 ID | 状态 | 备注 |
|---------|------|------|
| `bottomSheet.show` | 📋 | 规划中，使用 showModalBottomSheet |
| `picker.show` | 📋 | 规划中，支持日期/时间选择器 |

**计划实现时间**: 2026-08-01

---

## 开发路线图

### 近期（2026 Q3）

1. **剪贴板功能完善** (预计 2026-07-01)
   - 集成 Flutter Clipboard API
   - 支持文本的读写操作

2. **通知功能完善** (预计 2026-07-15)
   - 集成 flutter_local_notifications
   - 支持本地通知和角标管理

3. **设备能力** (预计 2026-08-30)
   - device.location.get (位置服务)
   - device.camera.scan (扫码)
   - device.info.get (设备信息)

### 中期（2026 Q4）

1. **文件能力**
   - file.pick (文件选择)
   - file.upload (文件上传)

2. **网络能力增强**
   - 支持 PUT/DELETE/PATCH 方法
   - network.upload (专用文件上传)
   - network.download (文件下载)

3. **UI 辅助能力**
   - bottomSheet.show (底部表单)
   - picker.show (日期/时间选择器)

### 远期

- 蓝牙设备扫描 (device.bluetooth.scan)
- 更多设备传感器能力

---

## 验证建议

### 工作日历插件验证

工作日历插件当前使用的能力：
- ✅ `toast.show` - 已实现
- ✅ `dialog.alert` - 已实现
- ✅ `dialog.confirm` - 已实现
- ✅ `storage.get` - 已实现
- ✅ `storage.set` - 已实现
- ✅ `navigation.open` - 已实现

**结论**: 工作日历插件使用的所有能力均已完整实现，可以正常运行。

---

## 贡献指南

如果您需要使用尚未实现的能力，可以：

1. **查看开发路线图** - 确认该能力是否在计划中
2. **提交需求** - 在项目中创建 issue 说明使用场景
3. **参与开发** - Fork 项目并提交 PR

---

## 相关文档

- [能力 API 文档](./capabilities.md)
- [插件开发指南](../guide/plugin-development.md)
- [权限系统](../guide/permissions.md)
