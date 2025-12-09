# Ant Design 文档

## 1. 基础概念

### 1.1 什么是 Ant Design？

Ant Design（简称 AntD）是一个企业级 UI 设计语言和 React 组件库，由阿里巴巴集团开发和维护。它提供了一套完整的设计规范和丰富的组件，帮助开发者快速构建高质量的企业级应用界面。

### 1.2 核心特性

- **企业级设计语言**：遵循统一的设计规范，确保界面一致性
- **丰富的组件库**：提供超过 50 个高质量组件，覆盖大部分业务场景
- **响应式设计**：支持各种设备尺寸，适配不同屏幕
- **国际化支持**：内置 40+ 种语言支持，易于本地化
- **TypeScript 支持**：完整的 TypeScript 类型定义
- **主题定制**：支持自定义主题，满足不同品牌需求
- **生态完善**：与 React、Vue、Angular 等主流框架深度集成
- **持续更新**：活跃的开发团队和社区，持续迭代更新

## 2. 安装

### 2.1 基本安装

在 React 项目中安装 Ant Design：

```bash
npm install antd
```

### 2.2 安装依赖

Ant Design 依赖于 React 和 React DOM，确保你的项目中已经安装了这些依赖：

```bash
npm install react react-dom
```

### 2.3 在 Next.js 项目中使用

在 Next.js 项目中，你可以直接安装并使用 Ant Design：

```bash
npm install antd
```

### 2.4 在 Vite 项目中使用

在 Vite 项目中，你可以使用以下命令安装：

```bash
npm install antd
```

## 3. 快速开始

### 3.1 基本使用

以下是一个简单的 Ant Design 组件使用示例：

```javascript
import React from 'react';
import { Button, message } from 'antd';
import 'antd/dist/reset.css'; // 导入样式

const App = () => {
  const handleClick = () => {
    message.success('Hello, Ant Design!');
  };

  return (
    <div style={{ padding: 24 }}>
      <Button type="primary" onClick={handleClick}>
        点击我
      </Button>
    </div>
  );
};

export default App;
```

### 3.2 使用 CSS-in-JS

如果你使用 CSS-in-JS，可以通过 `@ant-design/cssinjs` 来管理样式：

```javascript
import React from 'react';
import { ConfigProvider } from 'antd';
import { StyleProvider } from '@ant-design/cssinjs';

const App = () => {
  return (
    <StyleProvider>
      <ConfigProvider>
        {/* 你的应用组件 */}
      </ConfigProvider>
    </StyleProvider>
  );
};

export default App;
```

## 4. 核心组件

### 4.1 Button（按钮）

按钮是最常用的组件之一，Ant Design 提供了多种类型和样式的按钮：

```javascript
import { Button } from 'antd';

const ButtonExample = () => {
  return (
    <div>
      <Button type="primary">主要按钮</Button>
      <Button>默认按钮</Button>
      <Button type="dashed">虚线按钮</Button>
      <Button type="text">文本按钮</Button>
      <Button type="link">链接按钮</Button>
    </div>
  );
};
```

### 4.2 Form（表单）

表单组件用于收集和验证用户输入：

```javascript
import { Form, Input, Button, message } from 'antd';

const FormExample = () => {
  const [form] = Form.useForm();

  const onFinish = (values) => {
    message.success('表单提交成功！');
    console.log('表单值：', values);
  };

  return (
    <Form
      form={form}
      layout="vertical"
      onFinish={onFinish}
    >
      <Form.Item
        name="username"
        label="用户名"
        rules={[{ required: true, message: '请输入用户名' }]}
      >
        <Input placeholder="请输入用户名" />
      </Form.Item>
      <Form.Item
        name="password"
        label="密码"
        rules={[{ required: true, message: '请输入密码' }]}
      >
        <Input.Password placeholder="请输入密码" />
      </Form.Item>
      <Form.Item>
        <Button type="primary" htmlType="submit">
          登录
        </Button>
      </Form.Item>
    </Form>
  );
};
```

