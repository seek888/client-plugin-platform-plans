# Flutter Plugin Development AI Skills

为 Claude Code 设计和实现的专门 AI Skills 技能包，让大模型能够高质量地生成 Flutter 插件平台的插件代码。

## 概述

本技能包包含 4 个专门的 Skills，覆盖插件开发的完整生命周期：

1. **Plugin Scaffolding Skill** - 快速生成插件脚手架
2. **STAC UI Development Skill** - 基于自然语言生成 STAC UI Schema
3. **Capability Integration Skill** - 辅助集成 Host Bridge 能力桥接 API
4. **Plugin Testing Skill** - 生成测试用例和调试代码

---

## 技术架构

### Flutter 插件平台架构

```text
Flutter 跨端宿主（Mobile + Desktop）
├─ JS 引擎运行时（QuickJS）
│  └─ 每个插件独立沙箱
├─ STAC Server-Driven UI
│  └─ 声明式渲染
├─ Host Bridge（能力桥）
│  └─ 权限受控的宿主能力
└─ Event Bus（事件总线）
   └─ 系统事件 + 业务事件
```

### 插件结构

```
your_plugin/
├── manifest.json           # 插件清单
├── i18n/                   # 国际化
├── scripts/                # 构建脚本
├── src/
│   ├── index.js            # 入口
│   ├── state/              # 状态管理
│   ├── services/           # 服务层（Host API 封装）
│   ├── controllers/        # 事件处理
│   ├── ui/                 # UI 层（STAC Schema）
│   │   ├── pages/
│   │   ├── cards/
│   │   └── components/
│   └── utils/              # 工具函数
└── dist/
    └── bundle.js           # 构建输出
```

---

## Skills 详细说明

### 1. Plugin Scaffolding Skill

**功能**：快速生成插件脚手架

**触发关键词**：
- create plugin
- new plugin
- plugin scaffold
- 创建插件
- 生成插件

**生成内容**：
- ✅ manifest.json（自动配置权限）
- ✅ 标准目录结构
- ✅ src/index.js 入口文件
- ✅ src/state/plugin_state.js 状态管理
- ✅ src/services/host_api.js 宿主能力封装
- ✅ src/controllers/handlers.js 事件处理
- ✅ src/ui/pages/main_page.js 页面模板
- ✅ src/ui/tokens.js UI Token
- ✅ i18n/zh-CN.json 国际化资源
- ✅ scripts/build.py 构建脚本

**示例**：
```
用户: "创建一个日历插件"
AI: 生成完整的插件脚手架，包含所有必要文件和基础代码
```

---

### 2. STAC UI Development Skill

**功能**：基于自然语言描述生成 STAC UI Schema

**触发关键词**：
- create ui
- generate ui
- stac schema
- 生成界面
- 设计页面

**能力**：
- ✅ 组件库查询和选择（20+ 组件）
- ✅ 根据需求生成布局
- ✅ UI 风格一致性检查
- ✅ 响应式布局生成
- ✅ 表单校验规则生成
- ✅ 事件绑定生成

**支持的组件**：
- **布局**: column, row, container, card, stack, expanded, sizedBox
- **基础**: text, image, icon, divider
- **表单**: textFormField, textarea, dropdown, checkbox, switch, slider
- **交互**: button, iconButton, fab
- **列表**: listView, gridView, listItem
- **容器**: scaffold, appBar

**示例**：
```
用户: "生成一个表单页面，包含标题输入框、描述多行输入和提交按钮"
AI: 生成完整的 STAC Schema，包含表单字段、校验规则和事件处理
```

**知识库**：
- STAC 组件库文档
- 设计规范（颜色、间距、圆角、阴影）
- 常见布局模式（表单、列表、卡片网格、详情页、统计面板）
- Flutter TextStyle 预设

---

### 3. Capability Integration Skill

**功能**：辅助集成 Host Bridge 能力桥接 API

**触发关键词**：
- integrate capability
- host bridge
- add permission
- 集成能力
- 调用宿主

