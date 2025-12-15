# Python YAML 库

## 1. 概述

### 1.1 什么是 YAML
YAML（YAML Ain't Markup Language）是一种人类可读的数据序列化格式，设计目标是使数据文件既易于人类阅读，又易于机器解析。它基于 Unicode 标准，支持多种数据类型和复杂的数据结构。

### 1.2 YAML 的优势
- **易读性**：采用缩进表示层级关系，结构清晰，易于理解
- **简洁性**：相比 XML 和 JSON，语法更简洁，减少了冗余字符
- **支持多种数据类型**：包括字符串、数字、布尔值、数组、对象、日期、锚点和引用等
- **跨平台**：几乎所有现代编程语言都支持 YAML
- **注释支持**：允许在配置文件中添加注释
- **支持复杂数据结构**：支持嵌套、锚点、引用等高级特性

### 1.3 Python YAML 库
Python 中处理 YAML 数据的主要库是 `PyYAML`，它提供了将 Python 对象转换为 YAML 字符串（序列化）和将 YAML 字符串转换为 Python 对象（反序列化）的功能。

### 1.4 常见应用场景
- **配置文件**：存储应用程序配置（如 Docker Compose、Kubernetes、Ansible 等）
- **数据交换**：在不同编程语言之间传递数据
- **测试数据**：存储测试用例数据
- **文档编写**：编写结构化文档
- **API 定义**：如 OpenAPI/Swagger

## 2. 安装

### 2.1 基本安装
```bash
pip install pyyaml
```

### 2.2 安装特定版本
```bash
pip install pyyaml==6.0.2  # 安装特定版本
```

### 2.3 升级 PyYAML
```bash
pip install --upgrade pyyaml
```

## 3. 核心概念

### 3.1 YAML 数据类型
| YAML 类型 | Python 类型 | 示例 |
|----------|-------------|------|
| 字符串   | str         | `name: 张三` |
| 数字     | int/float   | `age: 25` |
| 布尔值   | bool        | `is_student: false` |
| 数组     | list        | `courses: [Python, Java]` |
| 对象     | dict        | `person: {name: 张三, age: 25}` |
| null     | None        | `birthday: null` |
| 日期     | datetime    | `created_at: 2024-01-01T12:00:00Z` |
| 锚点     | -           | `&anchor_key value` |
| 引用     | -           | `*anchor_key` |

### 3.2 YAML 语法规则
- **缩进**：使用空格（不建议使用制表符）表示层级关系，通常使用 2 个或 4 个空格
- **键值对**：使用 `:` 分隔键和值，键和冒号之间没有空格，冒号和值之间有空格
- **数组**：使用 `-` 表示数组元素
- **注释**：使用 `#` 表示注释，注释内容从 `#` 开始到行尾
- **多行字符串**：使用 `|` 保留换行，使用 `>` 折叠换行
- **引号**：字符串可以使用单引号或双引号，也可以不使用引号（当不包含特殊字符时）

### 3.3 序列化与反序列化
- **序列化**：将 Python 对象转换为 YAML 字符串的过程，使用 `yaml.dump()`
- **反序列化**：将 YAML 字符串转换为 Python 对象的过程，使用 `yaml.load()` 或 `yaml.safe_load()`

## 4. 基本使用

### 4.1 序列化（Python → YAML）

#### 4.1.1 将 Python 对象转换为 YAML 字符串
```python
import yaml

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

# 将 Python 字典转换为 YAML 字符串
yaml_str = yaml.dump(python_dict)
print(f"YAML 字符串：\n{yaml_str}")
```

#### 4.1.2 美化输出
```python
# 美化输出（指定缩进）
yaml_str_pretty = yaml.dump(python_dict, indent=4, allow_unicode=True)
print(f"美化后的 YAML 字符串：\n{yaml_str_pretty}")

# 禁用默认的锚点和引用
yaml_str_no_alias = yaml.dump(python_dict, indent=4, allow_unicode=True, default_flow_style=False, sort_keys=False)
print(f"禁用锚点和引用的 YAML 字符串：\n{yaml_str_no_alias}")

# 使用块样式（默认）
yaml_str_block = yaml.dump(python_dict, indent=4, allow_unicode=True, default_flow_style=False)
print(f"块样式 YAML 字符串：\n{yaml_str_block}")

# 使用流样式
yaml_str_flow = yaml.dump(python_dict, allow_unicode=True, default_flow_style=True)
print(f"流样式 YAML 字符串：\n{yaml_str_flow}")
```

