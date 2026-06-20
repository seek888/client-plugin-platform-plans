# JS 运行时 API 文档

## 概述

JS 运行时（JS Runtime）是插件的执行环境，基于 QuickJS 引擎实现。每个 JS 插件拥有独立的运行时实例，实现内存和执行隔离。

### 运行时特性

- **隔离性**: 每个插件独立的 JS 运行时，互不干扰
- **安全性**: 沙箱环境，无法访问文件系统和网络（需通过宿主能力）
- **轻量级**: QuickJS 引擎体积小，启动快
- **ES6+ 支持**: 支持现代 JavaScript 语法

### 限制

- 不支持 DOM API
- 不支持 Node.js 内置模块
- 不支持同步网络请求
- 内存限制：默认 16MB

---

## 全局对象

### host

宿主能力桥接对象，用于调用宿主提供的原生能力。

#### host.invoke(method, params)

调用宿主能力。

**参数**:
- `method` (string): 能力方法名
- `params` (object): 调用参数

**返回**: `Promise<any>` - 能力调用结果

**示例**:

```javascript
// 显示 Toast
await host.invoke('toast.show', {
  message: '操作成功'
});

// 获取存储值
const result = await host.invoke('storage.get', {
  key: 'user_token'
});
console.log('Token:', result.value);

// 发起网络请求
const response = await host.invoke('network.request', {
  method: 'GET',
  url: 'https://api.example.com/articles'
});
console.log('文章列表:', response.json);
```

**错误处理**:

```javascript
try {
  await host.invoke('storage.set', {
    key: 'config',
    value: JSON.stringify({ theme: 'dark' })
  });
} catch (error) {
  console.error('调用失败:', error);
}
```

---

### console

控制台对象，用于日志输出。

#### console.log(...args)

输出普通日志。

```javascript
console.log('Hello, Plugin!');
console.log('User:', { id: 1, name: 'Alice' });
```

#### console.error(...args)

输出错误日志。

```javascript
console.error('发生错误:', error);
```

#### console.warn(...args)

输出警告日志。

```javascript
console.warn('即将废弃的 API');
```

#### console.info(...args)

输出信息日志。

```javascript
console.info('插件已加载');
```

---

### JSON

JSON 处理对象（标准 JavaScript API）。

#### JSON.stringify(value, replacer, space)

将 JavaScript 对象转换为 JSON 字符串。

```javascript
const obj = { name: 'Alice', age: 25 };
const json = JSON.stringify(obj);
// 输出: '{"name":"Alice","age":25}'
```

#### JSON.parse(text)

将 JSON 字符串解析为 JavaScript 对象。

```javascript
const json = '{"name":"Alice","age":25}';
const obj = JSON.parse(json);
console.log(obj.name); // 'Alice'
```

---

### Promise

Promise 对象（标准 JavaScript API）。

```javascript
const promise = new Promise((resolve, reject) => {
  setTimeout(() => {
    resolve('成功');
  }, 1000);
});

promise.then(result => {
  console.log(result); // '成功'
});
```

支持 `async/await` 语法：

```javascript
async function fetchData() {
  const response = await host.invoke('network.request', {
    method: 'GET',
    url: 'https://api.example.com/data'
  });
  return response.json;
}

const data = await fetchData();
console.log(data);
```

---

### setTimeout / setInterval

定时器函数（标准 JavaScript API）。

#### setTimeout(callback, delay, ...args)

延迟执行函数。

```javascript
setTimeout(() => {
  console.log('1 秒后执行');
}, 1000);
```

#### setInterval(callback, delay, ...args)

定期执行函数。

```javascript
const intervalId = setInterval(() => {
  console.log('每 2 秒执行一次');
}, 2000);

// 取消定时器
clearInterval(intervalId);
```

#### clearTimeout(timeoutId)

取消延迟执行。

```javascript
const timeoutId = setTimeout(() => {
  console.log('这不会执行');
}, 1000);

clearTimeout(timeoutId);
```

#### clearInterval(intervalId)

取消定期执行。

```javascript
const intervalId = setInterval(() => {
  console.log('定期执行');
}, 1000);

clearInterval(intervalId);
```

---

## 插件生命周期

### onActivate()

插件激活时调用（入口函数）。

**说明**: 在 manifest.json 中通过 `engine.entryFunction` 配置。

