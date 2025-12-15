# Python 常用模块

## 1. 概述

Python 标准库包含了大量实用的模块，这些模块提供了丰富的功能，可以帮助我们快速开发各种应用。本文档将介绍 Python 中最常用的一些模块，包括它们的基本用法和示例。

## 2. os 模块

`os` 模块提供了与操作系统交互的功能，包括文件和目录操作、环境变量、进程管理等。

### 2.1 基本用法

```python
import os

# 获取当前工作目录
current_dir = os.getcwd()
print(f"当前工作目录: {current_dir}")

# 改变工作目录
os.chdir('/path/to/new/directory')

# 创建目录
os.makedirs('new_directory', exist_ok=True)  # 递归创建目录，exist_ok=True 避免目录已存在时抛出异常

# 列出目录内容
contents = os.listdir('.')
print(f"目录内容: {contents}")

# 检查路径是否存在
if os.path.exists('file.txt'):
    print("文件存在")

# 检查是否为文件
if os.path.isfile('file.txt'):
    print("这是一个文件")

# 检查是否为目录
if os.path.isdir('directory'):
    print("这是一个目录")

# 获取文件大小
file_size = os.path.getsize('file.txt')
print(f"文件大小: {file_size} 字节")

# 获取文件创建时间
create_time = os.path.getctime('file.txt')
print(f"文件创建时间: {create_time}")

# 获取文件修改时间
mod_time = os.path.getmtime('file.txt')
print(f"文件修改时间: {mod_time}")

# 重命名文件或目录
os.rename('old_name', 'new_name')

# 删除文件
os.remove('file.txt')

# 删除目录
os.rmdir('directory')  # 只能删除空目录
os.removedirs('dir1/dir2/dir3')  # 递归删除空目录

# 获取环境变量
python_path = os.environ.get('PYTHONPATH')
print(f"PYTHONPATH: {python_path}")

# 执行系统命令
os.system('ls -la')

# 使用 subprocess 模块执行命令（更推荐）
import subprocess
result = subprocess.run(['ls', '-la'], capture_output=True, text=True)
print(f"命令输出: {result.stdout}")
```

### 2.2 常用函数

| 函数 | 描述 |
|------|------|
| `os.getcwd()` | 获取当前工作目录 |
| `os.chdir(path)` | 改变当前工作目录 |
| `os.makedirs(path, exist_ok=False)` | 递归创建目录 |
| `os.listdir(path='.')` | 列出目录内容 |
| `os.path.exists(path)` | 检查路径是否存在 |
| `os.path.isfile(path)` | 检查是否为文件 |
| `os.path.isdir(path)` | 检查是否为目录 |
| `os.path.getsize(path)` | 获取文件大小 |
| `os.path.join(path1, path2, ...)` | 连接路径 |
| `os.path.abspath(path)` | 获取绝对路径 |
| `os.path.basename(path)` | 获取路径的文件名部分 |
| `os.path.dirname(path)` | 获取路径的目录部分 |

## 3. sys 模块

`sys` 模块提供了与 Python 解释器交互的功能，包括命令行参数、标准输入输出、模块搜索路径等。

### 3.1 基本用法

```python
import sys

# 获取命令行参数
print(f"命令行参数: {sys.argv}")
print(f"脚本名称: {sys.argv[0]}")
print(f"参数数量: {len(sys.argv) - 1}")

# 获取 Python 版本信息
print(f"Python 版本: {sys.version}")
print(f"Python 版本信息: {sys.version_info}")

# 获取模块搜索路径
print(f"模块搜索路径: {sys.path}")

# 添加自定义模块搜索路径
sys.path.append('/path/to/modules')

# 获取系统平台
print(f"系统平台: {sys.platform}")

# 标准输入输出
print("使用 sys.stdout 输出", file=sys.stdout)
print("使用 sys.stderr 输出错误", file=sys.stderr)

# 读取标准输入
print("请输入内容:")
input_content = sys.stdin.readline()
print(f"你输入的内容: {input_content}")

# 退出程序
sys.exit(0)  # 0 表示正常退出，非 0 表示错误退出
```

### 3.2 常用函数和属性