### 4.3 Table（表格）

表格组件用于展示结构化数据：

```javascript
import { Table } from 'antd';

const dataSource = [
  { key: '1', name: '张三', age: 32, address: '北京' },
  { key: '2', name: '李四', age: 42, address: '上海' },
  { key: '3', name: '王五', age: 32, address: '广州' },
];

const columns = [
  { title: '姓名', dataIndex: 'name', key: 'name' },
  { title: '年龄', dataIndex: 'age', key: 'age' },
  { title: '地址', dataIndex: 'address', key: 'address' },
];

const TableExample = () => {
  return <Table dataSource={dataSource} columns={columns} />;
};
```

### 4.4 Modal（模态框）

模态框用于显示重要信息或请求用户确认：

```javascript
import { Button, Modal } from 'antd';
import { useState } from 'react';

const ModalExample = () => {
  const [isModalOpen, setIsModalOpen] = useState(false);

  const showModal = () => {
    setIsModalOpen(true);
  };

  const handleOk = () => {
    setIsModalOpen(false);
  };

  const handleCancel = () => {
    setIsModalOpen(false);
  };

  return (
    <>
      <Button type="primary" onClick={showModal}>
        打开模态框
      </Button>
      <Modal
        title="基础模态框"
        open={isModalOpen}
        onOk={handleOk}
        onCancel={handleCancel}
      >
        <p>这是模态框的内容</p>
        <p>可以包含任意 React 组件</p>
      </Modal>
    </>
  );
};
```

### 4.5 Card（卡片）

卡片组件用于组织相关信息：

```javascript
import { Card, Button } from 'antd';

const CardExample = () => {
  return (
    <Card
      title="卡片标题"
      extra={<Button>更多</Button>}
      style={{ width: 300 }}
    >
      <p>卡片内容</p>
      <p>可以包含文本、图片等</p>
    </Card>
  );
};
```

## 5. 布局系统

### 5.1 Grid（栅格）

Ant Design 提供了 24 列的栅格系统，用于快速构建响应式布局：

```javascript
import { Row, Col } from 'antd';

const GridExample = () => {
  return (
    <Row>
      <Col span={8}>占用 8 列</Col>
      <Col span={8}>占用 8 列</Col>
      <Col span={8}>占用 8 列</Col>
    </Row>
  );
};
```

### 5.2 响应式布局

栅格系统支持响应式断点，包括 xs、sm、md、lg、xl、xxl：

```javascript
import { Row, Col } from 'antd';

const ResponsiveGridExample = () => {
  return (
    <Row>
      <Col xs={24} sm={12} md={8} lg={6} xl={4}>
        响应式列
      </Col>
      <Col xs={24} sm={12} md={8} lg={6} xl={4}>
        响应式列
      </Col>
      <Col xs={24} sm={12} md={8} lg={6} xl={4}>
        响应式列
      </Col>
    </Row>
  );
};
```

### 5.3 Layout（布局）

Layout 组件用于构建页面的整体布局，包括 Header、Sider、Content、Footer：

```javascript
import { Layout } from 'antd';

const { Header, Content, Footer, Sider } = Layout;

const LayoutExample = () => {
  return (
    <Layout style={{ minHeight: '100vh' }}>
      <Sider collapsible>
        <div className="logo" />
        {/* 侧边栏内容 */}
      </Sider>
      <Layout>
        <Header style={{ background: '#fff', padding: 0 }}>
          {/* 头部内容 */}
        </Header>
        <Content style={{ margin: '0 16px' }}>
          {/* 主要内容 */}
        </Content>
        <Footer style={{ textAlign: 'center' }}>
          Ant Design ©{new Date().getFullYear()} Created by Ant UED
        </Footer>
      </Layout>
    </Layout>
  );
};
```

## 6. 主题定制

### 6.1 使用 ConfigProvider 定制主题

你可以使用 ConfigProvider 组件来定制全局主题：

