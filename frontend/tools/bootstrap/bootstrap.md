# Bootstrap

## 1. Bootstrap 基础概念

### 1.1 什么是 Bootstrap

Bootstrap 是一个开源的前端框架，由 Twitter 开发，用于快速构建响应式、移动优先的网站。它提供了一套完整的 CSS 样式、JavaScript 组件和图标库，使开发者能够轻松创建现代化的网页设计。

### 1.2 Bootstrap 的特点

- **响应式设计**：自动适应不同屏幕尺寸
- **移动优先**：从移动设备开始设计，然后扩展到更大屏幕
- **组件化**：提供丰富的 UI 组件，如导航栏、按钮、表单等
- **易于定制**：支持自定义主题和样式
- **跨浏览器兼容**：兼容所有现代浏览器
- **开源免费**：基于 MIT 许可证

### 1.3 Bootstrap 版本

- **Bootstrap 5**：当前最新版本，移除了 jQuery 依赖，使用原生 JavaScript
- **Bootstrap 4**：使用 Flexbox 布局，支持 Sass 和 Less
- **Bootstrap 3**：经典版本，基于 Float 布局

## 2. 安装和使用

### 2.1 安装方式

#### 2.1.1 CDN 引入

最简单的方式是通过 CDN 引入 Bootstrap 的 CSS 和 JavaScript 文件。

```html
<!-- CSS 样式 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

<!-- JavaScript 组件 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
```

#### 2.1.2 包管理器安装

使用 npm、yarn 或 pnpm 安装 Bootstrap。

```bash
# 使用 npm
npm install bootstrap

# 使用 yarn
yarn add bootstrap

# 使用 pnpm
pnpm add bootstrap
```

然后在项目中引入：

```js
// 引入 CSS
import 'bootstrap/dist/css/bootstrap.min.css';

// 引入 JavaScript
import 'bootstrap/dist/js/bootstrap.bundle.min.js';
```

#### 2.1.3 下载源码

