# React Hooks

## 1. Hooks 概述

React Hooks 是 React 16.8 引入的新特性，允许在函数组件中使用状态和其他 React 特性，而无需编写类组件。

### 1.1 Hooks 工作原理示意图

```
┌────────────────────────────────────────────────────────────────────┐
│                          函数组件                                  │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │  import { useState, useEffect } from 'react';                │  │
│  │                                                              │  │
│  │  function Component() {                                      │  │
│  │    ┌──────────────────────────────────────────────────────┐  │  │
│  │    │  const [state, setState] = useState(initialValue);   │  │  │
│  │    └────────────────────────┬─────────────────────────────┘  │  │
│  │                             │                                │  │
│  │                             ▼                                │  │
│  │    ┌──────────────────────────────────────────────────────┐  │  │
│  │    │  useEffect(() => {                                  │  │  │
│  │    │    // 副作用逻辑                                    │  │  │
│  │    │  }, [dependencies]);                                │  │  │
│  │    └──────────────────────────────────────────────────────┘  │  │
│  │                                                              │  │
│  │    return <JSX />;                                           │  │
│  │  }                                                          │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                             │                                      │
│                             ▼                                      │
│                        React 渲染器                               │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │  1. 调用函数组件                                           │  │
│  │  2. 执行 Hooks，获取最新状态                               │  │
│  │  3. 渲染 JSX 到 DOM                                        │  │
│  │  4. 执行 useEffect 副作用                                 │  │
│  └──────────────────────────────────────────────────────────────┘  │
└────────────────────────────────────────────────────────────────────┘
```

### 1.2 Hooks 的特点

- **函数组件优先**：Hooks 使函数组件能够拥有类组件的所有功能
- **代码复用**：可以将状态逻辑提取到自定义 Hooks 中，便于复用
- **更简洁的代码**：减少样板代码，使组件更易于理解和维护
- **更好的性能**：避免了类组件的实例和生命周期方法的开销
- **更灵活的逻辑组织**：可以将相关的逻辑组织在一起，而不是分散在不同的生命周期方法中

### 1.3 Hooks 的原则

使用 Hooks 时需要遵循以下原则：

1. **只在函数组件或自定义 Hooks 中使用 Hooks**：不要在类组件、普通函数或循环/条件/嵌套函数中调用 Hooks
2. **只在函数组件的顶层调用 Hooks**：不要在循环、条件或嵌套函数中调用 Hooks
3. **遵循 Hook 的命名规范**：Hooks 名称必须以 `use` 开头，如 `useState`、`useEffect`

## 2. 常用 Hooks

### 2.1 useState

`useState` Hook 用于在函数组件中添加状态。

#### useState 工作流程示意图

```
┌────────────────────────────────────────────────────────────────────┐
│                        useState 工作流程                          │
├────────────────────────────────────────────────────────────────────┤
│  1. 组件首次渲染                                                   │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │  const [count, setCount] = useState(0);                     │  │
│  │  // 初始化状态：count = 0                                   │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                                                                      │
│  2. 用户交互，触发状态更新                                           │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │  <button onClick={() => setCount(count + 1)}>Increment</button>  │  │
│  │  // 调用 setCount(1)                                        │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                                                                      │
│  3. React 重新渲染组件                                               │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │  const [count, setCount] = useState(0);                     │  │
│  │  // 获取更新后的状态：count = 1                              │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                                                                      │
│  4. 渲染新的 JSX                                                     │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │  <p>Count: {count}</p> // 显示 "Count: 1"                   │  │
│  └──────────────────────────────────────────────────────────────┘  │
└────────────────────────────────────────────────────────────────────┘
```

#### 基本用法

```javascript
import React, { useState } from 'react';

function Counter() {
  // 声明状态变量，返回状态值和更新函数
  const [count, setCount] = useState(0);
  const [name, setName] = useState("World");
  const [user, setUser] = useState({ name: "John", age: 30 });

  return (
    <div>
      <h1>Hello, {name}!</h1>
      <p>Count: {count}</p>
      <p>User: {user.name}, {user.age}</p>
      <button onClick={() => setCount(count + 1)}>Increment</button>
      <button onClick={() => setCount(count - 1)}>Decrement</button>
      <input 
        type="text" 
        value={name} 
        onChange={(e) => setName(e.target.value)} 
        placeholder="Enter your name"
      />
      <button onClick={() => setUser({ ...user, age: user.age + 1 })}>Increment Age</button>
    </div>
  );
}
```

