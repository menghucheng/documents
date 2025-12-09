# Prisma 文档

## 1. 基础概念

### 1.1 什么是 Prisma？

Prisma 是一个现代化的 ORM（对象关系映射）工具，专为 Node.js 和 TypeScript 应用设计。它提供了一个直观的数据模型定义语言、自动生成的类型安全 API 以及强大的迁移工具，帮助开发者更高效地与数据库交互。

### 1.2 核心组件

Prisma 由以下核心组件组成：

1. **Prisma Schema**：使用 Prisma 数据模型语言（PDML）定义数据模型的配置文件
2. **Prisma Client**：自动生成的类型安全查询构建器，用于与数据库交互
3. **Prisma Migrate**：用于数据库迁移和架构管理的工具
4. **Prisma Studio**：可视化数据库管理工具

### 1.3 支持的数据库

Prisma 支持多种主流数据库：

- PostgreSQL
- MySQL
- SQLite
- SQL Server
- MongoDB（预览版）

### 1.4 核心特性

- **类型安全**：自动生成的 TypeScript 类型，提供编译时类型检查
- **直观的数据模型**：使用简洁的声明式语法定义数据模型
- **强大的查询 API**：支持复杂查询、关系查询、事务等
- **自动迁移**：轻松管理数据库架构变更
- **可视化管理工具**：Prisma Studio 提供直观的数据库管理界面
- **生态集成**：与 Next.js、NestJS、GraphQL 等主流框架深度集成
- **高性能**：优化的查询执行，减少数据库负载

## 2. 安装

### 2.1 初始化项目

首先，创建一个新的 Node.js 项目：

```bash
mkdir prisma-example
cd prisma-example
npm init -y
```

### 2.2 安装 Prisma CLI

安装 Prisma CLI 作为开发依赖：

```bash
npm install -D prisma
```

### 2.3 初始化 Prisma

初始化 Prisma 并创建初始配置：

```bash
npx prisma init
```

这将创建以下文件和目录：

- `prisma/schema.prisma`：Prisma 模式文件
- `.env`：环境变量文件，用于存储数据库连接字符串

### 2.4 安装 Prisma Client

安装 Prisma Client 作为生产依赖：

```bash
npm install @prisma/client
```

## 3. 配置

### 3.1 数据库连接

在 `.env` 文件中配置数据库连接字符串：

#### 3.1.1 PostgreSQL

```env
DATABASE_URL="postgresql://user:password@localhost:5432/mydb?schema=public"
```

#### 3.1.2 MySQL

```env
DATABASE_URL="mysql://user:password@localhost:3306/mydb"
```

#### 3.1.3 SQLite

```env
DATABASE_URL="file:./dev.db"
```

### 3.2 Prisma Schema 基本结构

`schema.prisma` 文件包含数据模型定义和数据库配置：

```prisma
// prisma/schema.prisma
generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"  // 或 mysql, sqlite, sqlserver, mongodb
  url      = env("DATABASE_URL")
}

// 数据模型定义
model User {
  id    Int     @id @default(autoincrement())
  name  String
  email String  @unique
  posts Post[]
}

model Post {
  id        Int      @id @default(autoincrement())
  title     String
  content   String?
  published Boolean  @default(false)
  author    User     @relation(fields: [authorId], references: [id])
  authorId  Int
}
```

## 4. 数据模型定义

### 4.1 模型基本语法

```prisma
model ModelName {
  fieldName FieldType Attribute1 Attribute2
}
```

### 4.2 常用数据类型

| 数据类型 | 描述 | 对应数据库类型 |
|----------|------|----------------|
| `String` | 字符串 | `VARCHAR` |
| `Boolean` | 布尔值 | `BOOLEAN` |
| `Int` | 整数 | `INT` |
| `BigInt` | 大整数 | `BIGINT` |
| `Float` | 浮点数 | `FLOAT` |
| `Decimal` | 高精度小数 | `DECIMAL` |
| `DateTime` | 日期时间 | `DATETIME`/`TIMESTAMP` |
| `Json` | JSON 数据 | `JSON`/`JSONB` |
| `Bytes` | 二进制数据 | `BLOB` |

### 4.3 常用属性

