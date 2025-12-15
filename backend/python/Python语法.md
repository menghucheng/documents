# Python 语法

## 1. 注释

Python 支持两种注释方式：

### 1.1 单行注释
使用 `#` 符号表示单行注释：

```python
# 这是一行单行注释
print("Hello, World!")  # 这也是单行注释，在代码后面
```

### 1.2 多行注释
使用三引号 `'''` 或 `"""` 表示多行注释：

```python
'''这是多行注释
可以包含多行内容
适合用于函数、类的文档字符串'''  

def add(a, b):
    return a + b

"""这也是多行注释
使用双引号的多行注释"""
```

## 2. 变量与赋值

### 2.1 变量定义
Python 是动态类型语言，变量不需要声明类型，直接赋值即可：

```python
name = "John"  # 字符串
age = 30       # 整数
height = 1.75  # 浮点数
is_student = True  # 布尔值
```

### 2.2 变量命名规则
- 变量名只能包含字母、数字和下划线
- 变量名不能以数字开头
- 变量名区分大小写
- 不能使用 Python 关键字作为变量名
- 建议使用有意义的变量名，遵循蛇形命名法（小写字母+下划线）

```python
# 合法的变量名
user_name = "Alice"
count = 100
_age = 25

# 非法的变量名
123abc = "invalid"  # 不能以数字开头
class = "Student"   # 不能使用关键字
user-name = "Bob"   # 不能使用连字符
```

### 2.3 赋值操作

#### 2.3.1 基本赋值
```python
x = 10
```

#### 2.3.2 多重赋值
```python
x, y, z = 1, 2, 3
print(x, y, z)  # 输出: 1 2 3
```

#### 2.3.3 连续赋值
```python
x = y = z = 0
print(x, y, z)  # 输出: 0 0 0
```

#### 2.3.4 交换赋值
```python
x, y = 1, 2
x, y = y, x  # 交换 x 和 y 的值
print(x, y)  # 输出: 2 1
```

## 3. 数据类型

Python 支持多种数据类型，主要分为以下几类：

### 3.1 基本数据类型

| 类型 | 描述 | 示例 |
|------|------|------|
| `int` | 整数 | `10`, `-5`, `0` |
| `float` | 浮点数 | `3.14`, `-0.5`, `2.0` |
| `bool` | 布尔值 | `True`, `False` |
| `str` | 字符串 | `"hello"`, `'world'` |

### 3.2 容器类型

| 类型 | 描述 | 示例 |
|------|------|------|
| `list` | 列表，有序可变 | `[1, 2, 3]`, `["a", "b", "c"]` |
| `tuple` | 元组，有序不可变 | `(1, 2, 3)`, `("a", "b", "c")` |
| `dict` | 字典，键值对集合 | `{"name": "John", "age": 30}` |
| `set` | 集合，无序不重复 | `{1, 2, 3}`, `{"a", "b", "c"}` |

### 3.3 特殊类型

| 类型 | 描述 | 示例 |
|------|------|------|
| `None` | 空值 | `None` |
| `range` | 范围对象 | `range(10)`, `range(1, 10, 2)` |
| `bytes` | 字节串 | `b"hello"`, `bytes([65, 66, 67])` |
| `bytearray` | 可变字节串 | `bytearray(b"hello")` |

## 4. 字符串

### 4.1 字符串定义

字符串可以使用单引号、双引号或三引号定义：

```python
# 单引号
str1 = 'Hello'

# 双引号  
str2 = "World"

# 三引号（支持多行）
str3 = '''Hello
World'''  

str4 = """Hello
World"""
```

### 4.2 字符串操作

#### 4.2.1 拼接字符串

```python
# 使用 + 拼接
str1 = "Hello" + " " + "World"
print(str1)  # 输出: Hello World

# 使用 * 重复
str2 = "Hello" * 3
print(str2)  # 输出: HelloHelloHello
```

#### 4.2.2 字符串格式化

```python
name = "John"
age = 30

# 1. 使用 f-strings（Python 3.6+）
print(f"My name is {name} and I'm {age} years old.")

# 2. 使用 format() 方法
print("My name is {} and I'm {} years old.".format(name, age))
print("My name is {0} and I'm {1} years old.".format(name, age))
print("My name is {name} and I'm {age} years old.".format(name=name, age=age))

# 3. 使用 % 格式化（旧方式）
print("My name is %s and I'm %d years old." % (name, age))
```