| 函数/属性 | 描述 |
|-----------|------|
| `sys.argv` | 命令行参数列表 |
| `sys.version` | Python 版本信息 |
| `sys.version_info` | Python 版本信息（元组） |
| `sys.path` | 模块搜索路径列表 |
| `sys.platform` | 系统平台名称 |
| `sys.stdout` | 标准输出流 |
| `sys.stderr` | 标准错误流 |
| `sys.stdin` | 标准输入流 |
| `sys.exit([arg])` | 退出程序 |
| `sys.getsizeof(object)` | 获取对象大小（字节） |

## 4. datetime 模块

`datetime` 模块提供了日期和时间处理的功能，包括日期、时间、datetime 对象的创建和操作。

### 4.1 基本用法

```python
from datetime import datetime, date, time, timedelta

# 获取当前日期和时间
now = datetime.now()
print(f"当前日期和时间: {now}")

# 获取当前日期
today = date.today()
print(f"当前日期: {today}")

# 获取当前时间
current_time = datetime.now().time()
print(f"当前时间: {current_time}")

# 创建日期对象
d = date(2023, 12, 25)
print(f"创建的日期: {d}")

# 创建时间对象
t = time(14, 30, 45)
print(f"创建的时间: {t}")

# 创建 datetime 对象
dt = datetime(2023, 12, 25, 14, 30, 45)
print(f"创建的 datetime: {dt}")

# 格式化日期和时间
formatted = now.strftime("%Y-%m-%d %H:%M:%S")
print(f"格式化后的日期和时间: {formatted}")
print(f"年份: {now.strftime('%Y')}")
print(f"月份: {now.strftime('%m')}")
print(f"日期: {now.strftime('%d')}")
print(f"星期: {now.strftime('%A')}")
print(f"小时: {now.strftime('%H')}")
print(f"分钟: {now.strftime('%M')}")
print(f"秒: {now.strftime('%S')}")

# 解析字符串为 datetime 对象
parsed = datetime.strptime("2023-12-25 14:30:45", "%Y-%m-%d %H:%M:%S")
print(f"解析后的 datetime: {parsed}")

# 日期时间运算
delta = timedelta(days=1, hours=2, minutes=30)
future = now + delta
print(f"当前时间加 1 天 2 小时 30 分钟: {future}")
past = now - delta
print(f"当前时间减 1 天 2 小时 30 分钟: {past}")

# 日期比较
date1 = date(2023, 12, 25)
date2 = date(2023, 12, 31)
print(f"date1 < date2: {date1 < date2}")
print(f"date1 > date2: {date1 > date2}")
print(f"date1 == date2: {date1 == date2}")

# 计算两个日期之间的天数差
diff = date2 - date1
print(f"两个日期之间的天数差: {diff.days}")
```

### 4.2 常用格式化符号

| 符号 | 描述 |
|------|------|
| `%Y` | 四位数年份 |
| `%y` | 两位数年份 |
| `%m` | 两位数月份（01-12） |
| `%d` | 两位数日期（01-31） |
| `%H` | 24小时制小时（00-23） |
| `%I` | 12小时制小时（01-12） |
| `%M` | 两位数分钟（00-59） |
| `%S` | 两位数秒（00-59） |
| `%A` | 完整星期名称 |
| `%a` | 缩写星期名称 |
| `%B` | 完整月份名称 |
| `%b` | 缩写月份名称 |
| `%p` | AM/PM |

## 5. json 模块

`json` 模块提供了 JSON 数据的序列化和反序列化功能，用于在 Python 对象和 JSON 字符串之间进行转换。

### 5.1 基本用法

```python
import json

# Python 对象转 JSON 字符串
# 字典转 JSON
person = {
    "name": "John",
    "age": 30,
    "city": "New York",
    "is_student": False,
    "courses": ["Math", "Science", "English"],
    "grades": {
        "Math": 90,
        "Science": 85,
        "English": 88
    }
}

# 序列化（Python 对象转 JSON 字符串）
json_str = json.dumps(person)
print(f"JSON 字符串: {json_str}")

# 格式化输出
json_str_pretty = json.dumps(person, indent=4, sort_keys=True)
print(f"格式化的 JSON 字符串: {json_str_pretty}")

# JSON 字符串转 Python 对象
# 反序列化（JSON 字符串转 Python 对象）
data = json.loads(json_str)
print(f"Python 对象: {data}")
print(f"姓名: {data['name']}")
print(f"年龄: {data['age']}")
print(f"课程: {data['courses']}")

# 读写 JSON 文件
# 写入 JSON 文件
with open('person.json', 'w') as f:
    json.dump(person, f, indent=4)

# 读取 JSON 文件
with open('person.json', 'r') as f:
    loaded_data = json.load(f)
print(f"从文件加载的数据: {loaded_data}")
```