#### 状态更新

- **直接更新**：对于基本类型的值，可以直接更新
  ```javascript
  setCount(10);
  ```

- **基于前一个状态更新**：对于需要基于前一个状态计算新状态的情况，应使用函数形式
  ```javascript
  setCount(prevCount => prevCount + 1);
  ```

- **更新对象或数组**：需要创建新的对象或数组，而不是直接修改原对象
  ```javascript
  // 更新对象
  setUser(prevUser => ({
    ...prevUser,
    age: prevUser.age + 1
  }));
  
  // 更新数组
  setItems(prevItems => [...prevItems, newItem]); // 添加元素
  setItems(prevItems => prevItems.filter(item => item.id !== id)); // 删除元素
  setItems(prevItems => prevItems.map(item => 
    item.id === id ? { ...item, name: newName } : item
  )); // 更新元素
  ```

### 2.2 useEffect

`useEffect` Hook 用于处理组件的副作用，如数据获取、订阅、DOM 操作等。

#### useEffect 工作流程示意图

```
┌────────────────────────────────────────────────────────────────────┐
│                        useEffect 工作流程                          │
├────────────────────────────────────────────────────────────────────┤
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │  组件挂载或依赖项变化                                       │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                             │                                      │
│                             ▼                                      │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │  1. 执行组件渲染                                           │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                             │                                      │
│                             ▼                                      │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │  2. 检查依赖项是否变化                                       │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                             │                                      │
│               ┌─────────────┴─────────────┐                        │
│               │                           │                        │
│               ▼                           ▼                        │
│  ┌─────────────────────────┐   ┌─────────────────────────┐        │
│  │  依赖项未变化            │   │  依赖项变化              │        │
│  │  ──────────────────────▶│   │  ──────────────────────▶│        │
│  │  跳过副作用执行         │   │  3. 执行上一次的清理函数  │        │
│  └─────────────────────────┘   └─────────────────────────┘        │
│                                         │                          │
│                                         ▼                          │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │  4. 执行副作用函数                                           │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                             │                                      │
│                             ▼                                      │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │  5. 组件卸载或依赖项变化                                     │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                             │                                      │
│                             ▼                                      │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │  6. 执行清理函数，清理资源                                     │  │
│  └──────────────────────────────────────────────────────────────┘  │
└────────────────────────────────────────────────────────────────────┘
```

#### 基本用法

```javascript
import React, { useState, useEffect } from 'react';

function DataFetcher({ url }) {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    // 副作用函数
    const fetchData = async () => {
      try {
        const response = await fetch(url);
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        const result = await response.json();
        setData(result);
        setLoading(false);
      } catch (error) {
        setError(error);
        setLoading(false);
      }
    };

    fetchData();
    
    // 清理函数，在组件卸载或依赖项变化时执行
    return () => {
      // 清理资源，如取消请求、移除事件监听器等
    };
  }, [url]); // 依赖项数组，只有当 url 变化时才重新执行副作用

  if (loading) {
    return <div>Loading...</div>;
  }

  if (error) {
    return <div>Error: {error.message}</div>;
  }

  return (
    <div>
      <h2>Data:</h2>
      <pre>{JSON.stringify(data, null, 2)}</pre>
    </div>
  );
}
```

#### 依赖项数组

`useEffect` 的第二个参数是依赖项数组，用于控制何时重新执行副作用：

- **空依赖数组 `[]`**：副作用只在组件挂载时执行一次，相当于 `componentDidMount`
  ```javascript
  useEffect(() => {
    console.log('Component mounted');
    return () => console.log('Component will unmount');
  }, []);
  ```

- **没有依赖项**：副作用在每次组件渲染后都执行，相当于 `componentDidMount` 和 `componentDidUpdate`
  ```javascript
  useEffect(() => {
    console.log('Component rendered');
  });
  ```

- **有依赖项**：副作用在组件挂载时执行，并且在依赖项变化时重新执行
  ```javascript
  useEffect(() => {
    console.log(`Count changed to ${count}`);
  }, [count]);
  ```

#### 清理函数

`useEffect` 可以返回一个清理函数，用于在组件卸载或依赖项变化时清理资源：

