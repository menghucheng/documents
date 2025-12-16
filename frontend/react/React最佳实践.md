# React 最佳实践

## 1. 概述

React 是一个用于构建用户界面的 JavaScript 库，它采用组件化的开发方式，使代码更加模块化、可复用和易于维护。本文档总结了 React 开发中的各种最佳实践，帮助开发者编写高质量、高性能的 React 应用。

## 2. 组件设计

### 2.1 组件命名

- **使用 PascalCase**：组件名称应使用 PascalCase（首字母大写）命名，如 `UserProfile`、`LoginForm`
- **使用描述性名称**：组件名称应清晰描述其功能，避免使用过于抽象的名称
- **文件名与组件名一致**：组件文件名应与组件名称保持一致，便于查找和导入

### 2.2 组件拆分

- **单一职责原则**：每个组件应只负责一个功能，避免将多个不相关的功能耦合在一个组件中
- **合理拆分组件**：将复杂组件拆分为更小的、可复用的子组件
- **容器组件与展示组件分离**：将数据获取和业务逻辑（容器组件）与 UI 展示（展示组件）分离

```jsx
// 展示组件（只负责 UI 展示）
const UserCard = ({ user, onEdit }) => {
  return (
    <div className="user-card">
      <h3>{user.name}</h3>
      <p>{user.email}</p>
      <button onClick={onEdit}>编辑</button>
    </div>
  );
};

// 容器组件（负责数据获取和业务逻辑）
const UserProfile = () => {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);
  
  useEffect(() => {
    fetchUser();
  }, []);
  
  const fetchUser = async () => {
    try {
      const response = await fetch('/api/user');
      const data = await response.json();
      setUser(data);
    } catch (error) {
      console.error('获取用户失败:', error);
    } finally {
      setLoading(false);
    }
  };
  
  const handleEdit = () => {
    // 编辑逻辑
  };
  
  if (loading) {
    return <div>加载中...</div>;
  }
  
  return <UserCard user={user} onEdit={handleEdit} />;
};
```

### 2.3 组件 props

- **使用 PropTypes 或 TypeScript**：为组件 props 添加类型检查，提高代码的可靠性和可维护性
- **使用默认值**：为可选 props 设置默认值，避免 undefined 错误
- **props 解构**：在组件内部解构 props，提高代码的可读性
- **避免 props 过度传递**：当组件层级较深时，避免通过 props 逐层传递数据，可考虑使用 Context API 或状态管理库

```jsx
import PropTypes from 'prop-types';

const Button = ({ 
  type = 'button', 
  variant = 'primary', 
  disabled = false, 
  children, 
  onClick 
}) => {
  return (
    <button
      type={type}
      className={`btn btn-${variant}`}
      disabled={disabled}
      onClick={onClick}
    >
      {children}
    </button>
  );
};

Button.propTypes = {
  type: PropTypes.oneOf(['button', 'submit', 'reset']),
  variant: PropTypes.oneOf(['primary', 'secondary', 'danger']),
  disabled: PropTypes.bool,
  children: PropTypes.node.isRequired,
  onClick: PropTypes.func
};
```

## 3. 状态管理

### 3.1 useState 最佳实践

- **使用多个 useState 而不是单个复杂对象**：将相关状态分组，但避免将所有状态放在一个复杂对象中
- **使用描述性的状态变量名**：状态变量名应清晰描述其用途，如 `isLoading`、`isAuthenticated`
- **避免不必要的状态更新**：只在状态真正改变时才更新状态，避免不必要的重新渲染

```jsx
// 推荐：使用多个 useState
const [isLoading, setIsLoading] = useState(false);
const [data, setData] = useState([]);
const [error, setError] = useState(null);

// 不推荐：使用单个复杂对象
const [state, setState] = useState({
  isLoading: false,
  data: [],
  error: null
});
```

### 3.2 useEffect 最佳实践

