# JavaScript DOM 操作

## 1. DOM 概述

DOM（Document Object Model，文档对象模型）是 HTML 和 XML 文档的编程接口，它将文档解析为一个由节点和对象（包含属性和方法）组成的结构集合。JavaScript 通过 DOM 可以访问和操作 HTML 文档的所有元素。

### 1.1 DOM 树结构

HTML 文档被解析为一个树形结构，称为 DOM 树。树中的每个节点代表文档中的一个部分：

```
├── Document
│   ├── html
│   │   ├── head
│   │   │   ├── title
│   │   │   └── meta
│   │   └── body
│   │       ├── h1
│   │       ├── p
│   │       └── div
│   │           └── img
```

### 1.2 DOM 节点类型

| 节点类型 | 描述 | 示例 |
|----------|------|------|
| **Document** | 文档节点，整个文档的根节点 | `document` |
| **Element** | 元素节点，HTML 标签 | `<div>`, `<p>`, `<h1>` |
| **Text** | 文本节点，元素内的文本内容 | "Hello World" |
| **Attribute** | 属性节点，元素的属性 | `class`, `id`, `src` |
| **Comment** | 注释节点，HTML 注释 | `<!-- 这是注释 -->` |
| **DocumentFragment** | 文档片段节点，轻量级文档对象 | 用于批量操作 DOM |

## 2. 选择 DOM 元素

JavaScript 提供了多种方法来选择和获取 DOM 元素。

### 2.1 根据 ID 选择

使用 `getElementById()` 方法根据元素的 ID 属性选择元素：

```javascript
const element = document.getElementById('myElement');
```

### 2.2 根据类名选择

使用 `getElementsByClassName()` 方法根据元素的类名选择元素，返回一个 HTMLCollection：

```javascript
const elements = document.getElementsByClassName('myClass');
// 转换为数组
const elementsArray = Array.from(elements);
```

### 2.3 根据标签名选择

使用 `getElementsByTagName()` 方法根据元素的标签名选择元素，返回一个 HTMLCollection：

```javascript
const paragraphs = document.getElementsByTagName('p');
```

### 2.4 根据 CSS 选择器选择

使用 `querySelector()` 方法根据 CSS 选择器选择第一个匹配的元素：

```javascript
const firstElement = document.querySelector('.myClass');
const firstParagraph = document.querySelector('p');
const nestedElement = document.querySelector('.container > .item');
```

使用 `querySelectorAll()` 方法根据 CSS 选择器选择所有匹配的元素，返回一个 NodeList：

```javascript
const allElements = document.querySelectorAll('.myClass');
const allParagraphs = document.querySelectorAll('p');
```

### 2.5 特殊元素选择

```javascript
// 获取 html 元素
const html = document.documentElement;

// 获取 head 元素
const head = document.head;

// 获取 body 元素
const body = document.body;

// 获取所有表单元素
const forms = document.forms;

// 获取所有图像元素
const images = document.images;
```

## 3. 操作 DOM 元素内容

### 3.1 文本内容

使用 `textContent` 属性获取或设置元素的文本内容：

```javascript
// 获取文本内容
const text = element.textContent;

// 设置文本内容
element.textContent = '新的文本内容';
```

### 3.2 HTML 内容

使用 `innerHTML` 属性获取或设置元素的 HTML 内容：

```javascript
// 获取 HTML 内容
const html = element.innerHTML;

// 设置 HTML 内容
element.innerHTML = '<p>新的 HTML 内容</p>';
```

**注意：** 使用 `innerHTML` 可能导致 XSS 攻击，尽量避免直接将用户输入设置为 `innerHTML`。

### 3.3 安全的 HTML 内容

使用 `insertAdjacentHTML()` 方法安全地插入 HTML 内容：

```javascript
// 在元素内部末尾插入
element.insertAdjacentHTML('beforeend', '<p>新的 HTML 内容</p>');

// 在元素前面插入
element.insertAdjacentHTML('beforebegin', '<div>前面的内容</div>');

// 在元素后面插入
element.insertAdjacentHTML('afterend', '<div>后面的内容</div>');

// 在元素内部开头插入
element.insertAdjacentHTML('afterbegin', '<p>开头的内容</p>');
```

## 4. 操作 DOM 元素属性

### 4.1 获取和设置属性

使用 `getAttribute()` 和 `setAttribute()` 方法操作元素属性：

```javascript
// 获取属性
const href = element.getAttribute('href');

// 设置属性
element.setAttribute('href', 'https://www.example.com');
```

### 4.2 直接操作属性

对于标准属性，可以直接通过元素对象访问：

```javascript
// 获取属性
const src = img.src;
const id = element.id;
const className = element.className;

// 设置属性
img.src = 'new-image.jpg';
element.id = 'newId';
element.className = 'newClass';
```

