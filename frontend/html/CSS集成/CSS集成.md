# HTML CSS 集成

## 1. CSS 概述

CSS（Cascading Style Sheets，层叠样式表）用于定义 HTML 文档的外观和格式，包括布局、颜色、字体、间距等。CSS 与 HTML 分离，实现了内容与表现的分离，便于维护和扩展。

## 2. CSS 在 HTML 中的应用方式

### 2.1 内联样式

内联样式直接应用于 HTML 元素，使用 `style` 属性：

```html
<h1 style="color: red; font-size: 24px;">这是标题</h1>
<p style="text-align: center; color: blue;">这是段落</p>
```

**特点：**
- 优先级最高，会覆盖其他样式
- 只影响单个元素
- 不利于维护，不推荐大量使用

### 2.2 内部样式表

内部样式表定义在 HTML 文档的 `<head>` 标签内，使用 `<style>` 标签：

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>内部样式表示例</title>
    <style>
        h1 {
            color: red;
            font-size: 24px;
        }
        
        p {
            text-align: center;
            color: blue;
        }
    </style>
</head>
<body>
    <h1>这是标题</h1>
    <p>这是段落</p>
</body>
</html>
```

**特点：**
- 影响整个 HTML 文档
- 便于维护单个文档的样式
- 不适合多个文档共享样式

### 2.3 外部样式表

外部样式表是一个独立的 `.css` 文件，通过 `<link>` 标签引入 HTML 文档：

**style.css 文件：**

```css
h1 {
    color: red;
    font-size: 24px;
}

p {
    text-align: center;
    color: blue;
}
```

**HTML 文档：**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>外部样式表示例</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>这是标题</h1>
    <p>这是段落</p>
</body>
</html>
```

**特点：**
- 可以被多个 HTML 文档共享
- 便于维护和更新样式
- 减少 HTML 文件大小
- 支持浏览器缓存，提高加载速度

### 2.4 @import 规则

使用 `@import` 规则可以在 CSS 文件中引入其他 CSS 文件：

```css
/* main.css */
@import url("reset.css");
@import url("layout.css");

/* 其他样式 */
h1 {
    color: red;
}
```

**特点：**
- 可以在 CSS 文件中组织和管理样式
- 加载顺序是串行的，可能影响性能
- 不推荐在 `<style>` 标签中使用，建议在外部 CSS 文件中使用

## 3. CSS 选择器

CSS 选择器用于选择要应用样式的 HTML 元素。

### 3.1 基本选择器

| 选择器 | 描述 | 示例 |
|--------|------|------|
| **元素选择器** | 选择所有指定标签的元素 | `p { color: red; }` |
| **类选择器** | 选择所有带有指定类名的元素 | `.myClass { color: red; }` |
| **ID 选择器** | 选择带有指定 ID 的元素 | `#myId { color: red; }` |
| **通用选择器** | 选择所有元素 | `* { margin: 0; padding: 0; }` |

### 3.2 组合选择器

| 选择器 | 描述 | 示例 |
|--------|------|------|
| **后代选择器** | 选择指定元素的所有后代元素 | `div p { color: red; }` |
| **子选择器** | 选择指定元素的直接子元素 | `div > p { color: red; }` |
| **相邻兄弟选择器** | 选择指定元素的下一个相邻兄弟元素 | `div + p { color: red; }` |
| **通用兄弟选择器** | 选择指定元素的所有后续兄弟元素 | `div ~ p { color: red; }` |

### 3.3 属性选择器

| 选择器 | 描述 | 示例 |
|--------|------|------|
| `[attribute]` | 选择带有指定属性的元素 | `[title] { color: red; }` |
| `[attribute=value]` | 选择带有指定属性和值的元素 | `[type="text"] { color: red; }` |
| `[attribute~=value]` | 选择属性值包含指定单词的元素 | `[class~="red"] { color: red; }` |
| `[attribute|=value]` | 选择属性值以指定值开头的元素 | `[lang|="en"] { color: red; }` |
| `[attribute^=value]` | 选择属性值以指定字符串开头的元素 | `[href^="https"] { color: red; }` |
| `[attribute$=value]` | 选择属性值以指定字符串结尾的元素 | `[src$=".jpg"] { border: 1px solid red; }` |
| `[attribute*=value]` | 选择属性值包含指定字符串的元素 | `[class*="red"] { color: red; }` |