```javascript
import { ConfigProvider, Button } from 'antd';

const ThemeExample = () => {
  return (
    <ConfigProvider
      theme={{
        token: {
          colorPrimary: '#1890ff',
          borderRadius: 4,
        },
      }}
    >
      <Button type="primary">定制主题按钮</Button>
    </ConfigProvider>
  );
};
```

### 6.2 自定义主题颜色

你可以修改主题的主要颜色、次要颜色等：

```javascript
import { ConfigProvider, Button, Slider } from 'antd';

const ColorThemeExample = () => {
  return (
    <ConfigProvider
      theme={{
        token: {
          colorPrimary: '#00b96b',
          colorSuccess: '#52c41a',
          colorWarning: '#faad14',
          colorError: '#f5222d',
        },
      }}
    >
      <div>
        <Button type="primary">绿色主题按钮</Button>
        <Button type="success">成功按钮</Button>
        <Button type="warning">警告按钮</Button>
        <Button type="danger">错误按钮</Button>
      </div>
      <div style={{ marginTop: 16 }}>
        <Slider defaultValue={30} />
      </div>
    </ConfigProvider>
  );
};
```

### 6.3 使用 less 变量定制主题

如果你使用 less，可以通过修改 less 变量来定制主题：

```less
// 在你的 less 文件中
@import '~antd/dist/antd.less';

@primary-color: #00b96b;
@success-color: #52c41a;
@warning-color: #faad14;
@error-color: #f5222d;
@font-size-base: 14px;
```

## 7. 国际化

### 7.1 基本国际化配置

Ant Design 内置了国际化支持，你可以使用 ConfigProvider 来设置语言：

```javascript
import { ConfigProvider, DatePicker, Button } from 'antd';
import zhCN from 'antd/locale/zh_CN';
import enUS from 'antd/locale/en_US';

const I18nExample = () => {
  return (
    <div>
      <ConfigProvider locale={zhCN}>
        <div>
          <DatePicker />
          <Button type="primary" style={{ marginLeft: 8 }}>
            中文按钮
          </Button>
        </div>
      </ConfigProvider>
      
      <ConfigProvider locale={enUS} style={{ marginTop: 16 }}>
        <div>
          <DatePicker />
          <Button type="primary" style={{ marginLeft: 8 }}>
            English Button
          </Button>
        </div>
      </ConfigProvider>
    </div>
  );
};
```

## 8. 最佳实践

### 8.1 组件使用建议

- **按需导入**：使用 Tree Shaking 或按需导入，减少打包体积
- **合理使用状态管理**：对于复杂应用，结合 Redux 或 MobX 使用
- **遵循设计规范**：尽量遵循 Ant Design 的设计规范，保持界面一致性
- **组件复用**：将常用组件封装为自定义组件，提高复用性
- **性能优化**：对于大数据量的组件（如 Table），使用虚拟滚动等优化手段

### 8.2 性能优化

- **使用 memo 优化组件**：对于纯展示组件，使用 React.memo 减少不必要的重新渲染
- **使用 useMemo 和 useCallback**：优化计算密集型操作和回调函数
- **虚拟滚动**：对于长列表，使用虚拟滚动技术
- **按需加载**：使用动态导入，减少初始加载时间

### 8.3 代码组织

- **按功能模块化**：将相关组件组织到同一个模块中
- **清晰的命名规范**：组件名称使用 PascalCase，文件名称与组件名称一致
- **合理的目录结构**：根据功能或页面组织组件目录
- **编写清晰的文档**：为组件编写使用文档和示例

## 9. 自定义组件

### 9.1 基础概念

自定义组件是基于 Ant Design 组件库扩展或全新创建的组件，用于满足特定业务需求。自定义组件可以：

- 扩展现有 Ant Design 组件的功能
- 组合多个 Ant Design 组件
- 实现全新的业务组件
- 统一业务逻辑和样式

### 9.2 扩展现有组件

你可以通过包装现有 Ant Design 组件来扩展其功能：

