# 快速入门：创建你的第一个插件

本教程将带你从零开始创建一个简单的 "Hello World" 插件，完成后你将理解插件开发的完整流程。

**预计时间：5-10 分钟**

## 目标

创建一个名为 "Hello Plugin" 的插件，它将：
- 显示一个简单的欢迎页面
- 展示当前时间
- 包含一个可点击的按钮

## 前置条件

- 已完成[环境准备](getting-started.md)
- Demo App 可以正常运行
- 了解基本的 JavaScript 语法

## Step 1: 创建插件目录

在 Demo App 的插件目录下创建新插件：

```bash
cd examples/demo_app/assets/plugins
mkdir hello_plugin
cd hello_plugin
```

创建必要的子目录：

```bash
mkdir src
mkdir dist
mkdir scripts
```

## Step 2: 编写 manifest.json

在 `hello_plugin` 目录下创建 `manifest.json` 文件：

```json
{
  "id": "com.example.hello_plugin",
  "name": "Hello Plugin",
  "description": "我的第一个插件",
  "version": "1.0.0",
  "publisher": "example",
  "type": "js",
  "platforms": [
    "ios",
    "android",
    "windows",
    "macos",
    "linux"
  ],
  "minHostVersion": "1.0.0",
  "engine": {
    "runtime": "quickjs",
    "bundle": "dist/bundle.js",
    "bundleHash": "",
    "bundleSize": 0,
    "entryFunction": "onActivate",
    "memoryLimitMb": 16,
    "executionTimeoutMs": 5000,
    "background": false
  },
  "activationEvents": [
    "onCommand:hello.open"
  ],
  "permissions": [
    "storage.local"
  ],
  "capabilities": [],
  "stac": {
    "schemaVersion": "1.0",
    "components": [
      "text",
      "button",
      "card",
      "column",
      "sizedBox"
    ],
    "customComponents": []
  },
  "performanceBudget": {
    "startupMs": 800,
    "firstScreenMs": 1500,
    "maxMemoryMb": 16,
    "maxCpuPercent": 10
  },
  "updatePolicy": {
    "channel": "stable",
    "allowAutoUpdate": true,
    "allowRollback": true,
    "allowRemoteConfig": false,
    "allowRemoteSchema": false,
    "allowRemoteCode": false,
    "signatureRequired": false
  }
}
```

### manifest.json 关键字段说明

| 字段 | 说明 | 必需 |
|------|------|------|
| `id` | 插件的唯一标识符，建议使用反向域名格式 | ✅ |
| `name` | 插件显示名称 | ✅ |
| `version` | 插件版本号，遵循语义化版本 | ✅ |
| `type` | 插件类型，目前仅支持 "js" | ✅ |
| `platforms` | 支持的平台列表 | ✅ |
| `engine.runtime` | JavaScript 运行时，目前仅支持 "quickjs" | ✅ |
| `engine.bundle` | 打包后的 JS 文件路径 | ✅ |
| `activationEvents` | 触发插件激活的事件列表 | ✅ |
| `permissions` | 插件所需的权限列表 | ✅ |
| `stac.components` | 插件使用的 STAC UI 组件 | ✅ |

## Step 3: 编写插件代码

在 `src/index.js` 创建入口文件：