### 4.3 类名操作

使用 `classList` 属性操作元素的类名，提供了添加、移除、切换和检查类名的方法：

```javascript
// 添加类名
element.classList.add('newClass');
element.classList.add('class1', 'class2', 'class3');

// 移除类名
element.classList.remove('oldClass');
element.classList.remove('class1', 'class2');

// 切换类名（存在则移除，不存在则添加）
element.classList.toggle('active');

// 检查类名是否存在
const hasClass = element.classList.contains('active');

// 替换类名
element.classList.replace('oldClass', 'newClass');
```

### 4.4 数据属性

使用 `dataset` 属性操作自定义数据属性（以 `data-` 开头的属性）：

```html
<div id="myDiv" data-user-id="123" data-user-name="John"></div>
```

```javascript
const div = document.getElementById('myDiv');

// 获取数据属性
const userId = div.dataset.userId;
const userName = div.dataset.userName;

// 设置数据属性
div.dataset.userAge = '30';
div.dataset.userCity = 'Beijing';

// 删除数据属性
delete div.dataset.userCity;
```

## 5. 操作 DOM 元素样式

### 5.1 行内样式

使用 `style` 属性操作元素的行内样式：

```javascript
// 设置样式
element.style.color = 'red';
element.style.backgroundColor = 'blue';
element.style.fontSize = '16px';
element.style.marginTop = '20px';
element.style.display = 'none';

// 获取样式
const color = element.style.color;
```

### 5.2 CSS 类操作

使用 CSS 类来管理元素样式，更符合关注点分离原则：

```css
.hidden {
    display: none;
}

.highlight {
    background-color: yellow;
    font-weight: bold;
}
```

```javascript
// 添加高亮样式
element.classList.add('highlight');

// 隐藏元素
element.classList.add('hidden');

// 移除高亮样式
element.classList.remove('highlight');
```

### 5.3 获取计算样式

使用 `getComputedStyle()` 方法获取元素的计算样式（包括 CSS 类和浏览器默认样式）：

```javascript
const computedStyle = window.getComputedStyle(element);
const color = computedStyle.color;
const fontSize = computedStyle.fontSize;
const display = computedStyle.display;
```

## 6. 创建和插入 DOM 元素

### 6.1 创建元素

使用 `createElement()` 方法创建新的元素节点：

```javascript
const newDiv = document.createElement('div');
newDiv.textContent = '新创建的 div 元素';
newDiv.className = 'new-div';
```

### 6.2 创建文本节点

使用 `createTextNode()` 方法创建新的文本节点：

```javascript
const textNode = document.createTextNode('这是文本节点');
```

### 6.3 插入元素

使用 `appendChild()` 方法将元素添加到父元素的末尾：

```javascript
const parent = document.getElementById('parent');
parent.appendChild(newDiv);
```

使用 `insertBefore()` 方法将元素插入到指定元素之前：

```javascript
const parent = document.getElementById('parent');
const referenceElement = document.getElementById('reference');
parent.insertBefore(newDiv, referenceElement);
```

使用 `prepend()` 方法将元素添加到父元素的开头：

```javascript
parent.prepend(newDiv);
```

使用 `append()` 方法将元素添加到父元素的末尾，可以添加多个元素：

```javascript
parent.append(newDiv1, newDiv2, textNode);
```

使用 `before()` 方法在元素前面插入内容：

```javascript
element.before(newElement, textNode);
```

使用 `after()` 方法在元素后面插入内容：

```javascript
element.after(newElement, textNode);
```

### 6.4 替换元素

使用 `replaceChild()` 方法替换元素：

```javascript
const parent = document.getElementById('parent');
const oldElement = document.getElementById('old');
parent.replaceChild(newElement, oldElement);
```

使用 `replaceWith()` 方法替换元素：

```javascript
oldElement.replaceWith(newElement);
```

## 7. 删除 DOM 元素

### 7.1 移除子元素

使用 `removeChild()` 方法移除子元素：

```javascript
const parent = document.getElementById('parent');
const child = document.getElementById('child');
parent.removeChild(child);
```

### 7.2 移除自身

使用 `remove()` 方法移除元素自身：

```javascript
const element = document.getElementById('myElement');
element.remove();
```

## 8. 遍历 DOM 树

### 8.1 父节点遍历

```javascript
// 获取父节点
const parent = element.parentNode;

// 获取父元素（忽略文本节点和注释节点）
const parentElement = element.parentElement;
```

### 8.2 子节点遍历

