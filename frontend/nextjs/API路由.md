# Next.js API 路由

## 1. API 路由概述

Next.js 允许在同一代码库中创建 API 端点，存放在 `pages/api/` 目录下。API 路由是服务器端运行的函数，用于处理 HTTP 请求并返回响应。

## 2. 基础用法

### 2.1 创建简单的 API 路由

在 `pages/api/` 目录下创建 JavaScript 文件，导出一个处理函数：

```jsx
// pages/api/hello.js
export default function handler(req, res) {
  res.status(200).json({ name: 'John Doe' });
}
```

访问 URL: `http://localhost:3000/api/hello`

### 2.2 HTTP 方法处理

可以在处理函数中检查 `req.method` 来处理不同的 HTTP 方法：

```jsx
// pages/api/posts.js
export default function handler(req, res) {
  const { method } = req;

  switch (method) {
    case 'GET':
      // 获取所有文章
      res.status(200).json({ message: '获取所有文章' });
      break;
    case 'POST':
      // 创建新文章
      res.status(201).json({ message: '创建新文章' });
      break;
    case 'PUT':
      // 更新文章
      res.status(200).json({ message: '更新文章' });
      break;
    case 'DELETE':
      // 删除文章
      res.status(200).json({ message: '删除文章' });
      break;
    default:
      // 不支持的方法
      res.setHeader('Allow', ['GET', 'POST', 'PUT', 'DELETE']);
      res.status(405).end(`Method ${method} Not Allowed`);
  }
}
```

## 3. 请求处理

### 3.1 获取查询参数

使用 `req.query` 获取 URL 查询参数：

```jsx
// pages/api/posts.js
export default function handler(req, res) {
  const { page = 1, limit = 10 } = req.query;
  
  res.status(200).json({
    message: '获取文章列表',
    page: parseInt(page),
    limit: parseInt(limit)
  });
}
```

访问 URL: `http://localhost:3000/api/posts?page=2&limit=20`

### 3.2 获取路由参数

API 路由支持动态参数，与页面路由类似：

```jsx
// pages/api/posts/[id].js
export default function handler(req, res) {
  const { id } = req.query;
  
  res.status(200).json({
    message: `获取文章 ${id}`,
    id
  });
}
```

访问 URL: `http://localhost:3000/api/posts/1`

### 3.3 获取请求体

使用 `req.body` 获取请求体数据：

```jsx
// pages/api/posts.js
export default function handler(req, res) {
  if (req.method === 'POST') {
    const { title, content } = req.body;
    
    res.status(201).json({
      message: '创建文章成功',
      post: {
        id: Date.now(),
        title,
        content
      }
    });
  }
}
```

## 4. 响应处理

### 4.1 设置响应状态码

使用 `res.status()` 设置 HTTP 响应状态码：

```jsx
// 成功响应
res.status(200).json({ message: '操作成功' });

// 创建成功
res.status(201).json({ message: '创建成功' });

// 资源未找到
res.status(404).json({ message: '资源未找到' });

// 服务器错误
res.status(500).json({ message: '服务器错误' });
```

### 4.2 设置响应头

使用 `res.setHeader()` 设置响应头：

```jsx
res.setHeader('Content-Type', 'application/json');
res.setHeader('Cache-Control', 'max-age=3600');
res.status(200).json({ message: '响应带有自定义头' });
```

### 4.3 重定向

使用 `res.redirect()` 进行重定向：

```jsx
res.redirect(307, '/api/new-endpoint');
```

## 5. 中间件

### 5.1 自定义中间件

可以创建自定义中间件函数，用于处理认证、日志记录等通用逻辑：

```jsx
// lib/middleware.js
export function withAuth(handler) {
  return async (req, res) => {
    // 检查认证
    const token = req.headers.authorization?.split(' ')[1];
    
    if (!token) {
      return res.status(401).json({ message: '未授权' });
    }
    
    // 验证 token
    try {
      const decoded = verifyToken(token);
      req.user = decoded;
    } catch (error) {
      return res.status(401).json({ message: '无效的令牌' });
    }
    
    // 调用原始处理函数
    return handler(req, res);
  };
}

// pages/api/protected.js
import { withAuth } from '../../lib/middleware';

function protectedHandler(req, res) {
  res.status(200).json({
    message: '访问受保护资源成功',
    user: req.user
  });
}

export default withAuth(protectedHandler);
```

### 5.2 使用第三方中间件

可以使用 `next-connect` 库简化中间件管理：

```jsx
// 安装 next-connect
// npm install next-connect

// pages/api/posts.js
import nc from 'next-connect';

const handler = nc()
  // 中间件：日志记录
  .use((req, res, next) => {
    console.log(`[${new Date().toISOString()}] ${req.method} ${req.url}`);
    next();
  })
  // 中间件：认证
  .use((req, res, next) => {
    const token = req.headers.authorization?.split(' ')[1];
    if (!token) {
      return res.status(401).json({ message: '未授权' });
    }
    req.user = { id: 1, name: 'John' };
    next();
  })
  // GET 请求处理
  .get((req, res) => {
    res.status(200).json({ message: '获取文章列表', user: req.user });
  })
  // POST 请求处理
  .post((req, res) => {
    res.status(201).json({ message: '创建文章', user: req.user });
  })
  // 处理不支持的方法
  .all((req, res) => {
    res.setHeader('Allow', ['GET', 'POST']);
    res.status(405).end(`Method ${req.method} Not Allowed`);
  });

export default handler;
```

## 6. 数据库集成

API 路由可以与各种数据库集成，如 MySQL、MongoDB、PostgreSQL 等。

### 6.1 与 MongoDB 集成