```javascript
// src/index.js

// 插件状态
let clickCount = 0;

/**
 * 插件激活时调用
 * 可以在这里做初始化工作
 */
export function onActivate() {
  console.log('[hello_plugin] Plugin activated!');
  
  // 从本地存储读取点击次数
  const stored = invokeHost('storage.get', { key: 'click_count' });
  if (stored && stored.value) {
    clickCount = Number(stored.value) || 0;
  }
}

/**
 * 插件停用时调用
 * 可以在这里做清理工作
 */
export function onDeactivate() {
  console.log('[hello_plugin] Plugin deactivated!');
}

/**
 * 渲染插件页面
 * 返回 STAC Schema 描述 UI
 */
export function renderPage() {
  const now = new Date();
  const timeString = now.toLocaleTimeString('zh-CN');
  const dateString = now.toLocaleDateString('zh-CN');
  
  return {
    schemaVersion: '1.0',
    type: 'page',
    title: 'Hello Plugin',
    layout: {
      type: 'column',
      padding: '16,16,16,16',
      scrollable: true,
      crossAxisAlignment: 'stretch'
    },
    children: [
      // 欢迎卡片
      {
        type: 'card',
        style: {
          padding: '16,16,16,16'
        },
        children: [
          createText('👋 欢迎使用 Hello Plugin', 24, '#111827', '700'),
          createSizedBox(12),
          createText('这是你的第一个插件！', 16, '#4B5563', '400'),
          createSizedBox(8),
          createText(`当前时间: ${timeString}`, 14, '#6B7280', '400'),
          createSizedBox(4),
          createText(`今天日期: ${dateString}`, 14, '#6B7280', '400')
        ]
      },
      
      createSizedBox(16),
      
      // 交互卡片
      {
        type: 'card',
        style: {
          padding: '16,16,16,16'
        },
        children: [
          createText('交互示例', 18, '#111827', '600'),
          createSizedBox(12),
          createText(`你已经点击了 ${clickCount} 次按钮`, 16, '#4B5563', '400'),
          createSizedBox(16),
          {
            type: 'button',
            props: {
              text: '点击我',
              onPressed: 'handleButtonClick'
            },
            style: {
              backgroundColor: '#3B82F6',
              textColor: '#FFFFFF',
              borderRadius: '8'
            }
          }
        ]
      },
      
      createSizedBox(16),
      
      // 说明卡片
      {
        type: 'card',
        style: {
          padding: '16,16,16,16',
          backgroundColor: '#F3F4F6'
        },
        children: [
          createText('💡 插件开发提示', 16, '#111827', '600'),
          createSizedBox(8),
          createText('1. 使用 console.log() 输出调试信息', 14, '#4B5563', '400'),
          createSizedBox(4),
          createText('2. 修改代码后需要重新构建', 14, '#4B5563', '400'),
          createSizedBox(4),
          createText('3. 使用 invokeHost() 调用宿主能力', 14, '#4B5563', '400'),
          createSizedBox(4),
          createText('4. 事件处理函数返回新的 Schema 刷新界面', 14, '#4B5563', '400')
        ]
      }
    ]
  };
}

/**
 * 处理按钮点击事件
 */
export function handleButtonClick() {
  clickCount++;
  console.log('[hello_plugin] Button clicked! Count:', clickCount);
  
  // 保存到本地存储
  invokeHost('storage.set', {
    key: 'click_count',
    value: String(clickCount)
  });
  
  // 显示提示
  invokeHost('toast.show', {
    message: `你点击了第 ${clickCount} 次！`,
    duration: 2000
  });
  
  // 返回新的 Schema，宿主会按 STACUpdate 规则刷新 UI
  return renderPage();
}

// ============ 辅助函数 ============

/**
 * 创建文本组件
 */
function createText(text, size, color, weight) {
  return {
    type: 'text',
    props: {
      text: text
    },
    style: {
      fontSize: size,
      color: color,
      fontWeight: weight || '400'
    }
  };
}

/**
 * 创建间距组件
 */
function createSizedBox(height) {
  return {
    type: 'sizedBox',
    props: {
      height: height
    }
  };
}
```

### 代码关键点说明

1. **生命周期函数**
   - `onActivate()`: 插件激活时调用，适合做初始化
   - `onDeactivate()`: 插件停用时调用，适合做清理

2. **UI 渲染函数**
   - `renderPage()`: 返回页面的 STAC Schema
   - Schema 是一个 JSON 对象，描述 UI 结构和样式

3. **事件处理函数**
   - `handleButtonClick()`: 处理按钮点击
   - 函数名与 Schema 中的 `onPressed` 对应

4. **宿主能力调用**
   - `invokeHost()`: 调用宿主提供的能力
   - 事件处理函数可以返回新的 Schema 或 STACUpdate 刷新 UI

## Step 4: 创建构建脚本

在 `scripts/build.py` 创建构建脚本：