```javascript
// 获取所有子节点（包括文本节点和注释节点）
const childNodes = element.childNodes;

// 获取所有子元素节点
const children = element.children;

// 获取第一个子节点
const firstChild = element.firstChild;

// 获取第一个子元素节点
const firstElementChild = element.firstElementChild;

// 获取最后一个子节点
const lastChild = element.lastChild;

// 获取最后一个子元素节点
const lastElementChild = element.lastElementChild;
```

### 8.3 兄弟节点遍历

```javascript
// 获取前一个兄弟节点
const previousSibling = element.previousSibling;

// 获取前一个兄弟元素节点
const previousElementSibling = element.previousElementSibling;

// 获取后一个兄弟节点
const nextSibling = element.nextSibling;

// 获取后一个兄弟元素节点
const nextElementSibling = element.nextElementSibling;
```

### 8.4 遍历所有后代元素

使用 `querySelectorAll()` 方法或递归遍历所有后代元素：

```javascript
// 使用 querySelectorAll
const allDescendants = element.querySelectorAll('*');

// 递归遍历
function traverse(element) {
    console.log(element);
    for (let child of element.children) {
        traverse(child);
    }
}

traverse(element);
```

## 9. DOM 事件基础

DOM 事件允许 JavaScript 响应用户交互和浏览器事件。

### 9.1 事件类型

| 事件类型 | 描述 |
|----------|------|
| **鼠标事件** | `click`, `dblclick`, `mouseenter`, `mouseleave`, `mousemove`, `mousedown`, `mouseup` |
| **键盘事件** | `keydown`, `keyup`, `keypress` |
| **表单事件** | `submit`, `change`, `input`, `focus`, `blur` |
| **窗口事件** | `load`, `resize`, `scroll`, `beforeunload` |
| **触摸事件** | `touchstart`, `touchmove`, `touchend`, `touchcancel` |
| **拖拽事件** | `dragstart`, `drag`, `dragend`, `dragenter`, `dragover`, `dragleave`, `drop` |

### 9.2 事件监听器

使用 `addEventListener()` 方法添加事件监听器：

```javascript
element.addEventListener('click', function(event) {
    console.log('元素被点击了', event);
});

// 使用箭头函数
element.addEventListener('click', (event) => {
    console.log('元素被点击了', event);
});

// 添加多个事件监听器
element.addEventListener('click', handleClick);
element.addEventListener('mouseenter', handleMouseEnter);
```

### 9.3 事件对象

事件处理函数会接收一个事件对象，包含事件的详细信息：

```javascript
element.addEventListener('click', function(event) {
    console.log('事件类型:', event.type);
    console.log('目标元素:', event.target);
    console.log('当前元素:', event.currentTarget);
    console.log('点击坐标 X:', event.clientX);
    console.log('点击坐标 Y:', event.clientY);
    console.log('是否按下 Ctrl 键:', event.ctrlKey);
    console.log('是否按下 Shift 键:', event.shiftKey);
    console.log('是否按下 Alt 键:', event.altKey);
});
```

### 9.4 移除事件监听器

使用 `removeEventListener()` 方法移除事件监听器：

```javascript
function handleClick(event) {
    console.log('元素被点击了');
}

// 添加事件监听器
element.addEventListener('click', handleClick);

// 移除事件监听器
element.removeEventListener('click', handleClick);
```

### 9.5 事件冒泡和捕获

DOM 事件有两个传播阶段：捕获阶段和冒泡阶段。

- **捕获阶段**：事件从根节点向下传播到目标元素
- **冒泡阶段**：事件从目标元素向上传播到根节点

```javascript
// 第三个参数为 true 表示在捕获阶段触发
element.addEventListener('click', handleClick, true);

// 第三个参数为 false 或省略表示在冒泡阶段触发
element.addEventListener('click', handleClick, false);
element.addEventListener('click', handleClick);
```

### 9.6 阻止事件传播

使用 `stopPropagation()` 方法阻止事件冒泡：

```javascript
element.addEventListener('click', function(event) {
    event.stopPropagation();
    console.log('元素被点击了');
});
```

使用 `stopImmediatePropagation()` 方法阻止事件冒泡并阻止同一元素的其他事件监听器被触发：

```javascript
element.addEventListener('click', function(event) {
    event.stopImmediatePropagation();
    console.log('第一个点击事件监听器');
});

element.addEventListener('click', function(event) {
    // 这个监听器不会被触发
    console.log('第二个点击事件监听器');
});
```

### 9.7 阻止默认行为

使用 `preventDefault()` 方法阻止事件的默认行为：

```javascript
// 阻止链接跳转
document.querySelectorAll('a').forEach(link => {
    link.addEventListener('click', function(event) {
        event.preventDefault();
        console.log('链接被点击，但阻止了跳转');
    });
});

// 阻止表单提交
document.querySelector('form').addEventListener('submit', function(event) {
    event.preventDefault();
    console.log('表单被提交，但阻止了默认提交行为');
});
```

