# React 组件

## 1. 组件概述

组件是 React 应用的基本构建块，一个 React 应用由多个组件组成。组件将 UI 拆分为独立的、可复用的部分，每个组件负责渲染自己的一部分 UI，并可以接收输入数据（props）和管理内部状态（state）。

### 1.1 组件的特点

- **可复用性**：组件可以在应用的多个地方使用
- **封装性**：组件封装了自己的 UI 和逻辑
- **独立性**：组件之间相互独立，便于维护和测试
- **组合性**：组件可以嵌套组合，形成复杂的 UI

### 1.2 组件的分类

React 组件主要分为以下几类：

| 类型 | 描述 | 示例 |
|------|------|------|
| **函数组件** | 用函数定义的组件，接收 props 并返回 JSX | `function Greeting(props) { return <h1>Hello, {props.name}!</h1>; }` |
| **类组件** | 用类定义的组件，继承自 React.Component | `class Greeting extends React.Component { render() { return <h1>Hello, {this.props.name}!</h1>; } }` |
| **纯组件** | 类组件的一种，会对 props 和 state 进行浅比较，避免不必要的渲染 | `class Greeting extends React.PureComponent { /* ... */ }` |
| **高阶组件** | 接收一个组件作为参数并返回一个新组件的函数 | `const EnhancedComponent = higherOrderComponent(WrappedComponent);` |
| **受控组件** | 由 React 控制状态的表单组件 | `<input value={this.state.value} onChange={this.handleChange} />` |
| **非受控组件** | 由 DOM 自身控制状态的表单组件 | `<input ref={this.inputRef} defaultValue="default" />` |

## 2. 函数组件

函数组件是 React 中定义组件的最简单方式，它是一个接收 props 并返回 React 元素的函数。

### 2.1 基本语法

```javascript
// 基本函数组件
function Greeting(props) {
  return <h1>Hello, {props.name}!</h1>;
}

// 使用 ES6 箭头函数
const Greeting = (props) => {
  return <h1>Hello, {props.name}!</h1>;
};

// 解构 props
const Greeting = ({ name }) => {
  return <h1>Hello, {name}!</h1>;
};

// 带默认值的 props
const Greeting = ({ name = "World" }) => {
  return <h1>Hello, {name}!</h1>;
};
```

### 2.2 使用 Hooks

从 React 16.8 开始，函数组件可以使用 Hooks 来管理状态和副作用。

```javascript
import React, { useState, useEffect } from 'react';

const Counter = () => {
  // 使用 useState Hook 管理状态
  const [count, setCount] = useState(0);
  const [name, setName] = useState("World");

  // 使用 useEffect Hook 处理副作用
  useEffect(() => {
    document.title = `Count: ${count}`;
  }, [count]); // 只有当 count 变化时才执行

  return (
    <div>
      <h1>Hello, {name}!</h1>
      <p>Count: {count}</p>
      <button onClick={() => setCount(count + 1)}>Increment</button>
      <button onClick={() => setCount(count - 1)}>Decrement</button>
      <input 
        type="text" 
        value={name} 
        onChange={(e) => setName(e.target.value)} 
        placeholder="Enter your name"
      />
    </div>
  );
};
```

### 2.3 函数组件的优势

- **简洁**：代码更简洁，可读性更好
- **易于测试**：函数组件更容易编写单元测试
- **性能更好**：函数组件比类组件更轻量，没有实例和生命周期方法的开销
- **支持 Hooks**：可以使用 React Hooks 来管理状态和副作用

## 3. 类组件

类组件是使用 ES6 类定义的组件，继承自 React.Component 类。

### 3.1 基本语法

```javascript
import React from 'react';

class Greeting extends React.Component {
  // 构造函数，用于初始化状态和绑定方法
  constructor(props) {
    super(props);
    this.state = {
      count: 0
    };
    // 绑定方法
    this.handleClick = this.handleClick.bind(this);
  }

  // 实例方法
  handleClick() {
    this.setState(prevState => ({
      count: prevState.count + 1
    }));
  }

  // 使用箭头函数自动绑定 this
  handleReset = () => {
    this.setState({ count: 0 });
  };

  // 渲染方法，必须实现
  render() {
    return (
      <div>
        <h1>Hello, {this.props.name}!</h1>
        <p>Count: {this.state.count}</p>
        <button onClick={this.handleClick}>Increment</button>
        <button onClick={this.handleReset}>Reset</button>
      </div>
    );
  }
}

// 默认 props
Greeting.defaultProps = {
  name: "World"
};

// props 类型检查
Greeting.propTypes = {
  name: PropTypes.string
};
```