- **明确依赖项**：始终为 useEffect 提供正确的依赖项数组，避免无限循环和遗漏依赖
- **分离不同用途的 useEffect**：将不同逻辑的副作用分离到不同的 useEffect 中
- **清理副作用**：对于产生副作用的操作（如订阅、定时器等），应在 useEffect 的清理函数中进行清理
- **避免在 useEffect 中执行昂贵的计算**：对于昂贵的计算，应使用 useMemo 或 useCallback

```jsx
// 推荐：分离不同用途的 useEffect
useEffect(() => {
  // 数据获取逻辑
  fetchData();
}, [fetchData]);

useEffect(() => {
  // 监听窗口大小变化
  const handleResize = () => {
    setWindowSize({ width: window.innerWidth, height: window.innerHeight });
  };
  
  window.addEventListener('resize', handleResize);
  
  // 清理函数
  return () => {
    window.removeEventListener('resize', handleResize);
  };
}, []);

// 推荐：正确使用依赖项
const fetchData = useCallback(async () => {
  setIsLoading(true);
  try {
    const response = await fetch(`/api/data?filter=${filter}`);
    const data = await response.json();
    setData(data);
  } catch (error) {
    setError(error);
  } finally {
    setIsLoading(false);
  }
}, [filter]);

useEffect(() => {
  fetchData();
}, [fetchData]);
```

### 3.3 useCallback 和 useMemo

- **使用 useCallback 优化回调函数**：对于传递给子组件的回调函数，使用 useCallback 避免不必要的重新渲染
- **使用 useMemo 优化计算结果**：对于昂贵的计算，使用 useMemo 缓存计算结果，避免每次渲染都重新计算
- **避免过度使用**：不要滥用 useCallback 和 useMemo，只有当性能问题确实存在时才使用

```jsx
// 使用 useCallback 优化回调函数
const handleClick = useCallback(() => {
  console.log('按钮被点击');
}, []);

// 使用 useMemo 优化计算结果
const total = useMemo(() => {
  return items.reduce((sum, item) => sum + item.price, 0);
}, [items]);

// 在依赖项中使用 useCallback 优化
const fetchData = useCallback(async (filter) => {
  // 数据获取逻辑
}, [filter]);
```

## 4. 性能优化

### 4.1 React.memo

- **使用 React.memo 优化组件**：对于纯展示组件，使用 React.memo 避免不必要的重新渲染
- **注意依赖项**：React.memo 默认使用浅比较，对于复杂对象或数组，需要提供自定义比较函数

```jsx
// 基本使用
const UserList = React.memo(({ users }) => {
  return (
    <ul>
      {users.map(user => (
        <li key={user.id}>{user.name}</li>
      ))}
    </ul>
  );
});

// 自定义比较函数
const DeepCompareComponent = React.memo(({ data }) => {
  // 组件内容
}, (prevProps, nextProps) => {
  // 自定义比较逻辑
  return JSON.stringify(prevProps.data) === JSON.stringify(nextProps.data);
});
```

### 4.2 虚拟列表

- **使用虚拟列表处理大量数据**：当列表数据量很大时，使用虚拟列表只渲染可见区域的内容，提高性能
- **推荐库**：react-window、react-virtualized

```jsx
import { FixedSizeList as List } from 'react-window';

const VirtualList = ({ items }) => {
  const Row = ({ index, style }) => (
    <div style={style}>
      {items[index].name}
    </div>
  );
  
  return (
    <List
      height={400}
      itemCount={items.length}
      itemSize={40}
      width="100%"
    >
      {Row}
    </List>
  );
};
```

### 4.3 图片优化

- **使用适当尺寸的图片**：根据容器大小使用适当尺寸的图片，避免过大的图片
- **使用懒加载**：对于不在视口内的图片，使用懒加载延迟加载
- **使用 WebP 格式**：优先使用 WebP 格式的图片，减少图片大小
- **使用图片 CDN**：使用图片 CDN 进行图片优化和加速

```jsx
// 图片懒加载
const LazyImage = ({ src, alt }) => {
  return <img src={src} alt={alt} loading="lazy" />;
};
```

### 4.4 避免不必要的渲染