| 属性 | 描述 | 示例 |
|------|------|------|
| `@id` | 主键 | `id Int @id` |
| `@default(value)` | 默认值 | `createdAt DateTime @default(now())` |
| `@unique` | 唯一约束 | `email String @unique` |
| `@relation()` | 关系定义 | `author User @relation(fields: [authorId], references: [id])` |
| `@map(name)` | 映射到数据库字段 | `fullName String @map("full_name")` |
| `@db.Type` | 数据库特定类型 | `price Decimal @db.Decimal(10, 2)` |
| `@updatedAt` | 自动更新时间戳 | `updatedAt DateTime @updatedAt` |
| `@ignore` | 忽略该字段 | `transientField String @ignore` |

### 4.4 关系定义

#### 4.4.1 一对一关系

```prisma
model User {
  id      Int      @id @default(autoincrement())
  profile Profile?
}

model Profile {
  id     Int  @id @default(autoincrement())
  bio    String
  user   User @relation(fields: [userId], references: [id])
  userId Int  @unique
}
```

#### 4.4.2 一对多关系

```prisma
model User {
  id    Int     @id @default(autoincrement())
  posts Post[]
}

model Post {
  id        Int   @id @default(autoincrement())
  author    User  @relation(fields: [authorId], references: [id])
  authorId  Int
}
```

#### 4.4.3 多对多关系

```prisma
model User {
  id    Int      @id @default(autoincrement())
  roles Role[]   @relation(through: UserRole)
}

model Role {
  id    Int      @id @default(autoincrement())
  users User[]   @relation(through: UserRole)
}

model UserRole {
  userId Int @map("user_id")
  roleId Int @map("role_id")
  user   User @relation(fields: [userId], references: [id])
  role   Role @relation(fields: [roleId], references: [id])

  @@id([userId, roleId])
}
```

## 5. 数据库迁移

### 5.1 创建初始迁移

在定义好数据模型后，创建初始数据库迁移：

```bash
npx prisma migrate dev --name init
```

这将：
1. 创建迁移文件
2. 执行迁移，创建数据库表
3. 生成 Prisma Client

### 5.2 应用迁移

对于已存在的迁移，使用以下命令应用：

```bash
npx prisma migrate deploy
```

### 5.3 重置数据库

重置数据库并重新应用所有迁移：

```bash
npx prisma migrate reset
```

### 5.4 查看迁移历史

查看已应用的迁移：

```bash
npx prisma migrate status
```

## 6. Prisma Client

### 6.1 生成 Prisma Client

修改数据模型后，需要重新生成 Prisma Client：

```bash
npx prisma generate
```

### 6.2 使用 Prisma Client

#### 6.2.1 初始化 Prisma Client

```javascript
// src/lib/prisma.js
import { PrismaClient } from '@prisma/client';

export const prisma = new PrismaClient();
```

#### 6.2.2 基本查询

```javascript
// 创建用户
const user = await prisma.user.create({
  data: {
    name: 'John Doe',
    email: 'john@example.com',
  },
});

// 查询所有用户
const users = await prisma.user.findMany();

// 根据 ID 查询用户
const user = await prisma.user.findUnique({
  where: {
    id: 1,
  },
});

// 更新用户
const updatedUser = await prisma.user.update({
  where: {
    id: 1,
  },
  data: {
    name: 'Jane Doe',
  },
});

// 删除用户
const deletedUser = await prisma.user.delete({
  where: {
    id: 1,
  },
});
```

#### 6.2.3 关系查询

```javascript
// 查询用户及其帖子
const userWithPosts = await prisma.user.findUnique({
  where: {
    id: 1,
  },
  include: {
    posts: true,
  },
});

// 查询帖子及其作者
const postWithAuthor = await prisma.post.findUnique({
  where: {
    id: 1,
  },
  include: {
    author: true,
  },
});

// 创建帖子并关联到用户
const post = await prisma.post.create({
  data: {
    title: 'Hello Prisma',
    content: 'This is my first post with Prisma',
    author: {
      connect: {
        id: 1,
      },
    },
  },
});
```

#### 6.2.4 过滤和排序

```javascript
// 过滤查询
const publishedPosts = await prisma.post.findMany({
  where: {
    published: true,
    title: {
      contains: 'Prisma',
    },
  },
});

// 排序
const sortedUsers = await prisma.user.findMany({
  orderBy: {
    createdAt: 'desc',
  },
});

// 分页
const paginatedPosts = await prisma.post.findMany({
  skip: 10,
  take: 5,
});
```

#### 6.2.5 聚合查询

```javascript
// 计数
const userCount = await prisma.user.count();

// 分组和聚合
const postsByAuthor = await prisma.post.groupBy({
  by: ['authorId'],
  _count: {
    _all: true,
  },
});

// 平均值
const averagePrice = await prisma.product.aggregate({
  _avg: {
    price: true,
  },
});
```