### 5.2 常用函数

| 函数 | 描述 |
|------|------|
| `json.dumps(obj, indent=None, sort_keys=False)` | 将 Python 对象转换为 JSON 字符串 |
| `json.loads(s)` | 将 JSON 字符串转换为 Python 对象 |
| `json.dump(obj, fp, indent=None, sort_keys=False)` | 将 Python 对象写入 JSON 文件 |
| `json.load(fp)` | 从 JSON 文件读取数据并转换为 Python 对象 |

### 5.3 JSON 与 Python 类型对应关系

| JSON 类型 | Python 类型 |
|-----------|-------------|
| object | dict |
| array | list |
| string | str |
| number (int) | int |
| number (float) | float |
| true | True |
| false | False |
| null | None |

## 6. re 模块

`re` 模块提供了正则表达式的功能，用于字符串的匹配、搜索、替换等操作。

### 6.1 基本用法

```python
import re

# 匹配字符串
pattern = r'\d+'  # 匹配一个或多个数字
text = "There are 123 apples and 456 oranges."

# 搜索匹配（返回第一个匹配）
match = re.search(pattern, text)
if match:
    print(f"找到匹配: {match.group()}")
    print(f"匹配开始位置: {match.start()}")
    print(f"匹配结束位置: {match.end()}")
    print(f"匹配范围: {match.span()}")

# 查找所有匹配（返回列表）
matches = re.findall(pattern, text)
print(f"所有匹配: {matches}")

# 分割字符串
split_result = re.split(r'\s+', text)  # 按一个或多个空格分割
print(f"分割结果: {split_result}")

# 替换字符串
replaced = re.sub(r'\d+', 'NUMBER', text)  # 将所有数字替换为 "NUMBER"
print(f"替换结果: {replaced}")

# 编译正则表达式（提高性能）
compiled_pattern = re.compile(r'\d+')
match = compiled_pattern.search(text)
if match:
    print(f"编译后匹配: {match.group()}")

matches = compiled_pattern.findall(text)
print(f"编译后所有匹配: {matches}")

# 匹配邮箱
email_pattern = r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}'
email_text = "Contact us at support@example.com or sales@test.org"
email_matches = re.findall(email_pattern, email_text)
print(f"找到的邮箱: {email_matches}")

# 匹配 URL
url_pattern = r'https?://[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&:/~\+#]*[\w\-\@?^=%&/~\+#])?'
url_text = "Visit https://www.example.com or http://test.org/path"
url_matches = re.findall(url_pattern, url_text)
print(f"找到的 URL: {[match[0] for match in url_matches]}")
```

### 6.2 常用正则表达式元字符

| 元字符 | 描述 |
|--------|------|
| `.` | 匹配任意字符（除换行符） |
| `^` | 匹配字符串开头 |
| `$` | 匹配字符串结尾 |
| `*` | 匹配前面的字符 0 次或多次 |
| `+` | 匹配前面的字符 1 次或多次 |
| `?` | 匹配前面的字符 0 次或 1 次 |
| `{n}` | 匹配前面的字符恰好 n 次 |
| `{n,}` | 匹配前面的字符至少 n 次 |
| `{n,m}` | 匹配前面的字符 n 到 m 次 |
| `[]` | 字符集，匹配括号内的任意一个字符 |
| `[^]` | 否定字符集，匹配不在括号内的任意一个字符 |
| `\d` | 匹配数字，等价于 `[0-9]` |
| `\D` | 匹配非数字，等价于 `[^0-9]` |
| `\w` | 匹配字母、数字、下划线，等价于 `[a-zA-Z0-9_]` |
| `\W` | 匹配非字母、数字、下划线，等价于 `[^a-zA-Z0-9_]` |
| `\s` | 匹配空白字符（空格、制表符、换行符等） |
| `\S` | 匹配非空白字符 |
| `\b` | 匹配单词边界 |
| `\B` | 匹配非单词边界 |
| `|` | 或，匹配左边或右边的表达式 |
| `()` | 分组，捕获匹配的内容 |

