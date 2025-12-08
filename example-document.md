# 文档助手项目 - 使用指南

## 1. 项目简介

文档助手项目是一个专注于创建高质量技术文档的纯文档项目。本项目旨在提供清晰、结构化的技术内容，帮助读者快速理解复杂概念。

## 2. 快速开始

### 2.1 环境要求
- 任意文本编辑器（推荐 VS Code）
- Git（用于版本控制）
- Markdown 查看器（可选）

### 2.2 项目结构

```
文档助手项目/
├── .github/
│   └── copilot-instruction.md   # Copilot 指令文档
├── example-document.md          # 示例文档
└── README.md                    # 项目说明
```

## 3. Markdown 写作技巧

### 3.1 标题层级

使用 # 符号创建标题，层级从 1 到 6：

```markdown
# 一级标题
## 二级标题
### 三级标题
#### 四级标题
##### 五级标题
###### 六级标题
```

### 3.2 文本格式化

- **粗体文本**：使用 `**粗体**` 或 `__粗体__`
- *斜体文本*：使用 `*斜体*` 或 `_斜体_`
- ~~删除线文本~~：使用 `~~删除线~~`
- 行内代码：使用 `` `行内代码` ``

### 3.3 列表

#### 无序列表
```markdown
- 项目 1
- 项目 2
  - 子项目 2.1
  - 子项目 2.2
```

#### 有序列表
```markdown
1. 第一步
2. 第二步
   1. 子步骤 2.1
   2. 子步骤 2.2
```

## 4. 代码示例最佳实践

### 4.1 JavaScript 示例

```javascript
/**
 * 计算两个数字的和
 * @param {number} a - 第一个数字
 * @param {number} b - 第二个数字
 * @returns {number} - 两个数字的和
 */
function add(a, b) {
    return a + b;
}

// 使用示例
const result = add(5, 3);
console.log(result); // 输出: 8
```

### 4.2 Python 示例

```python
def calculate_area(radius):
    """
    计算圆的面积
    :param radius: 圆的半径
    :return: 圆的面积
    """
    import math
    return math.pi * radius ** 2

# 使用示例
area = calculate_area(5)
print(f"圆的面积: {area:.2f}")  # 输出: 圆的面积: 78.54
```

## 5. 文档审核清单

在提交文档前，请检查以下项目：

- [ ] 标题层级清晰
- [ ] 内容结构合理
- [ ] 代码示例可运行
- [ ] 术语定义明确
- [ ] 链接有效
- [ ] 拼写和语法正确

## 6. 贡献指南

欢迎为文档助手项目做出贡献！请遵循以下步骤：

1. Fork 本项目
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'feat: Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 打开 Pull Request

---

**注意**：本项目遵循文档风格指南，所有贡献应保持一致的格式和质量。