**能力**：
- ✅ API 查询和推荐
- ✅ 权限配置生成
- ✅ 错误处理模板
- ✅ 调用示例生成
- ✅ 参数校验

**支持的能力分类**：
1. **Account & Org** - user.profile.get, org.contacts.search, org.contacts.pick
2. **IM & Message** - im.message.send, im.chat.open
3. **Approval & Workflow** - approval.detail.get, approval.submit, approval.list
4. **Notification** - notification.send, notification.cancel
5. **Navigation** - navigation.open, navigation.back, navigation.replace
6. **Network** - network.request（所有网络请求必须通过宿主代理）
7. **Storage** - storage.set, storage.get, storage.remove, storage.clear
8. **UI Helpers** - toast.show, dialog.alert, dialog.confirm, loading.show
9. **Device** - device.location.get, device.camera.scan, device.info.get
10. **Event** - event.publish（自定义事件）

**示例**：
```
用户: "添加发送通知的功能"
AI: 
1. 在 manifest.json 添加 "notification.send" 权限
2. 在 host_api.js 生成 sendNotification 函数
3. 生成错误处理代码
4. 提供调用示例
```

**知识库**：
- Host Bridge API 完整文档
- 权限分级映射表（低/中/高/关键）
- 错误处理最佳实践
- 参数和返回值 Schema

---

### 4. Plugin Testing Skill

**功能**：生成测试用例和调试代码

**触发关键词**：
- test plugin
- write test
- unit test
- 测试插件
- 编写测试

**能力**：
- ✅ 单元测试生成（状态、工具函数、服务）
- ✅ Host Bridge 集成测试（Mock invokeHost）
- ✅ UI Schema 验证测试
- ✅ 事件处理测试
- ✅ 端到端流程测试
- ✅ 性能基准测试
- ✅ 调试日志工具

**测试框架**：Jest

**生成内容**：
- ✅ jest.config.js 配置
- ✅ test/mocks/host_mock.js Host Bridge Mock
- ✅ 单元测试文件（*.test.js）
- ✅ Schema 验证器
- ✅ 性能基准测试
- ✅ 调试日志工具（logger.js）

**示例**：
```
用户: "为 handleFormSubmit 函数编写测试"
AI: 
1. 生成测试文件
2. 测试表单校验逻辑
3. 测试成功提交流程
4. 测试错误处理
5. Mock Host Bridge 调用
```

---

## 使用指南

### 1. 快速开始：创建新插件

**步骤**：

```text
1. 使用 Plugin Scaffolding Skill
   提示词: "创建一个工作日历插件，需要日程管理、会议安排和审批提醒功能"
   
2. 使用 STAC UI Development Skill
   提示词: "生成日历主页面，包含月份导航、日历网格和今日事件列表"
   
3. 使用 Capability Integration Skill
   提示词: "集成日历读写能力、通讯录选择和审批查询能力"
   
4. 使用 Plugin Testing Skill
   提示词: "为日历插件生成完整的测试用例"
```

### 2. 完整开发流程

```text
第一步：脚手架生成
├─ 确定插件功能和需求
├─ 使用 Plugin Scaffolding Skill 生成基础结构
└─ 配置 manifest.json（ID、名称、权限）

第二步：UI 开发
├─ 使用 STAC UI Development Skill 生成页面
├─ 生成卡片组件
├─ 生成可复用组件
└─ 确保 UI 风格一致

第三步：能力集成
├─ 使用 Capability Integration Skill 查询所需 API
├─ 在 manifest.json 添加权限
├─ 在 services/host_api.js 封装调用
└─ 在 controllers/handlers.js 实现业务逻辑

第四步：测试和调试
├─ 使用 Plugin Testing Skill 生成测试
├─ 运行单元测试
├─ 运行集成测试
├─ 使用调试日志工具排查问题
└─ 性能基准测试

第五步：构建和部署
├─ 运行 python3 scripts/build.py
├─ 验证 dist/bundle.js
├─ 检查 manifest.json 的 bundleHash
└─ 部署到插件平台
```