```jsx
// lib/mongodb.js
import { MongoClient } from 'mongodb';

const uri = process.env.MONGODB_URI;
const options = {
  useUnifiedTopology: true,
  useNewUrlParser: true,
};

let client;
let clientPromise;

if (!process.env.MONGODB_URI) {
  throw new Error('请在 .env 文件中配置 MONGODB_URI');
}

if (process.env.NODE_ENV === 'development') {
  // 开发环境下，使用全局变量存储客户端实例
  if (!global._mongoClientPromise) {
    client = new MongoClient(uri, options);
    global._mongoClientPromise = client.connect();
  }
  clientPromise = global._mongoClientPromise;
} else {
  // 生产环境下，直接创建客户端实例
  client = new MongoClient(uri, options);
  clientPromise = client.connect();
}

export default clientPromise;

// pages/api/posts.js
import clientPromise from '../../lib/mongodb';

export default async function handler(req, res) {
  try {
    const client = await clientPromise;
    const db = client.db('blog');
    
    if (req.method === 'GET') {
      const posts = await db.collection('posts').find({}).limit(10).toArray();
      res.status(200).json(posts);
    } else if (req.method === 'POST') {
      const post = await db.collection('posts').insertOne(req.body);
      res.status(201).json(post.ops[0]);
    }
  } catch (error) {
    res.status(500).json({ message: '服务器错误', error: error.message });
  }
}
```

## 7. 环境变量

API 路由可以访问所有环境变量，包括非客户端环境变量：

```jsx
// pages/api/config.js
export default function handler(req, res) {
  res.status(200).json({
    // 可以访问所有环境变量
    apiKey: process.env.API_KEY,
    databaseUrl: process.env.DATABASE_URL,
    // 也可以访问客户端环境变量
    publicApiUrl: process.env.NEXT_PUBLIC_API_URL
  });
}
```

## 8. 部署 API 路由

API 路由在部署时会自动包含在 Next.js 应用中，无需额外配置。可以部署到 Vercel、Netlify、AWS 等平台。

### 8.1 部署到 Vercel

1. 连接 GitHub 仓库到 Vercel
2. 配置环境变量
3. 部署应用
4. API 路由将自动可用

### 8.2 自定义服务器

如果使用自定义服务器，可以将 API 路由与服务器集成：

```js
// server.js
const { createServer } = require('http');
const { parse } = require('url');
const next = require('next');

const dev = process.env.NODE_ENV !== 'production';
const app = next({ dev });
const handle = app.getRequestHandler();

app.prepare().then(() => {
  createServer((req, res) => {
    const parsedUrl = parse(req.url, true);
    const { pathname, query } = parsedUrl;

    // 自定义路由处理
    if (pathname === '/api/custom') {
      res.writeHead(200, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ message: '自定义 API 端点' }));
    } else {
      // 让 Next.js 处理其他路由
      handle(req, res, parsedUrl);
    }
  }).listen(3000, (err) => {
    if (err) throw err;
    console.log('> Ready on http://localhost:3000');
  });
});
```

## 9. API 路由最佳实践

### 9.1 错误处理

始终使用 try-catch 块处理异步操作，并返回适当的错误响应：

```jsx
export default async function handler(req, res) {
  try {
    // 异步操作
    const result = await someAsyncOperation();
    res.status(200).json(result);
  } catch (error) {
    console.error('API 错误:', error);
    res.status(500).json({ message: '服务器错误', error: error.message });
  }
}
```

### 9.2 输入验证

验证所有用户输入，包括查询参数、路由参数和请求体：

```jsx
export default function handler(req, res) {
  if (req.method === 'POST') {
    const { title, content } = req.body;
    
    // 验证输入
    if (!title || !content) {
      return res.status(400).json({ message: '标题和内容不能为空' });
    }
    
    if (title.length < 3) {
      return res.status(400).json({ message: '标题长度不能少于 3 个字符' });
    }
    
    // 处理请求
    res.status(201).json({ message: '创建成功' });
  }
}
```

### 9.3 认证与授权

保护敏感 API 端点，使用适当的认证机制：

```jsx
export default async function handler(req, res) {
  // 检查认证头
  const authHeader = req.headers.authorization;
  if (!authHeader) {
    return res.status(401).json({ message: '未提供认证令牌' });
  }
  
  // 验证令牌
  const token = authHeader.split(' ')[1];
  try {
    const decoded = await verifyToken(token);
    // 检查权限
    if (!decoded.admin) {
      return res.status(403).json({ message: '没有访问权限' });
    }
    
    // 处理请求
    res.status(200).json({ message: '操作成功' });
  } catch (error) {
    res.status(401).json({ message: '无效的认证令牌' });
  }
}
```

### 9.4 性能优化

- 使用缓存减少数据库查询
- 优化查询，只获取必要的数据
- 使用分页处理大量数据
- 压缩响应数据

### 9.5 日志记录

记录 API 请求和响应，便于调试和监控：

```jsx
export default function handler(req, res) {
  // 记录请求
  console.log(`[${new Date().toISOString()}] ${req.method} ${req.url}`);
  
  // 处理请求
  const result = processRequest(req);
  
  // 记录响应
  console.log(`[${new Date().toISOString()}] ${res.statusCode} ${req.url}`);
  
  res.status(200).json(result);
}
```

## 10. 总结

Next.js API 路由提供了一种简单、高效的方式来创建 API 端点，与应用代码集成在同一代码库中。通过 API 路由，可以轻松处理各种 HTTP 请求，与数据库集成，并部署到各种平台。

API 路由是 Next.js 全栈能力的重要组成部分，掌握 API 路由对于构建完整的 Next.js 应用至关重要。