### 3.2 生命周期方法

类组件有丰富的生命周期方法，用于在组件的不同阶段执行特定的逻辑。

#### 3.2.1 挂载阶段

- `constructor()`：组件初始化
- `static getDerivedStateFromProps()`：根据 props 更新 state
- `render()`：渲染组件
- `componentDidMount()`：组件挂载到 DOM 后调用，适合进行数据获取等操作

#### 3.2.2 更新阶段

- `static getDerivedStateFromProps()`：根据 props 更新 state
- `shouldComponentUpdate(nextProps, nextState)`：决定是否更新组件，返回布尔值
- `render()`：渲染组件
- `getSnapshotBeforeUpdate(prevProps, prevState)`：在 DOM 更新前获取快照
- `componentDidUpdate(prevProps, prevState, snapshot)`：组件更新后调用，适合处理 DOM 更新后的逻辑

#### 3.2.3 卸载阶段

- `componentWillUnmount()`：组件卸载前调用，适合清理资源

#### 3.2.4 错误处理

- `static getDerivedStateFromError(error)`：捕获子组件错误，返回新的 state
- `componentDidCatch(error, info)`：处理子组件错误，适合记录错误信息

### 3.3 类组件示例

```javascript
import React from 'react';

class DataFetcher extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      data: null,
      loading: true,
      error: null
    };
  }

  componentDidMount() {
    // 数据获取
    fetch(this.props.url)
      .then(response => {
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        return response.json();
      })
      .then(data => {
        this.setState({ data, loading: false });
      })
      .catch(error => {
        this.setState({ error, loading: false });
      });
  }

  componentDidUpdate(prevProps) {
    // 当 url 变化时重新获取数据
    if (prevProps.url !== this.props.url) {
      this.setState({ loading: true, error: null });
      fetch(this.props.url)
        .then(response => response.json())
        .then(data => {
          this.setState({ data, loading: false });
        })
        .catch(error => {
          this.setState({ error, loading: false });
        });
    }
  }

  componentWillUnmount() {
    // 清理资源，如取消请求、移除事件监听器等
  }

  render() {
    if (this.state.loading) {
      return <div>Loading...</div>;
    }

    if (this.state.error) {
      return <div>Error: {this.state.error.message}</div>;
    }

    return (
      <div>
        <h2>Data:</h2>
        <pre>{JSON.stringify(this.state.data, null, 2)}</pre>
      </div>
    );
  }
}
```

## 4. Props

Props（属性）是从父组件传递给子组件的数据，用于定制子组件的行为和外观。

### 4.1 基本使用

```javascript
// 父组件
function Parent() {
  const user = {
    name: "John",
    age: 30,
    email: "john@example.com"
  };

  return (
    <div>
      <Child name="World" />
      <Child {...user} />
      <Child name="React" age={20} />
    </div>
  );
}

// 子组件
function Child(props) {
  return (
    <div>
      <h2>Hello, {props.name}!</h2>
      {props.age && <p>Age: {props.age}</p>}
      {props.email && <p>Email: {props.email}</p>}
    </div>
  );
}
```

### 4.2 默认 Props

可以为组件设置默认 props，当父组件没有传递该 prop 时使用。

```javascript
// 函数组件：使用默认参数
const Child = ({ name = "World", age = 18 }) => {
  return (
    <div>
      <h2>Hello, {name}!</h2>
      <p>Age: {age}</p>
    </div>
  );
};

// 类组件：使用 defaultProps 静态属性
class Child extends React.Component {
  static defaultProps = {
    name: "World",
    age: 18
  };

  render() {
    return (
      <div>
        <h2>Hello, {this.props.name}!</h2>
        <p>Age: {this.props.age}</p>
      </div>
    );
  }
}
```

### 4.3 Props 类型检查

可以使用 PropTypes 或 TypeScript 对 props 进行类型检查，确保组件接收正确类型的数据。

```javascript
import React from 'react';
import PropTypes from 'prop-types';

// 函数组件
const Child = ({ name, age, email }) => {
  return (
    <div>
      <h2>Hello, {name}!</h2>
      <p>Age: {age}</p>
      <p>Email: {email}</p>
    </div>
  );
};

Child.propTypes = {
  name: PropTypes.string.isRequired, // 必须的字符串
  age: PropTypes.number, // 可选的数字
  email: PropTypes.string, // 可选的字符串
  callback: PropTypes.func, // 可选的函数
  user: PropTypes.shape({ // 可选的对象
    name: PropTypes.string,
    age: PropTypes.number
  }),
  items: PropTypes.arrayOf(PropTypes.string) // 可选的字符串数组
};

// 类组件
class Child extends React.Component {
  static propTypes = {
    name: PropTypes.string.isRequired,
    age: PropTypes.number
  };

  render() {
    return (
      <div>
        <h2>Hello, {this.props.name}!</h2>
        <p>Age: {this.props.age}</p>
      </div>
    );
  }
}
```