```javascript
import React from 'react';
import { Button, Tooltip } from 'antd';
import { QuestionCircleOutlined } from '@ant-design/icons';

// 带提示的按钮组件
const TooltipButton = ({ title, tooltip, ...props }) => {
  return (
    <Tooltip title={tooltip}>
      <Button {...props}>
        {title}
        <QuestionCircleOutlined style={{ marginLeft: 8 }} />
      </Button>
    </Tooltip>
  );
};

// 使用示例
const App = () => {
  return (
    <div>
      <TooltipButton
        type="primary"
        title="提交"
        tooltip="点击提交表单数据"
        onClick={() => console.log('提交')}
      />
    </div>
  );
};
```

### 9.3 自定义样式

你可以使用 CSS Modules、styled-components 或 Less 来自定义组件样式：

#### 9.3.1 使用 CSS Modules

```javascript
// CustomButton.module.css
.customButton {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border: none;
  border-radius: 8px;
  padding: 10px 20px;
  font-weight: bold;
  transition: all 0.3s ease;
}

.customButton:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
}

// CustomButton.js
import React from 'react';
import { Button } from 'antd';
import styles from './CustomButton.module.css';

const CustomButton = ({ children, ...props }) => {
  return (
    <Button className={styles.customButton} {...props}>
      {children}
    </Button>
  );
};
```

#### 9.3.2 使用 styled-components

```javascript
import React from 'react';
import { Button } from 'antd';
import styled from 'styled-components';

const StyledButton = styled(Button)`
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border: none;
  border-radius: 8px;
  padding: 10px 20px;
  font-weight: bold;
  transition: all 0.3s ease;
  
  &:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
    background: linear-gradient(135deg, #5a6fd8 0%, #6a4298 100%);
  }
`;

const GradientButton = ({ children, ...props }) => {
  return <StyledButton {...props}>{children}</StyledButton>;
};
```

### 9.4 组合多个组件

你可以组合多个 Ant Design 组件来创建复杂的自定义组件：

```javascript
import React, { useState } from 'react';
import { Card, Input, Button, Space, message } from 'antd';
import { SearchOutlined, ClearOutlined } from '@ant-design/icons';

// 搜索卡片组件
const SearchCard = ({ title, onSearch, placeholder = '请输入搜索内容' }) => {
  const [searchText, setSearchText] = useState('');

  const handleSearch = () => {
    if (!searchText.trim()) {
      message.warning('请输入搜索内容');
      return;
    }
    onSearch(searchText);
  };

  const handleClear = () => {
    setSearchText('');
    onSearch('');
  };

  const handleKeyPress = (e) => {
    if (e.key === 'Enter') {
      handleSearch();
    }
  };

  return (
    <Card title={title}>
      <Space.Compact style={{ width: '100%' }}>
        <Input
          placeholder={placeholder}
          value={searchText}
          onChange={(e) => setSearchText(e.target.value)}
          onPressEnter={handleKeyPress}
          style={{ flex: 1 }}
        />
        <Button
          type="primary"
          icon={<SearchOutlined />}
          onClick={handleSearch}
        >
          搜索
        </Button>
        <Button icon={<ClearOutlined />} onClick={handleClear}>
          清空
        </Button>
      </Space.Compact>
    </Card>
  );
};

// 使用示例
const App = () => {
  const handleSearch = (text) => {
    console.log('搜索内容:', text);
    message.success(`搜索: ${text}`);
  };

  return (
    <div style={{ padding: 24 }}>
      <SearchCard
        title="用户搜索"
        onSearch={handleSearch}
        placeholder="请输入用户名或邮箱"
      />
    </div>
  );
};
```

### 9.5 实现复杂业务组件

以下是一个更复杂的业务组件示例 - 数据表格组件，包含搜索、筛选、分页等功能：

