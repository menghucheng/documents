# Python 脚本编写

## 1. 脚本基本结构

### 1.1 脚本文件格式
- Python 脚本文件扩展名为 `.py`
- 脚本第一行通常是 shebang 行，指定解释器：
  ```python
  #!/usr/bin/env python3
  # 或指定具体路径
  #!/usr/bin/python3
  ```
- **中文编码处理**：在脚本开头添加编码声明，确保中文正常显示：
  ```python
  # -*- coding: utf-8 -*-
  ```
  注：Python 3 默认使用 UTF-8 编码，此声明在 Python 3 中可省略，但为了兼容旧版本和明确编码，建议保留。

### 1.2 脚本注释
- 单行注释：使用 `#` 开头
- 多行注释：使用三引号 `'''` 或 `"""` 包裹
- 文档字符串：函数、类、模块开头的三引号注释，可通过 `__doc__` 属性访问

```python
# 这是单行注释

'''这是多行注释
可以包含多行内容
'''  

"""这是文档字符串
通常用于函数、类、模块的文档
"""
def add(a, b):
    """计算两个数的和
    
    Args:
        a: 第一个数
        b: 第二个数
    
    Returns:
        两数之和
    """
    return a + b
```

### 1.3 脚本执行方式
1. 直接执行（需要执行权限）：
   ```bash
   ./脚本名.py
   ```
2. 通过 Python 解释器执行：
   ```bash
   python3 脚本名.py
   ```
3. 在 Python 交互式环境中执行：
   ```python
   exec(open('脚本名.py').read())
   ```

## 2. 变量和数据类型

### 2.1 变量声明
Python 是动态类型语言，变量不需要声明类型，直接赋值即可：

```python
# 基本变量声明
name = "张三"
age = 25
is_student = True

# 变量赋值
number = 10 + 5  # 结果为 15
greeting = f"Hello, {name}"  # 结果为 "Hello, 张三"
```

### 2.2 数据类型
Python 支持多种数据类型：

| 数据类型 | 示例 | 说明 |
|---------|------|------|
| 字符串 | `"Hello"` | 文本数据 |
| 整数 | `123` | 整数数字 |
| 浮点数 | `3.14` | 小数 |
| 布尔值 | `True`/`False` | 真/假 |
| 列表 | `[1, 2, 3]` | 有序可变集合 |
| 元组 | `(1, 2, 3)` | 有序不可变集合 |
| 字典 | `{"name": "张三", "age": 25}` | 键值对集合 |
| 集合 | `{1, 2, 3}` | 无序不重复集合 |

## 3. 流程控制

### 3.1 条件语句

#### 3.1.1 if-elif-else 语句
```python
score = 85

if score >= 90:
    print("优秀")
elif score >= 80:
    print("良好")
elif score >= 60:
    print("及格")
else:
    print("不及格")
```

#### 3.1.2 条件表达式（三元运算符）
```python
result = "及格" if score >= 60 else "不及格"
print(result)
```

### 3.2 循环结构

#### 3.2.1 for 循环
```python
# 遍历列表
fruits = ["苹果", "香蕉", "橘子"]
for fruit in fruits:
    print(f"水果：{fruit}")

# 遍历字典
person = {"name": "张三", "age": 25, "city": "北京"}
for key, value in person.items():
    print(f"{key}: {value}")

# 遍历数字范围
for i in range(1, 6):
    print(f"数字：{i}")
```

#### 3.2.2 while 循环
```python
# 打印 1 到 5
i = 1
while i <= 5:
    print(f"数字：{i}")
    i += 1
```

#### 3.2.3 循环控制语句
- `break`：退出当前循环
- `continue`：跳过当前循环的剩余部分，继续下一次循环
- `else`：循环正常结束时执行（如果被 break 终止则不执行）

```python
for i in range(1, 10):
    if i == 5:
        break  # 退出循环
    if i % 2 == 0:
        continue  # 跳过偶数
    print(i)
else:
    print("循环正常结束")
```

## 4. 函数

### 4.1 函数定义
使用 `def` 关键字定义函数：

```python
# 基本函数
def hello():
    print("Hello, World!")

# 调用函数
hello()
```

### 4.2 带参数的函数
```python
# 带参数的函数
def greet(name, age=18):  # age 为默认参数
    print(f"你好，{name}！你今年 {age} 岁了。")

# 调用函数
greet("张三", 25)
greet("李四")  # 使用默认年龄 18
```