### 4.4 Props 不可变性

Props 是只读的，子组件不能直接修改 props。如果子组件需要修改数据，应该通过回调函数通知父组件，由父组件更新 state。

```javascript
// 父组件
function Parent() {
  const [count, setCount] = useState(0);

  const increment = () => {
    setCount(count + 1);
  };

  return (
    <div>
      <p>Count: {count}</p>
      <Child onIncrement={increment} />
    </div>
  );
}

// 子组件
function Child({ onIncrement }) {
  return (
    <button onClick={onIncrement}>
      Increment
    </button>
  );
}
```

## 5. State

State（状态）是组件内部管理的数据，用于控制组件的行为和外观。当 state 变化时，组件会重新渲染。

### 5.1 函数组件中的 State

使用 `useState` Hook 管理状态：

```javascript
import React, { useState } from 'react';

function Counter() {
  // 声明状态变量
  const [count, setCount] = useState(0);
  const [name, setName] = useState("World");

  // 更新状态
  const handleIncrement = () => {
    // 直接更新
    setCount(10);
    
    // 基于前一个状态更新
    setCount(prevCount => prevCount + 1);
    
    // 多次更新，只会生效一次
    setCount(count + 1);
    setCount(count + 1);
    
    // 正确的多次更新方式
    setCount(prevCount => prevCount + 1);
    setCount(prevCount => prevCount + 1);
  };

  return (
    <div>
      <h1>Hello, {name}!</h1>
      <p>Count: {count}</p>
      <button onClick={handleIncrement}>Increment</button>
    </div>
  );
}
```

### 5.2 类组件中的 State

使用 `this.state` 和 `this.setState()` 方法管理状态：

```javascript
import React from 'react';

class Counter extends React.Component {
  constructor(props) {
    super(props);
    // 初始化状态
    this.state = {
      count: 0,
      user: {
        name: "John",
        age: 30
      }
    };
  }

  handleIncrement = () => {
    // 直接更新
    this.setState({ count: 10 });
    
    // 基于前一个状态更新
    this.setState(prevState => ({
      count: prevState.count + 1
    }));
    
    // 更新对象类型的状态
    this.setState(prevState => ({
      user: {
        ...prevState.user,
        age: prevState.user.age + 1
      }
    }));
  };

  render() {
    return (
      <div>
        <h1>Hello, {this.state.user.name}!</h1>
        <p>Age: {this.state.user.age}</p>
        <p>Count: {this.state.count}</p>
        <button onClick={this.handleIncrement}>Increment</button>
      </div>
    );
  }
}
```

### 5.3 State 的特点

- **状态是私有的**：只有组件自己可以修改自己的状态
- **状态是可变的**：可以通过 `setState()` 或 `useState` Hook 更新状态
- **状态更新是异步的**：React 会将多个状态更新合并，批量执行，以提高性能
- **状态更新会触发重新渲染**：当状态变化时，组件会重新调用 render 方法

## 6. 组件样式

React 组件可以使用多种方式来添加样式。

### 6.1 内联样式

使用 `style` 属性直接在 JSX 中添加样式：

```javascript
function StyledComponent() {
  const style = {
    container: {
      backgroundColor: '#f0f0f0',
      padding: '20px',
      borderRadius: '8px',
      boxShadow: '0 2px 4px rgba(0, 0, 0, 0.1)'
    },
    title: {
      color: '#333',
      fontSize: '24px',
      marginBottom: '10px'
    },
    text: {
      color: '#666',
      fontSize: '16px'
    }
  };

  return (
    <div style={style.container}>
      <h1 style={style.title}>Styled Component</h1>
      <p style={style.text}>This component uses inline styles.</p>
    </div>
  );
}
```

### 6.2 CSS 类名

使用 CSS 类名来添加样式：

```css
/* styles.css */
.container {
  background-color: #f0f0f0;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.title {
  color: #333;
  font-size: 24px;
  margin-bottom: 10px;
}

.text {
  color: #666;
  font-size: 16px;
}
```

```javascript
import './styles.css';

function StyledComponent() {
  return (
    <div className="container">
      <h1 className="title">Styled Component</h1>
      <p className="text">This component uses CSS classes.</p>
    </div>
  );
}
```

