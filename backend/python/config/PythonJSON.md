# Python JSON 库

## 1. 概述

### 1.1 什么是 JSON
JSON（JavaScript Object Notation）是一种轻量级的数据交换格式，易于人阅读和编写，同时也易于机器解析和生成。它基于 JavaScript 语言的一个子集，但独立于语言，几乎所有的现代编程语言都支持 JSON。

### 1.2 JSON 的优势
- **轻量级**：相比 XML，JSON 更简洁，传输速度更快
- **易读性**：采用键值对的形式，结构清晰，易于理解
- **跨平台**：几乎所有现代编程语言都支持 JSON
- **易于解析**：解析和生成 JSON 数据的成本较低
- **支持多种数据类型**：包括字符串、数字、布尔值、数组、对象和 null

### 1.3 Python JSON 库
Python 标准库中内置了 `json` 模块，用于处理 JSON 数据。该模块提供了将 Python 对象转换为 JSON 字符串（序列化）和将 JSON 字符串转换为 Python 对象（反序列化）的功能。

### 1.4 常见应用场景
- **Web API 数据交换**：与各种 RESTful API 交互
- **配置文件**：存储应用程序配置
- **数据持久化**：将数据保存到文件
- **跨语言数据传输**：在不同编程语言之间传递数据
- **日志记录**：以结构化格式记录日志

## 2. 核心概念

### 2.1 JSON 数据类型
| JSON 类型 | Python 类型 |
|----------|-------------|
| 字符串   | str         |
| 数字     | int/float   |
| 布尔值   | bool        |
| 数组     | list        |
| 对象     | dict        |
| null     | None        |

### 2.2 序列化与反序列化
- **序列化**：将 Python 对象转换为 JSON 字符串的过程，使用 `json.dumps()` 或 `json.dump()`
- **反序列化**：将 JSON 字符串转换为 Python 对象的过程，使用 `json.loads()` 或 `json.load()`

## 3. 基本使用

### 3.1 序列化（Python → JSON）

#### 3.1.1 将 Python 对象转换为 JSON 字符串
```python
import json

# Python 字典
python_dict = {
    "name": "张三",
    "age": 25,
    "is_student": False,
    "courses": ["Python", "Java", "JavaScript"],
    "scores": {
        "Python": 90,
        "Java": 85,
        "JavaScript": 95
    },
    "birthday": None
}

# 将 Python 字典转换为 JSON 字符串
json_str = json.dumps(python_dict)
print(f"JSON 字符串：{json_str}")
```

#### 3.1.2 美化输出
```python
# 美化输出（添加缩进）
json_str_pretty = json.dumps(python_dict, indent=4)
print(f"美化后的 JSON 字符串：\n{json_str_pretty}")

# 美化输出（使用中文编码）
json_str_pretty = json.dumps(python_dict, indent=4, ensure_ascii=False)
print(f"包含中文的 JSON 字符串：\n{json_str_pretty}")
```

#### 3.1.3 控制序列化行为
```python
# 排序键
json_str_sorted = json.dumps(python_dict, indent=4, sort_keys=True)
print(f"按键排序的 JSON 字符串：\n{json_str_sorted}")

# 指定分隔符
json_str_sep = json.dumps(python_dict, separators=(',', ':'))
print(f"自定义分隔符的 JSON 字符串：{json_str_sep}")

# 跳过某些类型（如 datetime）
from datetime import datetime

python_dict_with_datetime = {
    "name": "张三",
    "birthday": datetime.now()
}

# 直接序列化会报错，因为 datetime 类型不支持直接序列化
# json.dumps(python_dict_with_datetime)  # 报错：TypeError: Object of type datetime is not JSON serializable
```

#### 3.1.4 将 Python 对象写入 JSON 文件
```python
# 将 Python 字典写入 JSON 文件
with open('data.json', 'w', encoding='utf-8') as f:
    json.dump(python_dict, f, indent=4, ensure_ascii=False)

print("数据已写入 data.json 文件")
```

### 3.2 反序列化（JSON → Python）

#### 3.2.1 将 JSON 字符串转换为 Python 对象
```python
# JSON 字符串
json_str = '{"name": "张三", "age": 25, "is_student": false, "courses": ["Python", "Java", "JavaScript"]}'

# 将 JSON 字符串转换为 Python 字典
python_obj = json.loads(json_str)
print(f"Python 对象类型：{type(python_obj)}")
print(f"Python 对象：{python_obj}")
print(f"姓名：{python_obj['name']}")
print(f"年龄：{python_obj['age']}")
print(f"课程：{python_obj['courses']}")
```

#### 3.2.2 从 JSON 文件读取数据
```python
# 从 JSON 文件读取数据
with open('data.json', 'r', encoding='utf-8') as f:
    python_obj = json.load(f)

print(f"从文件读取的 Python 对象：{python_obj}")
print(f"姓名：{python_obj['name']}")
print(f"分数：{python_obj['scores']}")
```

## 4. 高级功能

