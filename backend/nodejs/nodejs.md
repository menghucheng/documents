# Node.js 完整学习指南

## 1. 什么是 Node.js

Node.js 是一个基于 Chrome V8 引擎的 JavaScript 运行时环境，用于构建高性能、可扩展的网络应用。它采用事件驱动、非阻塞 I/O 模型，使其轻量且高效。

### 1.1 Node.js 的特点

- **单线程**：使用事件循环处理并发请求
- **非阻塞 I/O**：提高应用程序的吞吐量
- **事件驱动**：通过事件和回调函数处理异步操作
- **跨平台**：可在 Windows、Linux、macOS 等操作系统上运行
- **包管理**：使用 npm 或 yarn 管理依赖

### 1.2 Node.js 与浏览器的区别

| 特性 | Node.js | 浏览器 |
|------|---------|--------|
| JavaScript 引擎 | V8 | 各浏览器自有引擎 |
| 执行环境 | 服务器端 | 客户端 |
| DOM 操作 | 不支持 | 支持 |
| 模块系统 | CommonJS | ES 模块 |
| I/O 操作 | 支持 | 有限支持（通过 API） |
| 网络操作 | 支持 | 有限支持 |

## 2. 安装与配置

### 2.1 安装 Node.js

#### Windows

1. 访问 [Node.js 官网](https://nodejs.org/)
2. 下载 LTS（长期支持）版本
3. 运行安装程序，按照提示完成安装

#### macOS

使用 Homebrew 安装：

```bash
brew install node
```

#### Linux

使用 apt（Ubuntu/Debian）：

```bash
sudo apt update
sudo apt install nodejs npm
```

使用 yum（CentOS/RHEL）：

```bash
sudo yum install nodejs npm
```

### 2.2 验证安装

```bash
node -v       # 查看 Node.js 版本
npm -v        # 查看 npm 版本
```

### 2.3 更换 npm 源

为了提高下载速度，可以更换为国内镜像源：

```bash
npm config set registry https://registry.npmmirror.com/
```

## 3. 基础语法

### 3.1 模块系统

Node.js 使用 CommonJS 模块系统，通过 `require()` 和 `module.exports` 实现模块的导入和导出。

#### 导出模块

```javascript
// utils.js
const add = (a, b) => a + b;
const subtract = (a, b) => a - b;

module.exports = {
  add,
  subtract
};

// 或
module.exports.add = add;
module.exports.subtract = subtract;
```

#### 导入模块

```javascript
// app.js
const utils = require('./utils');

console.log(utils.add(2, 3)); // 输出: 5
console.log(utils.subtract(5, 2)); // 输出: 3

// 或
const { add, subtract } = require('./utils');
```

### 3.2 全局对象

Node.js 中的全局对象是 `global`，而不是浏览器中的 `window`。

常用的全局变量：

- `__dirname`：当前文件所在目录的绝对路径
- `__filename`：当前文件的绝对路径
- `process`：进程对象，包含环境变量、命令行参数等
- `console`：控制台对象，用于输出日志
- `setTimeout`/`setInterval`：定时器函数

### 3.3 文件系统操作

Node.js 提供了 `fs` 模块用于文件系统操作。

#### 同步操作

```javascript
const fs = require('fs');

// 读取文件
const data = fs.readFileSync('file.txt', 'utf8');
console.log(data);

// 写入文件
fs.writeFileSync('file.txt', 'Hello, Node.js!');

// 创建目录
fs.mkdirSync('new-dir');
```

#### 异步操作

```javascript
const fs = require('fs');

// 读取文件
fs.readFile('file.txt', 'utf8', (err, data) => {
  if (err) throw err;
  console.log(data);
});

// 写入文件
fs.writeFile('file.txt', 'Hello, Node.js!', (err) => {
  if (err) throw err;
  console.log('文件已写入');
});
```

## 4. 核心模块

### 4.1 HTTP 模块

用于创建 HTTP 服务器和客户端。

#### 创建 HTTP 服务器

```javascript
const http = require('http');

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end('Hello, World!\n');
});

const PORT = 3000;
server.listen(PORT, () => {
  console.log(`服务器运行在 http://localhost:${PORT}/`);
});
```

### 4.2 Express 框架

Express 是 Node.js 最流行的 Web 框架，用于快速构建 Web 应用和 API。

#### 安装 Express

```bash
npm install express
```

#### 创建 Express 应用

```javascript
const express = require('express');
const app = express();
const PORT = 3000;

// 中间件
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// 路由
app.get('/', (req, res) => {
  res.send('Hello, Express!');
});

app.get('/users/:id', (req, res) => {
  res.json({ id: req.params.id, name: 'User ' + req.params.id });
});

// 启动服务器
app.listen(PORT, () => {
  console.log(`服务器运行在 http://localhost:${PORT}/`);
});
```

### 4.3 路径模块

`path` 模块用于处理文件路径。

```javascript
const path = require('path');