## 7. math 模块

`math` 模块提供了数学运算相关的功能，包括基本数学运算、三角函数、对数函数、指数函数等。

### 7.1 基本用法

```python
import math

# 基本数学运算
print(f"绝对值: {math.fabs(-10)}")
print(f"向上取整: {math.ceil(4.2)}")
print(f"向下取整: {math.floor(4.8)}")
print(f"四舍五入: {round(4.5)}")
print(f"幂运算: {math.pow(2, 3)}")  # 2^3
print(f"平方根: {math.sqrt(16)}")
print(f"立方根: {math.pow(8, 1/3)}")

# 三角函数（弧度制）
print(f"sin(π/2): {math.sin(math.pi/2)}")
print(f"cos(π): {math.cos(math.pi)}")
print(f"tan(π/4): {math.tan(math.pi/4)}")
print(f"asin(1): {math.asin(1)}")
print(f"acos(0): {math.acos(0)}")
print(f"atan(1): {math.atan(1)}")

# 角度与弧度转换
print(f"45度转弧度: {math.radians(45)}")
print(f"π/4弧度转角度: {math.degrees(math.pi/4)}")

# 对数函数
print(f"自然对数: {math.log(math.e)}")  # ln(e) = 1
print(f"10为底的对数: {math.log10(100)}")  # log10(100) = 2
print(f"2为底的对数: {math.log2(8)}")  # log2(8) = 3

# 指数函数
print(f"e^1: {math.exp(1)}")
print(f"e^2: {math.exp(2)}")

# 常数
print(f"π: {math.pi}")
print(f"e: {math.e}")
print(f"无穷大: {math.inf}")
print(f"不是数字: {math.nan}")

# 阶乘
print(f"5的阶乘: {math.factorial(5)}")

# 最大公约数和最小公倍数
print(f"最大公约数: {math.gcd(12, 18)}")
print(f"最小公倍数: {math.lcm(12, 18)}")

# 组合数和排列数
print(f"组合数 C(5, 2): {math.comb(5, 2)}")  # 5选2
print(f"排列数 P(5, 2): {math.perm(5, 2)}")  # 5选2排列
```

### 7.2 常用函数

| 函数 | 描述 |
|------|------|
| `math.fabs(x)` | 返回 x 的绝对值 |
| `math.ceil(x)` | 返回 x 的向上取整值 |
| `math.floor(x)` | 返回 x 的向下取整值 |
| `math.pow(x, y)` | 返回 x 的 y 次幂 |
| `math.sqrt(x)` | 返回 x 的平方根 |
| `math.sin(x)` | 返回 x 的正弦值（弧度制） |
| `math.cos(x)` | 返回 x 的余弦值（弧度制） |
| `math.tan(x)` | 返回 x 的正切值（弧度制） |
| `math.radians(x)` | 将角度转换为弧度 |
| `math.degrees(x)` | 将弧度转换为角度 |
| `math.log(x)` | 返回 x 的自然对数 |
| `math.log10(x)` | 返回 x 的以10为底的对数 |
| `math.log2(x)` | 返回 x 的以2为底的对数 |
| `math.exp(x)` | 返回 e 的 x 次幂 |
| `math.factorial(x)` | 返回 x 的阶乘 |
| `math.gcd(x, y)` | 返回 x 和 y 的最大公约数 |
| `math.lcm(x, y)` | 返回 x 和 y 的最小公倍数 |
| `math.comb(n, k)` | 返回组合数 C(n, k) |
| `math.perm(n, k)` | 返回排列数 P(n, k) |

## 8. random 模块

`random` 模块提供了随机数生成相关的功能，用于生成随机数、随机选择、随机打乱等操作。

### 8.1 基本用法