### 4.1 自定义 JSON 编码器
当需要序列化 Python 中不支持的类型（如 `datetime`、`Decimal` 等）时，可以自定义 JSON 编码器：

```python
from datetime import datetime
from decimal import Decimal

# 自定义 JSON 编码器
class CustomJSONEncoder(json.JSONEncoder):
    def default(self, obj):
        # 处理 datetime 对象
        if isinstance(obj, datetime):
            return obj.isoformat()
        # 处理 Decimal 对象
        elif isinstance(obj, Decimal):
            return float(obj)
        # 处理其他不支持的类型
        return super().default(obj)

# 包含不支持类型的 Python 字典
python_dict = {
    "name": "张三",
    "birthday": datetime.now(),
    "salary": Decimal("10000.50"),
    "is_student": False
}

# 使用自定义编码器序列化
json_str = json.dumps(python_dict, cls=CustomJSONEncoder, indent=4, ensure_ascii=False)
print(f"使用自定义编码器序列化：\n{json_str}")

# 将结果写入文件
with open('custom_data.json', 'w', encoding='utf-8') as f:
    json.dump(python_dict, f, cls=CustomJSONEncoder, indent=4, ensure_ascii=False)
```

### 4.2 自定义 JSON 解码器
当需要将 JSON 数据转换为自定义 Python 对象时，可以自定义 JSON 解码器：

```python
# 自定义类
class Person:
    def __init__(self, name, age, courses):
        self.name = name
        self.age = age
        self.courses = courses
    
    def __str__(self):
        return f"Person(name='{self.name}', age={self.age}, courses={self.courses})"

# JSON 字符串
json_str = '{"name": "张三", "age": 25, "courses": ["Python", "Java", "JavaScript"]}'

# 方法 1：先反序列化为字典，再转换为自定义对象
python_dict = json.loads(json_str)
person = Person(python_dict['name'], python_dict['age'], python_dict['courses'])
print(f"方法 1 转换结果：{person}")

# 方法 2：使用 object_hook 自定义解码器
def person_decoder(obj):
    if isinstance(obj, dict) and all(key in obj for key in ['name', 'age', 'courses']):
        return Person(obj['name'], obj['age'], obj['courses'])
    return obj

person = json.loads(json_str, object_hook=person_decoder)
print(f"方法 2 转换结果：{person}")
print(f"类型：{type(person)}")
```

### 4.3 处理复杂数据结构

#### 4.3.1 嵌套数据
```python
# 复杂嵌套数据
complex_data = {
    "name": "张三",
    "age": 25,
    "address": {
        "city": "北京",
        "district": "朝阳区",
        "street": "建国路"
    },
    "courses": [
        {
            "name": "Python",
            "score": 90,
            "teachers": ["李老师", "王老师"]
        },
        {
            "name": "Java",
            "score": 85,
            "teachers": ["张老师"]
        }
    ],
    "hobbies": ["阅读", "跑步", "游泳"]
}

# 序列化复杂数据
json_str = json.dumps(complex_data, indent=4, ensure_ascii=False)
print(f"复杂数据序列化结果：\n{json_str}")

# 反序列化复杂数据
python_obj = json.loads(json_str)
print(f"反序列化后的数据类型：{type(python_obj)}")
print(f"城市：{python_obj['address']['city']}")
print(f"第一门课程名称：{python_obj['courses'][0]['name']}")
print(f"第二门课程老师：{python_obj['courses'][1]['teachers']}")
```

#### 4.3.2 处理大型 JSON 数据
```python
# 方法 1：直接读取（适用于中等大小的文件）
with open('large_data.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

# 方法 2：使用 ijson 库处理超大 JSON 文件（需要安装）
pip install ijson

import ijson

# 解析超大 JSON 文件
with open('very_large_data.json', 'r', encoding='utf-8') as f:
    # 逐个处理 JSON 对象
    for item in ijson.items(f, 'items.item'):
        print(f"处理数据项：{item['id']}")
        # 处理数据...
```

### 4.4 处理 JSON Lines 格式
JSON Lines 是一种文本格式，每行都是一个有效的 JSON 对象，适用于存储大量结构化数据。

```python
# JSON Lines 格式数据
data = [
    {"name": "张三", "age": 25},
    {"name": "李四", "age": 30},
    {"name": "王五", "age": 35}
]

# 写入 JSON Lines 文件
with open('data.jsonl', 'w', encoding='utf-8') as f:
    for item in data:
        json.dump(item, f, ensure_ascii=False)
        f.write('\n')

# 读取 JSON Lines 文件
with open('data.jsonl', 'r', encoding='utf-8') as f:
    for line in f:
        item = json.loads(line)
        print(f"姓名：{item['name']}, 年龄：{item['age']}")
```

## 5. 常见问题与解决方案

### 5.1 问题：处理中文时出现乱码
**解决方案**：
```python
# 在序列化时使用 ensure_ascii=False
data = {"name": "张三", "city": "北京"}
json_str = json.dumps(data, ensure_ascii=False, indent=4)
print(json_str)

# 写入文件时指定编码
with open('data.json', 'w', encoding='utf-8') as f:
    json.dump(data, f, ensure_ascii=False, indent=4)

# 读取文件时指定编码
with open('data.json', 'r', encoding='utf-8') as f:
    data = json.load(f)
print(data)
```