#### 4.1.3 将 Python 对象写入 YAML 文件
```python
# 将 Python 字典写入 YAML 文件
with open('data.yaml', 'w', encoding='utf-8') as f:
    yaml.dump(python_dict, f, indent=4, allow_unicode=True, sort_keys=False)

print("数据已写入 data.yaml 文件")
```

### 4.2 反序列化（YAML → Python）

#### 4.2.1 将 YAML 字符串转换为 Python 对象
```python
# YAML 字符串
yaml_str = """
name: 张三
age: 25
is_student: false
courses:
  - Python
  - Java
  - JavaScript
scores:
  Python: 90
  Java: 85
  JavaScript: 95
birthday: null
"""

# 将 YAML 字符串转换为 Python 字典
python_obj = yaml.safe_load(yaml_str)
print(f"Python 对象类型：{type(python_obj)}")
print(f"Python 对象：{python_obj}")
print(f"姓名：{python_obj['name']}")
print(f"年龄：{python_obj['age']}")
print(f"课程：{python_obj['courses']}")
```

#### 4.2.2 从 YAML 文件读取数据
```python
# 从 YAML 文件读取数据
with open('data.yaml', 'r', encoding='utf-8') as f:
    python_obj = yaml.safe_load(f)

print(f"从文件读取的 Python 对象：{python_obj}")
print(f"姓名：{python_obj['name']}")
print(f"分数：{python_obj['scores']}")
```

### 4.3 处理不同数据类型
```python
# 处理日期
from datetime import datetime

yaml_str = """
name: 张三
created_at: 2024-01-01T12:00:00Z
updated_at: 2024-01-02 14:30:00
"""

python_obj = yaml.safe_load(yaml_str)
print(f"created_at 类型：{type(python_obj['created_at'])}")
print(f"updated_at 类型：{type(python_obj['updated_at'])}")
print(f"created_at 值：{python_obj['created_at']}")

# 处理多行字符串
yaml_str = """
description: |
  这是一个多行字符串
  保留了换行符
  第三行内容
short_description: >
  这是一个折叠的多行字符串
  换行符被折叠为空格
  第三行内容
"""

python_obj = yaml.safe_load(yaml_str)
print(f"description：\n{python_obj['description']}")
print(f"short_description：{python_obj['short_description']}")

# 处理锚点和引用
yaml_str = """
defaults: &defaults
  host: localhost
  port: 3306

mysql:
  <<: *defaults
  database: mysql_db
  user: mysql_user

postgresql:
  <<: *defaults
  port: 5432
  database: pg_db
  user: pg_user
"""

python_obj = yaml.safe_load(yaml_str)
print(f"MySQL 配置：{python_obj['mysql']}")
print(f"PostgreSQL 配置：{python_obj['postgresql']}")
```

## 5. 高级功能

### 5.1 自定义 YAML 构造器和表示器

#### 5.1.1 自定义构造器（YAML → Python）
用于将 YAML 中的自定义类型转换为 Python 对象：

```python
from datetime import datetime, date

# 自定义构造器：处理日期字符串
def date_constructor(loader, node):
    value = loader.construct_scalar(node)
    return datetime.strptime(value, '%Y-%m-%d').date()

# 注册构造器
yaml.SafeLoader.add_constructor('!date', date_constructor)

# YAML 字符串
yaml_str = """
name: 张三
birthday: !date 1990-01-01
"""

# 反序列化
data = yaml.safe_load(yaml_str)
print(f"birthday 类型：{type(data['birthday'])}")  # <class 'datetime.date'>
print(f"birthday 值：{data['birthday']}")  # 1990-01-01
```

#### 5.1.2 自定义表示器（Python → YAML）
用于将 Python 自定义对象转换为 YAML 字符串：