```python
import random

# 生成随机浮点数（0.0 到 1.0 之间）
random_float = random.random()
print(f"随机浮点数: {random_float}")

# 生成指定范围的随机整数（包括 start，不包括 end）
random_int = random.randint(1, 10)  # 生成 1 到 10 之间的整数（包括 10）
print(f"随机整数: {random_int}")

# 生成指定范围的随机整数（包括 start，不包括 end）
random_range = random.randrange(0, 10, 2)  # 生成 0 到 10 之间的偶数（0, 2, 4, 6, 8）
print(f"随机范围整数: {random_range}")

# 生成指定范围的随机浮点数
drandom_uniform = random.uniform(1, 10)  # 生成 1 到 10 之间的浮点数
print(f"指定范围随机浮点数: {drandom_uniform}")

# 随机选择列表中的一个元素
fruits = ["Apple", "Banana", "Cherry", "Date", "Elderberry"]
random_fruit = random.choice(fruits)
print(f"随机选择的水果: {random_fruit}")

# 随机选择列表中的多个元素（可重复）
random_fruits = random.choices(fruits, k=3)  # 随机选择 3 个元素，可重复
print(f"随机选择的多个水果（可重复）: {random_fruits}")

# 随机选择列表中的多个元素（不可重复）
random_sample = random.sample(fruits, k=3)  # 随机选择 3 个元素，不可重复
print(f"随机选择的多个水果（不可重复）: {random_sample}")

# 打乱列表顺序
random.shuffle(fruits)  # 原地打乱列表
print(f"打乱后的水果列表: {fruits}")

# 生成随机字符串
import string
# 生成包含大小写字母和数字的随机字符串
def generate_random_string(length):
    characters = string.ascii_letters + string.digits
    return ''.join(random.choices(characters, k=length))

random_str = generate_random_string(8)
print(f"随机字符串: {random_str}")

# 生成随机密码（包含特殊字符）
def generate_password(length):
    characters = string.ascii_letters + string.digits + string.punctuation
    return ''.join(random.choices(characters, k=length))

password = generate_password(12)
print(f"随机密码: {password}")
```

## 9. collections 模块

`collections` 模块提供了额外的集合数据类型，扩展了 Python 内置的集合类型（list, tuple, dict, set）。

### 9.1 基本用法

```python
from collections import Counter, defaultdict, OrderedDict, namedtuple, deque

# Counter - 计数工具
# 统计列表中元素出现的次数
words = ["apple", "banana", "apple", "cherry", "banana", "apple"]
word_count = Counter(words)
print(f"单词计数: {word_count}")
print(f"出现次数最多的单词: {word_count.most_common(1)}")
print(f"出现次数最多的两个单词: {word_count.most_common(2)}")
print(f"apple 出现次数: {word_count['apple']}")

# 统计字符串中字符出现的次数
text = "hello world"
char_count = Counter(text)
print(f"字符计数: {char_count}")

# defaultdict - 默认值字典
# 普通字典访问不存在的键会报错
# 使用 defaultdict 可以设置默认值
d = defaultdict(int)  # 默认值为 0
d['apple'] += 1
d['banana'] += 2
d['cherry'] += 3
print(f"defaultdict 结果: {dict(d)}")

# 设置默认值为列表
d_list = defaultdict(list)
d_list['fruits'].append('apple')
d_list['fruits'].append('banana')
d_list['vegetables'].append('carrot')
print(f"defaultdict 列表结果: {dict(d_list)}")

# 设置默认值为字典
d_dict = defaultdict(dict)
d_dict['person']['name'] = 'John'
d_dict['person']['age'] = 30
d_dict['person']['city'] = 'New York'
print(f"defaultdict 字典结果: {dict(d_dict)}")

# OrderedDict - 有序字典（Python 3.7+ 中普通字典已经保持插入顺序）
ordered_dict = OrderedDict()
ordered_dict['a'] = 1
ordered_dict['b'] = 2
ordered_dict['c'] = 3
ordered_dict['d'] = 4
print(f"OrderedDict: {dict(ordered_dict)}")

# 移动到末尾
ordered_dict.move_to_end('a')
print(f"移动 'a' 到末尾: {dict(ordered_dict)}")

# 弹出第一个元素
first_key, first_value = ordered_dict.popitem(last=False)
print(f"弹出第一个元素: {first_key}: {first_value}")
print(f"剩余 OrderedDict: {dict(ordered_dict)}")

# namedtuple - 命名元组
# 定义命名元组
Person = namedtuple('Person', ['name', 'age', 'city'])

# 创建命名元组实例
person1 = Person('John', 30, 'New York')
person2 = Person(name='Jane', age=25, city='London')

print(f"Person 1: {person1}")
print(f"Person 1 姓名: {person1.name}")
print(f"Person 1 年龄: {person1.age}")
print(f"Person 1 城市: {person1.city}")

# 转换为字典
person_dict = person1._asdict()
print(f"转换为字典: {person_dict}")

# 替换字段值
person3 = person1._replace(age=31, city='Chicago')
print(f"替换后的 Person: {person3}")

# deque - 双端队列
# 创建双端队列
queue = deque()

# 从右端添加元素
queue.append('a')
queue.append('b')
queue.append('c')
print(f"双端队列: {queue}")

# 从左端添加元素
queue.appendleft('x')
queue.appendleft('y')
queue.appendleft('z')
print(f"从左端添加元素后的队列: {queue}")

# 从右端移除元素
right_item = queue.pop()
print(f"从右端移除的元素: {right_item}")
print(f"移除后的队列: {queue}")

# 从左端移除元素
left_item = queue.popleft()
print(f"从左端移除的元素: {left_item}")
print(f"移除后的队列: {queue}")

# 旋转
queue.rotate(1)  # 向右旋转 1 位
print(f"向右旋转 1 位后的队列: {queue}")

queue.rotate(-1)  # 向左旋转 1 位
print(f"向左旋转 1 位后的队列: {queue}")

# 扩展队列
queue.extend(['d', 'e', 'f'])
print(f"扩展后的队列: {queue}")

queue.extendleft(['w', 'v', 'u'])
print(f"从左端扩展后的队列: {queue}")
```