### 4.3 带返回值的函数
```python
# 带返回值的函数
def add(a, b):
    return a + b

# 调用函数并获取返回值
result = add(10, 5)
print(f"结果：{result}")  # 输出：结果：15
```

### 4.4 可变参数
```python
# *args：可变位置参数，接收任意数量的位置参数，类型为元组
def sum_numbers(*args):
    return sum(args)

print(sum_numbers(1, 2, 3, 4, 5))  # 输出：15

# **kwargs：可变关键字参数，接收任意数量的关键字参数，类型为字典
def print_person(**kwargs):
    for key, value in kwargs.items():
        print(f"{key}: {value}")

print_person(name="张三", age=25, city="北京")
```

## 5. 错误处理

### 5.1 try-except-finally
```python
try:
    # 可能出错的代码
    result = 10 / 0
except ZeroDivisionError:
    # 捕获特定异常
    print("除数不能为零")
except Exception as e:
    # 捕获所有其他异常
    print(f"发生错误：{e}")
finally:
    # 无论是否出错都会执行
    print("操作完成")
```

### 5.2 抛出异常
```python
def check_age(age):
    if age < 0 or age > 120:
        raise ValueError("年龄必须在 0 到 120 之间")
    return f"年龄有效：{age}"

try:
    result = check_age(150)
except ValueError as e:
    print(f"错误：{e}")
```

## 6. 命令行参数处理

### 6.1 使用 sys.argv
`sys.argv` 是一个列表，包含脚本名称和所有命令行参数：

```python
import sys

# 打印所有参数
print(f"脚本名称：{sys.argv[0]}")
print(f"参数数量：{len(sys.argv) - 1}")
print(f"所有参数：{sys.argv[1:]}")

# 访问单个参数
if len(sys.argv) > 1:
    name = sys.argv[1]
    print(f"你好，{name}！")
```

执行方式：
```bash
python3 脚本名.py 张三 25
```

### 6.2 使用 argparse（推荐）
`argparse` 是 Python 标准库，用于处理命令行参数，支持选项参数、位置参数、帮助信息等：

```python
import argparse

# 创建解析器
parser = argparse.ArgumentParser(description="这是一个示例脚本")

# 添加位置参数
parser.add_argument("name", type=str, help="姓名")
parser.add_argument("age", type=int, help="年龄")

# 添加选项参数
parser.add_argument("-v", "--verbose", action="store_true", help="启用详细模式")
parser.add_argument("-o", "--output", type=str, default="output.txt", help="输出文件路径")

# 解析参数
args = parser.parse_args()

# 使用参数
print(f"姓名：{args.name}")
print(f"年龄：{args.age}")
if args.verbose:
    print("详细模式已启用")
print(f"输出文件：{args.output}")
```

执行方式：
```bash
python3 脚本名.py 张三 25 -v -o result.txt
python3 脚本名.py --help  # 显示帮助信息
```

## 7. 用户输入处理

### 7.1 使用 input() 函数
`input()` 函数用于接收用户从键盘输入的数据，返回类型为字符串：

```python
# 基本输入
name = input("请输入你的姓名：")
print(f"你好，{name}！")

# 输入转换为整数
age = int(input("请输入你的年龄："))
print(f"你今年 {age} 岁了。")

# 输入转换为浮点数
height = float(input("请输入你的身高（米）："))
print(f"你的身高是 {height} 米。")
```

### 7.2 输入验证
```python
def get_valid_age():
    while True:
        try:
            age = int(input("请输入你的年龄："))
            if 0 <= age <= 120:
                return age
            else:
                print("年龄必须在 0 到 120 之间，请重新输入。")
        except ValueError:
            print("请输入有效的数字。")

age = get_valid_age()
print(f"你今年 {age} 岁了。")
```

### 7.3 密码输入（隐藏输入）
使用 `getpass` 模块可以隐藏用户输入的密码：

```python
import getpass

password = getpass.getpass("请输入密码：")
print(f"你输入的密码是：{password}")
```

## 8. 文件操作

### 8.1 读取文件
```python
# 方式 1：使用 open() 和 close()
file = open("test.txt", "r", encoding="utf-8")
try:
    content = file.read()
    print(content)
finally:
    file.close()

# 方式 2：使用 with 语句（推荐）
with open("test.txt", "r", encoding="utf-8") as file:
    content = file.read()
    print(content)

# 逐行读取
with open("test.txt", "r", encoding="utf-8") as file:
    for line in file:
        print(line.strip())
```