```javascript
import React, { useState } from 'react';
import { Table, Input, Select, Button, Space, Card, Row, Col, Pagination } from 'antd';
import { SearchOutlined, FilterOutlined, ReloadOutlined } from '@ant-design/icons';

// 数据表格组件
const DataTable = ({ 
  title, 
  columns, 
  dataSource, 
  onRefresh,
  rowKey = 'id'
}) => {
  const [searchText, setSearchText] = useState('');
  const [filteredData, setFilteredData] = useState(dataSource);
  const [currentPage, setCurrentPage] = useState(1);
  const [pageSize, setPageSize] = useState(10);
  const [filterOption, setFilterOption] = useState('');

  // 搜索和筛选逻辑
  const handleSearch = () => {
    let result = [...dataSource];
    
    // 搜索
    if (searchText) {
      result = result.filter(item => {
        return Object.values(item).some(value => {
          return String(value).toLowerCase().includes(searchText.toLowerCase());
        });
      });
    }
    
    // 筛选
    if (filterOption) {
      // 根据实际业务调整筛选逻辑
      result = result.filter(item => item.status === filterOption);
    }
    
    setFilteredData(result);
    setCurrentPage(1);
  };

  // 分页数据
  const paginatedData = filteredData.slice(
    (currentPage - 1) * pageSize,
    currentPage * pageSize
  );

  return (
    <Card title={title}>
      {/* 工具栏 */}
      <Row gutter={16} style={{ marginBottom: 16 }}>
        <Col span={8}>
          <Space.Compact style={{ width: '100%' }}>
            <Input
              placeholder="搜索"
              prefix={<SearchOutlined />}
              value={searchText}
              onChange={(e) => setSearchText(e.target.value)}
            />
            <Button type="primary" onClick={handleSearch}>
              搜索
            </Button>
          </Space.Compact>
        </Col>
        <Col span={6}>
          <Select
            placeholder="筛选状态"
            style={{ width: '100%' }}
            value={filterOption}
            onChange={setFilterOption}
          >
            <Select.Option value="">全部</Select.Option>
            <Select.Option value="active">活跃</Select.Option>
            <Select.Option value="inactive">非活跃</Select.Option>
          </Select>
        </Col>
        <Col span={10} style={{ textAlign: 'right' }}>
          <Space>
            <Button
              icon={<FilterOutlined />}
              onClick={handleSearch}
            >
              筛选
            </Button>
            <Button
              icon={<ReloadOutlined />}
              onClick={() => {
                setSearchText('');
                setFilterOption('');
                setFilteredData(dataSource);
                if (onRefresh) onRefresh();
              }}
            >
              刷新
            </Button>
          </Space>
        </Col>
      </Row>
      
      {/* 表格 */}
      <Table
        columns={columns}
        dataSource={paginatedData}
        rowKey={rowKey}
        pagination={false}
        bordered
      />
      
      {/* 分页 */}
      <Row style={{ marginTop: 16, justifyContent: 'flex-end' }}>
        <Pagination
          current={currentPage}
          pageSize={pageSize}
          total={filteredData.length}
          onChange={(page, size) => {
            setCurrentPage(page);
            setPageSize(size);
          }}
          showSizeChanger
          pageSizeOptions={['10', '20', '50', '100']}
          showTotal={(total) => `共 ${total} 条记录`}
        />
      </Row>
    </Card>
  );
};

// 使用示例
const App = () => {
  const columns = [
    { title: '姓名', dataIndex: 'name', key: 'name' },
    { title: '年龄', dataIndex: 'age', key: 'age' },
    { title: '邮箱', dataIndex: 'email', key: 'email' },
    { title: '状态', dataIndex: 'status', key: 'status' },
  ];

  const dataSource = [
    { id: 1, name: '张三', age: 32, email: 'zhangsan@example.com', status: 'active' },
    { id: 2, name: '李四', age: 28, email: 'lisi@example.com', status: 'active' },
    { id: 3, name: '王五', age: 45, email: 'wangwu@example.com', status: 'inactive' },
    // 更多数据...
  ];

  return (
    <div style={{ padding: 24 }}>
      <DataTable
        title="用户列表"
        columns={columns}
        dataSource={dataSource}
        onRefresh={() => console.log('刷新数据')}
      />
    </div>
  );
};
```