### 3.4 伪类选择器

| 选择器 | 描述 | 示例 |
|--------|------|------|
| `:hover` | 选择鼠标悬停的元素 | `a:hover { color: red; }` |
| `:active` | 选择活动的元素 | `button:active { background-color: blue; }` |
| `:focus` | 选择获得焦点的元素 | `input:focus { border: 2px solid red; }` |
| `:visited` | 选择已访问的链接 | `a:visited { color: purple; }` |
| `:link` | 选择未访问的链接 | `a:link { color: blue; }` |
| `:first-child` | 选择第一个子元素 | `p:first-child { color: red; }` |
| `:last-child` | 选择最后一个子元素 | `p:last-child { color: red; }` |
| `:nth-child(n)` | 选择第 n 个子元素 | `p:nth-child(2) { color: red; }` |
| `:nth-last-child(n)` | 选择倒数第 n 个子元素 | `p:nth-last-child(2) { color: red; }` |
| `:first-of-type` | 选择第一个指定类型的子元素 | `p:first-of-type { color: red; }` |
| `:last-of-type` | 选择最后一个指定类型的子元素 | `p:last-of-type { color: red; }` |
| `:nth-of-type(n)` | 选择第 n 个指定类型的子元素 | `p:nth-of-type(2) { color: red; }` |
| `:nth-last-of-type(n)` | 选择倒数第 n 个指定类型的子元素 | `p:nth-last-of-type(2) { color: red; }` |
| `:not(selector)` | 选择不匹配指定选择器的元素 | `p:not(.special) { color: red; }` |

### 3.5 伪元素选择器

| 选择器 | 描述 | 示例 |
|--------|------|------|
| `::before` | 在元素内容前插入内容 | `p::before { content: "→ "; }` |
| `::after` | 在元素内容后插入内容 | `p::after { content: " ←"; }` |
| `::first-letter` | 选择元素的第一个字母 | `p::first-letter { font-size: 2em; }` |
| `::first-line` | 选择元素的第一行 | `p::first-line { color: red; }` |
| `::selection` | 选择用户选中的内容 | `::selection { background-color: yellow; }` |

## 4. CSS 优先级

CSS 优先级用于确定当多个样式规则应用于同一元素时，哪个规则会被应用。优先级从高到低依次为：

1. **!important**：最高优先级，应谨慎使用
2. **内联样式**：使用 `style` 属性定义的样式
3. **ID 选择器**：使用 `#id` 定义的样式
4. **类选择器、属性选择器、伪类选择器**：使用 `.class`、`[attribute]`、`:pseudo-class` 定义的样式
5. **元素选择器、伪元素选择器**：使用 `element`、`::pseudo-element` 定义的样式
6. **通用选择器**：使用 `*` 定义的样式
7. **继承的样式**：从父元素继承的样式

### 4.1 优先级计算

优先级可以用四元组 (a, b, c, d) 表示，其中：
- a：!important 声明的数量（0 或 1）
- b：ID 选择器的数量
- c：类选择器、属性选择器、伪类选择器的数量
- d：元素选择器、伪元素选择器的数量

比较优先级时，从左到右依次比较，值大的优先级高。

**示例：**

| 选择器 | 优先级 (a, b, c, d) |
|--------|---------------------|
| `h1` | (0, 0, 0, 1) |
| `.myClass` | (0, 0, 1, 0) |
| `#myId` | (0, 1, 0, 0) |
| `h1.myClass` | (0, 0, 1, 1) |
| `#myId h1` | (0, 1, 0, 1) |
| `style="color: red;"` | (0, 0, 0, 0) 但优先级高于 ID 选择器 |
| `!important` | (1, 0, 0, 0) 最高优先级 |