```javascript
useEffect(() => {
  const intervalId = setInterval(() => {
    setCount(prevCount => prevCount + 1);
  }, 1000);

  // 清理函数，清除定时器
  return () => {
    clearInterval(intervalId);
  };
}, []);
```

### 2.3 useContext

`useContext` Hook 用于访问 React Context 中的值。

#### 基本用法

```javascript
import React, { useContext } from 'react';

// 创建 Context
const ThemeContext = React.createContext('light');

// 提供 Context
function App() {
  return (
    <ThemeContext.Provider value="dark">
      <ThemeComponent />
    </ThemeContext.Provider>
  );
}

// 使用 Context
function ThemeComponent() {
  const theme = useContext(ThemeContext);
  return (
    <div style={{ 
      backgroundColor: theme === 'dark' ? '#333' : '#fff', 
      color: theme === 'dark' ? '#fff' : '#333',
      padding: '20px'
    }}>
      <h1>Theme: {theme}</h1>
    </div>
  );
}
```

#### 多个 Context

可以在一个组件中使用多个 Context：

```javascript
const ThemeContext = React.createContext('light');
const UserContext = React.createContext({ name: "Guest" });

function App() {
  return (
    <ThemeContext.Provider value="dark">
      <UserContext.Provider value={{ name: "John" }}>
        <ProfileComponent />
      </UserContext.Provider>
    </ThemeContext.Provider>
  );
}

function ProfileComponent() {
  const theme = useContext(ThemeContext);
  const user = useContext(UserContext);
  return (
    <div style={{ 
      backgroundColor: theme === 'dark' ? '#333' : '#fff', 
      color: theme === 'dark' ? '#fff' : '#333',
      padding: '20px'
    }}>
      <h1>Hello, {user.name}!</h1>
      <p>Theme: {theme}</p>
    </div>
  );
}
```

### 2.4 useReducer

`useReducer` Hook 用于管理复杂的状态逻辑，类似于 Redux 的 reducer 模式。

#### 基本用法

```javascript
import React, { useReducer } from 'react';

// 定义 reducer 函数
function counterReducer(state, action) {
  switch (action.type) {
    case 'INCREMENT':
      return { count: state.count + 1 };
    case 'DECREMENT':
      return { count: state.count - 1 };
    case 'RESET':
      return { count: 0 };
    case 'INCREMENT_BY_AMOUNT':
      return { count: state.count + action.payload };
    default:
      return state;
  }
}

function Counter() {
  // 初始化状态和 dispatch 函数
  const [state, dispatch] = useReducer(counterReducer, { count: 0 });

  return (
    <div>
      <h1>Count: {state.count}</h1>
      <button onClick={() => dispatch({ type: 'INCREMENT' })}>Increment</button>
      <button onClick={() => dispatch({ type: 'DECREMENT' })}>Decrement</button>
      <button onClick={() => dispatch({ type: 'RESET' })}>Reset</button>
      <button onClick={() => dispatch({ type: 'INCREMENT_BY_AMOUNT', payload: 5 })}>Increment by 5</button>
    </div>
  );
}
```

#### 复杂状态管理

`useReducer` 适合管理复杂的状态，如表单状态：

```javascript
import React, { useReducer } from 'react';

const initialState = {
  username: '',
  password: '',
  email: '',
  errors: {}
};

function formReducer(state, action) {
  switch (action.type) {
    case 'SET_FIELD':
      return {
        ...state,
        [action.field]: action.value
      };
    case 'SET_ERRORS':
      return {
        ...state,
        errors: action.errors
      };
    case 'RESET':
      return initialState;
    default:
      return state;
  }
}

function Form() {
  const [state, dispatch] = useReducer(formReducer, initialState);

  const handleSubmit = (e) => {
    e.preventDefault();
    const errors = {};
    if (!state.username) errors.username = 'Username is required';
    if (!state.password) errors.password = 'Password is required';
    if (!state.email) errors.email = 'Email is required';
    
    if (Object.keys(errors).length > 0) {
      dispatch({ type: 'SET_ERRORS', errors });
    } else {
      console.log('Form submitted:', state);
      dispatch({ type: 'RESET' });
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <div>
        <label>Username:</label>
        <input 
          type="text" 
          value={state.username} 
          onChange={(e) => dispatch({ type: 'SET_FIELD', field: 'username', value: e.target.value })} 
        />
        {state.errors.username && <span>{state.errors.username}</span>}
      </div>
      <div>
        <label>Password:</label>
        <input 
          type="password" 
          value={state.password} 
          onChange={(e) => dispatch({ type: 'SET_FIELD', field: 'password', value: e.target.value })} 
        />
        {state.errors.password && <span>{state.errors.password}</span>}
      </div>
      <div>
        <label>Email:</label>
        <input 
          type="email" 
          value={state.email} 
          onChange={(e) => dispatch({ type: 'SET_FIELD', field: 'email', value: e.target.value })} 
        />
        {state.errors.email && <span>{state.errors.email}</span>}
      </div>
      <button type="submit">Submit</button>
    </form>
  );
}
```