### 6.3 CSS 模块

使用 CSS 模块来添加样式，避免样式冲突：

```css
/* styles.module.css */
.container {
  background-color: #f0f0f0;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.title {
  color: #333;
  font-size: 24px;
  margin-bottom: 10px;
}

.text {
  color: #666;
  font-size: 16px;
}
```

```javascript
import styles from './styles.module.css';

function StyledComponent() {
  return (
    <div className={styles.container}>
      <h1 className={styles.title}>Styled Component</h1>
      <p className={styles.text}>This component uses CSS modules.</p>
    </div>
  );
}
```

### 6.4 CSS-in-JS

使用 CSS-in-JS 库来添加样式，如 styled-components、emotion 等：

```bash
# 安装 styled-components
npm install styled-components
```

```javascript
import styled from 'styled-components';

// 创建样式组件
const Container = styled.div`
  background-color: #f0f0f0;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
`;

const Title = styled.h1`
  color: #333;
  font-size: 24px;
  margin-bottom: 10px;
`;

const Text = styled.p`
  color: #666;
  font-size: 16px;
`;

function StyledComponent() {
  return (
    <Container>
      <Title>Styled Component</Title>
      <Text>This component uses styled-components.</Text>
    </Container>
  );
}
```

### 6.5 条件样式

根据条件动态添加样式：

```javascript
function ConditionalStyle({ isActive }) {
  return (
    <div
      className={`container ${isActive ? 'active' : ''}`}
      style={{
        backgroundColor: isActive ? '#007bff' : '#f0f0f0',
        color: isActive ? 'white' : '#333'
      }}
    >
      <h1>Conditional Style</h1>
      <p>This component has conditional styles.</p>
    </div>
  );
}
```

## 7. 组件通信

组件通信是指组件之间传递数据和消息的方式。

### 7.1 父组件向子组件通信

通过 props 传递数据：

```javascript
// 父组件
function Parent() {
  const message = "Hello from Parent";
  return <Child message={message} />;
}

// 子组件
function Child({ message }) {
  return <p>{message}</p>;
}
```

### 7.2 子组件向父组件通信

通过回调函数传递数据：

```javascript
// 父组件
function Parent() {
  const [count, setCount] = useState(0);
  return (
    <div>
      <p>Count: {count}</p>
      <Child onIncrement={() => setCount(prev => prev + 1)} />
    </div>
  );
}

// 子组件
function Child({ onIncrement }) {
  return <button onClick={onIncrement}>Increment</button>;
}
```

### 7.3 兄弟组件通信

通过父组件作为中介传递数据：

```javascript
// 父组件
function Parent() {
  const [message, setMessage] = useState("");
  return (
    <div>
      <Child1 onSendMessage={setMessage} />
      <Child2 message={message} />
    </div>
  );
}

// 子组件 1
function Child1({ onSendMessage }) {
  return <button onClick={() => onSendMessage("Hello from Child1")}>Send Message</button>;
}

// 子组件 2
function Child2({ message }) {
  return <p>Message from Child1: {message}</p>;
}
```

### 7.4 跨层级组件通信

使用 React Context 或状态管理库（如 Redux）传递数据：

```javascript
// 创建 Context
const ThemeContext = React.createContext('light');

// 祖先组件
function Ancestor() {
  return (
    <ThemeContext.Provider value="dark">
      <Parent />
    </ThemeContext.Provider>
  );
}

// 父组件
function Parent() {
  return <Child />;
}

// 子组件
function Child() {
  const theme = useContext(ThemeContext);
  return <div style={{ backgroundColor: theme === 'dark' ? '#333' : '#fff', color: theme === 'dark' ? '#fff' : '#333' }}>
    Theme: {theme}
  </div>;
}
```

## 8. 组件生命周期

组件生命周期是指组件从创建到销毁的过程中经历的各个阶段。

### 8.1 函数组件生命周期

函数组件可以使用 `useEffect` Hook 来模拟生命周期：

```javascript
import React, { useEffect } from 'react';

function LifecycleComponent() {
  // componentDidMount
  useEffect(() => {
    console.log('Component mounted');
    
    // componentWillUnmount
    return () => {
      console.log('Component will unmount');
    };
  }, []); // 空依赖数组

  // componentDidUpdate
  useEffect(() => {
    console.log('Component updated');
  }, [count]); // 依赖 count

  return <div>Lifecycle Component</div>;
}
```

### 8.2 类组件生命周期

类组件的生命周期包括以下阶段：