```python
from datetime import datetime, date

# 自定义类
class Person:
    def __init__(self, name, age, birthday):
        self.name = name
        self.age = age
        self.birthday = birthday
    
    def __str__(self):
        return f"Person(name='{self.name}', age={self.age}, birthday={self.birthday})"

# 自定义表示器：处理 Person 对象
def person_representer(dumper, data):
    return dumper.represent_mapping('!Person', {
        'name': data.name,
        'age': data.age,
        'birthday': data.birthday
    })

# 注册表示器
yaml.SafeDumper.add_representer(Person, person_representer)

# 自定义构造器：处理 !Person 类型
def person_constructor(loader, node):
    value = loader.construct_mapping(node)
    return Person(value['name'], value['age'], value['birthday'])

# 注册构造器
yaml.SafeLoader.add_constructor('!Person', person_constructor)

# 创建 Person 对象
person = Person("张三", 25, date(1990, 1, 1))

# 序列化
yaml_str = yaml.safe_dump(person, allow_unicode=True)
print(f"序列化结果：\n{yaml_str}")

# 反序列化
data = yaml.safe_load(yaml_str)
print(f"反序列化结果：{data}")
print(f"反序列化类型：{type(data)}")
```

### 5.2 处理复杂数据结构

#### 5.2.1 处理嵌套数据
```python
# 复杂嵌套数据
complex_data = {
    "name": "张三",
    "age": 25,
    "address": {
        "city": "北京",
        "district": "朝阳区",
        "street": "建国路",
        "zipcode": "100022"
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
    "hobbies": ["阅读", "跑步", "游泳"],
    "metadata": {
        "created_at": datetime.now(),
        "updated_at": datetime.now(),
        "tags": ["student", "python", "developer"]
    }
}

# 序列化复杂数据
yaml_str = yaml.dump(complex_data, indent=4, allow_unicode=True, default_flow_style=False, sort_keys=False)
print(f"复杂数据序列化结果：\n{yaml_str}")

# 反序列化复杂数据
data = yaml.safe_load(yaml_str)
print(f"反序列化后的数据类型：{type(data)}")
print(f"城市：{data['address']['city']}")
print(f"第一门课程名称：{data['courses'][0]['name']}")
print(f"第二门课程老师：{data['courses'][1]['teachers']}")
```

#### 5.2.2 处理 YAML 流
YAML 流是指包含多个 YAML 文档的文件，文档之间用 `---` 分隔：

```python
# 写入 YAML 流
with open('stream.yaml', 'w', encoding='utf-8') as f:
    yaml.dump({'name': '张三', 'age': 25}, f, allow_unicode=True)
    f.write('---\n')
    yaml.dump({'name': '李四', 'age': 30}, f, allow_unicode=True)
    f.write('---\n')
    yaml.dump({'name': '王五', 'age': 35}, f, allow_unicode=True)

# 读取 YAML 流
with open('stream.yaml', 'r', encoding='utf-8') as f:
    docs = list(yaml.safe_load_all(f))

print(f"YAML 流包含 {len(docs)} 个文档")
for i, doc in enumerate(docs):
    print(f"文档 {i+1}：{doc}")
```

### 5.3 配置文件处理
YAML 常用于配置文件，以下是一个典型的配置文件处理示例：