#### 4.2.3 字符串索引与切片

```python
str = "Hello, World!"

# 索引（从 0 开始）
print(str[0])   # 输出: H
print(str[-1])  # 输出: !（负索引从末尾开始）

# 切片 [start:end:step]
print(str[0:5])     # 输出: Hello
print(str[7:])      # 输出: World!
print(str[:5])      # 输出: Hello
print(str[::2])     # 输出: Hlo ol!（步长为 2）
print(str[::-1])    # 输出: !dlroW ,olleH（反转字符串）
```

#### 4.2.4 字符串方法

常用字符串方法：

```python
str = "Hello, World!"

# 大小写转换
print(str.upper())    # 输出: HELLO, WORLD!
print(str.lower())    # 输出: hello, world!
print(str.title())    # 输出: Hello, World!
print(str.capitalize())  # 输出: Hello, world!

# 替换
print(str.replace("World", "Python"))  # 输出: Hello, Python!

# 分割与连接
parts = str.split(", ")
print(parts)          # 输出: ['Hello', 'World!']
print("-".join(parts))  # 输出: Hello-World!

# 去除空白
str2 = "   Hello   "
print(str2.strip())   # 输出: Hello
print(str2.lstrip())  # 输出: Hello   
print(str2.rstrip())  # 输出:    Hello

# 检查前缀和后缀
print(str.startswith("Hello"))  # 输出: True
print(str.endswith("!")）        # 输出: True

# 查找
print(str.find("World"))  # 输出: 7
print(str.index("World"))  # 输出: 7

# 统计
print(str.count("o"))  # 输出: 2
```

## 5. 列表

### 5.1 列表定义

列表使用方括号 `[]` 定义，元素之间用逗号分隔：

```python
# 空列表
empty_list = []

# 包含相同类型元素
numbers = [1, 2, 3, 4, 5]

# 包含不同类型元素
mixed = [1, "Hello", 3.14, True]

# 嵌套列表
nested = [[1, 2], [3, 4], [5, 6]]
```

### 5.2 列表操作

#### 5.2.1 访问列表元素

```python
numbers = [1, 2, 3, 4, 5]

# 索引访问
print(numbers[0])   # 输出: 1
print(numbers[-1])  # 输出: 5

# 切片访问
print(numbers[1:4])   # 输出: [2, 3, 4]
print(numbers[:3])    # 输出: [1, 2, 3]
print(numbers[3:])    # 输出: [4, 5]
print(numbers[::2])   # 输出: [1, 3, 5]（步长为 2）
```

#### 5.2.2 修改列表

```python
numbers = [1, 2, 3, 4, 5]

# 修改元素
numbers[0] = 10
print(numbers)  # 输出: [10, 2, 3, 4, 5]

# 添加元素
numbers.append(6)
print(numbers)  # 输出: [10, 2, 3, 4, 5, 6]

# 插入元素
numbers.insert(1, 20)
print(numbers)  # 输出: [10, 20, 2, 3, 4, 5, 6]

# 扩展列表
numbers.extend([7, 8, 9])
print(numbers)  # 输出: [10, 20, 2, 3, 4, 5, 6, 7, 8, 9]

# 删除元素
# 方式 1: del

del numbers[0]
print(numbers)  # 输出: [20, 2, 3, 4, 5, 6, 7, 8, 9]

# 方式 2: pop()
last = numbers.pop()
print(last)     # 输出: 9
print(numbers)  # 输出: [20, 2, 3, 4, 5, 6, 7, 8]

first = numbers.pop(0)
print(first)    # 输出: 20
print(numbers)  # 输出: [2, 3, 4, 5, 6, 7, 8]

# 方式 3: remove()
numbers.remove(3)
print(numbers)  # 输出: [2, 4, 5, 6, 7, 8]
```

#### 5.2.3 列表方法

常用列表方法：

```python
numbers = [3, 1, 4, 1, 5, 9, 2, 6]

# 排序
numbers.sort()
print(numbers)  # 输出: [1, 1, 2, 3, 4, 5, 6, 9]

numbers.sort(reverse=True)
print(numbers)  # 输出: [9, 6, 5, 4, 3, 2, 1, 1]

# 反转
numbers.reverse()
print(numbers)  # 输出: [1, 1, 2, 3, 4, 5, 6, 9]

# 计数
print(numbers.count(1))  # 输出: 2

# 查找索引
print(numbers.index(5))  # 输出: 5

# 清空列表
numbers.clear()
print(numbers)  # 输出: []
```