#### 6.2.6 事务

```javascript
// 简单事务
const [user, post] = await prisma.$transaction([
  prisma.user.create({
    data: {
      name: 'John Doe',
      email: 'john@example.com',
    },
  }),
  prisma.post.create({
    data: {
      title: 'Hello World',
      content: 'This is a test post',
      author: {
        connect: {
          email: 'john@example.com',
        },
      },
    },
  }),
]);

// 交互式事务
const result = await prisma.$transaction(async (prisma) => {
  const user = await prisma.user.create({
    data: {
      name: 'John Doe',
      email: 'john@example.com',
    },
  });

  const post = await prisma.post.create({
    data: {
      title: 'Hello World',
      content: 'This is a test post',
      author: {
        connect: {
          id: user.id,
        },
      },
    },
  });

  return { user, post };
});
```

## 7. Prisma Studio

### 7.1 启动 Prisma Studio

Prisma Studio 是一个可视化数据库管理工具，可以通过以下命令启动：

```bash
npx prisma studio
```

这将在浏览器中打开 Prisma Studio（默认地址：http://localhost:5555）。

### 7.2 使用 Prisma Studio

Prisma Studio 提供了直观的界面，可以：

- 查看和编辑数据库中的数据
- 执行查询和过滤
- 管理关系数据
- 查看表结构

## 8. 高级特性

### 8.1 复合主键

```prisma
model OrderItem {
  orderId   Int
  productId Int
  quantity  Int
  order     Order   @relation(fields: [orderId], references: [id])
  product   Product @relation(fields: [productId], references: [id])

  @@id([orderId, productId])
}
```

### 8.2 索引

```prisma
model User {
  id        Int      @id @default(autoincrement())
  email     String   @unique
  name      String
  createdAt DateTime @default(now())

  @@index([name, email])
}
```

### 8.3 原始查询

对于复杂查询，可以使用原始 SQL：

```javascript
const users = await prisma.$queryRaw`SELECT * FROM User WHERE email LIKE '%@example.com'`;
```

### 8.4 中间件

使用中间件扩展 Prisma Client 功能：

```javascript
prisma.$use(async (params, next) => {
  // 在查询前执行
  console.log(`Executing query: ${params.action} ${params.model}`);

  const result = await next(params);

  // 在查询后执行
  console.log(`Query completed: ${params.action} ${params.model}`);

  return result;
});
```

### 8.5 乐观锁

使用 `@updatedAt` 属性实现乐观锁：

```prisma
model Product {
  id        Int      @id @default(autoincrement())
  name      String
  price     Decimal
  updatedAt DateTime @updatedAt
}
```

### 8.6 连接池

Prisma Client 内置连接池管理，可以在 `schema.prisma` 中配置：

```prisma
generator client {
  provider = "prisma-client-js"
  previewFeatures = ["connectionPooling"]
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
  poolSize = 10
}
```

## 9. 与框架集成

### 9.1 Next.js 集成

在 Next.js 中使用 Prisma：

#### 9.1.1 安装依赖

```bash
npm install @prisma/client
npm install -D prisma
```

#### 9.1.2 初始化 Prisma

```bash
npx prisma init
```

#### 9.1.3 创建 Prisma 客户端实例

```javascript
// lib/prisma.js
import { PrismaClient } from '@prisma/client';

let prisma;

if (process.env.NODE_ENV === 'production') {
  prisma = new PrismaClient();
} else {
  if (!global.prisma) {
    global.prisma = new PrismaClient();
  }
  prisma = global.prisma;
}

export default prisma;
```

#### 9.1.4 在 API 路由中使用

```javascript
// pages/api/users.js
import prisma from '../../lib/prisma';

export default async function handler(req, res) {
  if (req.method === 'GET') {
    const users = await prisma.user.findMany();
    res.json(users);
  } else if (req.method === 'POST') {
    const user = await prisma.user.create({
      data: req.body,
    });
    res.json(user);
  }
}
```

### 9.2 NestJS 集成

在 NestJS 中使用 Prisma：

#### 9.2.1 安装依赖

```bash
npm install @prisma/client
npm install -D prisma
```

#### 9.2.2 创建 Prisma 服务

```javascript
// src/prisma/prisma.service.ts
import { Injectable, OnModuleInit, OnModuleDestroy } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class PrismaService extends PrismaClient implements OnModuleInit, OnModuleDestroy {
  async onModuleInit() {
    await this.$connect();
  }

  async onModuleDestroy() {
    await this.$disconnect();
  }
}
```