```python
# 配置文件示例（config.yaml）
"""
# 应用程序配置
app:
  name: "my_app"
  version: "1.0.0"
  debug: true

# 数据库配置
database:
  type: "mysql"
  host: "localhost"
  port: 3306
  database: "my_db"
  user: "my_user"
  password: "my_password"
  charset: "utf8mb4"
  pool_size: 10

# 日志配置
logging:
  level: "INFO"
  format: "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
  file: "logs/app.log"
  max_size: "10MB"
  backup_count: 5

# API 配置
api:
  host: "0.0.0.0"
  port: 8000
  prefix: "/api"
  timeout: 30
  cors:
    enabled: true
    origins: ["*"]
    methods: ["GET", "POST", "PUT", "DELETE"]
"""

# 读取配置文件
with open('config.yaml', 'r', encoding='utf-8') as f:
    config = yaml.safe_load(f)

# 使用配置
print(f"应用名称：{config['app']['name']}")
print(f"数据库类型：{config['database']['type']}")
print(f"日志级别：{config['logging']['level']}")
print(f"API 端口：{config['api']['port']}")

# 将配置转换为对象（更方便使用）
class Config:
    def __init__(self, config_dict):
        for key, value in config_dict.items():
            if isinstance(value, dict):
                setattr(self, key, Config(value))
            else:
                setattr(self, key, value)

# 使用对象访问配置
config_obj = Config(config)
print(f"应用名称：{config_obj.app.name}")
print(f"数据库类型：{config_obj.database.type}")
print(f"日志级别：{config_obj.logging.level}")
print(f"API 端口：{config_obj.api.port}")
print(f"CORS 启用：{config_obj.api.cors.enabled}")
```

## 6. 安全考虑

### 6.1 避免使用 yaml.load()
早期版本的 PyYAML 中，`yaml.load()` 函数可以执行任意 Python 代码，存在安全风险。因此，建议始终使用 `yaml.safe_load()` 或 `yaml.full_load()` 函数，这些函数只支持标准的 YAML 数据类型，不执行任意代码。

```python
# 不安全！可能执行任意 Python 代码
data = yaml.load(yaml_str)  # 不建议使用

# 安全！只支持标准 YAML 数据类型
data = yaml.safe_load(yaml_str)  # 推荐使用

data = yaml.full_load(yaml_str)  # 支持所有 YAML 1.2 功能，但仍安全

data = yaml.unsafe_load(yaml_str)  # 等同于旧版的 yaml.load()，不安全
```

### 6.2 验证 YAML 数据
在处理不可信的 YAML 数据时，应验证数据的结构和内容，确保符合预期：

```python
import jsonschema

# 定义 JSON Schema
schema = {
    "type": "object",
    "properties": {
        "name": {"type": "string"},
        "age": {"type": "integer", "minimum": 0, "maximum": 120},
        "is_student": {"type": "boolean"},
        "courses": {"type": "array", "items": {"type": "string"}}
    },
    "required": ["name", "age"]
}

# 验证 YAML 数据
try:
    jsonschema.validate(config, schema)
    print("配置文件格式正确")
except jsonschema.exceptions.ValidationError as e:
    print(f"配置文件格式错误：{e}")
except jsonschema.exceptions.SchemaError as e:
    print(f"Schema 定义错误：{e}")
```

## 7. 常见问题与解决方案

### 7.1 问题：处理中文时出现乱码
**解决方案**：
```python
# 写入文件时指定编码
with open('data.yaml', 'w', encoding='utf-8') as f:
    yaml.dump(python_dict, f, allow_unicode=True, indent=4)

# 读取文件时指定编码
with open('data.yaml', 'r', encoding='utf-8') as f:
    data = yaml.safe_load(f)
```

### 7.2 问题：YAML 解析错误
**解决方案**：
```python
# 捕获 YAML 解析错误
try:
    data = yaml.safe_load(yaml_str)
    print(data)
except yaml.YAMLError as e:
    print(f"YAML 解析错误：{e}")
    if hasattr(e, 'problem_mark'):
        mark = e.problem_mark
        print(f"错误位置：第 {mark.line+1} 行，第 {mark.column+1} 列")
```

### 7.3 问题：处理日期时间类型
**解决方案**：
```python
# 使用 dateutil 库解析各种日期格式
pip install python-dateutil

from dateutil import parser

yaml_str = """
created_at: 2024-01-01T12:00:00Z
updated_at: 2024-01-02 14:30:00
"""

data = yaml.safe_load(yaml_str)
print(f"created_at 类型：{type(data['created_at'])}")

# 手动解析日期字符串
yaml_str = """
created_at: 2024/01/01 12:00:00
"""

data = yaml.safe_load(yaml_str)
created_at = parser.parse(data['created_at'])
print(f"手动解析的 created_at：{created_at}")
print(f"类型：{type(created_at)}")
```