### 8.2 写入文件
```python
# 写入文件（覆盖）
with open("output.txt", "w", encoding="utf-8") as file:
    file.write("这是第一行\n")
    file.write("这是第二行\n")

# 追加写入
with open("output.txt", "a", encoding="utf-8") as file:
    file.write("这是追加的一行\n")
```

## 9. 中文编码处理

### 9.1 脚本编码声明
在脚本开头添加编码声明，确保中文正常显示：
```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
```

### 9.2 文件操作编码
在打开文件时，明确指定编码为 UTF-8：
```python
with open("file.txt", "r", encoding="utf-8") as file:
    content = file.read()
```

### 9.3 字符串编码
Python 3 中字符串默认使用 Unicode，不需要额外编码转换，直接使用即可：
```python
chinese_str = "中文文本"
print(chinese_str)
```

### 9.4 终端编码
如果在终端中显示中文乱码，可以尝试以下方法：
- Windows：在脚本开头添加
  ```python
  import sys
  import io
  sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
  ```
- Linux/macOS：确保终端编码为 UTF-8

## 10. 脚本模块化

### 10.1 导入模块
```python
# 导入标准库模块
import os
import sys
import datetime

# 导入第三方库模块
import requests

# 导入自定义模块
import mymodule
from mymodule import myfunction
```

### 10.2 创建自定义模块
创建一个名为 `mymodule.py` 的文件：
```python
# mymodule.py

def greet(name):
    return f"你好，{name}！"

def add(a, b):
    return a + b
```

在另一个脚本中导入使用：
```python
import mymodule

print(mymodule.greet("张三"))
print(mymodule.add(10, 5))
```

## 11. 脚本最佳实践

### 11.1 命名规范
- 脚本名：使用小写字母和下划线，如 `file_backup.py`
- 变量名：使用小写字母和下划线，如 `backup_path`
- 函数名：使用小写字母和下划线，如 `backup_files()`
- 类名：使用 PascalCase，如 `FileBackup`
- 常量名：使用全大写，如 `MAX_RETRY_COUNT = 5`

### 11.2 代码结构
```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""脚本文档字符串
这是脚本的详细描述，包括功能、使用方法等
"""

# 导入模块
import os
import sys
import argparse

# 定义常量
MAX_RETRY_COUNT = 5
DEFAULT_OUTPUT_DIR = "./output"

# 定义函数
def function1():
    """函数文档字符串"""
    pass

def main():
    """主函数"""
    pass

# 主程序入口
if __name__ == "__main__":
    main()
```

### 11.3 错误处理
- 始终使用 `try-except` 处理可能的错误
- 提供清晰的错误信息
- 记录错误日志

### 11.4 日志记录
使用 `logging` 模块记录日志：

```python
import logging

# 配置日志
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
    filename="app.log",
    encoding="utf-8"
)

# 使用日志
logging.info("程序开始执行")
try:
    # 可能出错的代码
    result = 10 / 0
except ZeroDivisionError as e:
    logging.error(f"发生错误：{e}")
logging.info("程序执行完成")
```

## 12. 示例脚本

### 12.1 文件备份脚本
```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""文件备份脚本
将指定目录下的文件备份到目标目录，并添加时间戳
"""

import os
import shutil
import datetime
import argparse


def backup_files(source_dir, dest_dir, verbose=False):
    """备份文件
    
    Args:
        source_dir: 源目录路径
        dest_dir: 目标目录路径
        verbose: 是否启用详细模式
    
    Returns:
        bool: 备份是否成功
    """
    try:
        # 检查源目录是否存在
        if not os.path.exists(source_dir):
            print(f"错误：源目录不存在：{source_dir}")
            return False
        
        # 创建目标目录
        timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
        backup_dir = os.path.join(dest_dir, f"backup_{timestamp}")
        os.makedirs(backup_dir, exist_ok=True)
        
        # 复制文件
        if verbose:
            print(f"开始备份 {source_dir} 到 {backup_dir}...")
        
        # 遍历源目录
        for item in os.listdir(source_dir):
            source_item = os.path.join(source_dir, item)
            dest_item = os.path.join(backup_dir, item)
            
            if os.path.isfile(source_item):
                shutil.copy2(source_item, dest_item)
                if verbose:
                    print(f"已复制文件：{item}")
            elif os.path.isdir(source_item):
                shutil.copytree(source_item, dest_item)
                if verbose:
                    print(f"已复制目录：{item}")
        
        print(f"备份成功！备份路径：{backup_dir}")
        return True
    except Exception as e:
        print(f"备份失败：{e}")
        return False


def main():
    """主函数"""
    # 创建解析器
    parser = argparse.ArgumentParser(description="文件备份脚本")
    parser.add_argument("source", help="源目录路径")
    parser.add_argument("dest", help="目标目录路径")
    parser.add_argument("-v", "--verbose", action="store_true", help="启用详细模式")
    
    # 解析参数
    args = parser.parse_args()
    
    # 执行备份
    backup_files(args.source, args.dest, args.verbose)


if __name__ == "__main__":
    main()
```