### 2.5 useCallback

`useCallback` Hook 用于缓存回调函数，避免在每次渲染时创建新的函数实例。

#### 基本用法

```javascript
import React, { useState, useCallback } from 'react';

function Parent() {
  const [count, setCount] = useState(0);
  const [name, setName] = useState("World");

  // 使用 useCallback 缓存回调函数
  const handleIncrement = useCallback(() => {
    setCount(count + 1);
  }, [count]);

  const handleNameChange = useCallback((newName) => {
    setName(newName);
  }, []);

  return (
    <div>
      <h1>Hello, {name}!</h1>
      <p>Count: {count}</p>
      <Child onIncrement={handleIncrement} onNameChange={handleNameChange} />
    </div>
  );
}

// 使用 React.memo 缓存子组件
const Child = React.memo(({ onIncrement, onNameChange }) => {
  console.log('Child rendered');
  return (
    <div>
      <button onClick={onIncrement}>Increment</button>
      <button onClick={() => onNameChange("React")}>Change Name</button>
    </div>
  );
});
```

#### 依赖项

`useCallback` 的第二个参数是依赖项数组，只有当依赖项变化时，才会重新创建回调函数。

### 2.6 useMemo

`useMemo` Hook 用于缓存计算结果，避免在每次渲染时重新计算。

#### 基本用法

```javascript
import React, { useState, useMemo } from 'react';

function ExpensiveComponent() {
  const [count, setCount] = useState(0);
  const [number, setNumber] = useState(10);

  // 使用 useMemo 缓存计算结果
  const expensiveValue = useMemo(() => {
    console.log('Computing expensive value...');
    let result = 0;
    for (let i = 0; i < 1000000000; i++) {
      result += i;
    }
    return result * number;
  }, [number]); // 只有当 number 变化时才重新计算

  return (
    <div>
      <h1>Expensive Component</h1>
      <p>Count: {count}</p>
      <p>Number: {number}</p>
      <p>Expensive Value: {expensiveValue}</p>
      <button onClick={() => setCount(count + 1)}>Increment Count</button>
      <button onClick={() => setNumber(number + 1)}>Increment Number</button>
    </div>
  );
}
```

#### 注意事项

- `useMemo` 返回的是计算结果，而 `useCallback` 返回的是缓存的函数
- `useMemo` 用于优化昂贵的计算，而 `useCallback` 用于优化函数的创建

### 2.7 useRef

`useRef` Hook 用于访问 DOM 元素或保存可变值。

#### 访问 DOM 元素

```javascript
import React, { useRef } from 'react';

function FocusComponent() {
  // 创建 ref
  const inputRef = useRef(null);

  const handleFocus = () => {
    // 访问 DOM 元素并调用 focus() 方法
    inputRef.current.focus();
  };

  return (
    <div>
      <input ref={inputRef} type="text" placeholder="Click the button to focus" />
      <button onClick={handleFocus}>Focus Input</button>
    </div>
  );
}
```

#### 保存可变值

`useRef` 可以保存可变值，并且不会触发组件重新渲染：

```javascript
import React, { useState, useRef, useEffect } from 'react';

function Counter() {
  const [count, setCount] = useState(0);
  // 保存上一次的 count 值
  const prevCountRef = useRef(0);

  useEffect(() => {
    // 更新上一次的 count 值
    prevCountRef.current = count;
  }, [count]);

  return (
    <div>
      <h1>Count: {count}</h1>
      <p>Previous Count: {prevCountRef.current}</p>
      <button onClick={() => setCount(count + 1)}>Increment</button>
    </div>
  );
}
```

### 2.8 useImperativeHandle

`useImperativeHandle` Hook 用于自定义暴露给父组件的实例值。

#### 基本用法