### 9.6 自定义 Hook

你可以创建自定义 Hook 来封装组件的业务逻辑：

```javascript
import { useState, useEffect } from 'react';

// 分页 Hook
const usePagination = (data, initialPage = 1, initialPageSize = 10) => {
  const [currentPage, setCurrentPage] = useState(initialPage);
  const [pageSize, setPageSize] = useState(initialPageSize);

  // 计算分页数据
  const total = data.length;
  const paginatedData = data.slice(
    (currentPage - 1) * pageSize,
    currentPage * pageSize
  );

  // 页码变化处理
  const handlePageChange = (page, size) => {
    setCurrentPage(page);
    if (size) setPageSize(size);
  };

  return {
    currentPage,
    pageSize,
    total,
    paginatedData,
    handlePageChange,
  };
};

// 使用示例
const DataList = ({ data }) => {
  const { currentPage, pageSize, total, paginatedData, handlePageChange } = usePagination(data);

  return (
    <div>
      {/* 渲染 paginatedData */}
      <Pagination
        current={currentPage}
        pageSize={pageSize}
        total={total}
        onChange={handlePageChange}
      />
    </div>
  );
};
```

### 9.7 最佳实践

1. **组件职责单一**：每个自定义组件只负责一个功能
2. **props 设计合理**：使用清晰的 props 命名，提供合理的默认值
3. **类型安全**：使用 TypeScript 定义组件 props 类型
4. **可测试性**：组件设计便于单元测试
5. **文档完善**：为自定义组件编写清晰的文档和示例
6. **样式隔离**：使用 CSS Modules 或 styled-components 确保样式隔离
7. **性能优化**：使用 React.memo、useMemo 和 useCallback 优化性能
8. **遵循 Ant Design 设计规范**：保持与 Ant Design 设计风格一致

## 10. 常见问题

### 10.1 样式冲突

如果遇到样式冲突问题，可以尝试以下解决方案：

- 使用 CSS Modules 或 styled-components 等 CSS-in-JS 方案
- 为 Ant Design 组件添加自定义前缀
- 调整样式加载顺序

### 10.2 组件不显示

检查以下几点：

- 确保已正确导入组件
- 确保已导入样式文件
- 检查组件的父容器是否有正确的尺寸
- 检查浏览器控制台是否有错误信息

### 10.3 主题定制不生效

检查以下几点：

- 确保使用了正确的主题定制方法
- 检查 less 版本是否兼容
- 确保主题配置被正确应用

## 11. 资源

- **官方文档**：https://ant.design/
- **GitHub 仓库**：https://github.com/ant-design/ant-design
- **组件示例**：https://ant.design/components/
- **设计规范**：https://ant.design/docs/spec/introduce
- **Ant Design Pro**：https://pro.ant.design/（企业级中后台解决方案）
- **Ant Design Mobile**：https://mobile.ant.design/（移动端组件库）

## 12. 总结

Ant Design 是一个功能强大、设计精良的企业级 UI 组件库，它提供了丰富的组件和工具，帮助开发者快速构建高质量的应用界面。通过合理使用 Ant Design，你可以提高开发效率，保证界面的一致性和专业性。

Ant Design 的核心优势在于其完善的设计规范、丰富的组件库和良好的生态支持。它适用于各种规模的企业级应用，从小型项目到大型复杂系统都能胜任。

自定义组件是 Ant Design 生态的重要组成部分，通过扩展和组合 Ant Design 组件，你可以快速构建符合业务需求的高质量组件。遵循自定义组件的最佳实践，可以提高组件的复用性、可维护性和性能。

随着 React 生态的不断发展，Ant Design 也在持续演进，不断推出新的组件和功能，以满足开发者的需求。如果你正在构建企业级 React 应用，Ant Design 绝对是一个值得考虑的选择。