## 6. 元组

### 6.1 元组定义

元组使用圆括号 `()` 定义，元素之间用逗号分隔：

```python
# 空元组
empty_tuple = ()

# 包含元素的元组
numbers = (1, 2, 3, 4, 5)

# 单元素元组（必须加逗号）
single_tuple = (1,)

# 嵌套元组
nested_tuple = ((1, 2), (3, 4), (5, 6))

# 可以省略括号
numbers2 = 1, 2, 3, 4, 5
```

### 6.2 元组操作

元组是不可变的，不能修改元素，但可以进行其他操作：

```python
numbers = (1, 2, 3, 4, 5)

# 访问元素（与列表相同）
print(numbers[0])   # 输出: 1
print(numbers[-1])  # 输出: 5
print(numbers[1:4]) # 输出: (2, 3, 4)

# 拼接元组
new_tuple = numbers + (6, 7, 8)
print(new_tuple)  # 输出: (1, 2, 3, 4, 5, 6, 7, 8)

# 重复元组
repeated = numbers * 2
print(repeated)  # 输出: (1, 2, 3, 4, 5, 1, 2, 3, 4, 5)

# 元组方法
print(numbers.count(1))  # 输出: 1
print(numbers.index(3))  # 输出: 2

# 元组转列表
list_numbers = list(numbers)
print(list_numbers)  # 输出: [1, 2, 3, 4, 5]

# 列表转元组
new_tuple2 = tuple(list_numbers)
print(new_tuple2)  # 输出: (1, 2, 3, 4, 5)
```

## 7. 字典

### 7.1 字典定义

字典使用花括号 `{}` 定义，包含键值对：

```python
# 空字典
empty_dict = {}
empty_dict2 = dict()

# 包含键值对的字典
person = {
    "name": "John",
    "age": 30,
    "city": "New York"
}

# 使用 dict() 构造函数
person2 = dict(name="John", age=30, city="New York")
person3 = dict([("name", "John"), ("age", 30)])
```

### 7.2 字典操作

#### 7.2.1 访问字典元素

```python
person = {"name": "John", "age": 30, "city": "New York"}

# 方式 1: 使用 []（如果键不存在会报错）
print(person["name"])

# 方式 2: 使用 get() 方法（如果键不存在返回 None 或指定默认值）
print(person.get("age"))
print(person.get("country", "USA"))
```

#### 7.2.2 修改字典

```python
person = {"name": "John", "age": 30, "city": "New York"}

# 添加/修改键值对
person["country"] = "USA"
person["age"] = 31

# 删除键值对
# 方式 1: del

del person["city"]

# 方式 2: pop()
age = person.pop("age")
print(age)  # 输出: 31

# 方式 3: popitem()（删除并返回最后一个键值对）
last_item = person.popitem()
print(last_item)  # 输出: ('country', 'USA')
```

#### 7.2.3 字典方法

常用字典方法：

```python
person = {"name": "John", "age": 30, "city": "New York"}

# 获取所有键
keys = person.keys()
print(list(keys))  # 输出: ['name', 'age', 'city']

# 获取所有值
values = person.values()
print(list(values))  # 输出: ['John', 30, 'New York']

# 获取所有键值对
items = person.items()
print(list(items))  # 输出: [('name', 'John'), ('age', 30), ('city', 'New York')]

# 复制字典
person2 = person.copy()

# 更新字典
person.update({"age": 31, "country": "USA"})

# 清空字典
person.clear()
```

## 8. 集合

### 8.1 集合定义

集合使用花括号 `{}` 或 `set()` 函数定义，元素之间用逗号分隔：

```python
# 空集合（必须使用 set()）
empty_set = set()

# 包含元素的集合
numbers = {1, 2, 3, 4, 5}

# 使用 set() 构造函数
numbers2 = set([1, 2, 3, 4, 5])
numbers3 = set((1, 2, 3, 4, 5))
numbers4 = set("hello")  # 输出: {'h', 'e', 'l', 'o'}（自动去重）
```

### 8.2 集合操作

#### 8.2.1 基本操作

```python
numbers = {1, 2, 3, 4, 5}

# 添加元素
numbers.add(6)
numbers.update([7, 8, 9])

# 删除元素
# 方式 1: remove()（如果元素不存在会报错）
numbers.remove(9)

# 方式 2: discard()（如果元素不存在不会报错）
numbers.discard(10)

# 方式 3: pop()（删除并返回任意元素）
first = numbers.pop()

# 清空集合
numbers.clear()
```