```javascript
import React, { useRef, useImperativeHandle, forwardRef } from 'react';

// 使用 forwardRef 将 ref 传递给子组件
const Child = forwardRef((props, ref) => {
  const inputRef = useRef(null);

  // 自定义暴露给父组件的方法
  useImperativeHandle(ref, () => ({
    focus: () => {
      inputRef.current.focus();
    },
    value: () => {
      return inputRef.current.value;
    },
    clear: () => {
      inputRef.current.value = '';
    }
  }));

  return (
    <div>
      <input ref={inputRef} type="text" placeholder="Enter text" />
    </div>
  );
});

function Parent() {
  const childRef = useRef(null);

  const handleFocus = () => {
    childRef.current.focus();
  };

  const handleGetValue = () => {
    alert(childRef.current.value());
  };

  const handleClear = () => {
    childRef.current.clear();
  };

  return (
    <div>
      <Child ref={childRef} />
      <button onClick={handleFocus}>Focus Input</button>
      <button onClick={handleGetValue}>Get Value</button>
      <button onClick={handleClear}>Clear Input</button>
    </div>
  );
}
```

### 2.9 useLayoutEffect

`useLayoutEffect` Hook 类似于 `useEffect`，但它在 DOM 更新后同步执行，而不是异步执行。

#### 基本用法

```javascript
import React, { useState, useLayoutEffect, useRef } from 'react';

function LayoutEffectComponent() {
  const [count, setCount] = useState(0);
  const containerRef = useRef(null);

  // useLayoutEffect 在 DOM 更新后同步执行
  useLayoutEffect(() => {
    if (containerRef.current) {
      const rect = containerRef.current.getBoundingClientRect();
      console.log('Container dimensions:', rect.width, rect.height);
    }
  }, [count]);

  return (
    <div ref={containerRef}>
      <h1>Count: {count}</h1>
      <button onClick={() => setCount(count + 1)}>Increment</button>
    </div>
  );
}
```

#### 与 useEffect 的区别

- **执行时机**：`useLayoutEffect` 在 DOM 更新后同步执行，`useEffect` 在 DOM 更新后异步执行
- **阻塞渲染**：`useLayoutEffect` 会阻塞浏览器绘制，`useEffect` 不会
- **使用场景**：`useLayoutEffect` 适合需要在 DOM 更新后立即读取 DOM 布局的场景

### 2.10 useDebugValue

`useDebugValue` Hook 用于在 React DevTools 中显示自定义 Hook 的标签。

#### 基本用法

```javascript
import React, { useState, useDebugValue } from 'react';

// 自定义 Hook
function useCounter(initialCount = 0) {
  const [count, setCount] = useState(initialCount);

  // 在 React DevTools 中显示标签
  useDebugValue(`Count: ${count}`);

  const increment = () => setCount(count + 1);
  const decrement = () => setCount(count - 1);

  return { count, increment, decrement };
}

function Counter() {
  const { count, increment, decrement } = useCounter(0);

  return (
    <div>
      <h1>Count: {count}</h1>
      <button onClick={increment}>Increment</button>
      <button onClick={decrement}>Decrement</button>
    </div>
  );
}
```

## 3. 自定义 Hooks

自定义 Hooks 是一种重用状态逻辑的方式，可以将组件中的状态逻辑提取到可重用的函数中。

### 3.1 基本结构

自定义 Hook 是一个以 `use` 开头的函数，可以调用其他 Hooks。

```javascript
import { useState, useEffect } from 'react';

function useCustomHook(initialValue) {
  const [state, setState] = useState(initialValue);

  useEffect(() => {
    // 副作用逻辑
  }, [state]);

  const updateState = (newValue) => {
    setState(newValue);
  };

  return [state, updateState];
}
```

### 3.2 示例：自定义 Hooks

#### 3.2.1 useLocalStorage

用于在 localStorage 中保存和读取状态：