// 连接路径
const fullPath = path.join(__dirname, 'files', 'data.txt');

// 获取文件扩展名
const extname = path.extname('file.txt'); // .txt

// 获取文件名
const basename = path.basename('/path/to/file.txt'); // file.txt
```

## 5. 异步编程

### 5.1 回调函数

回调函数是 Node.js 早期处理异步操作的主要方式。

```javascript
const fs = require('fs');

fs.readFile('file.txt', 'utf8', (err, data) => {
  if (err) {
    console.error('读取文件失败:', err);
    return;
  }
  console.log('文件内容:', data);
});
```

### 5.2 Promise

Promise 提供了更优雅的异步编程方式。

```javascript
const fs = require('fs').promises;

fs.readFile('file.txt', 'utf8')
  .then(data => {
    console.log('文件内容:', data);
  })
  .catch(err => {
    console.error('读取文件失败:', err);
  });
```

### 5.3 async/await

async/await 是基于 Promise 的语法糖，使异步代码看起来像同步代码。

```javascript
const fs = require('fs').promises;

async function readFile() {
  try {
    const data = await fs.readFile('file.txt', 'utf8');
    console.log('文件内容:', data);
  } catch (err) {
    console.error('读取文件失败:', err);
  }
}

readFile();
```

## 6. 数据库操作

### 6.1 MongoDB

使用 Mongoose 库操作 MongoDB。

#### 安装 Mongoose

```bash
npm install mongoose
```

#### 连接 MongoDB

```javascript
const mongoose = require('mongoose');

async function connectDB() {
  try {
    await mongoose.connect('mongodb://localhost:27017/mydatabase', {
      useNewUrlParser: true,
      useUnifiedTopology: true
    });
    console.log('MongoDB 连接成功');
  } catch (err) {
    console.error('MongoDB 连接失败:', err);
  }
}

connectDB();
```

#### 创建模型和架构

```javascript
const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true
  },
  email: {
    type: String,
    required: true,
    unique: true
  },
  age: {
    type: Number,
    min: 0
  }
});

const User = mongoose.model('User', userSchema);

// 创建用户
async function createUser() {
  const user = new User({
    name: 'John Doe',
    email: 'john@example.com',
    age: 30
  });
  
  try {
    const savedUser = await user.save();
    console.log('用户创建成功:', savedUser);
  } catch (err) {
    console.error('用户创建失败:', err);
  }
}

createUser();
```

### 6.2 MySQL

使用 mysql2 库操作 MySQL。

#### 安装 mysql2

```bash
npm install mysql2
```

#### 连接 MySQL

```javascript
const mysql = require('mysql2/promise');

async function connectDB() {
  try {
    const connection = await mysql.createConnection({
      host: 'localhost',
      user: 'root',
      password: 'password',
      database: 'mydatabase'
    });
    
    console.log('MySQL 连接成功');
    return connection;
  } catch (err) {
    console.error('MySQL 连接失败:', err);
  }
}

async function queryDB() {
  const connection = await connectDB();
  if (connection) {
    const [rows] = await connection.execute('SELECT * FROM users');
    console.log('查询结果:', rows);
    await connection.end();
  }
}

queryDB();
```

## 7. 中间件

中间件是处理请求和响应的函数，可以访问请求对象、响应对象和下一个中间件函数。

### 7.1 自定义中间件

```javascript
const express = require('express');
const app = express();

// 日志中间件
const loggerMiddleware = (req, res, next) => {
  console.log(`${new Date().toISOString()} - ${req.method} ${req.url}`);
  next();
};

// 错误处理中间件
const errorMiddleware = (err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send('Something broke!');
};

app.use(loggerMiddleware);

app.get('/', (req, res) => {
  res.send('Hello, World!');
});

app.use(errorMiddleware);

app.listen(3000, () => {
  console.log('服务器运行在 http://localhost:3000/');
});
```

### 7.2 常用中间件

- **express.json()**：解析 JSON 请求体
- **express.urlencoded()**：解析 URL 编码的请求体
- **express.static()**：提供静态文件服务
- **cors**：处理跨域资源共享
- **helmet**：设置安全相关的 HTTP 头

## 8. 测试

### 8.1 Jest

Jest 是一个流行的 JavaScript 测试框架。

#### 安装 Jest

```bash
npm install --save-dev jest
```

#### 编写测试

```javascript
// utils.js
export const add = (a, b) => a + b;

// utils.test.js
const { add } = require('./utils');

test('adds 2 + 3 to equal 5', () => {
  expect(add(2, 3)).toBe(5);
});
```

#### 运行测试

```bash
npm test
```

### 8.2 集成测试

使用 Supertest 进行 HTTP 集成测试。

#### 安装 Supertest

```bash
npm install --save-dev supertest
```

#### 编写集成测试

```javascript
const request = require('supertest');
const app = require('./app');