1. **挂载阶段**：
   - `constructor()`：组件初始化
   - `static getDerivedStateFromProps()`：根据 props 更新 state
   - `render()`：渲染组件
   - `componentDidMount()`：组件挂载到 DOM 后调用

2. **更新阶段**：
   - `static getDerivedStateFromProps()`：根据 props 更新 state
   - `shouldComponentUpdate()`：决定是否更新组件
   - `render()`：渲染组件
   - `getSnapshotBeforeUpdate()`：在 DOM 更新前获取快照
   - `componentDidUpdate()`：组件更新后调用

3. **卸载阶段**：
   - `componentWillUnmount()`：组件卸载前调用

4. **错误处理**：
   - `static getDerivedStateFromError()`：捕获子组件错误
   - `componentDidCatch()`：处理子组件错误

## 9. 组件设计原则

### 9.1 单一职责原则

每个组件应该只负责一个功能，避免组件变得过大和复杂。

### 9.2 可复用性

设计组件时应该考虑可复用性，避免过度定制化。

### 9.3 组合优于继承

React 鼓励使用组合而不是继承来构建组件。

### 9.4 关注点分离

将 UI 渲染和业务逻辑分离，提高组件的可维护性和可测试性。

### 9.5 性能优化

- 使用 `React.memo` 缓存函数组件
- 使用 `useMemo` 缓存计算结果
- 使用 `useCallback` 缓存回调函数
- 避免在 render 中创建新函数
- 使用 key 属性优化列表渲染

### 9.6 可测试性

设计组件时应该考虑可测试性，避免组件过于复杂和依赖外部环境。

## 10. 组件测试

组件测试是确保组件按照预期工作的重要手段。

### 10.1 测试工具

- **Jest**：JavaScript 测试框架
- **React Testing Library**：用于测试 React 组件的库
- **Enzyme**：用于测试 React 组件的库
- **Cypress**：端到端测试框架

### 10.2 测试示例

```javascript
// 使用 React Testing Library 测试组件
import React from 'react';
import { render, screen, fireEvent } from '@testing-library/react';
import '@testing-library/jest-dom';
import Counter from './Counter';

describe('Counter Component', () => {
  test('renders correctly', () => {
    render(<Counter />);
    expect(screen.getByText('Count: 0')).toBeInTheDocument();
  });

  test('increments count when button is clicked', () => {
    render(<Counter />);
    const button = screen.getByText('Increment');
    fireEvent.click(button);
    expect(screen.getByText('Count: 1')).toBeInTheDocument();
  });

  test('decrements count when button is clicked', () => {
    render(<Counter />);
    const button = screen.getByText('Decrement');
    fireEvent.click(button);
    expect(screen.getByText('Count: -1')).toBeInTheDocument();
  });
});
```

## 11. 组件最佳实践

### 11.1 命名规范

- 使用 PascalCase 命名组件
- 使用 camelCase 命名文件
- 使用描述性的名称
- 避免使用缩写

### 11.2 代码组织

- 按功能组织组件
- 将相关的组件放在同一个目录下
- 使用 index.js 文件导出组件
- 分离样式文件

### 11.3 性能优化

- 使用 `React.memo` 缓存组件
- 使用 `useMemo` 和 `useCallback` 缓存计算结果和回调函数
- 避免在 render 中创建新函数
- 使用 key 属性优化列表渲染
- 懒加载组件

### 11.4 可访问性

- 使用语义化 HTML
- 添加适当的 ARIA 属性
- 确保键盘可访问性
- 提供替代文本
- 确保足够的对比度

### 11.5 错误处理

- 添加错误边界
- 处理异步错误
- 提供友好的错误信息
- 记录错误信息

### 11.6 文档

- 为组件添加文档
- 使用 Storybook 展示组件
- 提供示例代码
- 说明组件的用法和 API

## 12. 总结

组件是 React 应用的基本构建块，掌握组件的设计和开发是 React 开发的核心。React 提供了函数组件和类组件两种定义组件的方式，函数组件使用 Hooks 来管理状态和副作用，类组件使用生命周期方法来管理组件的生命周期。

组件之间通过 props 传递数据，通过回调函数和 Context 等方式进行通信。组件的样式可以使用内联样式、CSS 类名、CSS 模块或 CSS-in-JS 等方式添加。

设计组件时应该遵循单一职责原则、可复用性、组合优于继承等原则，同时考虑性能优化、可测试性和可访问性等因素。

通过学习和实践组件开发，你可以创建出可复用、可维护、高性能的 React 组件，构建出复杂的 React 应用。