- **使用 keys 优化列表渲染**：为列表项提供唯一的 key，帮助 React 识别哪些项发生了变化
- **避免在 render 中创建新对象或函数**：避免在 render 方法中创建新的对象、数组或函数，导致不必要的重新渲染
- **使用 useRef 存储不变值**：对于不需要触发重新渲染的值，使用 useRef 存储

```jsx
// 不推荐：在 render 中创建新函数
const Component = () => {
  return (
    <ChildComponent
      onButtonClick={() => console.log('按钮被点击')} // 每次渲染都会创建新函数
    />
  );
};

// 推荐：使用 useCallback
const Component = () => {
  const handleClick = useCallback(() => {
    console.log('按钮被点击');
  }, []);
  
  return <ChildComponent onButtonClick={handleClick} />;
};
```

## 5. 代码组织

### 5.1 文件结构

- **按功能组织文件**：将相关的组件、工具函数、样式文件等放在同一个目录下
- **组件目录结构**：为每个组件创建单独的目录，包含组件文件、样式文件、测试文件等

```
src/
├── components/
│   ├── Button/
│   │   ├── Button.jsx
│   │   ├── Button.css
│   │   └── Button.test.jsx
│   ├── UserProfile/
│   │   ├── UserProfile.jsx
│   │   ├── UserProfile.css
│   │   └── UserProfile.test.jsx
│   └── index.js // 导出所有组件
├── hooks/
│   ├── useAuth.js
│   └── useWindowSize.js
├── utils/
│   ├── api.js
│   └── format.js
└── pages/
    ├── HomePage.jsx
    └── AboutPage.jsx
```

### 5.2 导入和导出

- **使用绝对路径**：使用绝对路径导入文件，避免相对路径的混乱
- **使用 index.js 导出组件**：在组件目录中创建 index.js 文件，导出组件，简化导入路径
- **按需导入**：只导入需要的模块，避免导入整个库

```jsx
// 推荐：使用绝对路径和 index.js 导出
import { Button, UserCard } from '@/components';

// 不推荐：使用相对路径
import Button from '../../components/Button/Button';
```

### 5.3 注释

- **使用 JSDoc 注释**：为组件、函数、hooks 添加 JSDoc 注释，说明其用途、参数和返回值
- **添加必要的注释**：在复杂逻辑或难以理解的代码处添加注释
- **保持注释更新**：确保注释与代码保持一致，避免过时的注释

```jsx
/**
 * 用户卡片组件
 * @param {Object} props - 组件属性
 * @param {Object} props.user - 用户信息
 * @param {string} props.user.name - 用户名
 * @param {string} props.user.email - 用户邮箱
 * @param {Function} props.onEdit - 编辑按钮点击事件处理函数
 * @returns {JSX.Element} 用户卡片组件
 */
const UserCard = ({ user, onEdit }) => {
  // 组件内容
};
```

## 6. 样式管理

### 6.1 CSS-in-JS

- **使用 CSS-in-JS 库**：如 styled-components、emotion 等，将样式与组件紧密结合
- **避免全局样式冲突**：CSS-in-JS 会自动生成唯一的类名，避免全局样式冲突
- **支持动态样式**：可以根据组件 props 动态生成样式

```jsx
import styled from 'styled-components';

const Button = styled.button`
  padding: 8px 16px;
  border: none;
  border-radius: 4px;
  background-color: ${props => {
    switch (props.variant) {
      case 'primary': return '#007bff';
      case 'secondary': return '#6c757d';
      case 'danger': return '#dc3545';
      default: return '#007bff';
    }
  }};
  color: white;
  cursor: pointer;
  
  &:hover {
    opacity: 0.8;
  }
  
  &:disabled {
    opacity: 0.5;
    cursor: not-allowed;
  }
`;
```

### 6.2 CSS 模块

- **使用 CSS 模块**：为每个组件创建单独的 CSS 文件，通过 Webpack 处理生成唯一的类名
- **避免全局样式**：CSS 模块默认只在当前组件中生效，避免全局样式冲突

