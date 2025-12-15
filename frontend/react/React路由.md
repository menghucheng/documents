# React 路由

## 1. 路由基础概念

### 1.1 什么是路由

路由是指根据URL的变化，显示不同的页面内容。在单页应用（SPA）中，路由负责管理URL与组件之间的映射关系，实现页面的无刷新切换。

### 1.2 React 路由的作用

- **实现页面导航**：根据URL显示不同的页面内容
- **管理页面状态**：通过URL参数传递数据
- **实现嵌套路由**：支持复杂的页面结构
- **实现路由守卫**：控制页面的访问权限
- **实现代码分割**：按需加载页面组件，提高应用性能

### 1.3 常用的 React 路由库

- **React Router**：最流行的React路由库，支持Web、React Native和React VR
- **Reach Router**：由React Router团队开发的轻量级路由库，现已合并到React Router 6
- **Next.js 路由**：Next.js框架内置的路由系统

## 2. React Router 入门

### 2.1 安装 React Router

React Router v6 是目前的最新版本，它对API进行了简化和优化。

```bash
# 使用 npm
npm install react-router-dom

# 使用 yarn
yarn add react-router-dom

# 使用 pnpm
pnpm add react-router-dom
```

### 2.2 基本使用

#### 2.2.1 设置路由配置

在React Router v6中，我们使用 `createBrowserRouter` 或 `createHashRouter` 来创建路由配置。

```jsx
import { createBrowserRouter, RouterProvider } from 'react-router-dom';
import Home from './pages/Home';
import About from './pages/About';
import Contact from './pages/Contact';

const router = createBrowserRouter([
  {
    path: '/',
    element: <Home />,
  },
  {
    path: '/about',
    element: <About />,
  },
  {
    path: '/contact',
    element: <Contact />,
  },
]);

function App() {
  return <RouterProvider router={router} />;
}

export default App;
```

#### 2.2.2 导航链接

使用 `Link` 组件创建导航链接，它会渲染为 `<a>` 标签，但不会引起页面刷新。

```jsx
import { Link } from 'react-router-dom';

function Navbar() {
  return (
    <nav>
      <ul>
        <li>
          <Link to="/">Home</Link>
        </li>
        <li>
          <Link to="/about">About</Link>
        </li>
        <li>
          <Link to="/contact">Contact</Link>
        </li>
      </ul>
    </nav>
  );
}
```

#### 2.2.3 导航到外部链接

对于外部链接，使用普通的 `<a>` 标签即可。

```jsx
function ExternalLink() {
  return (
    <a href="https://example.com" target="_blank" rel="noopener noreferrer">
      Example
    </a>
  );
}
```

## 3. 路由参数

### 3.1 动态路由

动态路由允许我们在URL中使用参数，例如 `/users/:id`，其中 `:id` 是一个动态参数。

```jsx
const router = createBrowserRouter([
  {
    path: '/users/:id',
    element: <UserDetail />,
  },
]);
```

### 3.2 获取路由参数

使用 `useParams` Hook 来获取路由参数。

```jsx
import { useParams } from 'react-router-dom';

function UserDetail() {
  const { id } = useParams();
  
  return <div>User ID: {id}</div>;
}
```

### 3.3 查询参数

查询参数是URL中 `?` 后面的部分，例如 `/users?page=1&sort=name`。

使用 `useSearchParams` Hook 来获取和更新查询参数。

```jsx
import { useSearchParams } from 'react-router-dom';

function UserList() {
  const [searchParams, setSearchParams] = useSearchParams();
  const page = searchParams.get('page') || '1';
  const sort = searchParams.get('sort') || 'name';
  
  const handleSortChange = (newSort) => {
    setSearchParams({ page, sort: newSort });
  };
  
  return (
    <div>
      <h1>User List</h1>
      <p>Page: {page}</p>
      <p>Sort by: {sort}</p>
      <button onClick={() => handleSortChange('name')}>Sort by Name</button>
      <button onClick={() => handleSortChange('age')}>Sort by Age</button>
    </div>
  );
}
```

## 4. 嵌套路由

嵌套路由允许我们在一个组件中渲染另一个路由组件，实现复杂的页面结构。

### 4.1 配置嵌套路由