### 7.4 问题：处理大型 YAML 文件
**解决方案**：
```python
# 使用 ruamel.yaml 库处理大型 YAML 文件（支持流式处理）
pip install ruamel.yaml

from ruamel.yaml import YAML

yaml = YAML()
yaml.indent(mapping=4, sequence=4, offset=2)

# 读取大型 YAML 文件
with open('large_file.yaml', 'r', encoding='utf-8') as f:
    data = yaml.load(f)

# 写入大型 YAML 文件
with open('output.yaml', 'w', encoding='utf-8') as f:
    yaml.dump(data, f)
```

## 8. 最佳实践

### 8.1 代码规范
- **使用 safe_load()**：始终使用 `yaml.safe_load()` 或 `yaml.full_load()`，避免使用不安全的 `yaml.load()`
- **指定编码**：处理文件时始终指定编码，避免中文乱码
- **处理异常**：捕获 YAML 解析和序列化过程中的异常
- **使用 with 语句**：处理文件时使用 with 语句，确保文件正确关闭
- **添加注释**：在 YAML 文件中添加注释，提高可读性

### 8.2 性能优化
- **使用 ruamel.yaml**：处理大型 YAML 文件时，使用 ruamel.yaml 库，支持流式处理
- **避免不必要的序列化/反序列化**：减少中间转换步骤
- **使用生成器**：处理 YAML 流时，使用生成器逐个处理文档

### 8.3 安全性
- **使用安全加载函数**：避免使用 `yaml.load()`
- **验证输入数据**：验证 YAML 数据的结构和内容
- **限制允许的数据类型**：只处理预期的数据类型
- **避免执行外部代码**：不要在 YAML 文件中包含可执行代码

### 8.4 YAML 编写规范
- **使用一致的缩进**：通常使用 2 个或 4 个空格
- **避免使用制表符**：YAML 规范建议使用空格，不使用制表符
- **使用清晰的命名**：使用有意义的键名
- **分组相关配置**：将相关的配置项分组
- **使用锚点和引用**：避免重复配置
- **使用多行字符串**：当字符串包含换行时，使用 `|` 或 `>`

## 9. 相关资源

### 9.1 官方文档
- [PyYAML 官方文档](https://pyyaml.org/wiki/PyYAMLDocumentation)
- [YAML 1.2 规范](https://yaml.org/spec/1.2/spec.html)

### 9.2 学习资源
- [YAML 入门教程](https://www.runoob.com/w3cnote/yaml-intro.html)
- [YAML 语法参考](https://docs.ansible.com/ansible/latest/reference_appendices/YAMLSyntax.html)

### 9.3 在线工具
- [YAML 在线验证器](https://yamlchecker.com/)
- [YAML 格式化工具](https://www.yamllint.com/)
- [YAML 转 JSON 工具](https://www.convertjson.com/yaml-to-json.htm)

### 9.4 相关库
- **PyYAML**：Python 中最常用的 YAML 库
- **ruamel.yaml**：功能更强大的 YAML 库，支持 YAML 1.2 规范，支持流式处理
- **oyaml**：PyYAML 的扩展，修复了一些默认行为
- **jsonschema**：用于验证 YAML 数据结构

## 10. 总结

YAML 是一种强大的数据序列化格式，具有易读性、简洁性和灵活性等优点，广泛应用于配置文件、数据交换等场景。Python 中主要使用 PyYAML 库来处理 YAML 数据，提供了序列化和反序列化功能。

通过学习 PyYAML，你可以：
- 轻松处理 YAML 配置文件
- 与其他支持 YAML 的系统进行数据交换
- 利用 YAML 的高级特性（如锚点、引用、多行字符串等）
- 自定义 YAML 类型，处理复杂数据结构

在使用 PyYAML 时，需要注意以下几点：
- 始终使用安全的加载函数（`yaml.safe_load()` 或 `yaml.full_load()`）
- 处理中文时指定编码
- 捕获和处理 YAML 解析异常
- 验证不可信的 YAML 数据

无论是配置文件管理、数据交换还是文档编写，YAML 都是一种强大而灵活的选择。通过掌握 PyYAML 库，你可以更高效地处理各种 YAML 数据，提高开发效率和代码质量。