```javascript
// manifest.json
{
  "engine": {
    "entryFunction": "onActivate"
  }
}

// JS 代码
function onActivate() {
  console.log('插件已激活');
  
  // 初始化逻辑
  initPlugin();
  
  // 注册事件监听器
  registerEventListeners();
}
```

---

### onDeactivate()

插件停用时调用（可选）。

```javascript
function onDeactivate() {
  console.log('插件即将停用');
  
  // 清理资源
  cleanup();
  
  // 取消定时器
  clearAllTimers();
}
```

---

## 事件系统

### 事件监听

通过 STAC Schema 中的 `events` 字段绑定事件处理函数。

**STAC Schema**:

```json
{
  "type": "button",
  "id": "submit-btn",
  "props": {
    "text": "提交"
  },
  "events": {
    "onTap": "handleSubmit"
  }
}
```

**JS 事件处理函数**:

```javascript
function handleSubmit(event) {
  console.log('按钮被点击');
  console.log('事件数据:', event);
  
  // 执行提交逻辑
  submitForm();
}
```

---

### 事件对象

事件处理函数接收一个事件对象作为参数。

**事件对象结构**:

```javascript
{
  type: 'onTap',           // 事件类型
  componentId: 'submit-btn', // 组件 ID
  timestamp: 1234567890,   // 时间戳
  data: { ... }            // 事件数据（根据事件类型而定）
}
```

**示例：处理文本输入事件**:

```javascript
function handleInputChange(event) {
  const newValue = event.value;
  console.log('输入值:', newValue);
  
  // 更新状态
  updateState({ inputValue: newValue });
}
```

---

## 状态管理

### 插件状态

插件可以维护自己的状态。推荐使用闭包或模块模式。

**模块模式**:

```javascript
// 状态模块
const State = (function() {
  let state = {
    user: null,
    feeds: [],
    articles: []
  };
  
  return {
    get(key) {
      return state[key];
    },
    
    set(key, value) {
      state[key] = value;
      notifyStateChange(key, value);
    },
    
    getAll() {
      return { ...state };
    }
  };
})();

// 使用状态
State.set('user', { id: 1, name: 'Alice' });
const user = State.get('user');
console.log(user);
```

---

### 持久化状态

使用 `storage.local` 能力持久化状态。

```javascript
// 保存状态
async function saveState(key, value) {
  await host.invoke('storage.set', {
    key: key,
    value: JSON.stringify(value)
  });
}

// 加载状态
async function loadState(key) {
  const result = await host.invoke('storage.get', { key });
  return result.value ? JSON.parse(result.value) : null;
}

// 使用
await saveState('user_preferences', {
  theme: 'dark',
  fontSize: 16
});

const preferences = await loadState('user_preferences');
console.log(preferences);
```

---

## STAC 动态渲染

### 渲染页面

通过返回 STAC Schema 渲染 UI。

```javascript
function renderMainPage() {
  return {
    schemaVersion: '1.0',
    type: 'page',
    title: '首页',
    children: [
      {
        type: 'scaffold',
        props: {
          appBar: {
            type: 'appBar',
            props: {
              title: '我的插件'
            }
          },
          body: {
            type: 'column',
            props: {
              mainAxisAlignment: 'center',
              spacing: 16.0
            },
            children: [
              {
                type: 'text',
                props: {
                  text: '欢迎使用插件'
                },
                style: {
                  fontSize: 20.0,
                  fontWeight: 'bold'
                }
              },
              {
                type: 'button',
                props: {
                  text: '开始使用'
                },
                events: {
                  onTap: 'handleStart'
                }
              }
            ]
          }
        }
      }
    ]
  };
}

// 事件处理
function handleStart() {
  console.log('开始使用');
  // 导航到下一页
  host.invoke('navigation.open', {
    route: '/plugin/features'
  });
}
```

---

### 动态更新 UI

通过重新返回 Schema 更新 UI。

```javascript
let articles = [];

async function loadArticles() {
  const response = await host.invoke('network.request', {
    method: 'GET',
    url: 'https://api.example.com/articles'
  });
  
  articles = response.json.items;
  
  // 重新渲染
  return renderArticleList();
}

function renderArticleList() {
  return {
    schemaVersion: '1.0',
    type: 'page',
    title: '文章列表',
    children: [
      {
        type: 'scaffold',
        props: {
          appBar: {
            type: 'appBar',
            props: {
              title: `文章 (${articles.length})`
            }
          },
          body: {
            type: 'listView',
            children: articles.map(article => ({
              type: 'listItem',
              props: {
                title: article.title,
                subtitle: article.author
              },
              events: {
                onTap: `openArticle_${article.id}`
              }
            }))
          }
        }
      }
    ]
  };
}
```