```css
/* Button.module.css */
.button {
  padding: 8px 16px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.primary {
  background-color: #007bff;
  color: white;
}

.secondary {
  background-color: #6c757d;
  color: white;
}
```

```jsx
import styles from './Button.module.css';

const Button = ({ variant, children, ...props }) => {
  return (
    <button
      className={`${styles.button} ${styles[variant]}`}
      {...props}
    >
      {children}
    </button>
  );
};
```

### 6.3 Tailwind CSS

- **使用 Tailwind CSS**：使用原子化 CSS 框架，快速构建 UI
- **配置 Tailwind**：根据项目需求配置 Tailwind，移除未使用的样式
- **使用 @apply 提取重复样式**：对于重复使用的样式组合，使用 @apply 提取到自定义类中

```jsx
// 使用 Tailwind CSS
const Button = ({ variant, children, ...props }) => {
  const variantClasses = {
    primary: 'bg-blue-500 hover:bg-blue-600 text-white',
    secondary: 'bg-gray-500 hover:bg-gray-600 text-white',
    danger: 'bg-red-500 hover:bg-red-600 text-white'
  };
  
  return (
    <button
      className={`px-4 py-2 rounded ${variantClasses[variant]}`}
      {...props}
    >
      {children}
    </button>
  );
};
```

## 7. 状态管理库

### 7.1 Redux

- **使用 Redux Toolkit**：使用 Redux Toolkit 简化 Redux 开发，减少样板代码
- **合理设计 Redux 状态**：将状态按功能划分为不同的 slice，避免单一状态树过于庞大
- **使用 selector 优化性能**：使用 createSelector 创建记忆化的 selector，避免不必要的计算

```javascript
import { configureStore, createSlice, createSelector } from '@reduxjs/toolkit';

// 创建 slice
const counterSlice = createSlice({
  name: 'counter',
  initialState: {
    value: 0
  },
  reducers: {
    increment: state => {
      state.value += 1;
    },
    decrement: state => {
      state.value -= 1;
    }
  }
});

// 导出 actions
export const { increment, decrement } = counterSlice.actions;

// 配置 store
const store = configureStore({
  reducer: {
    counter: counterSlice.reducer
  }
});

// 创建 selector
const selectCounter = state => state.counter;
const selectCounterValue = createSelector(
  selectCounter,
  counter => counter.value
);
```

### 7.2 Context API

- **使用 Context API 管理全局状态**：对于简单的全局状态，使用 Context API 替代 Redux
- **结合 useReducer**：对于复杂的状态逻辑，结合 useReducer 使用 Context API
- **避免过度使用**：只将真正需要全局共享的状态放入 Context 中

```jsx
// 创建 Context
const AuthContext = createContext();

// 创建 Provider
const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);
  
  const login = async (credentials) => {
    // 登录逻辑
  };
  
  const logout = () => {
    // 登出逻辑
  };
  
  const value = {
    user,
    loading,
    login,
    logout
  };
  
  return (
    <AuthContext.Provider value={value}>
      {children}
    </AuthContext.Provider>
  );
};

// 自定义 Hook
const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth 必须在 AuthProvider 中使用');
  }
  return context;
};
```

## 8. 表单处理

### 8.1 使用受控组件

- **优先使用受控组件**：使用受控组件处理表单输入，便于管理表单状态
- **使用 useState 或 useReducer 管理表单状态**：根据表单复杂度选择合适的状态管理方式
- **使用表单库简化开发**：对于复杂表单，使用表单库如 Formik、React Hook Form