## 5. CSS 盒模型

CSS 盒模型描述了 HTML 元素的布局，包括内容（content）、内边距（padding）、边框（border）和外边距（margin）。

### 5.1 标准盒模型

标准盒模型中，元素的宽度和高度仅包括内容区域：

```
+---------------------------+
|          margin           |
|  +---------------------+  |
|  |       border        |  |
|  |  +---------------+  |  |
|  |  |    padding    |  |  |
|  |  |  +---------+  |  |  |
|  |  |  | content |  |  |  |
|  |  |  +---------+  |  |  |
|  |  +---------------+  |  |
|  +---------------------+  |
|                           |
+---------------------------+
```

### 5.2 IE 盒模型

IE 盒模型中，元素的宽度和高度包括内容区域、内边距和边框：

```css
/* 使用 IE 盒模型 */
box-sizing: border-box;
```

### 5.3 box-sizing 属性

`box-sizing` 属性用于控制盒模型的计算方式：

| 值 | 描述 |
|-----|------|
| `content-box` | 标准盒模型，宽度和高度仅包括内容区域 |
| `border-box` | IE 盒模型，宽度和高度包括内容区域、内边距和边框 |
| `inherit` | 继承父元素的 box-sizing 值 |

## 6. CSS 布局

### 6.1 传统布局

#### 6.1.1 流动布局

流动布局是默认的布局方式，元素按照在 HTML 中出现的顺序从上到下、从左到右排列。

#### 6.1.2 浮动布局

使用 `float` 属性可以使元素向左或向右浮动，其他元素环绕它：

```css
/* 左浮动 */
.float-left {
    float: left;
}

/* 右浮动 */
.float-right {
    float: right;
}

/* 清除浮动 */
.clearfix::after {
    content: "";
    display: table;
    clear: both;
}
```

#### 6.1.3 定位布局

使用 `position` 属性可以精确控制元素的位置：

| 值 | 描述 |
|-----|------|
| `static` | 默认值，元素按照正常流布局 |
| `relative` | 相对定位，相对于元素的正常位置进行定位 |
| `absolute` | 绝对定位，相对于最近的定位祖先元素进行定位 |
| `fixed` | 固定定位，相对于浏览器窗口进行定位 |
| `sticky` | 粘性定位，结合了相对定位和固定定位的特性 |

### 6.2 现代布局

#### 6.2.1 Flexbox 布局

Flexbox（弹性盒子）是一种一维布局模型，用于在水平或垂直方向上排列元素：

```css
/* 容器样式 */
.flex-container {
    display: flex;
    flex-direction: row; /* 主轴方向：row, row-reverse, column, column-reverse */
    justify-content: flex-start; /* 主轴对齐方式：flex-start, flex-end, center, space-between, space-around, space-evenly */
    align-items: stretch; /* 交叉轴对齐方式：stretch, flex-start, flex-end, center, baseline */
    flex-wrap: nowrap; /* 是否换行：nowrap, wrap, wrap-reverse */
    gap: 10px; /* 元素间距 */
}

/* 项目样式 */
.flex-item {
    flex: 1; /* 简写：flex-grow, flex-shrink, flex-basis */
    align-self: center; /* 单个项目的交叉轴对齐方式 */
    order: 0; /* 项目的排列顺序 */
}
```

#### 6.2.2 Grid 布局

Grid（网格）是一种二维布局模型，用于在行列网格中排列元素：

```css
/* 容器样式 */
.grid-container {
    display: grid;
    grid-template-columns: 1fr 2fr 1fr; /* 列定义 */
    grid-template-rows: auto 1fr auto; /* 行定义 */
    grid-template-areas: 
        "header header header"
        "sidebar main main"
        "footer footer footer";
    gap: 10px; /* 网格间距 */
    justify-items: stretch; /* 单元格内容的水平对齐方式 */
    align-items: stretch; /* 单元格内容的垂直对齐方式 */
}

/* 项目样式 */
.grid-item {
    grid-column: 1 / 3; /* 列位置：start / end */
    grid-row: 1 / 2; /* 行位置：start / end */
    grid-area: header; /* 网格区域名称 */
}
```