---

## 数据获取与处理

### 网络请求

```javascript
async function fetchArticles(page = 1, limit = 20) {
  try {
    const response = await host.invoke('network.request', {
      method: 'GET',
      url: 'https://api.example.com/articles',
      query: {
        page: page,
        limit: limit
      },
      headers: {
        'Content-Type': 'application/json'
      }
    });
    
    if (response.statusCode === 200) {
      return response.json.items;
    } else {
      throw new Error(`HTTP ${response.statusCode}`);
    }
  } catch (error) {
    console.error('获取文章失败:', error);
    throw error;
  }
}

// 使用
const articles = await fetchArticles(1, 20);
console.log('获取到', articles.length, '篇文章');
```

---

### POST 请求

```javascript
async function createComment(articleId, content) {
  const response = await host.invoke('network.request', {
    method: 'POST',
    url: 'https://api.example.com/comments',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + getToken()
    },
    body: {
      articleId: articleId,
      content: content
    }
  });
  
  return response.json;
}

// 使用
const comment = await createComment('123', '这是一条评论');
console.log('评论已创建:', comment);
```

---

### 错误处理

```javascript
async function safeApiCall(url, options) {
  try {
    const response = await host.invoke('network.request', {
      url: url,
      ...options
    });
    
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return { success: true, data: response.json };
    } else {
      return {
        success: false,
        error: `HTTP ${response.statusCode}`,
        message: response.body
      };
    }
  } catch (error) {
    return {
      success: false,
      error: 'NetworkError',
      message: error.toString()
    };
  }
}

// 使用
const result = await safeApiCall('https://api.example.com/data', {
  method: 'GET'
});

if (result.success) {
  console.log('数据:', result.data);
} else {
  console.error('错误:', result.error, result.message);
}
```

---

## 工具函数

### 实用函数库

```javascript
// 工具函数模块
const Utils = {
  // 防抖
  debounce(func, delay) {
    let timeoutId;
    return function(...args) {
      clearTimeout(timeoutId);
      timeoutId = setTimeout(() => func.apply(this, args), delay);
    };
  },
  
  // 节流
  throttle(func, limit) {
    let inThrottle;
    return function(...args) {
      if (!inThrottle) {
        func.apply(this, args);
        inThrottle = true;
        setTimeout(() => inThrottle = false, limit);
      }
    };
  },
  
  // 深度克隆
  deepClone(obj) {
    return JSON.parse(JSON.stringify(obj));
  },
  
  // 格式化日期
  formatDate(timestamp) {
    const date = new Date(timestamp);
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
  },
  
  // 截断文本
  truncate(text, maxLength) {
    if (text.length <= maxLength) return text;
    return text.substring(0, maxLength) + '...';
  }
};

// 使用
const debouncedSearch = Utils.debounce(performSearch, 300);
const formattedDate = Utils.formatDate(Date.now());
```

---

## 最佳实践

### 1. 错误处理

始终使用 try-catch 包裹异步调用。

```javascript
async function initialize() {
  try {
    const config = await loadConfig();
    const data = await fetchData();
    render(data);
  } catch (error) {
    console.error('初始化失败:', error);
    showErrorPage(error.message);
  }
}
```

---

### 2. 资源清理

在 `onDeactivate` 中清理资源。

```javascript
let timers = [];

function onActivate() {
  const timer = setInterval(() => {
    checkUpdates();
  }, 60000);
  
  timers.push(timer);
}

function onDeactivate() {
  // 清理所有定时器
  timers.forEach(timer => clearInterval(timer));
  timers = [];
  
  // 保存状态
  saveCurrentState();
}
```

---

### 3. 性能优化

- 避免频繁的 DOM 更新
- 使用防抖/节流优化事件处理
- 缓存不变的数据

```javascript
// 缓存数据
let cachedCategories = null;

async function getCategories() {
  if (cachedCategories) {
    return cachedCategories;
  }
  
  const response = await host.invoke('network.request', {
    method: 'GET',
    url: 'https://api.example.com/categories'
  });
  
  cachedCategories = response.json;
  return cachedCategories;
}
```