## 10. itertools 模块

`itertools` 模块提供了用于高效循环的迭代器工具，包括无穷迭代器、排列组合、分组等功能。

### 10.1 基本用法

```python
from itertools import count, cycle, repeat, permutations, combinations, combinations_with_replacement, product, groupby, chain

# 无穷迭代器
# count(start=0, step=1) - 从 start 开始，以 step 为步长无限生成数字
print("count 示例:")
for i in count(10, 2):
    print(i, end=' ')
    if i > 20:
        break
print()

# cycle(iterable) - 无限循环遍历 iterable
print("cycle 示例:")
count = 0
for item in cycle(['a', 'b', 'c']):
    print(item, end=' ')
    count += 1
    if count > 10:
        break
print()

# repeat(elem, times=None) - 重复生成 elem，times 次，不指定 times 则无限重复
print("repeat 示例:")
for item in repeat('x', 5):
    print(item, end=' ')
print()

# 组合迭代器
# permutations(iterable, r=None) - 排列，r 为排列长度，不指定则为 iterable 长度
print("permutations 示例:")
perms = permutations([1, 2, 3], 2)  # 3选2的排列
print(list(perms))

# combinations(iterable, r) - 组合，r 为组合长度
print("combinations 示例:")
combs = combinations([1, 2, 3, 4], 2)  # 4选2的组合
print(list(combs))

# combinations_with_replacement(iterable, r) - 带重复的组合
print("combinations_with_replacement 示例:")
combs_with_replacement = combinations_with_replacement([1, 2, 3], 2)  # 3选2的带重复组合
print(list(combs_with_replacement))

# product(*iterables, repeat=1) - 笛卡尔积
print("product 示例:")
products = product([1, 2], ['a', 'b'])
print(list(products))

# 多个列表的笛卡尔积
products_multi = product([1, 2], ['a', 'b'], [True, False])
print(list(products_multi))

# 单个列表的笛卡尔积（重复自身）
products_self = product([1, 2], repeat=3)  # 相当于 product([1, 2], [1, 2], [1, 2])
print(list(products_self))

# 分组
print("groupby 示例:")
# 注意：groupby 要求数据已经按照分组键排序
data = [
    {'name': 'John', 'age': 30, 'city': 'New York'},
    {'name': 'Jane', 'age': 25, 'city': 'London'},
    {'name': 'Bob', 'age': 35, 'city': 'New York'},
    {'name': 'Alice', 'age': 28, 'city': 'London'}
]

# 按城市分组
data_sorted = sorted(data, key=lambda x: x['city'])
for city, group in groupby(data_sorted, key=lambda x: x['city']):
    print(f"City: {city}")
    for person in group:
        print(f"  {person['name']}, {person['age']}")

# 链接多个迭代器
print("chain 示例:")
list1 = [1, 2, 3]
list2 = ['a', 'b', 'c']
list3 = [True, False]
chained = chain(list1, list2, list3)
print(list(chained))
```

## 11. logging 模块