---

## Skills 使用最佳实践

### 1. 清晰的需求描述

**好的提示词**：
```
"创建一个审批插件，包含：
1. 审批列表页（待办/已办分类）
2. 审批详情页（显示审批内容、流程、意见）
3. 快速审批功能（同意/拒绝/转交）
4. 审批提醒通知
需要支持 iOS、Android 和桌面端"
```

**不好的提示词**：
```
"做一个审批的东西"
```

### 2. 渐进式开发

不要一次性要求完成所有功能，而是：
1. 先生成脚手架
2. 再生成核心页面
3. 再集成关键能力
4. 最后添加测试

### 3. 利用知识库

Skills 内置了完整的知识库，可以直接问：
- "STAC 有哪些表单组件？"
- "如何调用审批提交 API？"
- "需要什么权限才能发送通知？"

### 4. 验证生成的代码

生成代码后：
- ✅ 检查 manifest.json 配置是否正确
- ✅ 验证权限声明是否完整
- ✅ 运行 ESLint/Prettier 格式化
- ✅ 运行构建脚本确保能正常打包
- ✅ 运行测试确保代码质量

---

## 验收标准

### Skills 能力验收

#### 1. Plugin Scaffolding Skill
- ✅ 能够根据插件名称和描述生成完整脚手架
- ✅ 生成的 manifest.json 格式正确
- ✅ 目录结构符合规范
- ✅ 基础代码可以直接运行
- ✅ 构建脚本可以正常执行

#### 2. STAC UI Development Skill
- ✅ 能够根据自然语言描述生成 UI Schema
- ✅ 组件选择准确
- ✅ 布局结构合理
- ✅ 样式一致性达到 90%+
- ✅ 表单校验规则正确
- ✅ 事件绑定完整

#### 3. Capability Integration Skill
- ✅ 能够推荐合适的 Host API
- ✅ 自动生成权限配置
- ✅ 生成的调用代码正确
- ✅ 错误处理完整
- ✅ 参数校验正确

#### 4. Plugin Testing Skill
- ✅ 能够生成完整的测试用例
- ✅ 测试覆盖率 > 70%
- ✅ Mock 正确
- ✅ 测试可以独立运行
- ✅ 性能测试有效

---

## 示例场景

### 场景 1：从零创建日历插件

**用户输入**：
```
"我想创建一个工作日历插件，功能包括：
1. 查看月度日历
2. 管理日程事件（创建、编辑、删除）
3. 支持不同类型事件（会议、任务、审批、提醒）
4. 可以邀请参与人
5. 集成审批流程"
```

**AI 工作流程**：

1. **使用 Plugin Scaffolding Skill**
   ```
   生成插件目录结构
   ├── manifest.json (配置权限: calendar.read, calendar.write, org.contacts.read, approval.read)
   ├── src/index.js
   ├── src/state/calendar_state.js
   ├── src/services/host_api.js
   ├── src/controllers/calendar_handlers.js
   ├── src/ui/pages/calendar_page.js
   └── ...
   ```

2. **使用 STAC UI Development Skill**
   ```
   生成日历页面 UI:
   - 月份导航 header
   - 统计面板（总数、完成数）
   - 7x5 日历网格
   - 今日事件列表
   - 事件编辑器表单
   ```

3. **使用 Capability Integration Skill**
   ```
   集成能力:
   - org.contacts.pick (选择参与人)
   - notification.send (发送提醒)
   - approval.submit (提交审批)
   - storage.local (本地存储)
   ```

4. **使用 Plugin Testing Skill**
   ```
   生成测试:
   - calendar_state.test.js (状态管理测试)
   - calendar_handlers.test.js (事件处理测试)
   - calendar_page.test.js (UI Schema 测试)
   - host_api.test.js (API 集成测试)
   ```

### 场景 2：为现有插件添加功能

**用户输入**：
```
"在日历插件中添加搜索功能，可以搜索事件标题和参与人"
```

**AI 工作流程**：