#### 8.2.2 集合运算

```python
set1 = {1, 2, 3, 4, 5}
set2 = {4, 5, 6, 7, 8}

# 并集
print(set1 | set2)  # 输出: {1, 2, 3, 4, 5, 6, 7, 8}
print(set1.union(set2))

# 交集
print(set1 & set2)  # 输出: {4, 5}
print(set1.intersection(set2))

# 差集
print(set1 - set2)  # 输出: {1, 2, 3}
print(set1.difference(set2))

# 对称差集（只在一个集合中出现的元素）
print(set1 ^ set2)  # 输出: {1, 2, 3, 6, 7, 8}
print(set1.symmetric_difference(set2))

# 子集判断
print({1, 2}.issubset(set1))  # 输出: True
print(set1.issuperset({1, 2}))  # 输出: True

# 不相交判断
print({1, 2}.isdisjoint({3, 4}))  # 输出: True
```

## 9. 运算符

### 9.1 算术运算符

| 运算符 | 描述 | 示例 |
|--------|------|------|
| `+` | 加法 | `2 + 3 = 5` |
| `-` | 减法 | `5 - 2 = 3` |
| `*` | 乘法 | `2 * 3 = 6` |
| `/` | 除法（浮点数） | `5 / 2 = 2.5` |
| `%` | 取模（余数） | `5 % 2 = 1` |
| `**` | 幂运算 | `2 ** 3 = 8` |
| `//` | 整除（向下取整） | `5 // 2 = 2` |

### 9.2 比较运算符

| 运算符 | 描述 | 示例 |
|--------|------|------|
| `==` | 等于 | `2 == 3` → `False` |
| `!=` | 不等于 | `2 != 3` → `True` |
| `>` | 大于 | `3 > 2` → `True` |
| `<` | 小于 | `2 < 3` → `True` |
| `>=` | 大于等于 | `3 >= 3` → `True` |
| `<=` | 小于等于 | `3 <= 2` → `False` |

### 9.3 逻辑运算符

| 运算符 | 描述 | 示例 |
|--------|------|------|
| `and` | 逻辑与 | `True and False` → `False` |
| `or` | 逻辑或 | `True or False` → `True` |
| `not` | 逻辑非 | `not True` → `False` |

### 9.4 赋值运算符

| 运算符 | 描述 | 示例 |
|--------|------|------|
| `=` | 基本赋值 | `x = 5` |
| `+=` | 加法赋值 | `x += 3` → `x = x + 3` |
| `-=` | 减法赋值 | `x -= 3` → `x = x - 3` |
| `*=` | 乘法赋值 | `x *= 3` → `x = x * 3` |
| `/=` | 除法赋值 | `x /= 3` → `x = x / 3` |
| `%=` | 取模赋值 | `x %= 3` → `x = x % 3` |
| `**=` | 幂赋值 | `x **= 3` → `x = x ** 3` |
| `//=` | 整除赋值 | `x //= 3` → `x = x // 3` |

### 9.5 成员运算符

| 运算符 | 描述 | 示例 |
|--------|------|------|
| `in` | 如果在指定序列中返回 True | `3 in [1, 2, 3]` → `True` |
| `not in` | 如果不在指定序列中返回 True | `4 not in [1, 2, 3]` → `True` |

### 9.6 身份运算符

| 运算符 | 描述 | 示例 |
|--------|------|------|
| `is` | 判断两个变量是否引用同一对象 | `x is y` |
| `is not` | 判断两个变量是否引用不同对象 | `x is not y` |

## 10. 流程控制

### 10.1 条件语句

#### 10.1.1 if 语句

```python
x = 10

if x > 0:
    print("x is positive")
```

#### 10.1.2 if-else 语句

```python
x = -1

if x > 0:
    print("x is positive")
else:
    print("x is not positive")
```

#### 10.1.3 if-elif-else 语句

```python
x = 0

if x > 0:
    print("x is positive")
elif x < 0:
    print("x is negative")
else:
    print("x is zero")
```

#### 10.1.4 嵌套 if 语句

```python
x = 10
y = 5

if x > 0:
    if y > 0:
        print("Both x and y are positive")
    else:
        print("x is positive but y is not")
```

### 10.2 循环语句

#### 10.2.1 for 循环