```jsx
// 基本受控组件
const LoginForm = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  
  const handleSubmit = (e) => {
    e.preventDefault();
    // 表单提交逻辑
  };
  
  return (
    <form onSubmit={handleSubmit}>
      <div>
        <label htmlFor="email">邮箱</label>
        <input
          type="email"
          id="email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
        />
      </div>
      <div>
        <label htmlFor="password">密码</label>
        <input
          type="password"
          id="password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
        />
      </div>
      <button type="submit">登录</button>
    </form>
  );
};

// 使用 React Hook Form
import { useForm } from 'react-hook-form';

const LoginForm = () => {
  const { register, handleSubmit, formState: { errors } } = useForm();
  
  const onSubmit = (data) => {
    console.log(data);
  };
  
  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <div>
        <label htmlFor="email">邮箱</label>
        <input
          type="email"
          id="email"
          {...register('email', { required: '邮箱不能为空', pattern: { value: /^[^\s@]+@[^\s@]+\.[^\s@]+$/, message: '请输入有效的邮箱地址' })}
        />
        {errors.email && <p>{errors.email.message}</p>}
      </div>
      <div>
        <label htmlFor="password">密码</label>
        <input
          type="password"
          id="password"
          {...register('password', { required: '密码不能为空', minLength: { value: 6, message: '密码长度不能少于6个字符' })}
        />
        {errors.password && <p>{errors.password.message}</p>}
      </div>
      <button type="submit">登录</button>
    </form>
  );
};
```

## 9. 路由

### 9.1 React Router

- **使用 React Router 处理路由**：使用 React Router 管理应用的路由
- **合理设计路由结构**：根据应用的功能模块设计路由结构
- **使用嵌套路由**：对于复杂页面，使用嵌套路由组织子页面
- **使用懒加载**：使用 React.lazy 和 Suspense 实现路由懒加载，减少初始加载时间

```jsx
import { BrowserRouter, Routes, Route, Link, Outlet } from 'react-router-dom';

// 懒加载组件
const HomePage = React.lazy(() => import('@/pages/HomePage'));
const AboutPage = React.lazy(() => import('@/pages/AboutPage'));
const UserPage = React.lazy(() => import('@/pages/UserPage'));

const App = () => {
  return (
    <BrowserRouter>
      <nav>
        <Link to="/">首页</Link>
        <Link to="/about">关于我们</Link>
        <Link to="/users">用户管理</Link>
      </nav>
      
      <React.Suspense fallback={<div>加载中...</div>}>
        <Routes>
          <Route path="/" element={<HomePage />} />
          <Route path="/about" element={<AboutPage />} />
          <Route path="/users" element={<UsersLayout />}>
            <Route index element={<UsersList />} />
            <Route path=":id" element={<UserDetail />} />
          </Route>
          <Route path="*" element={<NotFoundPage />} />
        </Routes>
      </React.Suspense>
    </BrowserRouter>
  );
};

// 嵌套路由布局
const UsersLayout = () => {
  return (
    <div>
      <h2>用户管理</h2>
      <Outlet /> {/* 渲染子路由 */}
    </div>
  );
};
```

## 10. 错误处理

### 10.1 使用 Error Boundary

- **使用 Error Boundary 捕获组件错误**：使用 Error Boundary 组件捕获子组件的错误，避免整个应用崩溃
- **显示友好的错误信息**：在 Error Boundary 中显示友好的错误信息，提高用户体验
- **记录错误日志**：在 Error Boundary 中记录错误日志，便于调试和监控

```jsx
class ErrorBoundary extends React.Component {
  constructor(props) {
    super(props);
    this.state = { hasError: false, error: null };
  }
  
  static getDerivedStateFromError(error) {
    return { hasError: true, error };
  }
  
  componentDidCatch(error, errorInfo) {
    // 记录错误日志
    console.error('Error:', error);
    console.error('Error Info:', errorInfo);
  }
  
  render() {
    if (this.state.hasError) {
      return (
        <div className="error-boundary">
          <h2>出现了错误</h2>
          <p>{this.state.error.message}</p>
          <button onClick={() => this.setState({ hasError: false })}>
            重试
          </button>
        </div>
      );
    }
    
    return this.props.children;
  }
}

// 使用 Error Boundary
<ErrorBoundary>
  <App />
</ErrorBoundary>
```

### 10.2 异步错误处理

- **使用 try/catch 捕获异步错误**：在异步函数中使用 try/catch 捕获错误
- **使用错误状态**：使用错误状态管理异步操作的错误信息
- **显示错误信息**：在 UI 中显示友好的错误信息