```python
#!/usr/bin/env python3
# scripts/build.py

import os
import json
import hashlib

def bundle_js():
    """打包 JavaScript 文件"""
    src_dir = 'src'
    output_file = 'dist/bundle.js'
    
    # 确保输出目录存在
    os.makedirs('dist', exist_ok=True)
    
    # 读取源文件
    source_files = []
    for root, dirs, files in os.walk(src_dir):
        for file in sorted(files):
            if file.endswith('.js'):
                file_path = os.path.join(root, file)
                with open(file_path, 'r', encoding='utf-8') as f:
                    source_files.append(f.read())
    
    # 合并为单个文件
    bundle_content = '\n\n'.join(source_files)
    
    # 写入输出文件
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(bundle_content)
    
    # 计算哈希和大小
    bundle_hash = hashlib.sha256(bundle_content.encode('utf-8')).hexdigest()
    bundle_size = len(bundle_content.encode('utf-8'))
    
    print(f'✅ Bundle created: {output_file}')
    print(f'   Size: {bundle_size} bytes')
    print(f'   Hash: {bundle_hash}')
    
    return bundle_hash, bundle_size

def update_manifest(bundle_hash, bundle_size):
    """更新 manifest.json 中的哈希和大小"""
    manifest_file = 'manifest.json'
    
    with open(manifest_file, 'r', encoding='utf-8') as f:
        manifest = json.load(f)
    
    manifest['engine']['bundleHash'] = bundle_hash
    manifest['engine']['bundleSize'] = bundle_size
    
    with open(manifest_file, 'w', encoding='utf-8') as f:
        json.dump(manifest, f, indent=2, ensure_ascii=False)
        f.write('\n')
    
    print(f'✅ Manifest updated')

if __name__ == '__main__':
    print('🔨 Building hello_plugin...')
    bundle_hash, bundle_size = bundle_js()
    update_manifest(bundle_hash, bundle_size)
    print('✅ Build complete!')
```

## Step 5: 构建插件

运行构建脚本：

```bash
python3 scripts/build.py
```

你应该看到类似输出：

```
🔨 Building hello_plugin...
✅ Bundle created: dist/bundle.js
   Size: 3421 bytes
   Hash: a1b2c3d4...
✅ Manifest updated
✅ Build complete!
```

构建完成后，检查生成的文件：

```bash
ls -la dist/
# 应该看到 bundle.js
```

## Step 6: 在 Demo App 中测试

### 1. 启动 Demo App

```bash
cd ../../../  # 回到 demo_app 目录
flutter run
```

### 2. 激活插件

在 Demo App 中：
1. 找到插件列表
2. 找到 "Hello Plugin"
3. 点击激活按钮

### 3. 查看插件页面

激活后，你应该能看到：
- 欢迎标题和说明
- 当前时间和日期
- 一个计数器和按钮
- 插件开发提示

### 4. 测试交互

- 点击 "点击我" 按钮
- 观察计数器增加
- 应该看到 Toast 提示
- 查看控制台输出的日志

## Step 7: 调试和迭代

### 查看日志

在运行 Demo App 的终端中，你可以看到插件的 `console.log()` 输出：

```
[hello_plugin] Plugin activated!
[hello_plugin] Button clicked! Count: 1
[hello_plugin] Button clicked! Count: 2
```

### 修改代码

1. 修改 `src/index.js`（例如改变文本或颜色）
2. 重新构建：`python3 scripts/build.py`
3. 在 Demo App 中热重启（按 `R`）或重新运行
4. 查看变化

### 常见问题排查

**问题：插件没有出现在列表中**
- 检查 `manifest.json` 格式是否正确
- 确认插件目录在 `assets/plugins/` 下
- 重新运行 `flutter run`

**问题：点击按钮没有反应**
- 检查 `handleButtonClick` 函数名是否正确
- 确认函数已正确导出（`export function`）
- 查看控制台是否有错误

**问题：UI 没有更新**
- 确认事件处理函数返回了新的 Schema 或 STACUpdate
- 检查 `renderPage()` 是否返回正确的 Schema

## 下一步

恭喜！你已经创建了第一个插件。接下来可以：

1. 查看 [示例集合](examples.md) 了解更多场景
2. 探索更多 STAC 组件（textField、列表、图片等）
3. 尝试调用更多宿主能力（网络请求、通知等）
4. 研究现有插件的源代码（`work_calendar`）

## 完整目录结构

完成后，你的插件目录应该是这样的：

```
hello_plugin/
├── manifest.json           # 插件配置（已更新哈希和大小）
├── src/
│   └── index.js           # 源代码
├── dist/
│   └── bundle.js          # 打包后的代码
└── scripts/
    └── build.py           # 构建脚本
```

## 附录：完整文件清单

### manifest.json
参见 Step 2

### src/index.js
参见 Step 3

### scripts/build.py
参见 Step 4

这个简单的插件演示了：
- ✅ 基本的插件结构
- ✅ 生命周期管理
- ✅ STAC UI 渲染
- ✅ 事件处理
- ✅ 宿主能力调用
- ✅ 状态管理
- ✅ 本地存储

你已经掌握了插件开发的核心流程！