## 7. CSS 响应式设计

响应式设计使网页能够适应不同屏幕尺寸和设备，提供良好的用户体验。

### 7.1 媒体查询

使用 `@media` 规则可以根据不同的媒体特性（如屏幕宽度、高度、设备类型等）应用不同的样式：

```css
/* 基础样式 */
body {
    font-size: 16px;
}

/* 屏幕宽度小于 768px 时的样式 */
@media (max-width: 767px) {
    body {
        font-size: 14px;
    }
    
    .container {
        width: 100%;
        padding: 0 10px;
    }
}

/* 屏幕宽度大于等于 768px 时的样式 */
@media (min-width: 768px) {
    .container {
        width: 750px;
        margin: 0 auto;
    }
}

/* 屏幕宽度大于等于 992px 时的样式 */
@media (min-width: 992px) {
    .container {
        width: 970px;
    }
}

/* 屏幕宽度大于等于 1200px 时的样式 */
@media (min-width: 1200px) {
    .container {
        width: 1170px;
    }
}
```

### 7.2 视口设置

使用 `viewport` meta 标签可以控制网页在移动设备上的显示方式：

```html
<meta name="viewport" content="width=device-width, initial-scale=1.0">
```

### 7.3 相对单位

使用相对单位可以使元素尺寸随屏幕尺寸变化：

| 单位 | 描述 |
|------|------|
| `%` | 相对于父元素的百分比 |
| `em` | 相对于元素的字体大小 |
| `rem` | 相对于根元素（html）的字体大小 |
| `vw` | 相对于视口宽度的 1% |
| `vh` | 相对于视口高度的 1% |
| `vmin` | 相对于视口宽度和高度中较小值的 1% |
| `vmax` | 相对于视口宽度和高度中较大值的 1% |

## 8. CSS 变量

CSS 变量（自定义属性）允许在 CSS 中定义和使用变量，便于维护和更新样式。

### 8.1 定义和使用 CSS 变量

```css
/* 定义 CSS 变量 */
:root {
    --primary-color: #007bff;
    --secondary-color: #6c757d;
    --font-size: 16px;
    --spacing: 16px;
}

/* 使用 CSS 变量 */
body {
    font-size: var(--font-size);
    color: var(--primary-color);
}

.button {
    background-color: var(--primary-color);
    padding: var(--spacing);
}

.button-secondary {
    background-color: var(--secondary-color);
    padding: calc(var(--spacing) / 2);
}
```

### 8.2 CSS 变量的特点

- 可以在任何选择器中定义
- 可以继承和覆盖
- 支持计算（使用 `calc()` 函数）
- 可以在 JavaScript 中访问和修改

## 9. CSS 动画和过渡

### 9.1 过渡动画

使用 `transition` 属性可以实现元素从一种样式平滑过渡到另一种样式：

```css
/* 基础样式 */
.box {
    width: 100px;
    height: 100px;
    background-color: red;
    transition: all 0.3s ease;
}

/* 鼠标悬停样式 */
.box:hover {
    width: 200px;
    height: 200px;
    background-color: blue;
}
```

### 9.2 关键帧动画

使用 `@keyframes` 规则可以定义更复杂的动画：

```css
/* 定义动画 */
@keyframes slideIn {
    from {
        transform: translateX(-100%);
        opacity: 0;
    }
    to {
        transform: translateX(0);
        opacity: 1;
    }
}

/* 使用动画 */
.animated-element {
    animation-name: slideIn;
    animation-duration: 0.5s;
    animation-timing-function: ease;
    animation-delay: 0.2s;
    animation-iteration-count: 1;
    animation-direction: normal;
    animation-fill-mode: both;
    animation-play-state: running;
    
    /* 简写 */
    animation: slideIn 0.5s ease 0.2s 1 normal both running;
}
```