```jsx
const DataFetchingComponent = () => {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  
  useEffect(() => {
    fetchData();
  }, []);
  
  const fetchData = async () => {
    try {
      setLoading(true);
      setError(null);
      const response = await fetch('/api/data');
      if (!response.ok) {
        throw new Error('获取数据失败');
      }
      const data = await response.json();
      setData(data);
    } catch (error) {
      setError(error.message);
      console.error('获取数据失败:', error);
    } finally {
      setLoading(false);
    }
  };
  
  if (loading) {
    return <div>加载中...</div>;
  }
  
  if (error) {
    return (
      <div className="error">
        <p>错误：{error}</p>
        <button onClick={fetchData}>重试</button>
      </div>
    );
  }
  
  return (
    <div>
      {/* 展示数据 */}
    </div>
  );
};
```

## 11. 测试

### 11.1 单元测试

- **使用 Jest 和 React Testing Library**：使用 Jest 和 React Testing Library 进行单元测试
- **测试组件的行为**：测试组件的行为和输出，而不是内部实现
- **测试覆盖率**：保持合理的测试覆盖率，重点测试核心功能

```jsx
import { render, screen, fireEvent } from '@testing-library/react';
import Button from '@/components/Button';

describe('Button Component', () => {
  test('渲染按钮并显示正确的文本', () => {
    render(<Button>点击我</Button>);
    const buttonElement = screen.getByText('点击我');
    expect(buttonElement).toBeInTheDocument();
  });
  
  test('点击按钮触发 onClick 事件', () => {
    const handleClick = jest.fn();
    render(<Button onClick={handleClick}>点击我</Button>);
    const buttonElement = screen.getByText('点击我');
    fireEvent.click(buttonElement);
    expect(handleClick).toHaveBeenCalledTimes(1);
  });
  
  test('禁用状态下不可点击', () => {
    const handleClick = jest.fn();
    render(<Button disabled onClick={handleClick}>点击我</Button>);
    const buttonElement = screen.getByText('点击我');
    expect(buttonElement).toBeDisabled();
    fireEvent.click(buttonElement);
    expect(handleClick).not.toHaveBeenCalled();
  });
});
```

### 11.2 集成测试

- **使用 Cypress 进行集成测试**：使用 Cypress 进行端到端的集成测试
- **测试用户流程**：测试用户的完整操作流程，如登录、注册、购物等
- **模拟 API 请求**：使用 Cypress 的拦截功能模拟 API 请求，测试不同场景

```javascript
describe('登录流程', () => {
  it('登录成功后跳转到首页', () => {
    // 访问登录页面
    cy.visit('/login');
    
    // 输入用户名和密码
    cy.get('input[name="email"]').type('test@example.com');
    cy.get('input[name="password"]').type('password123');
    
    // 点击登录按钮
    cy.get('button[type="submit"]').click();
    
    // 验证是否跳转到首页
    cy.url().should('include', '/home');
    cy.contains('欢迎回来！');
  });
  
  it('登录失败显示错误信息', () => {
    // 访问登录页面
    cy.visit('/login');
    
    // 输入错误的用户名和密码
    cy.get('input[name="email"]').type('invalid@example.com');
    cy.get('input[name="password"]').type('wrongpassword');
    
    // 点击登录按钮
    cy.get('button[type="submit"]').click();
    
    // 验证是否显示错误信息
    cy.contains('用户名或密码错误');
  });
});
```

## 12. 性能监控和调试

### 12.1 React DevTools

- **使用 React DevTools 调试**：使用 React DevTools 查看组件树、状态和性能
- **性能分析**：使用 React DevTools 的 Profiler 分析组件的渲染性能
- **组件检查**：使用 React DevTools 检查组件的 props、state 和 hooks

### 12.2 Chrome DevTools

- **使用 Chrome DevTools 调试**：使用 Chrome DevTools 进行网络请求、性能分析和调试
- **Performance 面板**：使用 Performance 面板分析应用的性能瓶颈
- **Network 面板**：使用 Network 面板分析网络请求，优化请求时间