## 10. DOM 性能优化

### 10.1 减少 DOM 操作次数

DOM 操作是昂贵的，应尽量减少 DOM 操作次数：

```javascript
// 不推荐：多次 DOM 操作
for (let i = 0; i < 1000; i++) {
    document.getElementById('container').innerHTML += `<div>Item ${i}</div>`;
}

// 推荐：使用文档片段批量操作
const fragment = document.createDocumentFragment();
for (let i = 0; i < 1000; i++) {
    const div = document.createElement('div');
    div.textContent = `Item ${i}`;
    fragment.appendChild(div);
}
document.getElementById('container').appendChild(fragment);
```

### 10.2 使用事件委托

事件委托利用事件冒泡原理，将事件监听器添加到父元素，而不是每个子元素：

```javascript
// 不推荐：为每个子元素添加事件监听器
document.querySelectorAll('.item').forEach(item => {
    item.addEventListener('click', function() {
        console.log('Item clicked:', this.textContent);
    });
});

// 推荐：使用事件委托
const container = document.getElementById('container');
container.addEventListener('click', function(event) {
    if (event.target.classList.contains('item')) {
        console.log('Item clicked:', event.target.textContent);
    }
});
```

### 10.3 缓存 DOM 元素

避免重复查询 DOM 元素，将查询结果缓存起来：

```javascript
// 不推荐：重复查询 DOM 元素
for (let i = 0; i < 100; i++) {
    document.getElementById('counter').textContent = i;
}

// 推荐：缓存 DOM 元素
const counter = document.getElementById('counter');
for (let i = 0; i < 100; i++) {
    counter.textContent = i;
}
```

### 10.4 避免使用 innerHTML

`innerHTML` 会重新解析整个元素的内容，性能较差。尽量使用 `textContent` 或 `createElement()` 代替：

```javascript
// 不推荐：使用 innerHTML
element.innerHTML += '<p>新内容</p>';

// 推荐：使用 createElement()
const p = document.createElement('p');
p.textContent = '新内容';
element.appendChild(p);
```

### 10.5 使用 requestAnimationFrame

对于频繁的 DOM 更新，使用 `requestAnimationFrame()` 优化性能：

```javascript
function updateDOM() {
    // DOM 更新操作
    requestAnimationFrame(updateDOM);
}

requestAnimationFrame(updateDOM);
```

## 11. 文档片段

文档片段（DocumentFragment）是一个轻量级的文档对象，用于批量操作 DOM。它不会触发页面重排，性能更好。

### 11.1 创建文档片段

```javascript
const fragment = document.createDocumentFragment();
```

### 11.2 使用文档片段

```javascript
// 创建多个元素
for (let i = 0; i < 100; i++) {
    const div = document.createElement('div');
    div.textContent = `Item ${i}`;
    div.className = 'item';
    // 添加到文档片段
    fragment.appendChild(div);
}

// 将文档片段添加到 DOM，只触发一次重排
const container = document.getElementById('container');
container.appendChild(fragment);
```

## 12. DOM 操作最佳实践

### 12.1 代码组织

- 将 DOM 操作相关代码放在 DOMContentLoaded 事件中，确保 DOM 加载完成后执行
- 分离 HTML、CSS 和 JavaScript 代码，遵循关注点分离原则
- 使用模块化设计，将 DOM 操作封装为函数或类

### 12.2 性能优化

- 减少 DOM 操作次数，使用文档片段批量操作
- 使用事件委托减少事件监听器数量
- 缓存 DOM 元素查询结果
- 避免在循环中进行 DOM 操作
- 使用 `requestAnimationFrame()` 优化频繁的 DOM 更新

### 12.3 可维护性

- 使用有意义的变量名和函数名
- 添加适当的注释
- 遵循一致的代码风格
- 使用现代 JavaScript 语法和特性

### 12.4 兼容性

- 考虑浏览器兼容性，使用 polyfill 或降级方案
- 使用特性检测，避免使用不支持的方法
- 测试在不同浏览器和设备上的表现

## 13. 总结

DOM 操作是 JavaScript 前端开发的核心内容，掌握 DOM 操作对于创建动态、交互式的网页至关重要。

通过学习 DOM 操作，你可以：
- 选择和获取 HTML 元素
- 修改元素内容和属性
- 动态创建和插入元素
- 操作元素样式
- 处理用户交互事件
- 优化 DOM 操作性能

DOM 操作需要注意性能问题，尽量减少 DOM 操作次数，使用事件委托和文档片段等优化手段。同时，要遵循最佳实践，编写可维护、高性能的 DOM 操作代码。