### 5.2 问题：序列化不支持的类型
**解决方案**：
```python
from datetime import datetime
from decimal import Decimal

# 自定义 JSON 编码器
class CustomJSONEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, datetime):
            return obj.isoformat()
        elif isinstance(obj, Decimal):
            return float(obj)
        # 添加其他类型的处理...
        return super().default(obj)

# 使用自定义编码器
json_str = json.dumps({
    "name": "张三",
    "birthday": datetime.now(),
    "salary": Decimal("10000.50")
}, cls=CustomJSONEncoder, ensure_ascii=False)
print(json_str)
```

### 5.3 问题：JSON 字符串格式错误
**解决方案**：
```python
# 错误的 JSON 字符串（使用了单引号）
json_str = "{'name': '张三', 'age': 25}"  # 错误！JSON 要求使用双引号

# 正确的 JSON 字符串
json_str = '{"name": "张三", "age": 25}'

# 捕获解析错误
try:
    data = json.loads(json_str)
    print(data)
except json.JSONDecodeError as e:
    print(f"JSON 解析错误：{e}")
    print(f"错误位置：第 {e.lineno} 行，第 {e.colno} 列")
    print(f"错误信息：{e.msg}")
```

### 5.4 问题：处理超大 JSON 文件时内存不足
**解决方案**：
```python
# 使用 ijson 库处理超大 JSON 文件
import ijson

with open('very_large_data.json', 'r', encoding='utf-8') as f:
    # 逐行解析
    parser = ijson.parse(f)
    for prefix, event, value in parser:
        if prefix == 'items.item.name' and event == 'string':
            print(f"处理项目：{value}")
```

## 6. 最佳实践

### 6.1 代码规范
- **使用 with 语句**：处理文件时使用 with 语句，确保文件正确关闭
- **指定编码**：始终指定编码，避免中文乱码
- **处理异常**：捕获 JSON 解析和序列化过程中的异常
- **使用有意义的变量名**：提高代码可读性
- **添加注释**：解释复杂的 JSON 结构

### 6.2 性能优化
- **使用生成器**：处理大型 JSON 数据时，使用生成器逐个处理
- **避免不必要的序列化/反序列化**：减少中间转换步骤
- **使用 ijson**：处理超大 JSON 文件时，使用 ijson 库
- **预编译 JSON 模板**：对于重复生成的 JSON 结构，预编译模板

### 6.3 安全性
- **验证输入**：验证 JSON 数据的结构和内容
- **限制递归深度**：处理不可信的 JSON 数据时，限制递归深度
- **使用安全的解析器**：避免使用不安全的 JSON 解析器
- **避免 eval()**：永远不要使用 eval() 解析 JSON 数据

### 6.4 调试技巧
- **打印 JSON 字符串**：使用 `json.dumps(data, indent=4)` 美化输出，方便调试
- **使用 type() 检查类型**：验证转换后的对象类型
- **捕获异常**：详细记录 JSON 解析错误
- **使用在线 JSON 验证器**：验证 JSON 格式是否正确

## 7. 相关资源

### 7.1 官方文档
- [Python JSON 模块官方文档](https://docs.python.org/3/library/json.html)
- [JSON 官方网站](https://www.json.org/)

### 7.2 学习资源
- [JSON 教程](https://www.w3schools.com/js/js_json_intro.asp)
- [Python JSON 教程](https://realpython.com/python-json/)

### 7.3 在线工具
- [JSON 在线验证器](https://jsonlint.com/)
- [JSON 格式化工具](https://jsonformatter.curiousconcept.com/)
- [JSON 转 Python 工具](https://www.convertjson.com/json-to-python.htm)

### 7.4 相关库
- **ijson**：用于处理超大 JSON 文件
- **orjson**：高性能 JSON 库（C 实现）
- **ujson**：另一个高性能 JSON 库
- **simplejson**：兼容标准库的 JSON 库，提供更多功能
- **jsonschema**：用于验证 JSON 数据结构

## 8. 总结

Python 的 `json` 模块是处理 JSON 数据的强大工具，它提供了将 Python 对象与 JSON 字符串相互转换的功能。通过学习和掌握 `json` 模块，你可以轻松地与各种 Web API 交互、处理配置文件、进行数据持久化等。

在使用 `json` 模块时，需要注意以下几点：
- 了解 JSON 和 Python 数据类型之间的映射关系
- 正确处理中文编码问题
- 处理不支持的类型时，使用自定义编码器/解码器
- 处理大型 JSON 文件时，考虑使用流式解析
- 始终验证和清理不可信的 JSON 数据

无论是 Web 开发、数据科学还是自动化测试，JSON 处理都是 Python 开发中的重要技能。通过掌握 `json` 模块，你可以更高效地处理各种 JSON 数据，提高开发效率和代码质量。