### 12.3 Lighthouse

- **使用 Lighthouse 进行性能审计**：使用 Lighthouse 对应用进行性能、可访问性、最佳实践等方面的审计
- **优化建议**：根据 Lighthouse 的建议优化应用的性能和用户体验

## 13. 可访问性

### 13.1 基本可访问性原则

- **使用语义化 HTML**：使用语义化的 HTML 标签，提高可访问性
- **添加 alt 属性**：为图片添加 alt 属性，描述图片内容
- **使用 ARIA 属性**：为复杂组件添加 ARIA 属性，提高屏幕阅读器的可访问性
- **确保键盘可访问**：确保所有交互元素都可以通过键盘访问
- **提供足够的对比度**：确保文本和背景之间有足够的对比度

### 13.2 可访问性实践

```jsx
// 使用语义化 HTML
const Navigation = () => {
  return (
    <nav>
      <ul>
        <li><a href="/">首页</a></li>
        <li><a href="/about">关于我们</a></li>
      </ul>
    </nav>
  );
};

// 添加 alt 属性
<img src="logo.png" alt="公司 Logo">

// 使用 ARIA 属性
const Modal = ({ isOpen, onClose, children }) => {
  return isOpen ? (
    <div className="modal-backdrop" onClick={onClose}>
      <div className="modal" role="dialog" aria-modal="true" aria-labelledby="modal-title" onClick={(e) => e.stopPropagation()}>
        <h2 id="modal-title">模态框标题</h2>
        {children}
        <button onClick={onClose} aria-label="关闭">×</button>
      </div>
    </div>
  ) : null;
};

// 确保键盘可访问
<button type="button" onClick={handleClick}>
  点击我
</button>

// 提供足够的对比度
<button style={{ backgroundColor: '#007bff', color: 'white', padding: '10px 20px' }}>
  点击我
</button>
```

## 14. 国际化

- **使用 i18next 进行国际化**：使用 i18next 和 react-i18next 进行应用的国际化
- **提取文本到翻译文件**：将所有需要翻译的文本提取到单独的翻译文件中
- **支持多种语言**：根据需要支持多种语言
- **动态切换语言**：支持动态切换语言，无需刷新页面

```jsx
import { useTranslation } from 'react-i18next';

const UserProfile = () => {
  const { t } = useTranslation();
  
  return (
    <div>
      <h2>{t('profile.title')}</h2>
      <p>{t('profile.name')}: John Doe</p>
      <p>{t('profile.email')}: john@example.com</p>
    </div>
  );
};

// 翻译文件 (en.json)
{
  "profile": {
    "title": "User Profile",
    "name": "Name",
    "email": "Email"
  }
}

// 翻译文件 (zh.json)
{
  "profile": {
    "title": "用户资料",
    "name": "姓名",
    "email": "邮箱"
  }
}
```

## 15. 总结

React 最佳实践涵盖了组件设计、状态管理、性能优化、代码组织、路由、表单处理、错误处理、测试、可访问性等多个方面。遵循这些最佳实践可以帮助开发者编写高质量、高性能、易维护的 React 应用。

主要内容包括：

1. 组件设计：组件命名、拆分、props 管理
2. 状态管理：useState、useEffect、useCallback、useMemo 最佳实践
3. 性能优化：React.memo、虚拟列表、懒加载
4. 代码组织：文件结构、导入导出、注释
5. 样式管理：CSS-in-JS、CSS 模块、Tailwind CSS
6. 状态管理库：Redux、Context API
7. 表单处理：受控组件、表单库
8. 路由：React Router、嵌套路由、懒加载
9. 错误处理：Error Boundary、异步错误处理
10. 测试：单元测试、集成测试
11. 性能监控和调试：React DevTools、Chrome DevTools、Lighthouse
12. 可访问性：语义化 HTML、ARIA 属性、键盘可访问性
13. 国际化：i18next

通过不断学习和实践这些最佳实践，开发者可以不断提高自己的 React 开发技能，构建出更好的 React 应用。