```python
# 遍历列表
numbers = [1, 2, 3, 4, 5]
for num in numbers:
    print(num)

# 遍历字符串
for char in "hello":
    print(char)

# 遍历字典
person = {"name": "John", "age": 30, "city": "New York"}
for key in person:
    print(key, person[key])

for key, value in person.items():
    print(key, value)

# 使用 range()
for i in range(5):
    print(i)  # 输出: 0 1 2 3 4

for i in range(1, 10, 2):
    print(i)  # 输出: 1 3 5 7 9
```

#### 10.2.2 while 循环

```python
count = 0
while count < 5:
    print(count)
    count += 1
```

#### 10.2.3 循环控制语句

- `break`：退出当前循环
- `continue`：跳过当前循环的剩余部分，继续下一次循环
- `else`：循环正常结束时执行（如果被 break 终止则不执行）

```python
# 使用 break
for i in range(10):
    if i == 5:
        break
    print(i)  # 输出: 0 1 2 3 4

# 使用 continue
for i in range(10):
    if i % 2 == 0:
        continue
    print(i)  # 输出: 1 3 5 7 9

# 使用 else
for i in range(5):
    print(i)
else:
    print("Loop completed normally")

for i in range(5):
    if i == 3:
        break
    print(i)
else:
    print("Loop completed normally")  # 不会执行
```

## 11. 函数

### 11.1 函数定义

```python
def function_name(parameters):
    """函数文档字符串（可选）"""
    # 函数体
    return value  # 可选
```

### 11.2 函数参数

#### 11.2.1 位置参数

```python
def add(a, b):
    return a + b

result = add(2, 3)
print(result)  # 输出: 5
```

#### 11.2.2 默认参数

```python
def greet(name, message="Hello"):
    return f"{message}, {name}!"

print(greet("John"))           # 输出: Hello, John!
print(greet("John", "Hi"))    # 输出: Hi, John!
```

#### 11.2.3 关键字参数

```python
def greet(name, message="Hello"):
    return f"{message}, {name}!"

print(greet(message="Hi", name="John"))  # 输出: Hi, John!
```

#### 11.2.4 可变位置参数（*args）

```python
def add(*args):
    sum = 0
    for num in args:
        sum += num
    return sum

print(add(1, 2, 3))       # 输出: 6
print(add(1, 2, 3, 4, 5))  # 输出: 15
```

#### 11.2.5 可变关键字参数（**kwargs）

```python
def print_person(**kwargs):
    for key, value in kwargs.items():
        print(f"{key}: {value}")

print_person(name="John", age=30, city="New York")
```

### 11.3 函数返回值

```python
# 返回单个值
def add(a, b):
    return a + b

# 返回多个值（作为元组）
def calculate(a, b):
    return a + b, a - b, a * b, a / b

result = calculate(10, 5)
print(result)  # 输出: (15, 5, 50, 2.0)

# 解包返回值
add_result, sub_result, mul_result, div_result = calculate(10, 5)
```

### 11.4 匿名函数（lambda）

```python
# 语法: lambda parameters: expression
add = lambda a, b: a + b
print(add(2, 3))  # 输出: 5

# 结合其他函数使用
numbers = [1, 2, 3, 4, 5]
even_numbers = list(filter(lambda x: x % 2 == 0, numbers))
print(even_numbers)  # 输出: [2, 4]

# 排序使用
tuples = [(1, 2), (3, 1), (2, 4), (4, 3)]
tuples.sort(key=lambda x: x[1])
print(tuples)  # 输出: [(3, 1), (1, 2), (4, 3), (2, 4)]
```

### 11.5 函数注解

```python
def add(a: int, b: int) -> int:
    """计算两个整数的和"""
    return a + b

result = add(2, 3)
print(result)  # 输出: 5
```

## 12. 类与对象

### 12.1 类定义

```python
class ClassName:
    # 类属性
    class_variable = "value"
    
    # 初始化方法
    def __init__(self, parameter1, parameter2):
        self.instance_variable1 = parameter1
        self.instance_variable2 = parameter2
    
    # 实例方法
    def instance_method(self):
        return f"{self.instance_variable1} {self.instance_variable2}"
    
    # 类方法
    @classmethod
    def class_method(cls):
        return cls.class_variable
    
    # 静态方法
    @staticmethod
    def static_method():
        return "Static method"
```

### 12.2 对象创建与使用