`logging` 模块提供了日志记录功能，可以记录不同级别的日志信息，包括调试信息、普通信息、警告信息、错误信息和致命错误信息。

### 11.1 基本用法

```python
import logging

# 配置日志
# 基本配置
logging.basicConfig(
    level=logging.DEBUG,  # 日志级别，低于此级别的日志不会被记录
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',  # 日志格式
    filename='app.log',  # 日志文件
    filemode='w'  # 文件模式，'w' 表示覆盖，'a' 表示追加
)

# 创建日志记录器
logger = logging.getLogger(__name__)

# 记录不同级别的日志
logger.debug('这是调试信息')
logger.info('这是普通信息')
logger.warning('这是警告信息')
logger.error('这是错误信息')
logger.critical('这是致命错误信息')

# 日志级别
# DEBUG < INFO < WARNING < ERROR < CRITICAL
# 默认日志级别是 WARNING，只记录 WARNING 及以上级别的日志

# 配置控制台和文件双输出
import logging
from logging.handlers import RotatingFileHandler

# 创建日志记录器
logger = logging.getLogger('my_logger')
logger.setLevel(logging.DEBUG)

# 创建格式化器
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# 创建控制台处理器
console_handler = logging.StreamHandler()
console_handler.setLevel(logging.INFO)  # 控制台只输出 INFO 及以上级别的日志
console_handler.setFormatter(formatter)

# 创建文件处理器（带轮转）
file_handler = RotatingFileHandler(
    'app.log',
    maxBytes=1024 * 1024,  # 1MB
    backupCount=5  # 保留 5 个备份文件
)
file_handler.setLevel(logging.DEBUG)  # 文件输出所有级别的日志
file_handler.setFormatter(formatter)

# 添加处理器到日志记录器
logger.addHandler(console_handler)
logger.addHandler(file_handler)

# 记录日志
logger.debug('这是调试信息，只输出到文件')
logger.info('这是普通信息，输出到控制台和文件')
logger.warning('这是警告信息，输出到控制台和文件')
logger.error('这是错误信息，输出到控制台和文件')
logger.critical('这是致命错误信息，输出到控制台和文件')

# 在函数中使用日志
def divide(a, b):
    logger.debug(f"计算 {a} / {b}")
    try:
        result = a / b
        logger.info(f"结果: {result}")
        return result
    except ZeroDivisionError as e:
        logger.error(f"除零错误: {e}")
        raise

# 调用函数
divide(10, 2)
divide(10, 0)
```

### 11.2 日志级别

| 级别 | 描述 |
|------|------|
| `DEBUG` | 调试信息，用于开发和调试 |
| `INFO` | 普通信息，记录程序正常运行状态 |
| `WARNING` | 警告信息，可能会出现问题，但程序仍能正常运行 |
| `ERROR` | 错误信息，程序出现错误，部分功能可能无法正常运行 |
| `CRITICAL` | 致命错误信息，程序无法继续运行 |

### 11.3 日志格式参数

| 参数 | 描述 |
|------|------|
| `%(asctime)s` | 日志记录时间 |
| `%(name)s` | 日志记录器名称 |
| `%(levelname)s` | 日志级别 |
| `%(message)s` | 日志消息 |
| `%(filename)s` | 文件名 |
| `%(lineno)d` | 行号 |
| `%(funcName)s` | 函数名 |
| `%(process)d` | 进程 ID |
| `%(thread)d` | 线程 ID |

## 12. 总结

Python 标准库提供了丰富的模块，涵盖了各种功能，可以帮助我们快速开发各种应用。本文档介绍了 Python 中最常用的一些模块，包括：

1. `os` - 操作系统相关功能
2. `sys` - 系统相关功能
3. `datetime` - 日期和时间处理
4. `json` - JSON数据处理
5. `re` - 正则表达式
6. `math` - 数学运算
7. `random` - 随机数生成
8. `collections` - 集合数据类型
9. `itertools` - 迭代器工具
10. `logging` - 日志记录

通过学习和掌握这些常用模块，可以提高 Python 编程的效率和质量。在实际开发中，我们还会用到许多第三方模块，如 `requests`、`numpy`、`pandas` 等，这些模块可以通过 `pip` 安装，进一步扩展 Python 的功能。

建议在开发过程中，多查阅 Python 官方文档，了解更多模块的详细用法和示例。