```jsx
const router = createBrowserRouter([
  {
    path: '/dashboard',
    element: <DashboardLayout />,
    children: [
      {
        index: true,
        element: <DashboardHome />,
      },
      {
        path: 'users',
        element: <Users />,
      },
      {
        path: 'settings',
        element: <Settings />,
      },
    ],
  },
]);
```

### 4.2 渲染嵌套路由

在父组件中使用 `Outlet` 组件来渲染嵌套路由。

```jsx
import { Outlet, Link } from 'react-router-dom';

function DashboardLayout() {
  return (
    <div>
      <aside>
        <nav>
          <ul>
            <li>
              <Link to="/dashboard">Home</Link>
            </li>
            <li>
              <Link to="/dashboard/users">Users</Link>
            </li>
            <li>
              <Link to="/dashboard/settings">Settings</Link>
            </li>
          </ul>
        </nav>
      </aside>
      <main>
        <Outlet />
      </main>
    </div>
  );
}
```

### 4.3 索引路由

索引路由是当父路由匹配时，默认渲染的子路由，使用 `index: true` 来定义。

```jsx
const router = createBrowserRouter([
  {
    path: '/',
    element: <Layout />,
    children: [
      {
        index: true,
        element: <Home />,
      },
      {
        path: 'about',
        element: <About />,
      },
    ],
  },
]);
```

## 5. 编程式导航

除了使用 `Link` 组件进行声明式导航外，我们还可以使用编程式导航来实现更复杂的导航逻辑。

### 5.1 使用 useNavigate Hook

`useNavigate` Hook 返回一个函数，用于进行编程式导航。

```jsx
import { useNavigate } from 'react-router-dom';

function Login() {
  const navigate = useNavigate();
  
  const handleLogin = () => {
    // 登录逻辑
    navigate('/dashboard');
  };
  
  const handleGoBack = () => {
    navigate(-1); // 后退一步
  };
  
  const handleGoForward = () => {
    navigate(1); // 前进一步
  };
  
  return (
    <div>
      <h1>Login</h1>
      <button onClick={handleLogin}>Login</button>
      <button onClick={handleGoBack}>Go Back</button>
      <button onClick={handleGoForward}>Go Forward</button>
    </div>
  );
}
```

### 5.2 导航到指定路径

```jsx
// 导航到首页
navigate('/');

// 导航到详情页
navigate('/users/123');

// 带查询参数的导航
navigate('/users?page=1&sort=name');

// 带状态的导航
navigate('/users/123', { state: { from: 'dashboard' } });
```

### 5.3 替换当前历史记录

使用 `replace: true` 选项可以替换当前历史记录，而不是添加新的记录。

```jsx
navigate('/dashboard', { replace: true });
```

## 6. 路由守卫

路由守卫用于控制页面的访问权限，例如检查用户是否登录、是否有访问某个页面的权限等。

### 6.1 使用导航守卫

在React Router v6中，我们可以使用 `useEffect` 和 `useNavigate` 来实现导航守卫。

```jsx
import { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';

function ProtectedRoute({ children }) {
  const navigate = useNavigate();
  const isAuthenticated = checkIfAuthenticated(); // 检查用户是否登录
  
  useEffect(() => {
    if (!isAuthenticated) {
      navigate('/login', { replace: true });
    }
  }, [isAuthenticated, navigate]);
  
  return isAuthenticated ? children : null;
}
```

### 6.2 使用 Router Outlet

在React Router v6中，我们可以使用 `Router Outlet` 和 `useRoutes` 来实现更灵活的路由守卫。

```jsx
const router = createBrowserRouter([
  {
    path: '/',
    element: <Layout />,
    children: [
      {
        index: true,
        element: <Home />,
      },
      {
        path: 'dashboard',
        element: (
          <ProtectedRoute>
            <Dashboard />
          </ProtectedRoute>
        ),
      },
    ],
  },
]);
```

### 6.3 使用 Navigation Events

使用 `useNavigation` Hook 可以获取当前导航状态，例如导航是否正在进行中。

```jsx
import { useNavigation } from 'react-router-dom';

function LoadingSpinner() {
  const navigation = useNavigation();
  
  if (navigation.state === 'loading') {
    return <div>Loading...</div>;
  }
  
  return null;
}
```

## 7. 代码分割

代码分割允许我们按需加载页面组件，提高应用的初始加载速度。

### 7.1 使用 React.lazy 和 Suspense