#### 9.2.3 在模块中注册

```javascript
// src/app.module.ts
import { Module } from '@nestjs/common';
import { PrismaService } from './prisma/prisma.service';
import { UsersModule } from './users/users.module';

@Module({
  imports: [UsersModule],
  providers: [PrismaService],
})
export class AppModule {}
```

## 10. 最佳实践

### 10.1 项目结构

```
prisma-example/
├── prisma/                 # Prisma 相关文件
│   ├── schema.prisma      # Prisma 模式定义
│   └── migrations/        # 迁移文件
├── src/                   # 源代码
│   ├── lib/               # 工具库
│   │   └── prisma.js     # Prisma Client 实例
│   ├── models/            # 业务模型
│   ├── services/          # 业务逻辑
│   └── controllers/       # 控制器
├── .env                   # 环境变量
├── package.json           # 项目配置
└── tsconfig.json          # TypeScript 配置
```

### 10.2 性能优化

1. **只查询需要的字段**：使用 `select` 只返回需要的字段
2. **批量操作**：使用 `createMany`、`updateMany` 等批量操作
3. **避免 N+1 查询**：使用 `include` 或 `select` 预加载关系数据
4. **合理使用索引**：为频繁查询的字段添加索引
5. **连接池优化**：根据实际情况调整连接池大小
6. **缓存查询结果**：对频繁访问的数据使用缓存

### 10.3 安全性

1. **验证输入**：始终验证用户输入，防止 SQL 注入
2. **使用参数化查询**：Prisma 自动使用参数化查询，避免 SQL 注入
3. **限制查询权限**：根据用户角色限制查询权限
4. **加密敏感数据**：对敏感数据（如密码）进行加密存储
5. **定期更新依赖**：及时更新 Prisma 和相关依赖，修复安全漏洞

### 10.4 开发流程

1. **定义数据模型**：在 `schema.prisma` 中定义数据模型
2. **生成迁移**：使用 `prisma migrate dev` 创建迁移
3. **生成 Prisma Client**：使用 `prisma generate` 生成客户端
4. **编写业务逻辑**：使用 Prisma Client 编写业务逻辑
5. **测试**：编写单元测试和集成测试
6. **部署**：使用 `prisma migrate deploy` 部署迁移

## 11. 常见问题

### 11.1 迁移失败

如果迁移失败，可以尝试以下解决方案：

- 检查数据库连接是否正确
- 检查迁移文件是否有语法错误
- 手动修复数据库状态，然后使用 `prisma migrate resolve` 解决冲突
- 使用 `prisma migrate reset` 重置数据库（注意：这会删除所有数据）

### 11.2 Prisma Client 生成失败

如果 Prisma Client 生成失败，可以尝试以下解决方案：

- 检查 `schema.prisma` 文件是否有语法错误
- 删除 `node_modules/.prisma` 目录，然后重新生成
- 更新 Prisma 到最新版本

### 11.3 关系查询性能问题

如果关系查询性能不佳，可以尝试以下解决方案：

- 使用 `select` 只查询需要的字段
- 避免深度嵌套的关系查询
- 考虑使用分页减少返回的数据量
- 为关系字段添加适当的索引

## 12. 资源

- **官方文档**：https://www.prisma.io/docs/
- **GitHub 仓库**：https://github.com/prisma/prisma
- **Prisma Studio**：https://www.prisma.io/studio/
- **示例项目**：https://github.com/prisma/prisma-examples
- **社区论坛**：https://www.prisma.io/forum/
- **Discord 社区**：https://pris.ly/discord

## 13. 总结

Prisma 是一个现代化的 ORM 工具，为 Node.js 和 TypeScript 应用提供了强大的数据访问能力。它的核心优势在于：

1. **类型安全**：自动生成的 TypeScript 类型，提供编译时类型检查
2. **直观的数据模型**：使用简洁的声明式语法定义数据模型
3. **强大的查询 API**：支持复杂查询、关系查询、事务等
4. **自动迁移**：轻松管理数据库架构变更
5. **可视化管理工具**：Prisma Studio 提供直观的数据库管理界面
6. **生态集成**：与主流框架深度集成

通过学习和使用 Prisma，开发者可以更高效地与数据库交互，减少重复工作，提高代码质量和开发效率。无论是小型应用还是大型企业级项目，Prisma 都能提供可靠的数据访问解决方案。