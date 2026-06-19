---
description: "生成插件测试用例和调试代码，包含单元测试、集成测试、调试日志和性能检查"
globs: ["**/plugins/**/test/**/*.js", "**/plugins/**/src/**/*.test.js"]
alwaysApply: false
---

# Plugin Testing Skill

生成 Flutter 插件平台的测试用例和调试代码，确保插件质量和稳定性。

## 触发关键词
- test plugin
- write test
- unit test
- integration test
- debug plugin
- 测试插件
- 编写测试
- 调试代码

---

## 测试分类

### 1. 单元测试
测试独立的函数和模块

### 2. 集成测试
测试 JS ↔ Host Bridge 的交互

### 3. UI 测试
测试 STAC Schema 生成和渲染

### 4. 端到端测试
测试完整的用户流程

---

## 测试框架

### Jest 配置（推荐）

**安装依赖**:
```bash
npm install --save-dev jest @types/jest
```

**jest.config.js**:
```javascript
module.exports = {
  testEnvironment: 'node',
  testMatch: [
    '**/__tests__/**/*.js',
    '**/*.test.js'
  ],
  collectCoverageFrom: [
    'src/**/*.js',
    '!src/**/*.test.js',
    '!src/**/index.js'
  ],
  coverageThreshold: {
    global: {
      branches: 70,
      functions: 70,
      lines: 70,
      statements: 70
    }
  }
};
```

**package.json**:
```json
{
  "scripts": {
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage"
  }
}
```

---

## 单元测试

### 1. 状态管理测试

**src/state/plugin_state.test.js**:
```javascript
import {
  pluginState,
  ensurePluginData,
  resetPluginState
} from './plugin_state.js';

describe('pluginState', () => {
  beforeEach(() => {
    resetPluginState();
  });

  test('should initialize with default values', () => {
    expect(pluginState.initialized).toBe(false);
    expect(pluginState.data).toEqual([]);
    expect(pluginState.selectedId).toBeNull();
  });

  test('ensurePluginData should initialize data once', () => {
    expect(pluginState.initialized).toBe(false);
    
    ensurePluginData();
    expect(pluginState.initialized).toBe(true);
    
    // 第二次调用不应该重新初始化
    pluginState.data = ['item1'];
    ensurePluginData();
    expect(pluginState.data).toEqual(['item1']);
  });

  test('resetPluginState should clear all data', () => {
    pluginState.initialized = true;
    pluginState.data = ['item1', 'item2'];
    pluginState.selectedId = 'id1';
    
    resetPluginState();
    
    expect(pluginState.initialized).toBe(false);
    expect(pluginState.data).toEqual([]);
    expect(pluginState.selectedId).toBeNull();
  });
});
```

### 2. 工具函数测试

**src/utils/helpers.test.js**:
```javascript
import { formatDate, formatTime, truncateText } from './helpers.js';

describe('helpers', () => {
  describe('formatDate', () => {
    test('should format date correctly', () => {
      const date = new Date('2024-06-20T10:30:00Z');
      expect(formatDate(date)).toBe('2024-06-20');
    });

    test('should handle invalid date', () => {
      expect(formatDate(null)).toBe('');
      expect(formatDate(undefined)).toBe('');
    });
  });

  describe('formatTime', () => {
    test('should format time correctly', () => {
      const date = new Date('2024-06-20T10:30:00Z');
      expect(formatTime(date)).toBe('10:30');
    });
  });

  describe('truncateText', () => {
    test('should truncate long text', () => {
      const text = 'This is a very long text that should be truncated';
      expect(truncateText(text, 20)).toBe('This is a very lo...');
    });

    test('should not truncate short text', () => {
      const text = 'Short text';
      expect(truncateText(text, 20)).toBe('Short text');
    });
  });
});
```

### 3. 数据服务测试