执行方式：
```bash
python3 backup_script.py ./source ./dest -v
```

### 12.2 系统信息收集脚本
```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""系统信息收集脚本
收集计算机的硬件、软件、网络等信息
"""

import os
import platform
import socket
import subprocess


def get_os_info():
    """获取操作系统信息"""
    return {
        "系统名称": platform.system(),
        "系统版本": platform.version(),
        "系统架构": platform.machine(),
        "Python版本": platform.python_version()
    }


def get_network_info():
    """获取网络信息"""
    try:
        hostname = socket.gethostname()
        ip_address = socket.gethostbyname(hostname)
        return {
            "主机名": hostname,
            "IP地址": ip_address
        }
    except Exception as e:
        return {"网络信息": f"获取失败：{e}"}


def get_disk_info():
    """获取磁盘信息"""
    try:
        if platform.system() == "Windows":
            result = subprocess.run(["wmic", "logicaldisk", "get", "size,freespace,caption"], 
                                 capture_output=True, text=True, encoding="gbk")
        else:
            result = subprocess.run(["df", "-h"], capture_output=True, text=True)
        return {"磁盘信息": result.stdout}
    except Exception as e:
        return {"磁盘信息": f"获取失败：{e}"}


def main():
    """主函数"""
    print("=== 系统信息收集 ===")
    
    # 获取操作系统信息
    print("\n1. 操作系统信息：")
    for key, value in get_os_info().items():
        print(f"   {key}: {value}")
    
    # 获取网络信息
    print("\n2. 网络信息：")
    for key, value in get_network_info().items():
        print(f"   {key}: {value}")
    
    # 获取磁盘信息
    print("\n3. 磁盘信息：")
    disk_info = get_disk_info()
    if "磁盘信息" in disk_info:
        print(disk_info["磁盘信息"])
    
    # 获取当前目录
    print(f"\n4. 当前工作目录：{os.getcwd()}")
    
    # 获取文件列表
    print("\n5. 当前目录文件列表：")
    for file in os.listdir("."):
        print(f"   {file}")


if __name__ == "__main__":
    main()
```

## 13. 调试技巧

### 13.1 使用 print() 调试
在关键位置添加 `print()` 语句，输出变量值：

```python
def add(a, b):
    print(f"调试信息：a={a}, b={b}")
    return a + b
```

### 13.2 使用 logging 模块
使用 `logging` 模块记录调试信息，可以控制日志级别：

```python
import logging

# 配置日志
logging.basicConfig(level=logging.DEBUG, format="%(levelname)s: %(message)s")

# 使用日志
logging.debug("调试信息")
logging.info("普通信息")
logging.warning("警告信息")
logging.error("错误信息")
```

### 13.3 使用 pdb 调试器
`pdb` 是 Python 内置的调试器，可以设置断点、单步执行、查看变量值等：

```python
import pdb

# 在代码中设置断点
pdb.set_trace()

# 或在命令行中启动调试
# python3 -m pdb 脚本名.py
```

常用 pdb 命令：
- `h`：查看帮助
- `n`：执行下一行
- `s`：进入函数
- `c`：继续执行
- `p 变量名`：查看变量值
- `q`：退出调试

### 13.4 使用 IDE 调试
在 VS Code、PyCharm 等 IDE 中设置断点，图形化调试，更直观方便。

## 14. 资源推荐

- [Python 官方文档](https://docs.python.org/zh-cn/3/)
- [Python 教程 - 廖雪峰](https://www.liaoxuefeng.com/wiki/1016959663602400)
- [Python 最佳实践](https://pythonguidecn.readthedocs.io/zh/latest/)
- [argparse 官方文档](https://docs.python.org/zh-cn/3/library/argparse.html)
- [logging 官方文档](https://docs.python.org/zh-cn/3/library/logging.html)