## 10. CSS 最佳实践

### 10.1 代码组织

- 使用外部 CSS 文件，实现内容与表现分离
- 按功能组织 CSS 代码（如重置样式、布局样式、组件样式等）
- 使用 CSS 预处理器（如 Sass、Less、Stylus）或后处理器（如 PostCSS）
- 采用模块化 CSS 架构（如 BEM、SMACSS、OOCSS 等）

### 10.2 性能优化

- 减少 CSS 文件大小，使用压缩工具（如 CSSNano、UglifyCSS）
- 避免使用 `@import` 规则，改为使用 `<link>` 标签
- 优化 CSS 选择器，避免使用复杂的选择器
- 使用 CSS 变量减少重复代码
- 利用浏览器缓存，设置合理的缓存策略

### 10.3 可维护性

- 使用有意义的类名和 ID 名
- 遵循一致的命名规范（如 BEM：Block__Element--Modifier）
- 添加注释说明复杂的样式规则
- 避免使用 `!important`，除非必要
- 使用相对单位，提高响应式设计能力

### 10.4 兼容性

- 使用 CSS 前缀（如 `-webkit-`、`-moz-`、`-ms-`）处理浏览器兼容性
- 使用 Autoprefixer 自动添加 CSS 前缀
- 考虑使用 CSS reset 或 normalize.css 统一浏览器默认样式
- 测试在不同浏览器和设备上的表现

## 11. 常见 CSS 框架

### 11.1 Bootstrap

Bootstrap 是最流行的 CSS 框架之一，提供了响应式布局、组件和工具类：

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bootstrap 示例</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h1 class="text-center mt-5">Hello, Bootstrap!</h1>
        <div class="row">
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Card Title</h5>
                        <p class="card-text">Card content</p>
                        <a href="#" class="btn btn-primary">Button</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
```

### 11.2 Tailwind CSS

Tailwind CSS 是一种实用优先的 CSS 框架，提供了大量的工具类：

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tailwind CSS 示例</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>
    <div class="container mx-auto px-4">
        <h1 class="text-center mt-10 text-3xl font-bold text-blue-600">Hello, Tailwind CSS!</h1>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mt-6">
            <div class="bg-white p-6 rounded-lg shadow-md">
                <h5 class="text-xl font-semibold mb-2">Card Title</h5>
                <p class="text-gray-700 mb-4">Card content</p>
                <a href="#" class="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded">Button</a>
            </div>
        </div>
    </div>
</body>
</html>
```

### 11.3 Foundation

Foundation 是另一个流行的响应式 CSS 框架，适合构建企业级网站：

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Foundation 示例</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/foundation-sites@6.7.5/dist/css/foundation.min.css">
</head>
<body>
    <div class="grid-container">
        <h1 class="text-center">Hello, Foundation!</h1>
        <div class="grid-x grid-margin-x">
            <div class="cell small-12 medium-4">
                <div class="card">
                    <div class="card-section">
                        <h5 class="card-title">Card Title</h5>
                        <p class="card-text">Card content</p>
                        <a href="#" class="button primary">Button</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
```

## 12. 总结

HTML CSS 集成是前端开发的重要组成部分，连接了 HTML 结构和 CSS 样式。通过学习 CSS 集成，你可以：

- 掌握 CSS 在 HTML 中的各种应用方式
- 理解 CSS 选择器和优先级
- 学会使用不同的 CSS 布局技术
- 实现响应式设计，适配不同设备
- 使用 CSS 变量、动画和过渡增强用户体验
- 遵循 CSS 最佳实践，编写高质量的样式代码

CSS 技术不断发展，从传统的浮动布局到现代的 Flexbox 和 Grid 布局，从 CSS 预处理器到 CSS 变量，为前端开发者提供了更多强大的工具和技术。掌握这些技术，你可以创建出美观、高效、响应式的网页。