test('GET / should return Hello, Express!', async () => {
  const response = await request(app).get('/');
  expect(response.statusCode).toBe(200);
  expect(response.text).toBe('Hello, Express!');
});
```

## 9. 部署

### 9.1 部署到 Heroku

1. 创建 Heroku 账号并安装 Heroku CLI
2. 登录 Heroku：`heroku login`
3. 初始化 Git 仓库：`git init`
4. 创建 Heroku 应用：`heroku create`
5. 部署应用：`git push heroku master`

### 9.2 部署到 AWS

1. 创建 EC2 实例
2. 安装 Node.js 和 npm
3. 克隆代码仓库
4. 安装依赖：`npm install`
5. 使用 PM2 管理进程：`pm2 start app.js`
6. 配置 Nginx 作为反向代理

### 9.3 使用 Docker 部署

#### 创建 Dockerfile

```dockerfile
FROM node:16-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3000

CMD ["node", "app.js"]
```

#### 构建和运行 Docker 镜像

```bash
docker build -t my-node-app .
docker run -p 3000:3000 my-node-app
```

## 10. 性能优化

### 10.1 代码优化

- 使用异步 I/O 操作
- 避免阻塞事件循环
- 使用流处理大文件
- 合理使用缓存

### 10.2 数据库优化

- 使用索引
- 优化查询
- 使用连接池
- 合理设计数据库 schema

### 10.3 服务器优化

- 使用负载均衡
- 启用 Gzip 压缩
- 使用 CDN 分发静态资源
- 配置适当的 HTTP 缓存头

## 11. 安全性

### 11.1 常见安全问题

- SQL 注入
- XSS（跨站脚本攻击）
- CSRF（跨站请求伪造）
- 密码存储不安全
- 敏感信息泄露

### 11.2 安全最佳实践

- 使用参数化查询防止 SQL 注入
- 对用户输入进行验证和过滤
- 使用 HTTPS
- 安全存储密码（使用 bcrypt 等库）
- 定期更新依赖
- 使用安全中间件（如 helmet）

## 12. 常见问题与解决方案

### 12.1 端口被占用

**问题**：启动服务器时提示端口被占用。

**解决方案**：

- 查找占用端口的进程：`lsof -i :3000`（macOS/Linux）或 `netstat -ano | findstr :3000`（Windows）
- 终止占用端口的进程：`kill -9 <PID>`（macOS/Linux）或 `taskkill /PID <PID> /F`（Windows）
- 使用不同的端口启动服务器
- 使用 Node.js 代码查找和终止占用端口的进程：

```javascript
const { exec } = require('child_process');
const os = require('os');

function killProcessUsingPort(port) {
  const platform = os.platform();
  let command;
  
  if (platform === 'win32') {
    // Windows
    command = `netstat -ano | findstr :${port}`;
    exec(command, (err, stdout) => {
      if (err) {
        console.error('查找进程失败:', err);
        return;
      }
      
      const lines = stdout.trim().split('\n');
      if (lines.length > 0) {
        const lastLine = lines[lines.length - 1];
        const pid = lastLine.trim().split(/\s+/).pop();
        exec(`taskkill /PID ${pid} /F`, (err) => {
          if (err) {
            console.error('终止进程失败:', err);
          } else {
            console.log(`已终止占用端口 ${port} 的进程，PID: ${pid}`);
          }
        });
      } else {
        console.log(`端口 ${port} 未被占用`);
      }
    });
  } else {
    // macOS/Linux
    command = `lsof -t -i :${port}`;
    exec(command, (err, stdout) => {
      if (err) {
        console.log(`端口 ${port} 未被占用`);
        return;
      }
      
      const pid = stdout.trim();
      if (pid) {
        exec(`kill -9 ${pid}`, (err) => {
          if (err) {
            console.error('终止进程失败:', err);
          } else {
            console.log(`已终止占用端口 ${port} 的进程，PID: ${pid}`);
          }
        });
      } else {
        console.log(`端口 ${port} 未被占用`);
      }
    });
  }
}

// 使用示例
killProcessUsingPort(3000);
```

- 使用 Node.js 代码自动查找可用端口：

```javascript
const net = require('net');

function findAvailablePort(startPort = 3000, maxPort = 9000) {
  return new Promise((resolve, reject) => {
    const server = net.createServer();
    
    server.on('error', (err) => {
      if (err.code === 'EADDRINUSE') {
        if (startPort < maxPort) {
          server.close();
          findAvailablePort(startPort + 1, maxPort).then(resolve).catch(reject);
        } else {
          reject(new Error('没有找到可用端口'));
        }
      } else {
        reject(err);
      }
    });
    
    server.on('listening', () => {
      server.close();
      resolve(startPort);
    });
    
    server.listen(startPort);
  });
}