**src/services/data_service.test.js**:
```javascript
import { fetchData, transformData, filterData } from './data_service.js';

// Mock invokeHost
global.invokeHost = jest.fn();

describe('data_service', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('fetchData', () => {
    test('should fetch and return data', async () => {
      const mockData = [{ id: '1', title: 'Item 1' }];
      global.invokeHost.mockResolvedValue({ items: mockData });

      const result = await fetchData();
      
      expect(global.invokeHost).toHaveBeenCalledWith('data.fetch', {});
      expect(result).toEqual(mockData);
    });

    test('should handle fetch error', async () => {
      global.invokeHost.mockRejectedValue(new Error('Network error'));

      const result = await fetchData();
      
      expect(result).toEqual([]);
    });
  });

  describe('transformData', () => {
    test('should transform data correctly', () => {
      const input = [
        { id: '1', name: 'Item 1', value: 10 },
        { id: '2', name: 'Item 2', value: 20 }
      ];
      
      const result = transformData(input);
      
      expect(result).toEqual([
        { id: '1', title: 'Item 1', amount: 10 },
        { id: '2', title: 'Item 2', amount: 20 }
      ]);
    });
  });

  describe('filterData', () => {
    test('should filter data by query', () => {
      const data = [
        { id: '1', title: 'Apple' },
        { id: '2', title: 'Banana' },
        { id: '3', title: 'Orange' }
      ];
      
      const result = filterData(data, 'an');
      
      expect(result).toEqual([
        { id: '2', title: 'Banana' },
        { id: '3', title: 'Orange' }
      ]);
    });
  });
});
```

---

## Host Bridge 集成测试

### Host API Mock

**test/mocks/host_mock.js**:
```javascript
/**
 * Host Bridge Mock
 * 模拟 invokeHost 函数行为
 */

export class HostMock {
  constructor() {
    this.calls = [];
    this.responses = new Map();
    this.errors = new Map();
  }

  /**
   * 设置 API 响应
   */
  setResponse(method, response) {
    this.responses.set(method, response);
  }

  /**
   * 设置 API 错误
   */
  setError(method, error) {
    this.errors.set(method, error);
  }

  /**
   * 模拟 invokeHost 函数
   */
  async invoke(method, params) {
    this.calls.push({ method, params, timestamp: Date.now() });

    // 检查是否有设置的错误
    if (this.errors.has(method)) {
      throw this.errors.get(method);
    }

    // 检查是否有设置的响应
    if (this.responses.has(method)) {
      return this.responses.get(method);
    }

    // 默认响应
    return this.getDefaultResponse(method, params);
  }

  /**
   * 获取默认响应
   */
  getDefaultResponse(method, params) {
    const responses = {
      'toast.show': { success: true },
      'dialog.alert': { success: true },
      'dialog.confirm': { confirmed: false },
      'navigation.open': { success: true },
      'navigation.back': { success: true },
      'storage.set': { success: true },
      'storage.get': { value: null },
      'notification.send': { success: true, id: 'ntf_123' },
      'org.contacts.pick': { contacts: [] },
      'approval.submit': { success: true }
    };

    return responses[method] || { success: false };
  }

  /**
   * 获取调用记录
   */
  getCalls(method = null) {
    if (method) {
      return this.calls.filter(call => call.method === method);
    }
    return this.calls;
  }

  /**
   * 清除调用记录
   */
  clear() {
    this.calls = [];
    this.responses.clear();
    this.errors.clear();
  }

  /**
   * 断言是否被调用
   */
  assertCalled(method, times = null) {
    const calls = this.getCalls(method);
    if (times === null) {
      return calls.length > 0;
    }
    return calls.length === times;
  }

  /**
   * 断言调用参数
   */
  assertCalledWith(method, expectedParams) {
    const calls = this.getCalls(method);
    if (calls.length === 0) {
      throw new Error(`${method} was not called`);
    }
    
    const lastCall = calls[calls.length - 1];
    expect(lastCall.params).toEqual(expectedParams);
  }
}

// 创建全局 mock 实例
export const hostMock = new HostMock();

// 替换全局 invokeHost
global.invokeHost = (method, params) => hostMock.invoke(method, params);
```

### Host API 测试

