# Auth.js 文档

## 1. 基础概念

### 1.1 什么是 Auth.js？

Auth.js（前身为 NextAuth.js）是一个灵活的开源认证库，专为现代 Web 应用设计，支持多种认证方式，包括 OAuth、OpenID Connect、Email/Password、Magic Links 等。它提供了简单易用的 API，同时保持高度的可定制性。

### 1.2 核心特性

- **多种认证方式**：支持超过 40 种 OAuth 提供商（如 Google、GitHub、Facebook 等）
- **灵活的配置**：支持自定义认证流程和 UI
- **安全可靠**：内置 CSRF 保护、JWT 支持、密码哈希等安全特性
- **易于集成**：适用于 React、Next.js、SvelteKit 等现代框架
- **TypeScript 支持**：完整的 TypeScript 类型定义
- **社区活跃**：持续更新和维护，拥有活跃的社区

### 1.3 认证流程图

Auth.js 的认证流程如下所示：

```
┌────────────────────────────────────────────────────────────────────┐
│                          客户端                                  │
└───────────────────┬────────────────────────────────────────────────┘
                    │
                    ▼
┌────────────────────────────────────────────────────────────────────┐
│                        Auth.js 认证 API                          │
└───────────────────┬────────────────────────────────────────────────┘
                    │
                    ▼
┌────────────────────────────────────────────────────────────────────┐
│                        认证提供商                                 │
│  (Google, GitHub, Email/Password, Magic Links 等)                 │
└───────────────────┬────────────────────────────────────────────────┘
                    │
                    ▼
┌────────────────────────────────────────────────────────────────────┐
│                        数据库                                    │
│  (存储用户信息、会话等)                                          │
└───────────────────┬────────────────────────────────────────────────┘
                    │
                    ▼
┌────────────────────────────────────────────────────────────────────┐
│                          客户端                                  │
│  (接收认证结果、获取用户信息)                                    │
└────────────────────────────────────────────────────────────────────┘
```

#### 详细认证流程

1. **用户发起登录请求**：用户点击登录按钮，选择认证方式
2. **重定向到认证页面**：Auth.js 将用户重定向到认证提供商的登录页面
3. **用户认证**：用户在认证提供商处输入凭证并授权
4. **提供商回调**：认证提供商将用户重定向回应用，并携带授权码
5. **获取访问令牌**：Auth.js 使用授权码向提供商请求访问令牌
6. **获取用户信息**：使用访问令牌获取用户信息
7. **创建会话**：Auth.js 创建用户会话，并将会话信息存储到数据库
8. **返回认证结果**：Auth.js 将认证结果返回给客户端
9. **客户端获取用户信息**：客户端使用 Auth.js 提供的 API 获取用户信息

### 1.4 核心概念

- **认证提供商**：负责验证用户身份的服务，如 Google、GitHub 等
- **适配器**：Auth.js 与数据库之间的接口，负责用户和会话的存储和检索
- **会话策略**：控制会话的管理方式，支持 JWT 和数据库会话
- **回调函数**：允许自定义认证流程中的各个环节
- **钩子**：在 React 组件中使用的 API，用于获取会话信息和触发认证操作

## 2. 安装

### 2.1 基本安装

在你的项目中安装 Auth.js：

```bash
npm install next-auth  # Next.js 项目
# 或
npm install @auth/core @auth/react  # React 项目
# 或
npm install @auth/sveltekit  # SvelteKit 项目
```

### 2.2 依赖要求

- Node.js 16.14.0 或更高版本
- 现代浏览器支持（Chrome、Firefox、Safari、Edge）

## 3. 配置

### 3.1 基本配置

以下是一个 Next.js 项目中的基本配置示例：

```javascript
// pages/api/auth/[...nextauth].js
import NextAuth from "next-auth";
import GoogleProvider from "next-auth/providers/google";

export default NextAuth({
  // 配置认证提供商
  providers: [
    GoogleProvider({
      clientId: process.env.GOOGLE_CLIENT_ID,
      clientSecret: process.env.GOOGLE_CLIENT_SECRET,
    }),
    // 可以添加更多提供商
  ],
  
  // 配置会话策略
  session: {
    strategy: "jwt",
    maxAge: 30 * 24 * 60 * 60, // 30 天
  },
  
  // 配置 callbacks
  callbacks: {
    async jwt({ token, user }) {
      if (user) {
        token.id = user.id;
      }
      return token;
    },
    async session({ session, token }) {
      if (token) {
        session.user.id = token.id;
      }
      return session;
    },
  },
  
  // 配置页面
  pages: {
    signIn: "/auth/signin",
    signOut: "/auth/signout",
    error: "/auth/error",
  },
});
```

### 3.2 环境变量

在项目根目录创建 `.env.local` 文件，添加所需的环境变量：

```env
# Google OAuth
GOOGLE_CLIENT_ID=your-google-client-id
GOOGLE_CLIENT_SECRET=your-google-client-secret

# Auth.js 密钥
NEXTAUTH_SECRET=your-secret-key
NEXTAUTH_URL=http://localhost:3000
```

## 4. 使用

### 4.1 在组件中使用

```javascript
// 组件中使用 Auth.js
import { useSession, signIn, signOut } from "next-auth/react";

export default function Component() {
  const { data: session } = useSession();
  
  if (session) {
    return (
      <div>
        <p>已登录：{session.user.email}</p>
        <button onClick={() => signOut()}>退出登录</button>
      </div>
    );
  }
  
  return (
    <div>
      <p>未登录</p>
      <button onClick={() => signIn()}>登录</button>
    </div>
  );
}
```