---

### 4. 模块化组织

将代码组织成模块。

```javascript
// api.js 模块
const API = {
  baseUrl: 'https://api.example.com',
  
  async get(endpoint, params) {
    return await host.invoke('network.request', {
      method: 'GET',
      url: this.baseUrl + endpoint,
      query: params
    });
  },
  
  async post(endpoint, data) {
    return await host.invoke('network.request', {
      method: 'POST',
      url: this.baseUrl + endpoint,
      body: data
    });
  }
};

// ui.js 模块
const UI = {
  showLoading(message) {
    return host.invoke('loading.show', { message });
  },
  
  hideLoading() {
    return host.invoke('loading.hide');
  },
  
  showToast(message) {
    return host.invoke('toast.show', { message });
  }
};

// 使用
await UI.showLoading('加载中...');
const articles = await API.get('/articles', { page: 1 });
await UI.hideLoading();
```

---

### 5. 状态同步

使用观察者模式同步状态变化。

```javascript
const StateManager = (function() {
  let state = {};
  let listeners = {};
  
  return {
    setState(key, value) {
      state[key] = value;
      this.notify(key, value);
    },
    
    getState(key) {
      return state[key];
    },
    
    subscribe(key, callback) {
      if (!listeners[key]) {
        listeners[key] = [];
      }
      listeners[key].push(callback);
    },
    
    notify(key, value) {
      if (listeners[key]) {
        listeners[key].forEach(callback => callback(value));
      }
    }
  };
})();

// 订阅状态变化
StateManager.subscribe('articles', (articles) => {
  console.log('文章列表更新:', articles.length);
  rerenderArticleList();
});

// 更新状态（会触发监听器）
StateManager.setState('articles', newArticles);
```

---

## 完整示例

### RSS 新闻阅读器插件

```javascript
// ========== 全局状态 ==========
const State = {
  feeds: [],
  articles: [],
  currentFeedId: null
};

// ========== 入口函数 ==========
async function onActivate() {
  console.log('RSS 阅读器插件已激活');
  
  // 加载订阅源
  await loadFeeds();
  
  // 加载文章
  await loadArticles();
}

// ========== 数据加载 ==========
async function loadFeeds() {
  const result = await host.invoke('storage.get', {
    key: 'rss_feeds'
  });
  
  if (result.value) {
    State.feeds = JSON.parse(result.value);
  } else {
    // 默认订阅源
    State.feeds = [
      { id: '1', name: 'Tech News', url: 'https://example.com/tech.rss' },
      { id: '2', name: 'World News', url: 'https://example.com/world.rss' }
    ];
    await saveFeeds();
  }
}

async function saveFeeds() {
  await host.invoke('storage.set', {
    key: 'rss_feeds',
    value: JSON.stringify(State.feeds)
  });
}

async function loadArticles() {
  const feed = State.feeds[0];
  if (!feed) return;
  
  try {
    await host.invoke('loading.show', { message: '加载文章...' });
    
    const response = await host.invoke('network.request', {
      method: 'GET',
      url: feed.url
    });
    
    // 解析 RSS（简化示例）
    State.articles = parseRSS(response.body);
    
    await host.invoke('loading.hide');
    await host.invoke('toast.show', {
      message: `已加载 ${State.articles.length} 篇文章`
    });
  } catch (error) {
    await host.invoke('loading.hide');
    console.error('加载文章失败:', error);
    await host.invoke('dialog.alert', {
      title: '加载失败',
      message: error.toString()
    });
  }
}

function parseRSS(xmlString) {
  // RSS 解析逻辑（简化）
  return [
    { id: '1', title: '文章 1', link: 'https://example.com/1' },
    { id: '2', title: '文章 2', link: 'https://example.com/2' }
  ];
}

// ========== UI 渲染 ==========
function renderMainPage() {
  return {
    schemaVersion: '1.0',
    type: 'page',
    title: 'RSS 阅读器',
    children: [
      {
        type: 'scaffold',
        props: {
          appBar: {
            type: 'appBar',
            props: {
              title: 'RSS 阅读器',
              actions: [
                {
                  type: 'iconButton',
                  props: { icon: 'refresh' },
                  events: { onTap: 'handleRefresh' }
                }
              ]
            }
          },
          body: {
            type: 'listView',
            children: State.articles.map(article => ({
              type: 'card',
              props: {
                margin: '8,16,8,16'
              },
              children: [
                {
                  type: 'listItem',
                  props: {
                    title: article.title,
                    subtitle: article.link
                  },
                  events: {
                    onTap: `openArticle_${article.id}`
                  }
                }
              ]
            }))
          }
        }
      }
    ]
  };
}

// ========== 事件处理 ==========
async function handleRefresh() {
  await loadArticles();
  // 触发 UI 重新渲染
  return renderMainPage();
}

function openArticle_1() {
  openArticleDetail(State.articles[0]);
}

function openArticle_2() {
  openArticleDetail(State.articles[1]);
}

async function openArticleDetail(article) {
  await host.invoke('navigation.open', {
    route: '/article/detail',
    arguments: {
      url: article.link,
      title: article.title
    }
  });
}

// ========== 停用时清理 ==========
function onDeactivate() {
  console.log('RSS 阅读器插件即将停用');
  // 保存当前状态
  saveFeeds();
}
```