**src/services/host_api.test.js**:
```javascript
import { hostMock } from '../../test/mocks/host_mock.js';
import {
  showToast,
  showConfirm,
  navigateTo,
  storageSet,
  storageGet,
  sendNotification
} from './host_api.js';

describe('host_api', () => {
  beforeEach(() => {
    hostMock.clear();
  });

  describe('showToast', () => {
    test('should call toast.show with message', async () => {
      await showToast('Hello');
      
      expect(hostMock.assertCalled('toast.show', 1)).toBe(true);
      hostMock.assertCalledWith('toast.show', { message: 'Hello' });
    });
  });

  describe('showConfirm', () => {
    test('should return true when confirmed', async () => {
      hostMock.setResponse('dialog.confirm', { confirmed: true });
      
      const result = await showConfirm('Title', 'Message');
      
      expect(result).toBe(true);
      expect(hostMock.assertCalled('dialog.confirm', 1)).toBe(true);
    });

    test('should return false when cancelled', async () => {
      hostMock.setResponse('dialog.confirm', { confirmed: false });
      
      const result = await showConfirm('Title', 'Message');
      
      expect(result).toBe(false);
    });
  });

  describe('navigateTo', () => {
    test('should navigate with route and params', async () => {
      await navigateTo('/plugin/calendar', { date: '2024-06-20' });
      
      hostMock.assertCalledWith('navigation.open', {
        route: '/plugin/calendar',
        params: { date: '2024-06-20' }
      });
    });
  });

  describe('storageSet and storageGet', () => {
    test('should save and retrieve data', async () => {
      const testData = { name: 'test', value: 123 };
      
      // 保存数据
      await storageSet('testKey', testData);
      hostMock.assertCalledWith('storage.set', {
        key: 'testKey',
        value: JSON.stringify(testData)
      });
      
      // 模拟读取
      hostMock.setResponse('storage.get', {
        value: JSON.stringify(testData)
      });
      
      const result = await storageGet('testKey');
      expect(result).toEqual(testData);
    });

    test('should return default value when key not found', async () => {
      hostMock.setResponse('storage.get', { value: null });
      
      const result = await storageGet('nonexistent', 'default');
      expect(result).toBe('default');
    });
  });

  describe('sendNotification', () => {
    test('should send notification with payload', async () => {
      await sendNotification('Title', 'Body', { type: 'info' });
      
      hostMock.assertCalledWith('notification.send', {
        title: 'Title',
        body: 'Body',
        payload: { type: 'info' }
      });
    });
  });
});
```

---

## UI Schema 测试

### STAC Schema 验证

**src/ui/pages/main_page.test.js**:
```javascript
import { renderMainPage } from './main_page.js';
import { pluginState } from '../../state/plugin_state.js';

describe('main_page', () => {
  beforeEach(() => {
    pluginState.data = [];
    pluginState.formData = { title: '', description: '' };
  });

  test('should return valid STAC schema', () => {
    const schema = renderMainPage({ page: 'main' });
    
    // 检查必要字段
    expect(schema.schemaVersion).toBe('1.0');
    expect(schema.type).toBe('page');
    expect(schema.title).toBeDefined();
    expect(schema.layout).toBeDefined();
    expect(schema.children).toBeInstanceOf(Array);
  });

  test('should include form fields', () => {
    const schema = renderMainPage({});
    
    // 查找表单字段
    const findComponent = (node, type) => {
      if (node.type === type) return node;
      if (node.children) {
        for (const child of node.children) {
          const found = findComponent(child, type);
          if (found) return found;
        }
      }
      return null;
    };
    
    const titleField = findComponent(schema, 'textFormField');
    expect(titleField).toBeDefined();
    expect(titleField.id).toBe('title');
    expect(titleField.props.label).toBeDefined();
  });

  test('should bind event handlers', () => {
    const schema = renderMainPage({});
    
    const findButton = (node) => {
      if (node.type === 'button') return node;
      if (node.children) {
        for (const child of node.children) {
          const found = findButton(child);
          if (found) return found;
        }
      }
      return null;
    };
    
    const button = findButton(schema);
    expect(button).toBeDefined();
    expect(button.events).toBeDefined();
    expect(button.events.onTap).toBeDefined();
  });

  test('should reflect plugin state', () => {
    pluginState.formData.title = 'Test Title';
    
    const schema = renderMainPage({});
    
    // 验证表单字段包含状态值
    const findField = (node, id) => {
      if (node.id === id) return node;
      if (node.children) {
        for (const child of node.children) {
          const found = findField(child, id);
          if (found) return found;
        }
      }
      return null;
    };
    
    const titleField = findField(schema, 'title');
    expect(titleField.props.initialValue).toBe('Test Title');
  });
});
```

### Schema 结构验证器