### 4.2 保护 API 路由

```javascript
// pages/api/protected.js
import { getServerSession } from "next-auth/next";
import { authOptions } from "./auth/[...nextauth]";

export default async function handler(req, res) {
  const session = await getServerSession(req, res, authOptions);
  
  if (!session) {
    res.status(401).json({ message: "未授权" });
    return;
  }
  
  res.status(200).json({ message: "受保护的资源", user: session.user });
}
```

### 4.3 保护页面路由

```javascript
// pages/protected.js
import { getServerSession } from "next-auth/next";
import { authOptions } from "./api/auth/[...nextauth]";

export async function getServerSideProps(context) {
  const session = await getServerSession(context.req, context.res, authOptions);
  
  if (!session) {
    return {
      redirect: {
        destination: "/api/auth/signin",
        permanent: false,
      },
    };
  }
  
  return { props: { session } };
}

export default function ProtectedPage({ session }) {
  return <div>受保护页面，欢迎 {session.user.email}</div>;
}
```

## 5. 认证提供商配置

### 5.1 常用提供商示例

#### 5.1.1 GitHub

```javascript
import GitHubProvider from "next-auth/providers/github";

providers: [
  GitHubProvider({
    clientId: process.env.GITHUB_ID,
    clientSecret: process.env.GITHUB_SECRET,
  }),
],
```

#### 5.1.2 Email/Password

```javascript
import EmailProvider from "next-auth/providers/email";
import { PrismaAdapter } from "@next-auth/prisma-adapter";
import prisma from "../../lib/prisma";

providers: [
  EmailProvider({
    server: process.env.EMAIL_SERVER,
    from: process.env.EMAIL_FROM,
  }),
],
adapter: PrismaAdapter(prisma),
```

#### 5.1.3 Credentials（自定义凭证）

```javascript
import CredentialsProvider from "next-auth/providers/credentials";

providers: [
  CredentialsProvider({
    name: "Credentials",
    credentials: {
      username: { label: "Username", type: "text", placeholder: "" },
      password: { label: "Password", type: "password" },
    },
    async authorize(credentials, req) {
      // 自定义认证逻辑
      const user = {
        id: "1",
        name: "Admin",
        email: "admin@example.com",
      };
      
      if (user) {
        return user;
      } else {
        return null;
      }
    },
  }),
],
```

## 6. 高级配置

### 6.1 自定义回调函数

```javascript
callbacks: {
  // JWT 回调
  async jwt({ token, user, account, profile, isNewUser }) {
    if (account) {
      token.accessToken = account.access_token;
      token.id = profile.id;
    }
    return token;
  },
  
  // 会话回调
  async session({ session, token, user }) {
    session.user.id = token.id;
    session.accessToken = token.accessToken;
    return session;
  },
  
  // 重定向回调
  async redirect({ url, baseUrl }) {
    return url.startsWith(baseUrl) ? url : baseUrl;
  },
  
  // 签名回调
  async signIn({ user, account, profile, email, credentials }) {
    return true;
  },
}
```

### 6.2 自定义数据库适配器

Auth.js 支持多种数据库适配器，如 Prisma、MongoDB、Firebase 等。以下是 Prisma 适配器的配置示例：

```javascript
import { PrismaAdapter } from "@next-auth/prisma-adapter";
import prisma from "../../lib/prisma";

export default NextAuth({
  adapter: PrismaAdapter(prisma),
  // 其他配置
});
```

## 7. 最佳实践

### 7.1 安全建议

- **使用环境变量**：将敏感信息（如客户端 ID、密钥）存储在环境变量中，不要硬编码到代码中
- **启用 CSRF 保护**：Auth.js 默认启用 CSRF 保护，确保不要禁用
- **使用 HTTPS**：在生产环境中始终使用 HTTPS
- **定期更新依赖**：及时更新 Auth.js 和相关依赖，以修复安全漏洞
- **限制会话时长**：根据应用需求设置合适的会话时长

### 7.2 性能优化

- **使用 JWT 会话策略**：对于不需要频繁访问数据库的应用，使用 JWT 会话策略可以提高性能
- **按需加载**：只在需要认证的页面或组件中使用 Auth.js hooks
- **缓存会话数据**：合理使用缓存机制，减少不必要的数据库查询

### 7.3 可维护性

- **模块化配置**：将认证配置拆分为多个模块，便于维护和扩展
- **编写清晰的文档**：记录认证流程和配置，便于团队成员理解
- **使用 TypeScript**：利用 TypeScript 的类型检查，减少运行时错误

## 8. 常见问题

### 8.1 登录后重定向问题

如果登录后没有正确重定向，检查 `redirect` 回调函数和 `NEXTAUTH_URL` 环境变量是否配置正确。

### 8.2 会话过期问题

如果会话频繁过期，检查 `session.maxAge` 配置和 JWT 过期时间。

### 8.3 自定义认证流程

对于复杂的认证需求，可以使用 Auth.js 的自定义适配器和回调函数，实现完全自定义的认证流程。

## 9. 资源

- **官方文档**：https://authjs.dev/
- **GitHub 仓库**：https://github.com/nextauthjs/next-auth
- **示例项目**：https://github.com/nextauthjs/next-auth-example
- **社区讨论**：https://github.com/nextauthjs/next-auth/discussions

## 10. 总结

Auth.js 是一个功能强大、灵活易用的认证库，适用于各种现代 Web 应用。它提供了丰富的认证方式和高度的可定制性，同时保持了良好的安全性和性能。通过合理配置和使用 Auth.js，可以快速实现可靠的认证系统，为应用提供安全保障。