```javascript
import { useState, useEffect } from 'react';

function useLocalStorage(key, initialValue) {
  // 从 localStorage 中读取初始值
  const readValue = () => {
    if (typeof window === 'undefined') {
      return initialValue;
    }

    try {
      const item = window.localStorage.getItem(key);
      return item ? JSON.parse(item) : initialValue;
    } catch (error) {
      console.error(`Error reading localStorage key "${key}":`, error);
      return initialValue;
    }
  };

  const [storedValue, setStoredValue] = useState(readValue);

  // 更新 localStorage
  const setValue = (value) => {
    try {
      const valueToStore = value instanceof Function ? value(storedValue) : value;
      setStoredValue(valueToStore);
      if (typeof window !== 'undefined') {
        window.localStorage.setItem(key, JSON.stringify(valueToStore));
      }
    } catch (error) {
      console.error(`Error setting localStorage key "${key}":`, error);
    }
  };

  // 监听 localStorage 变化
  useEffect(() => {
    const handleStorageChange = (event) => {
      if (event.key === key && event.newValue) {
        setStoredValue(JSON.parse(event.newValue));
      }
    };

    window.addEventListener('storage', handleStorageChange);
    return () => window.removeEventListener('storage', handleStorageChange);
  }, [key]);

  return [storedValue, setValue];
}

// 使用自定义 Hook
function LocalStorageComponent() {
  const [name, setName] = useLocalStorage('name', 'World');

  return (
    <div>
      <h1>Hello, {name}!</h1>
      <input 
        type="text" 
        value={name} 
        onChange={(e) => setName(e.target.value)} 
        placeholder="Enter your name"
      />
    </div>
  );
}
```

#### 3.2.2 useDebounce

用于防抖，延迟执行函数：

```javascript
import { useState, useEffect, useCallback } from 'react';

function useDebounce(value, delay) {
  const [debouncedValue, setDebouncedValue] = useState(value);

  useEffect(() => {
    const handler = setTimeout(() => {
      setDebouncedValue(value);
    }, delay);

    return () => {
      clearTimeout(handler);
    };
  }, [value, delay]);

  return debouncedValue;
}

function SearchComponent() {
  const [searchTerm, setSearchTerm] = useState('');
  const debouncedSearchTerm = useDebounce(searchTerm, 500);
  const [results, setResults] = useState([]);
  const [loading, setLoading] = useState(false);

  // 当 debouncedSearchTerm 变化时，执行搜索
  useEffect(() => {
    const search = async () => {
      if (debouncedSearchTerm) {
        setLoading(true);
        try {
          const response = await fetch(`https://api.example.com/search?q=${debouncedSearchTerm}`);
          const data = await response.json();
          setResults(data.results);
        } catch (error) {
          console.error('Search error:', error);
        } finally {
          setLoading(false);
        }
      } else {
        setResults([]);
      }
    };

    search();
  }, [debouncedSearchTerm]);

  return (
    <div>
      <input 
        type="text" 
        value={searchTerm} 
        onChange={(e) => setSearchTerm(e.target.value)} 
        placeholder="Search..."
      />
      {loading && <div>Loading...</div>}
      <ul>
        {results.map(result => (
          <li key={result.id}>{result.name}</li>
        ))}
      </ul>
    </div>
  );
}
```

#### 3.2.3 useWindowSize

用于获取窗口大小：

```javascript
import { useState, useEffect } from 'react';

function useWindowSize() {
  const [windowSize, setWindowSize] = useState({
    width: typeof window !== 'undefined' ? window.innerWidth : 0,
    height: typeof window !== 'undefined' ? window.innerHeight : 0
  });

  useEffect(() => {
    const handleResize = () => {
      setWindowSize({
        width: window.innerWidth,
        height: window.innerHeight
      });
    };

    window.addEventListener('resize', handleResize);
    return () => window.removeEventListener('resize', handleResize);
  }, []);

  return windowSize;
}