1. **使用 STAC UI Development Skill**
   ```
   生成搜索栏 UI:
   - textFormField (搜索输入框)
   - iconButton (搜索按钮)
   - listView (搜索结果列表)
   ```

2. **使用 Capability Integration Skill**
   ```
   添加搜索相关能力:
   - 可能需要 org.contacts.search (搜索参与人)
   - storage.local (保存搜索历史)
   ```

3. **实现搜索逻辑**
   ```javascript
   // controllers/calendar_handlers.js
   export function handleSearch(state, context) {
     const query = state.searchQuery;
     const filteredEvents = pluginState.events.filter(event => 
       event.title.includes(query) || 
       event.attendees.some(a => a.includes(query))
     );
     
     return {
       type: 'patch',
       patches: [
         { op: 'replace', path: '/searchResults', value: filteredEvents }
       ]
     };
   }
   ```

4. **使用 Plugin Testing Skill**
   ```
   生成搜索功能测试:
   - 测试关键词搜索
   - 测试参与人搜索
   - 测试空结果处理
   ```

---

## 常见问题

### Q1: Skills 生成的代码质量如何？

**A**: Skills 基于完整的技术文档和最佳实践设计，生成的代码：
- ✅ 符合项目规范
- ✅ 包含完整的错误处理
- ✅ 样式一致性高
- ✅ 可直接运行（脚手架）
- ⚠️ 复杂业务逻辑需要人工调整

### Q2: 如何确保 UI 风格一致？

**A**: STAC UI Development Skill 内置了设计规范：
- 标准颜色系统（primary、secondary、success、warning、error）
- 标准间距系统（4px 基准）
- 标准圆角系统（4/8/12/16/20）
- Flutter TextStyle 预设
- UI Token 模板

### Q3: 权限如何配置？

**A**: Capability Integration Skill 会：
1. 根据使用的 API 自动推荐权限
2. 在 manifest.json 中添加权限声明
3. 标注权限级别（低/中/高/关键）
4. 提示需要用户确认的高风险权限

### Q4: 如何调试插件？

**A**: Plugin Testing Skill 提供了完整的调试工具：
- Logger 工具（支持不同日志级别）
- Host Bridge Mock（模拟宿主环境）
- 性能追踪（trace/traceAsync）
- 错误码映射

### Q5: Skills 支持哪些语言？

**A**: 当前 Skills 主要支持：
- 中文（触发关键词和文档）
- 英文（触发关键词）
- 生成的代码使用英文标识符
- 国际化资源支持多语言

---

## 技术支持

### 文档位置
- 本 README: `/docs/skills/README.md`
- Plugin Scaffolding: `/docs/skills/plugin-scaffolding.md`
- STAC UI Development: `/docs/skills/stac-ui-development.md`
- Capability Integration: `/docs/skills/capability-integration.md`
- Plugin Testing: `/docs/skills/plugin-testing.md`

### 参考资料
- 技术架构文档: `/mobile-plugin-platform-plan.md`
- Phase 2 总结: `/phase2-summary.md`
- work_calendar 示例: `/plugins_platform/examples/demo_app/assets/plugins/work_calendar/`

---

## 更新日志

### v1.0.0 (2024-06-20)
- ✅ 完成 4 个 Skills 设计和实现
- ✅ 包含完整的知识库和模板
- ✅ 支持插件完整生命周期
- ✅ 提供详细的使用文档

---

## 贡献指南

如需扩展 Skills 功能：

1. **添加新组件到 STAC UI Skill**
   - 在 `stac-ui-development.md` 添加组件文档
   - 包含完整的属性说明和示例

2. **添加新 Host API 到 Capability Integration Skill**
   - 在 `capability-integration.md` 添加 API 文档
   - 包含权限要求、参数、返回值和示例

3. **添加新测试模式到 Plugin Testing Skill**
   - 在 `plugin-testing.md` 添加测试模板
   - 包含完整的测试用例和 Mock

4. **优化提示词**
   - 根据实际使用反馈优化触发关键词
   - 改进自然语言理解能力