```python
# 创建对象
obj = ClassName("Hello", "World")

# 访问实例属性
print(obj.instance_variable1)

# 调用实例方法
print(obj.instance_method())

# 访问类属性
print(ClassName.class_variable)
print(obj.class_variable)

# 调用类方法
print(ClassName.class_method())
print(obj.class_method())

# 调用静态方法
print(ClassName.static_method())
print(obj.static_method())
```

### 12.3 继承

```python
# 父类
class Animal:
    def __init__(self, name):
        self.name = name
    
    def speak(self):
        pass

# 子类
class Dog(Animal):
    def speak(self):
        return "Woof!"

class Cat(Animal):
    def speak(self):
        return "Meow!"

# 使用
dog = Dog("Buddy")
print(dog.speak())  # 输出: Woof!

cat = Cat("Kitty")
print(cat.speak())  # 输出: Meow!
```

### 12.4 多态

```python
def make_animal_speak(animal):
    return animal.speak()

animal = Animal("Generic")
dog = Dog("Buddy")
cat = Cat("Kitty")

print(make_animal_speak(animal))  # 输出: None
print(make_animal_speak(dog))     # 输出: Woof!
print(make_animal_speak(cat))     # 输出: Meow!
```

## 13. 模块与包

### 13.1 模块导入

```python
# 导入整个模块
import math
print(math.pi)

# 导入特定函数/变量
from math import pi, sqrt
print(pi)
print(sqrt(16))

# 导入所有函数/变量
from math import *

# 给模块起别名
import math as m
print(m.pi)

# 给函数起别名
from math import sqrt as square_root
print(square_root(16))
```

### 13.2 模块创建

创建一个名为 `mymodule.py` 的文件：

```python
# mymodule.py

# 定义变量
pi = 3.14159

# 定义函数
def add(a, b):
    return a + b

def subtract(a, b):
    return a - b

# 定义类
class Calculator:
    def multiply(self, a, b):
        return a * b
    
    def divide(self, a, b):
        return a / b
```

然后在另一个文件中导入使用：

```python
import mymodule

print(mymodule.pi)
print(mymodule.add(2, 3))

calc = mymodule.Calculator()
print(calc.multiply(2, 3))
```

### 13.3 包

包是包含多个模块的目录，必须包含一个 `__init__.py` 文件（可以为空）。

目录结构：
```
mypackage/
├── __init__.py
├── module1.py
└── module2.py
```

导入包中的模块：

```python
# 方式 1
import mypackage.module1
print(mypackage.module1.function1())

# 方式 2
from mypackage import module1
print(module1.function1())

# 方式 3
from mypackage.module1 import function1
print(function1())
```

## 14. 异常处理

### 14.1 基本 try-except

```python
try:
    # 可能引发异常的代码
    x = 1 / 0
except ZeroDivisionError:
    # 处理特定异常
    print("Division by zero!")
```

### 14.2 捕获多个异常

```python
try:
    x = int("abc")
    y = 1 / 0
except ZeroDivisionError:
    print("Division by zero!")
except ValueError:
    print("Invalid value!")
except Exception as e:
    # 捕获所有其他异常
    print(f"An error occurred: {e}")
```

### 14.3 try-except-else-finally

```python
try:
    x = 10 / 2
except ZeroDivisionError:
    print("Division by zero!")
else:
    # 没有异常时执行
    print(f"Result: {x}")
finally:
    # 无论是否有异常都会执行
    print("Execution completed")
```

### 14.4 自定义异常

```python
class MyCustomError(Exception):
    def __init__(self, message):
        self.message = message

try:
    raise MyCustomError("This is a custom error")
except MyCustomError as e:
    print(f"Custom error caught: {e.message}")
```

## 15. 文件操作

### 15.1 文件打开与关闭

```python
# 方式 1: 使用 open() 和 close()
file = open("test.txt", "w")
file.write("Hello, World!")
file.close()

# 方式 2: 使用 with 语句（自动关闭文件）
with open("test.txt", "r") as file:
    content = file.read()
    print(content)
```

### 15.2 文件模式

| 模式 | 描述 |
|------|------|
| `r` | 只读模式（默认） |
| `w` | 写入模式（覆盖已有文件，文件不存在则创建） |
| `a` | 追加模式（在文件末尾写入，文件不存在则创建） |
| `x` | 独占创建模式（如果文件已存在则报错） |
| `b` | 二进制模式（与其他模式结合使用，如 `rb`、`wb`） |
| `+` | 读写模式（与其他模式结合使用，如 `r+`、`w+`） |