// 使用示例
findAvailablePort(3000)
  .then(port => {
    console.log(`找到可用端口: ${port}`);
    // 在这里启动你的服务器，使用找到的端口
  })
  .catch(err => {
    console.error('查找端口失败:', err);
  });
```

### 12.2 依赖冲突

**问题**：安装依赖时出现版本冲突。

**解决方案**：

- 使用 npm 或 yarn 的锁文件（package-lock.json 或 yarn.lock）
- 使用 npx 运行命令，避免全局依赖冲突
- 使用容器化部署，隔离依赖环境

### 12.3 内存泄漏

**问题**：应用程序内存占用不断增加。

**解决方案**：

- 使用 Node.js 内置的内存分析工具：`node --inspect app.js`
- 使用 heapdump 或 clinic 等工具分析内存使用情况
- 避免全局变量累积
- 正确关闭资源（如数据库连接、文件流）

## 13. Excel 处理

### 13.1 使用 SheetJS 处理 Excel 文件

SheetJS 是 Node.js 中最流行的 Excel 处理库，支持读取和写入 Excel 文件。

#### 13.1.1 安装 SheetJS

```bash
npm install xlsx
```

#### 13.1.2 读取 Excel 文件

```javascript
const XLSX = require('xlsx');

// 读取 Excel 文件
const workbook = XLSX.readFile('data.xlsx');

// 获取工作表名称
const sheetNames = workbook.SheetNames;

// 获取第一个工作表
const worksheet = workbook.Sheets[sheetNames[0]];

// 将工作表转换为 JSON
const data = XLSX.utils.sheet_to_json(worksheet);

console.log(data);
```

#### 13.1.3 写入 Excel 文件

```javascript
const XLSX = require('xlsx');

// 示例数据
const data = [
  { Name: '张三', Age: 25, City: '北京' },
  { Name: '李四', Age: 30, City: '上海' },
  { Name: '王五', Age: 28, City: '广州' }
];

// 创建工作表
const worksheet = XLSX.utils.json_to_sheet(data);

// 创建工作簿
const workbook = XLSX.utils.book_new();
XLSX.utils.book_append_sheet(workbook, worksheet, 'Sheet1');

// 写入文件
XLSX.writeFile(workbook, 'output.xlsx');

console.log('Excel 文件已生成');
```

#### 13.1.4 读取指定工作表

```javascript
const XLSX = require('xlsx');

// 读取 Excel 文件
const workbook = XLSX.readFile('data.xlsx');

// 获取指定名称的工作表
const worksheet = workbook.Sheets['Sheet2'];

// 将工作表转换为 JSON
const data = XLSX.utils.sheet_to_json(worksheet);

console.log(data);
```

#### 13.1.5 处理大型 Excel 文件

对于大型 Excel 文件，可以使用流式读取来提高性能：

```javascript
const XLSX = require('xlsx');
const fs = require('fs');

// 读取文件内容
const fileContent = fs.readFileSync('large_file.xlsx');

// 解析文件
const workbook = XLSX.read(fileContent, { type: 'buffer' });

// 获取工作表
const worksheet = workbook.Sheets[workbook.SheetNames[0]];

// 转换为 JSON，使用流式处理
const data = XLSX.utils.sheet_to_json(worksheet, {
  header: 1, // 第一行作为标题
  defval: '', // 空单元格的默认值
  blankrows: false // 跳过空行
});

console.log(`共读取 ${data.length} 行数据`);
```

## 13. 学习资源

### 13.1 官方文档

- [Node.js 官方文档](https://nodejs.org/docs/latest-v16.x/api/)
- [Express 官方文档](https://expressjs.com/)
- [npm 官方文档](https://docs.npmjs.com/)

### 13.2 在线课程

- [Node.js 官方教程](https://nodejs.dev/learn/)
- [MDN Web Docs - Node.js](https://developer.mozilla.org/en-US/docs/Learn/Server-side/Express_Nodejs)
- [Coursera - Node.js 课程](https://www.coursera.org/courses?query=node.js)

### 13.3 书籍

- 《Node.js 设计模式》
- 《深入理解 Node.js》
- 《Express.js 实战》

## 14. 总结

Node.js 是一个强大的 JavaScript 运行时环境，适用于构建各种类型的应用程序，从简单的命令行工具到复杂的 Web 应用和 API。通过学习 Node.js 的核心概念、异步编程模型和常用框架，你可以构建高性能、可扩展的应用程序。

Node.js 的生态系统非常丰富，拥有大量的第三方库和工具，可以帮助你快速开发应用程序。同时，Node.js 社区非常活跃，不断推出新的功能和改进，使 Node.js 成为现代 Web 开发的重要组成部分。

希望本指南对你学习 Node.js 有所帮助！