从 [Bootstrap 官网](https://getbootstrap.com/) 下载源码，然后手动引入 CSS 和 JavaScript 文件。

### 2.2 基本模板

以下是一个基本的 Bootstrap 模板：

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bootstrap 基础模板</title>
  <!-- 引入 Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
  <div class="container">
    <h1>Hello, Bootstrap!</h1>
    <p>这是一个使用 Bootstrap 构建的网页。</p>
  </div>

  <!-- 引入 Bootstrap JavaScript -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

## 3. 核心组件

### 3.1 容器（Container）

容器是 Bootstrap 布局的基础，用于包裹页面内容。

```html
<!-- 固定宽度容器，在不同断点处有不同宽度 -->
<div class="container">
  <!-- 内容 -->
</div>

<!-- 流体容器，宽度始终为 100% -->
<div class="container-fluid">
  <!-- 内容 -->
</div>
```

### 3.2 网格系统

Bootstrap 提供了响应式的 12 列网格系统，用于创建复杂的布局。

```html
<div class="container">
  <div class="row">
    <div class="col">
      1/3 宽度
    </div>
    <div class="col">
      1/3 宽度
    </div>
    <div class="col">
      1/3 宽度
    </div>
  </div>
  
  <div class="row">
    <div class="col-6">
      50% 宽度
    </div>
    <div class="col-6">
      50% 宽度
    </div>
  </div>
  
  <div class="row">
    <div class="col-md-8">
      中等屏幕及以上占 8 列
    </div>
    <div class="col-md-4">
      中等屏幕及以上占 4 列
    </div>
  </div>
</div>
```

### 3.3 按钮（Button）

提供多种样式和尺寸的按钮。

```html
<!-- 基本按钮 -->
<button type="button" class="btn btn-primary">主要按钮</button>
<button type="button" class="btn btn-secondary">次要按钮</button>
<button type="button" class="btn btn-success">成功按钮</button>
<button type="button" class="btn btn-danger">危险按钮</button>
<button type="button" class="btn btn-warning">警告按钮</button>
<button type="button" class="btn btn-info">信息按钮</button>
<button type="button" class="btn btn-light">浅色按钮</button>
<button type="button" class="btn btn-dark">深色按钮</button>

<!-- 按钮尺寸 -->
<button type="button" class="btn btn-primary btn-lg">大按钮</button>
<button type="button" class="btn btn-primary">默认按钮</button>
<button type="button" class="btn btn-primary btn-sm">小按钮</button>

<!-- 轮廓按钮 -->
<button type="button" class="btn btn-outline-primary">轮廓按钮</button>

<!-- 链接按钮 -->
<a href="#" class="btn btn-primary">链接按钮</a>
```

### 3.4 表单（Form）

提供样式统一的表单组件。

```html
<form>
  <div class="mb-3">
    <label for="exampleInputEmail1" class="form-label">Email 地址</label>
    <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
    <div id="emailHelp" class="form-text">我们不会分享您的邮箱给任何人。</div>
  </div>
  <div class="mb-3">
    <label for="exampleInputPassword1" class="form-label">密码</label>
    <input type="password" class="form-control" id="exampleInputPassword1">
  </div>
  <div class="mb-3 form-check">
    <input type="checkbox" class="form-check-input" id="exampleCheck1">
    <label class="form-check-label" for="exampleCheck1">记住我</label>
  </div>
  <button type="submit" class="btn btn-primary">提交</button>
</form>
```

### 3.5 导航栏（Navbar）

响应式导航栏，支持折叠菜单。

```html
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Navbar</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="#">首页</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">链接</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            下拉菜单
          </a>
          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
            <li><a class="dropdown-item" href="#">行动</a></li>
            <li><a class="dropdown-item" href="#">另一行动</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="#">其他</a></li>
          </ul>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">禁用</a>
        </li>
      </ul>
      <form class="d-flex">
        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success" type="submit">搜索</button>
      </form>
    </div>
  </div>
</nav>
```

### 3.6 卡片（Card）

灵活的内容容器，用于展示信息。

```html
<div class="card" style="width: 18rem;">
  <img src="..." class="card-img-top" alt="...">
  <div class="card-body">
    <h5 class="card-title">卡片标题</h5>
    <p class="card-text">这是一张 Bootstrap 卡片，用于展示信息。</p>
    <a href="#" class="btn btn-primary">了解更多</a>
  </div>
</div>
```

### 3.7 模态框（Modal）

用于显示对话框或通知。

```html
<!-- 触发按钮 -->
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
  打开模态框
</button>

<!-- 模态框 -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">模态框标题</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p>这是模态框的内容。</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary">保存更改</button>
      </div>
    </div>
  </div>
</div>
```

### 3.8 轮播图（Carousel）

用于展示多张图片或内容。

```html
<div id="carouselExampleIndicators" class="carousel slide">
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
  </div>
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="..." class="d-block w-100" alt="...">
      <div class="carousel-caption d-none d-md-block">
        <h5>第一张幻灯片</h5>
        <p>这是第一张幻灯片的描述。</p>
      </div>
    </div>
    <div class="carousel-item">
      <img src="..." class="d-block w-100" alt="...">
      <div class="carousel-caption d-none d-md-block">
        <h5>第二张幻灯片</h5>
        <p>这是第二张幻灯片的描述。</p>
      </div>
    </div>
    <div class="carousel-item">
      <img src="..." class="d-block w-100" alt="...">
      <div class="carousel-caption d-none d-md-block">
        <h5>第三张幻灯片</h5>
        <p>这是第三张幻灯片的描述。</p>
      </div>
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">上一张</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">下一张</span>
  </button>
</div>
```

## 3. 自定义主题

### 3.1 自定义 CSS 变量

Bootstrap 5 使用 CSS 变量，你可以通过覆盖这些变量来自定义主题。

```css
:root {
  --bs-primary: #0d6efd;
  --bs-secondary: #6c757d;
  --bs-success: #198754;
  --bs-danger: #dc3545;
  --bs-warning: #ffc107;
  --bs-info: #0dcaf0;
  --bs-light: #f8f9fa;
  --bs-dark: #212529;
  --bs-font-sans-serif: system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Noto Sans", "Liberation Sans", sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
  --bs-font-monospace: SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
  --bs-gradient: linear-gradient(180deg, rgba(255, 255, 255, 0.15), rgba(255, 255, 255, 0));
}
```

### 3.2 使用 Sass 自定义

如果使用 Sass 预处理器，可以通过修改 Sass 变量来自定义 Bootstrap。

```scss
// 引入 Bootstrap 源码
@import "~bootstrap/scss/bootstrap";

// 自定义变量
$primary: #0d6efd;
$secondary: #6c757d;
$success: #198754;
$danger: #dc3545;
$warning: #ffc107;
$info: #0dcaf0;
$light: #f8f9fa;
$dark: #212529;

// 引入 Bootstrap 组件
@import "~bootstrap/scss/functions";
@import "~bootstrap/scss/variables";
@import "~bootstrap/scss/mixins";
@import "~bootstrap/scss/root";
@import "~bootstrap/scss/reboot";
@import "~bootstrap/scss/type";
@import "~bootstrap/scss/images";
@import "~bootstrap/scss/containers";
@import "~bootstrap/scss/grid";
```

## 4. Bootstrap 与 React、Vue、Angular 的集成

### 4.1 React Bootstrap

React Bootstrap 是 Bootstrap 的 React 组件库，提供了 React 版本的 Bootstrap 组件。

```bash
# 安装
npm install react-bootstrap bootstrap
```

```jsx
import React from 'react';
import { Button, Navbar, Container } from 'react-bootstrap';
import 'bootstrap/dist/css/bootstrap.min.css';

function App() {
  return (
    <div className="App">
      <Navbar bg="light" expand="lg">
        <Container>
          <Navbar.Brand href="#">React Bootstrap</Navbar.Brand>
        </Container>
      </Navbar>
      <Container>
        <Button variant="primary">Click me</Button>
      </Container>
    </div>
  );
}

export default App;
```

### 4.2 Bootstrap Vue

Bootstrap Vue 是 Bootstrap 的 Vue 组件库，提供了 Vue 版本的 Bootstrap 组件。

```bash
# 安装
npm install bootstrap-vue bootstrap
```

```vue
<template>
  <div>
    <b-navbar toggleable="lg" type="light" variant="light">
      <b-navbar-brand href="#">Bootstrap Vue</b-navbar-brand>
    </b-navbar>
    <b-container>
      <b-button variant="primary">Click me</b-button>
    </b-container>
  </div>
</template>

<script>
import { BNavbar, BNavbarBrand, BContainer, BButton } from 'bootstrap-vue';
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap-vue/dist/bootstrap-vue.css';

export default {
  components: {
    BNavbar,
    BNavbarBrand,
    BContainer,
    BButton
  }
}
</script>
```

### 4.3 ng-bootstrap

ng-bootstrap 是 Bootstrap 的 Angular 组件库，提供了 Angular 版本的 Bootstrap 组件。

```bash
# 安装
npm install @ng-bootstrap/ng-bootstrap bootstrap
```

```typescript
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { AppComponent } from './app.component';
import { FormsModule } from '@angular/forms';

@NgModule({
  declarations: [AppComponent],
  imports: [BrowserModule, FormsModule, NgbModule],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
```

## 5. 最佳实践

### 5.1 响应式设计

- 使用容器、行和列创建响应式布局
- 使用响应式工具类（如 `d-none`, `d-md-block`）控制元素在不同屏幕尺寸下的显示
- 测试在不同设备上的显示效果

### 5.2 自定义样式

- 尽量使用 Bootstrap 提供的类，避免自定义过多样式
- 使用 CSS 变量或 Sass 变量自定义主题
- 为自定义样式添加前缀，避免与 Bootstrap 样式冲突

### 5.3 性能优化

- 只引入需要的 Bootstrap 组件
- 使用生产版本的 Bootstrap 文件
- 考虑使用 CSS 框架的按需引入功能

### 5.4 可访问性

- 确保所有交互元素都有适当的 ARIA 属性
- 确保文本和背景有足够的对比度
- 确保键盘可访问性

## 6. 常见问题和解决方案

### 6.1 如何解决 Bootstrap 样式冲突？

- 使用 CSS 变量自定义主题
- 为自定义样式添加前缀
- 使用更具体的选择器
- 使用 `!important`（谨慎使用）

### 6.2 如何优化 Bootstrap 性能？

- 使用 CDN 引入
- 只引入需要的组件
- 使用生产版本的文件
- 启用浏览器缓存

### 6.3 如何自定义 Bootstrap 主题？

- 使用 CSS 变量
- 使用 Sass 变量
- 使用 Bootstrap 主题生成器

## 7. 总结

Bootstrap 是一个功能强大的前端框架，提供了丰富的组件和样式，使开发者能够快速构建现代化的响应式网站。它的特点包括响应式设计、移动优先、组件化、易于定制和跨浏览器兼容。

Bootstrap 5 是当前最新版本，移除了 jQuery 依赖，使用原生 JavaScript，提供了更好的性能和更现代的 API。它可以与 React、Vue、Angular 等流行框架集成，满足不同项目的需求。

通过遵循最佳实践，如响应式设计、合理自定义样式、优化性能和确保可访问性，开发者可以充分利用 Bootstrap 的优势，创建高质量的网页设计。