---

## 调试技巧

### 1. 日志输出

使用 `console.log` 输出调试信息。

```javascript
console.log('当前状态:', State);
console.log('API 响应:', response);
```

---

### 2. 错误捕获

捕获并记录所有错误。

```javascript
window.addEventListener('error', (event) => {
  console.error('全局错误:', event.error);
});

window.addEventListener('unhandledrejection', (event) => {
  console.error('未处理的 Promise 拒绝:', event.reason);
});
```

---

### 3. 性能监控

记录关键操作的耗时。

```javascript
async function loadData() {
  const startTime = Date.now();
  
  const data = await fetchData();
  
  const endTime = Date.now();
  console.log(`加载耗时: ${endTime - startTime}ms`);
  
  return data;
}
```

---

## 常见问题

### Q1: 如何在插件间通信？

A: 使用宿主提供的事件总线或共享存储。

```javascript
// 发送事件
await host.invoke('eventBus.emit', {
  event: 'article.updated',
  data: { articleId: '123' }
});

// 监听事件（需要在 onActivate 中注册）
host.on('article.updated', (data) => {
  console.log('文章更新:', data);
});
```

---

### Q2: 如何实现数据缓存？

A: 使用内存缓存或 `storage.local`。

```javascript
const Cache = {
  memory: {},
  
  async get(key) {
    // 优先从内存读取
    if (this.memory[key]) {
      return this.memory[key];
    }
    
    // 从持久化存储读取
    const result = await host.invoke('storage.get', { key });
    if (result.value) {
      const data = JSON.parse(result.value);
      this.memory[key] = data;
      return data;
    }
    
    return null;
  },
  
  async set(key, value, persist = true) {
    this.memory[key] = value;
    
    if (persist) {
      await host.invoke('storage.set', {
        key: key,
        value: JSON.stringify(value)
      });
    }
  }
};
```

---

### Q3: 如何处理大量数据？

A: 使用分页加载和虚拟滚动。

```javascript
let currentPage = 1;
const pageSize = 20;

async function loadMoreArticles() {
  const response = await host.invoke('network.request', {
    method: 'GET',
    url: 'https://api.example.com/articles',
    query: {
      page: currentPage,
      limit: pageSize
    }
  });
  
  State.articles = State.articles.concat(response.json.items);
  currentPage++;
  
  return renderArticleList();
}

// 在 listView 中触发
function handleScrollEnd() {
  loadMoreArticles();
}
```

---

## 附录

### 支持的 JavaScript 特性

- ES6+ 语法（箭头函数、解构、模板字符串等）
- Promise 和 async/await
- Map, Set, WeakMap, WeakSet
- Proxy, Reflect
- 数组方法（map, filter, reduce 等）
- 字符串方法
- 正则表达式

### 不支持的特性

- DOM API（document, window 等）
- Node.js 内置模块（fs, http 等）
- XMLHttpRequest / fetch（使用 `host.invoke('network.request')` 替代）
- WebSocket（规划中）
- Web Workers

---

## 相关文档

- [能力桥接 API 文档](./capabilities.md)
- [STAC 组件库文档](./stac-components.md)
- [插件 Manifest 配置文档](./manifest.md)