**test/utils/schema_validator.js**:
```javascript
/**
 * STAC Schema 验证器
 */

export function validateSchema(schema) {
  const errors = [];

  // 检查必要字段
  if (!schema.schemaVersion) {
    errors.push('Missing schemaVersion');
  }
  
  if (!schema.type) {
    errors.push('Missing type');
  }

  // 验证组件树
  if (schema.children) {
    validateChildren(schema.children, errors, 'root');
  }

  return {
    valid: errors.length === 0,
    errors
  };
}

function validateChildren(children, errors, path) {
  if (!Array.isArray(children)) {
    errors.push(`${path}: children must be an array`);
    return;
  }

  children.forEach((child, index) => {
    const childPath = `${path}[${index}]`;
    
    if (!child.type) {
      errors.push(`${childPath}: Missing type`);
    }

    // 验证表单字段有 ID
    const formFields = ['textFormField', 'textarea', 'dropdown', 'checkbox'];
    if (formFields.includes(child.type) && !child.id) {
      errors.push(`${childPath}: Form field missing id`);
    }

    // 验证事件处理函数
    if (child.events) {
      Object.entries(child.events).forEach(([event, handler]) => {
        if (typeof handler !== 'string') {
          errors.push(`${childPath}.events.${event}: Handler must be a string`);
        }
      });
    }

    // 递归验证子节点
    if (child.children) {
      validateChildren(child.children, errors, childPath);
    }
  });
}
```

---

## 事件处理测试

**src/controllers/handlers.test.js**:
```javascript
import { hostMock } from '../../test/mocks/host_mock.js';
import {
  handleButtonClick,
  handleFormSubmit,
  handleRefresh
} from './handlers.js';

describe('handlers', () => {
  beforeEach(() => {
    hostMock.clear();
  });

  describe('handleButtonClick', () => {
    test('should show toast on click', () => {
      const state = {};
      const context = { invokeHost: (m, p) => hostMock.invoke(m, p) };
      
      handleButtonClick(state, context);
      
      expect(hostMock.assertCalled('toast.show')).toBe(true);
    });
  });

  describe('handleFormSubmit', () => {
    test('should validate required fields', async () => {
      const state = { title: '' };
      const context = { invokeHost: (m, p) => hostMock.invoke(m, p) };
      
      await handleFormSubmit(state, context);
      
      // 应该显示错误提示
      expect(hostMock.assertCalled('toast.show')).toBe(true);
      const calls = hostMock.getCalls('toast.show');
      expect(calls[0].params.message).toContain('不能为空');
    });

    test('should submit valid form', async () => {
      const state = {
        title: 'Valid Title',
        description: 'Valid Description'
      };
      const context = { invokeHost: (m, p) => hostMock.invoke(m, p) };
      
      await handleFormSubmit(state, context);
      
      // 应该显示成功提示
      expect(hostMock.assertCalled('toast.show')).toBe(true);
      
      // 应该导航返回
      expect(hostMock.assertCalled('navigation.back')).toBe(true);
    });
  });

  describe('handleRefresh', () => {
    test('should return full schema update', () => {
      const state = {};
      const context = { invokeHost: (m, p) => hostMock.invoke(m, p) };
      
      const result = handleRefresh(state, context);
      
      expect(result.type).toBe('full');
      expect(result.schema).toBeDefined();
    });
  });
});
```

---

## 端到端测试

### 完整流程测试

**test/e2e/plugin_flow.test.js**:
```javascript
import { hostMock } from '../mocks/host_mock.js';
import { onActivate, renderPage, handleFormSubmit } from '../../src/index.js';
import { pluginState } from '../../src/state/plugin_state.js';

describe('E2E: Plugin Flow', () => {
  beforeEach(() => {
    hostMock.clear();
    pluginState.initialized = false;
  });

  test('complete user flow: activate → render → interact → submit', async () => {
    // 1. 激活插件
    onActivate();
    expect(pluginState.initialized).toBe(true);

    // 2. 渲染页面
    const schema = renderPage({ page: 'main' });
    expect(schema.schemaVersion).toBe('1.0');
    expect(schema.type).toBe('page');

    // 3. 模拟表单填写
    const formState = {
      title: 'Test Title',
      description: 'Test Description'
    };

    // 4. 提交表单
    const context = { invokeHost: (m, p) => hostMock.invoke(m, p) };
    await handleFormSubmit(formState, context);

    // 5. 验证调用
    expect(hostMock.assertCalled('toast.show')).toBe(true);
    expect(hostMock.assertCalled('navigation.back')).toBe(true);

    // 6. 验证状态更新
    expect(pluginState.formData.title).toBe('Test Title');
  });
});
```