```jsx
import { lazy, Suspense } from 'react';
import { createBrowserRouter, RouterProvider } from 'react-router-dom';

const Home = lazy(() => import('./pages/Home'));
const About = lazy(() => import('./pages/About'));
const Contact = lazy(() => import('./pages/Contact'));

const router = createBrowserRouter([
  {
    path: '/',
    element: (
      <Suspense fallback={<div>Loading...</div>}>
        <Home />
      </Suspense>
    ),
  },
  {
    path: '/about',
    element: (
      <Suspense fallback={<div>Loading...</div>}>
        <About />
      </Suspense>
    ),
  },
  {
    path: '/contact',
    element: (
      <Suspense fallback={<div>Loading...</div>}>
        <Contact />
      </Suspense>
    ),
  },
]);

function App() {
  return <RouterProvider router={router} />;
}
```

### 7.2 使用 React Router v6 的数据加载

React Router v6 提供了内置的数据加载功能，可以在路由渲染前加载数据。

```jsx
const router = createBrowserRouter([
  {
    path: '/users/:id',
    element: <UserDetail />,
    loader: async ({ params }) => {
      const response = await fetch(`https://api.example.com/users/${params.id}`);
      if (!response.ok) {
        throw new Error('Failed to fetch user');
      }
      return response.json();
    },
  },
]);
```

使用 `useLoaderData` Hook 获取加载的数据：

```jsx
import { useLoaderData } from 'react-router-dom';

function UserDetail() {
  const user = useLoaderData();
  
  return (
    <div>
      <h1>{user.name}</h1>
      <p>{user.email}</p>
    </div>
  );
}
```

## 8. 错误处理

React Router v6 提供了内置的错误处理功能，可以优雅地处理路由加载过程中的错误。

### 8.1 使用 errorElement

```jsx
const router = createBrowserRouter([
  {
    path: '/',
    element: <Layout />,
    errorElement: <ErrorPage />,
    children: [
      {
        index: true,
        element: <Home />,
      },
      {
        path: 'users/:id',
        element: <UserDetail />,
        loader: async ({ params }) => {
          const response = await fetch(`https://api.example.com/users/${params.id}`);
          if (!response.ok) {
            throw new Error('Failed to fetch user');
          }
          return response.json();
        },
      },
    ],
  },
]);
```

### 8.2 使用 useRouteError

```jsx
import { useRouteError } from 'react-router-dom';

function ErrorPage() {
  const error = useRouteError();
  
  return (
    <div>
      <h1>Oops!</h1>
      <p>Something went wrong.</p>
      <p>{error.status} {error.statusText}</p>
      <p>{error.message}</p>
    </div>
  );
}
```

## 9. 路由状态管理

### 9.1 使用 Location State

在导航时，我们可以传递状态数据，这些数据不会出现在URL中。

```jsx
// 导航时传递状态
navigate('/users/123', { state: { from: 'dashboard' } });

// 获取状态
import { useLocation } from 'react-router-dom';

function UserDetail() {
  const location = useLocation();
  const from = location.state?.from;
  
  return <div>From: {from}</div>;
}
```

### 9.2 使用 URL State

URL State 是指通过URL参数传递的状态，它会出现在URL中，适合需要分享或书签的页面。

```jsx
// 导航时传递URL参数
navigate('/users?page=1&sort=name');

// 获取URL参数
import { useSearchParams } from 'react-router-dom';

function UserList() {
  const [searchParams] = useSearchParams();
  const page = searchParams.get('page') || '1';
  const sort = searchParams.get('sort') || 'name';
  
  return (
    <div>
      <p>Page: {page}</p>
      <p>Sort by: {sort}</p>
    </div>
  );
}
```

## 10. 多路由出口

在某些情况下，我们需要在页面的不同位置渲染不同的路由内容，这时候可以使用多路由出口。

### 10.1 使用 Outlet Context

```jsx
import { Outlet } from 'react-router-dom';