function ResponsiveComponent() {
  const { width, height } = useWindowSize();
  const isMobile = width < 768;

  return (
    <div>
      <h1>Window Size</h1>
      <p>Width: {width}px</p>
      <p>Height: {height}px</p>
      <p>Device: {isMobile ? 'Mobile' : 'Desktop'}</p>
    </div>
  );
}
```

## 4. Hooks 最佳实践

### 4.1 命名规范

- **Hooks 名称必须以 `use` 开头**：便于识别和遵循 Hooks 规则
- **使用描述性的名称**：如 `useLocalStorage`、`useDebounce`
- **避免使用缩写**：提高代码可读性

### 4.2 依赖项管理

- **正确设置依赖项**：确保依赖项数组包含所有使用的外部变量
- **避免使用空依赖项**：除非确实只需要执行一次
- **使用 `useCallback` 和 `useMemo` 优化依赖项**：避免不必要的重新渲染

### 4.3 性能优化

- **使用 `React.memo` 缓存组件**：避免不必要的重新渲染
- **使用 `useCallback` 缓存回调函数**：减少子组件的重新渲染
- **使用 `useMemo` 缓存计算结果**：避免昂贵的计算
- **使用 `useRef` 保存可变值**：避免触发重新渲染

### 4.4 代码组织

- **将相关的逻辑组织在一起**：使用 `useEffect` 将相关的副作用组织在一起
- **提取重复逻辑到自定义 Hooks**：提高代码复用性
- **保持 Hook 简洁**：每个 Hook 只负责一个功能

### 4.5 可测试性

- **编写可测试的自定义 Hooks**：便于单元测试
- **使用 Jest 和 React Testing Library 测试 Hooks**：确保 Hook 按预期工作
- **模拟外部依赖**：如 `fetch`、`localStorage` 等

### 4.6 错误处理

- **在 `useEffect` 中处理异步错误**：使用 try/catch 块
- **使用错误边界包裹组件**：捕获 Hooks 抛出的错误
- **提供默认值**：避免 Hooks 返回 undefined

## 5. 常见问题和解决方案

### 5.1 Hooks 只能在函数组件的顶层调用

**问题**：在循环、条件或嵌套函数中调用 Hooks 会导致错误。

**解决方案**：将 Hooks 移到函数组件的顶层，确保每次渲染时调用顺序一致。

### 5.2 无限循环

**问题**：`useEffect` 中的状态更新导致无限循环。

**解决方案**：
- 检查依赖项数组，确保只包含必要的依赖项
- 使用 `useCallback` 或 `useMemo` 优化回调函数和计算结果
- 避免在 `useEffect` 中直接修改依赖项

### 5.3 状态更新不及时

**问题**：使用当前状态值更新状态时，得到的是旧值。

**解决方案**：
- 使用函数式更新，基于前一个状态计算新状态
  ```javascript
  setCount(prevCount => prevCount + 1);
  ```

### 5.4 组件不重新渲染

**问题**：更新状态后，组件没有重新渲染。

**解决方案**：
- 确保使用 `useState` 或 `useReducer` 更新状态
- 确保状态是不可变的，不要直接修改对象或数组
  ```javascript
  // 错误
  state.count = 1;
  
  // 正确
  setCount(1);
  setUser({ ...user, count: 1 });
  setArray([...array, newItem]);
  ```

### 5.5 自定义 Hooks 不工作

**问题**：自定义 Hooks 没有按预期工作。

**解决方案**：
- 确保 Hooks 名称以 `use` 开头
- 确保在函数组件或其他自定义 Hooks 中调用
- 确保 Hooks 的依赖项设置正确

## 6. Hooks 与类组件的比较

| 特性 | 函数组件 + Hooks | 类组件 |
|------|-----------------|--------|
| **状态管理** | `useState`、`useReducer` | `this.state`、`this.setState()` |
| **副作用** | `useEffect` | `componentDidMount`、`componentDidUpdate`、`componentWillUnmount` |
| **上下文** | `useContext` | `static contextType`、`Context.Consumer` |
| **性能优化** | `React.memo`、`useCallback`、`useMemo` | `shouldComponentUpdate`、`PureComponent` |
| **代码复用** | 自定义 Hooks | HOC、Render Props |
| **代码简洁性** | 更简洁，更少的样板代码 | 更多的样板代码 |
| **学习曲线** | 较平缓，只需学习 Hooks API | 较陡峭，需要理解类、this、生命周期等 |

## 7. 总结

React Hooks 是 React 16.8 引入的重要特性，它使函数组件能够拥有类组件的所有功能，并且提供了更好的代码复用和组织方式。

常用的 Hooks 包括：
- `useState`：管理组件状态
- `useEffect`：处理副作用
- `useContext`：访问 Context
- `useReducer`：管理复杂状态
- `useCallback`：缓存回调函数
- `useMemo`：缓存计算结果
- `useRef`：访问 DOM 元素或保存可变值

通过自定义 Hooks，可以将组件中的状态逻辑提取到可重用的函数中，提高代码的复用性和可维护性。

使用 Hooks 时需要遵循一定的原则，如只在函数组件的顶层调用 Hooks，使用正确的依赖项等。同时，需要注意性能优化，避免不必要的重新渲染。

Hooks 已经成为 React 开发的主流方式，掌握 Hooks 对于 React 开发者来说至关重要。