---

## 性能测试

### 性能基准测试

**test/performance/benchmark.test.js**:
```javascript
import { renderMainPage } from '../../src/ui/pages/main_page.js';
import { pluginState } from '../../src/state/plugin_state.js';

describe('Performance Benchmarks', () => {
  test('renderMainPage should complete under 50ms', () => {
    const iterations = 100;
    const start = Date.now();
    
    for (let i = 0; i < iterations; i++) {
      renderMainPage({ page: 'main' });
    }
    
    const end = Date.now();
    const avgTime = (end - start) / iterations;
    
    expect(avgTime).toBeLessThan(50);
    console.log(`Average render time: ${avgTime.toFixed(2)}ms`);
  });

  test('state initialization should complete under 10ms', () => {
    const iterations = 1000;
    const start = Date.now();
    
    for (let i = 0; i < iterations; i++) {
      pluginState.initialized = false;
      ensurePluginData();
    }
    
    const end = Date.now();
    const avgTime = (end - start) / iterations;
    
    expect(avgTime).toBeLessThan(10);
    console.log(`Average init time: ${avgTime.toFixed(2)}ms`);
  });
});
```

---

## 调试工具

### 调试日志工具

**src/utils/logger.js**:
```javascript
/**
 * 调试日志工具
 */

const LOG_LEVEL = {
  DEBUG: 0,
  INFO: 1,
  WARN: 2,
  ERROR: 3
};

class Logger {
  constructor(name, level = 'INFO') {
    this.name = name;
    this.level = LOG_LEVEL[level] || LOG_LEVEL.INFO;
    this.enabled = true;
  }

  debug(...args) {
    if (this.enabled && this.level <= LOG_LEVEL.DEBUG) {
      console.log(`[${this.name}] DEBUG:`, ...args);
    }
  }

  info(...args) {
    if (this.enabled && this.level <= LOG_LEVEL.INFO) {
      console.log(`[${this.name}] INFO:`, ...args);
    }
  }

  warn(...args) {
    if (this.enabled && this.level <= LOG_LEVEL.WARN) {
      console.warn(`[${this.name}] WARN:`, ...args);
    }
  }

  error(...args) {
    if (this.enabled && this.level <= LOG_LEVEL.ERROR) {
      console.error(`[${this.name}] ERROR:`, ...args);
    }
  }

  trace(label, fn) {
    const start = Date.now();
    const result = fn();
    const duration = Date.now() - start;
    this.debug(`${label} took ${duration}ms`);
    return result;
  }

  async traceAsync(label, fn) {
    const start = Date.now();
    const result = await fn();
    const duration = Date.now() - start;
    this.debug(`${label} took ${duration}ms`);
    return result;
  }
}

export function createLogger(name, level) {
  return new Logger(name, level);
}

// 全局日志实例
export const logger = createLogger('Plugin', 'DEBUG');
```

**使用示例**:
```javascript
import { logger } from './utils/logger.js';

export async function fetchData() {
  logger.info('Fetching data...');
  
  try {
    const result = await logger.traceAsync('Data fetch', async () => {
      return await invokeHost('data.fetch', {});
    });
    
    logger.info('Data fetched:', result.items.length, 'items');
    return result.items;
  } catch (error) {
    logger.error('Failed to fetch data:', error);
    return [];
  }
}
```

---

## Checklist

编写测试时确保：

- [ ] 单元测试覆盖率 > 70%
- [ ] 所有公共函数有测试
- [ ] 所有事件处理函数有测试
- [ ] Host API 调用有 mock
- [ ] UI Schema 结构验证
- [ ] 错误处理路径有测试
- [ ] 边界条件有测试
- [ ] 性能关键路径有基准测试
- [ ] 测试可以独立运行
- [ ] 测试命名清晰描述意图

---

## 快速命令

```bash
# 运行所有测试
npm test

# 监听模式
npm run test:watch

# 生成覆盖率报告
npm run test:coverage

# 运行特定测试文件
npm test -- src/state/plugin_state.test.js

# 运行特定测试用例
npm test -- -t "should initialize data"
```