function Layout() {
  return (
    <div>
      <header>
        {/* 头部内容 */}
      </header>
      <main>
        <Outlet context={{ user: currentUser }} />
      </main>
      <aside>
        <Outlet name="sidebar" />
      </aside>
      <footer>
        {/* 底部内容 */}
      </footer>
    </div>
  );
}
```

### 10.2 配置多路由出口

```jsx
const router = createBrowserRouter([
  {
    path: '/',
    element: <Layout />,
    children: [
      {
        index: true,
        element: <Home />,
        children: [
          {
            element: <HomeSidebar />,
            outlet: 'sidebar',
          },
        ],
      },
      {
        path: 'about',
        element: <About />,
      },
    ],
  },
]);
```

## 11. 服务器渲染（SSR）

React Router 支持服务器渲染，可以使用 `react-router-dom/server` 包来实现。

### 11.1 基本用法

```jsx
import { renderToString } from 'react-dom/server';
import { StaticRouter } from 'react-router-dom/server';

function handleRequest(req, res) {
  const html = renderToString(
    <StaticRouter location={req.url}>
      <App />
    </StaticRouter>
  );
  
  res.send(`
    <!DOCTYPE html>
    <html>
      <head>
        <title>React Router SSR</title>
      </head>
      <body>
        <div id="root">${html}</div>
        <script src="/bundle.js"></script>
      </body>
    </html>
  `);
}
```

### 11.2 使用 Remix

Remix 是一个基于 React Router 的全栈框架，它内置了服务器渲染功能。

```bash
# 创建 Remix 项目
npx create-remix@latest
```

## 12. React Router v6 与 v5 的区别

React Router v6 对API进行了重大简化和优化，以下是一些主要区别：

| 特性 | v5 | v6 |
|------|----|----|
| 路由配置 | 使用 `<Switch>` 和 `<Route>` | 使用 `createBrowserRouter` 和 `RouterProvider` |
| 嵌套路由 | 使用 `<Route>` 嵌套 | 使用 `children` 配置 |
| 路由匹配 | 精确匹配需要 `exact` 属性 | 自动精确匹配 |
| 导航 | 使用 `<Redirect>` 和 `history.push` | 使用 `navigate` 函数 |
| 路由守卫 | 使用 `Route` 的 `render` 或 `component` 属性 | 使用组件包裹 |
| 数据加载 | 需要第三方库 | 内置 `loader` 功能 |
| 错误处理 | 需要手动实现 | 内置 `errorElement` 功能 |

## 13. 最佳实践

### 13.1 组织路由配置

将路由配置放在单独的文件中，便于管理和维护。

```jsx
// src/routes/index.js
import { createBrowserRouter } from 'react-router-dom';
import Home from '../pages/Home';
import About from '../pages/About';
import Contact from '../pages/Contact';
import Dashboard from '../pages/Dashboard';
import ProtectedRoute from '../components/ProtectedRoute';

const router = createBrowserRouter([
  {
    path: '/',
    element: <Home />,
  },
  {
    path: '/about',
    element: <About />,
  },
  {
    path: '/contact',
    element: <Contact />,
  },
  {
    path: '/dashboard',
    element: (
      <ProtectedRoute>
        <Dashboard />
      </ProtectedRoute>
    ),
  },
]);

export default router;
```

### 13.2 使用嵌套路由

使用嵌套路由来组织复杂的页面结构，提高代码的复用性。

### 13.3 实现路由守卫

为需要权限的页面添加路由守卫，确保用户只能访问他们有权限的页面。

### 13.4 使用代码分割

使用代码分割来按需加载页面组件，提高应用的初始加载速度。

### 13.5 实现错误处理

为应用添加全局错误处理，优雅地处理路由加载过程中的错误。

### 13.6 使用语义化的URL

使用语义化的URL，便于用户理解和搜索引擎优化。

### 13.7 避免深层嵌套路由

避免使用过深的嵌套路由，这会导致URL变得复杂，难以维护。

## 14. 总结

React Router 是 React 应用中最流行的路由库，它提供了强大的路由功能，包括：

1. **基本路由**：实现页面导航和URL映射
2. **动态路由**：支持URL参数
3. **嵌套路由**：实现复杂的页面结构
4. **编程式导航**：使用代码控制导航
5. **路由守卫**：控制页面访问权限
6. **代码分割**：按需加载页面组件
7. **错误处理**：优雅地处理路由错误
8. **服务器渲染**：支持服务器端渲染

React Router v6 对API进行了重大简化和优化，提供了更好的开发体验和性能。在实际开发中，我们应该根据应用的需求选择合适的路由方案，并遵循最佳实践，构建高性能、可维护的React应用。