### 15.3 文件读写操作

```python
# 写入文件
with open("test.txt", "w") as file:
    file.write("Hello, World!\n")
    file.write("This is a test file.\n")

# 读取文件
# 方式 1: 读取全部内容
with open("test.txt", "r") as file:
    content = file.read()
    print(content)

# 方式 2: 逐行读取
with open("test.txt", "r") as file:
    for line in file:
        print(line.strip())

# 方式 3: 读取所有行到列表
with open("test.txt", "r") as file:
    lines = file.readlines()
    print(lines)
```

### 15.4 文件位置

```python
with open("test.txt", "r") as file:
    # 获取当前位置
    print(f"Current position: {file.tell()}")
    
    # 读取部分内容
    content = file.read(5)
    print(f"Read: {content}")
    print(f"Current position: {file.tell()}")
    
    # 移动到文件开头
    file.seek(0)
    print(f"Current position after seek(0): {file.tell()}")
```

## 16. 高级特性

### 16.1 列表推导式

```python
# 基本语法: [expression for item in iterable if condition]

# 创建列表 [0, 1, 2, 3, 4]
numbers = [i for i in range(5)]

# 创建偶数列表 [0, 2, 4, 6, 8]
even_numbers = [i for i in range(10) if i % 2 == 0]

# 创建平方列表 [1, 4, 9, 16, 25]
squares = [i ** 2 for i in range(1, 6)]

# 嵌套列表推导式
matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
flattened = [num for row in matrix for num in row]
print(flattened)  # 输出: [1, 2, 3, 4, 5, 6, 7, 8, 9]
```

### 16.2 字典推导式

```python
# 基本语法: {key_expression: value_expression for item in iterable if condition}

# 创建字典 {0: 0, 1: 1, 2: 4, 3: 9, 4: 16}
squares = {i: i ** 2 for i in range(5)}

# 反转字典
original = {"a": 1, "b": 2, "c": 3}
reversed_dict = {value: key for key, value in original.items()}
```

### 16.3 集合推导式

```python
# 基本语法: {expression for item in iterable if condition}

# 创建集合 {1, 2, 3, 4}
numbers = {i for i in range(5) if i > 0}

# 创建不重复的字符集合 {'h', 'e', 'l', 'o'}
unique_chars = {char for char in "hello"}
```

### 16.4 生成器表达式

```python
# 基本语法: (expression for item in iterable if condition)

# 创建生成器
gen = (i ** 2 for i in range(5))

# 遍历生成器
for num in gen:
    print(num)

# 生成器节省内存
import sys

list_comp = [i for i in range(1000000)]
gen_expr = (i for i in range(1000000))

print(sys.getsizeof(list_comp))  # 输出较大的内存占用
print(sys.getsizeof(gen_expr))   # 输出较小的内存占用
```

### 16.5 装饰器

```python
def my_decorator(func):
    def wrapper(*args, **kwargs):
        print("Before function call")
        result = func(*args, **kwargs)
        print("After function call")
        return result
    return wrapper

@my_decorator
def say_hello():
    print("Hello!")

@my_decorator
def add(a, b):
    return a + b

say_hello()
# 输出:
# Before function call
# Hello!
# After function call

result = add(2, 3)
print(result)
# 输出:
# Before function call
# After function call
# 5
```

### 16.6 上下文管理器

```python
class MyContextManager:
    def __enter__(self):
        print("Entering context")
        return self
    
    def __exit__(self, exc_type, exc_val, exc_tb):
        print("Exiting context")
        return False  # 不抑制异常

# 使用
with MyContextManager() as cm:
    print("Inside context")

# 使用 contextlib 装饰器简化
from contextlib import contextmanager

@contextmanager
def my_context_manager():
    print("Entering context")
    try:
        yield
    finally:
        print("Exiting context")

with my_context_manager():
    print("Inside context")
```

## 17. 总结

Python 语法简洁明了，易于学习和使用。本文介绍了 Python 的基本语法、数据类型、流程控制、函数、类与对象、模块与包、异常处理、文件操作以及高级特性。

通过掌握这些语法知识，可以编写各种 Python 程序，从简单的脚本到复杂的应用。Python 拥有丰富的标准库和第三方库，可以帮助开发者快速实现各种功能，提高开发效率。

建议在学习语法的同时，多动手编写代码，通过实践加深理解和记忆。