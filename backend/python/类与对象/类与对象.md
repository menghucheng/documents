# Python 类与对象

## 1. 面向对象编程概述

### 1.1 什么是面向对象编程

面向对象编程（Object-Oriented Programming，简称 OOP）是一种编程范式，它将数据和操作数据的方法封装在一起，形成对象。面向对象编程的核心概念包括类、对象、继承、多态、封装等。

### 1.2 面向对象编程的特点

- **封装**：将数据和方法封装在对象中，隐藏内部实现细节，只暴露必要的接口
- **继承**：允许创建新类，继承现有类的属性和方法，实现代码复用
- **多态**：允许不同类的对象对同一消息作出不同响应，提高代码的灵活性和可扩展性
- **抽象**：提取对象的共同特征，形成抽象类或接口

## 2. 类的定义

### 2.1 基本语法

**语法：**
```python
class 类名:
    类属性
    
    def __init__(self, 参数1, 参数2, ...):
        初始化方法
        self.实例属性 = 参数
    
    def 实例方法(self, 参数1, 参数2, ...):
        方法体
        return 返回值
    
    @classmethod
    def 类方法(cls, 参数1, 参数2, ...):
        方法体
        return 返回值
    
    @staticmethod
    def 静态方法(参数1, 参数2, ...):
        方法体
        return 返回值
```

**示例：**
```python
class Person:
    # 类属性
    species = "Homo sapiens"
    
    # 初始化方法
    def __init__(self, name, age):
        # 实例属性
        self.name = name
        self.age = age
    
    # 实例方法
    def greet(self):
        return f"Hello, my name is {self.name} and I'm {self.age} years old."
    
    # 类方法
    @classmethod
    def from_birth_year(cls, name, birth_year):
        current_year = 2025
        age = current_year - birth_year
        return cls(name, age)
    
    # 静态方法
    @staticmethod
    def is_adult(age):
        return age >= 18
```

## 3. 对象的创建

### 3.1 基本语法

**语法：**
```python
对象名 = 类名(参数1, 参数2, ...)
```

**示例：**
```python
# 创建 Person 对象
person = Person("John", 30)
```

### 3.2 访问属性和方法

**语法：**
```python
# 访问属性
对象名.属性名

# 调用方法
对象名.方法名(参数1, 参数2, ...)
```

**示例：**
```python
# 访问实例属性
print(person.name)  # 输出: John
print(person.age)   # 输出: 30

# 访问类属性
print(Person.species)  # 输出: Homo sapiens

# 调用实例方法
print(person.greet())  # 输出: Hello, my name is John and I'm 30 years old.

# 调用类方法
person2 = Person.from_birth_year("Alice", 1995)
print(person2.name)  # 输出: Alice
print(person2.age)   # 输出: 30

# 调用静态方法
print(Person.is_adult(18))  # 输出: True
print(Person.is_adult(16))  # 输出: False
```

## 4. 属性

### 4.1 实例属性

实例属性是每个对象独有的属性，在 `__init__` 方法中初始化，使用 `self.属性名` 定义。

**示例：**
```python
class Person:
    def __init__(self, name, age):
        self.name = name  # 实例属性
        self.age = age    # 实例属性

person1 = Person("John", 30)
person2 = Person("Alice", 25)

print(person1.name)  # 输出: John
print(person2.name)  # 输出: Alice
```

### 4.2 类属性

类属性是所有对象共享的属性，定义在类体中，使用 `属性名` 定义。

**示例：**
```python
class Person:
    species = "Homo sapiens"  # 类属性
    
    def __init__(self, name, age):
        self.name = name
        self.age = age

person1 = Person("John", 30)
person2 = Person("Alice", 25)

print(person1.species)  # 输出: Homo sapiens
print(person2.species)  # 输出: Homo sapiens
print(Person.species)   # 输出: Homo sapiens

# 修改类属性，所有对象都会受到影响
Person.species = "Homo sapiens sapiens"
print(person1.species)  # 输出: Homo sapiens sapiens
print(person2.species)  # 输出: Homo sapiens sapiens
```

### 4.3 属性访问控制

Python 中没有严格的访问控制机制，但可以使用命名约定来表示属性的访问级别：

- **公有属性**：直接使用属性名，如 `self.name`
- **保护属性**：属性名前加一个下划线 `_`，如 `self._name`，表示不建议外部直接访问
- **私有属性**：属性名前加两个下划线 `__`，如 `self.__name`，会被 Python 解释器自动转换为 `_类名__name`，实现伪私有

**示例：**
```python
class Person:
    def __init__(self, name, age):
        self.name = name  # 公有属性
        self._age = age   # 保护属性
        self.__id = 12345  # 私有属性

person = Person("John", 30)

# 访问公有属性
print(person.name)  # 输出: John

# 访问保护属性（不建议直接访问）
print(person._age)  # 输出: 30

# 访问私有属性（会报错）
# print(person.__id)  # AttributeError: 'Person' object has no attribute '__id'

# 访问转换后的私有属性
print(person._Person__id)  # 输出: 12345
```

### 4.4 属性装饰器

Python 提供了 `@property` 装饰器，用于将方法转换为属性，实现 getter、setter 和 deleter。

**示例：**
```python
class Person:
    def __init__(self, name, age):
        self._name = name
        self._age = age
    
    # getter 方法
    @property
    def name(self):
        return self._name
    
    # setter 方法
    @name.setter
    def name(self, value):
        if not isinstance(value, str):
            raise TypeError("Name must be a string")
        self._name = value
    
    # deleter 方法
    @name.deleter
    def name(self):
        del self._name
    
    @property
    def age(self):
        return self._age
    
    @age.setter
    def age(self, value):
        if not isinstance(value, int) or value < 0:
            raise TypeError("Age must be a positive integer")
        self._age = value

person = Person("John", 30)

# 使用 getter
print(person.name)  # 输出: John
print(person.age)   # 输出: 30

# 使用 setter
person.name = "Alice"
person.age = 25
print(person.name)  # 输出: Alice
print(person.age)   # 输出: 25

# 删除属性
# del person.name
# print(person.name)  # AttributeError: 'Person' object has no attribute '_name'

# 测试类型检查
try:
    person.age = "30"
except TypeError as e:
    print(e)  # 输出: Age must be a positive integer
```

## 5. 方法

### 5.1 实例方法

实例方法是最常用的方法类型，第一个参数是 `self`，指向当前对象。

**示例：**
```python
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age
    
    def greet(self):
        return f"Hello, my name is {self.name}."

person = Person("John", 30)
print(person.greet())  # 输出: Hello, my name is John.
```

### 5.2 类方法

类方法使用 `@classmethod` 装饰器，第一个参数是 `cls`，指向当前类。类方法可以访问和修改类属性，用于创建类的实例。

**示例：**
```python
class Person:
    count = 0  # 类属性
    
    def __init__(self, name, age):
        self.name = name
        self.age = age
        Person.count += 1
    
    @classmethod
    def get_count(cls):
        return cls.count
    
    @classmethod
    def from_string(cls, person_string):
        name, age = person_string.split(",")
        return cls(name, int(age))

person1 = Person("John", 30)
person2 = Person("Alice", 25)

print(Person.get_count())  # 输出: 2

person3 = Person.from_string("Bob, 35")
print(person3.name)  # 输出: Bob
print(person3.age)   # 输出: 35
print(Person.get_count())  # 输出: 3
```

### 5.3 静态方法

静态方法使用 `@staticmethod` 装饰器，不需要 `self` 或 `cls` 参数，不能访问实例属性或类属性，用于实现与类相关但不依赖于实例或类的功能。

**示例：**
```python
class Math:
    @staticmethod
    def add(a, b):
        return a + b
    
    @staticmethod
    def multiply(a, b):
        return a * b

print(Math.add(2, 3))       # 输出: 5
print(Math.multiply(2, 3))  # 输出: 6
```

## 6. 继承

### 6.1 基本语法

继承允许创建新类，继承现有类的属性和方法，实现代码复用。被继承的类称为父类或基类，继承的类称为子类或派生类。

**语法：**
```python
class 子类名(父类名):
    def __init__(self, 参数1, 参数2, ...):
        # 调用父类的初始化方法
        super().__init__(参数1, 参数2, ...)
        # 子类的初始化代码
    
    # 子类的方法
    def 方法名(self, 参数1, 参数2, ...):
        方法体
```

**示例：**
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
        return f"{self.name} says Woof!"

class Cat(Animal):
    def speak(self):
        return f"{self.name} says Meow!"

# 创建对象
dog = Dog("Buddy")
cat = Cat("Kitty")

print(dog.speak())  # 输出: Buddy says Woof!
print(cat.speak())  # 输出: Kitty says Meow!
```

### 6.2 方法重写

子类可以重写父类的方法，实现自己的功能。

**示例：**
```python
class Animal:
    def __init__(self, name):
        self.name = name
    
    def speak(self):
        return f"{self.name} makes a sound."

class Dog(Animal):
    def speak(self):
        return f"{self.name} says Woof!"  # 重写父类方法

class Cat(Animal):
    def speak(self):
        return f"{self.name} says Meow!"  # 重写父类方法

animal = Animal("Generic Animal")
dog = Dog("Buddy")
cat = Cat("Kitty")

print(animal.speak())  # 输出: Generic Animal makes a sound.
print(dog.speak())     # 输出: Buddy says Woof!
print(cat.speak())     # 输出: Kitty says Meow!
```

### 6.3 多重继承

Python 支持多重继承，一个子类可以继承多个父类。

**语法：**
```python
class 子类名(父类1, 父类2, ...):
    # 类体
```

**示例：**
```python
class A:
    def method_a(self):
        return "Method A from class A"

class B:
    def method_b(self):
        return "Method B from class B"

class C(A, B):
    def method_c(self):
        return "Method C from class C"

c = C()
print(c.method_a())  # 输出: Method A from class A
print(c.method_b())  # 输出: Method B from class B
print(c.method_c())  # 输出: Method C from class C
```

### 6.4 MRO（方法解析顺序）

当一个类继承多个父类时，Python 使用 C3 线性化算法确定方法解析顺序（MRO），可以使用 `__mro__` 属性或 `mro()` 方法查看。

**示例：**
```python
print(C.__mro__)
# 输出: (<class '__main__.C'>, <class '__main__.A'>, <class '__main__.B'>, <class 'object'>)

print(C.mro())
# 输出: [<class '__main__.C'>, <class '__main__.A'>, <class '__main__.B'>, <class 'object'>]
```

## 7. 多态

多态是指不同类的对象对同一消息作出不同响应，实现代码的灵活性和可扩展性。

**示例：**
```python
def make_animal_speak(animal):
    return animal.speak()

animal = Animal("Generic Animal")
dog = Dog("Buddy")
cat = Cat("Kitty")

print(make_animal_speak(animal))  # 输出: Generic Animal makes a sound.
print(make_animal_speak(dog))     # 输出: Buddy says Woof!
print(make_animal_speak(cat))     # 输出: Kitty says Meow!
```

## 8. 特殊方法

Python 中有许多特殊方法，也称为魔术方法，以双下划线开头和结尾，用于实现对象的特殊行为。

### 8.1 `__init__` 方法

初始化方法，创建对象时调用，用于初始化对象的属性。

**示例：**
```python
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

person = Person("John", 30)
```

### 8.2 `__str__` 方法

返回对象的字符串表示，使用 `print()` 或 `str()` 函数时调用。

**示例：**
```python
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age
    
    def __str__(self):
        return f"Person(name='{self.name}', age={self.age})"

person = Person("John", 30)
print(person)  # 输出: Person(name='John', age=30)
```

### 8.3 `__repr__` 方法

返回对象的官方字符串表示，使用 `repr()` 函数或在交互式环境中直接输入对象时调用。

**示例：**
```python
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age
    
    def __repr__(self):
        return f"Person(name='{self.name}', age={self.age})"

person = Person("John", 30)
print(repr(person))  # 输出: Person(name='John', age=30)
```

### 8.4 `__eq__` 方法

用于比较两个对象是否相等，使用 `==` 运算符时调用。

**示例：**
```python
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age
    
    def __eq__(self, other):
        if isinstance(other, Person):
            return self.name == other.name and self.age == other.age
        return False

person1 = Person("John", 30)
person2 = Person("John", 30)
person3 = Person("Alice", 25)

print(person1 == person2)  # 输出: True
print(person1 == person3)  # 输出: False
```

### 8.5 其他特殊方法

| 方法 | 描述 | 调用方式 |
|------|------|----------|
| `__add__` | 加法运算 | `+` |
| `__sub__` | 减法运算 | `-` |
| `__mul__` | 乘法运算 | `*` |
| `__truediv__` | 除法运算 | `/` |
| `__len__` | 长度 | `len()` |
| `__getitem__` | 索引访问 | `obj[key]` |
| `__setitem__` | 设置索引 | `obj[key] = value` |
| `__delitem__` | 删除索引 | `del obj[key]` |
| `__contains__` | 成员检查 | `in` |

**示例：**
```python
class Vector:
    def __init__(self, x, y):
        self.x = x
        self.y = y
    
    def __add__(self, other):
        if isinstance(other, Vector):
            return Vector(self.x + other.x, self.y + other.y)
        return NotImplemented
    
    def __str__(self):
        return f"Vector({self.x}, {self.y})"

v1 = Vector(1, 2)
v2 = Vector(3, 4)
v3 = v1 + v2
print(v3)  # 输出: Vector(4, 6)
```

## 9. 抽象类和接口

### 9.1 抽象类

抽象类是不能实例化的类，用于定义接口和共享代码。在 Python 中，可以使用 `abc` 模块创建抽象类和抽象方法。

**示例：**
```python
from abc import ABC, abstractmethod

class Animal(ABC):
    @abstractmethod
    def speak(self):
        pass
    
    def eat(self):
        return "Eating..."

class Dog(Animal):
    def speak(self):
        return "Woof!"

class Cat(Animal):
    def speak(self):
        return "Meow!"

# 不能实例化抽象类
# animal = Animal()  # TypeError: Can't instantiate abstract class Animal with abstract method speak

dog = Dog()
print(dog.speak())  # 输出: Woof!
print(dog.eat())    # 输出: Eating...

cat = Cat()
print(cat.speak())  # 输出: Meow!
print(cat.eat())    # 输出: Eating...
```

### 9.2 接口

Python 没有正式的接口概念，但可以使用抽象类来模拟接口，只定义抽象方法，不实现任何具体功能。

**示例：**
```python
from abc import ABC, abstractmethod

class Shape(ABC):
    @abstractmethod
    def area(self):
        pass
    
    @abstractmethod
    def perimeter(self):
        pass

class Rectangle(Shape):
    def __init__(self, width, height):
        self.width = width
        self.height = height
    
    def area(self):
        return self.width * self.height
    
    def perimeter(self):
        return 2 * (self.width + self.height)

class Circle(Shape):
    def __init__(self, radius):
        self.radius = radius
    
    def area(self):
        return 3.14159 * self.radius ** 2
    
    def perimeter(self):
        return 2 * 3.14159 * self.radius

rectangle = Rectangle(5, 10)
print(rectangle.area())      # 输出: 50
print(rectangle.perimeter())  # 输出: 30

circle = Circle(5)
print(circle.area())      # 输出: 78.53975
print(circle.perimeter())  # 输出: 31.4159
```

## 10. 封装

封装是指将数据和方法封装在对象中，隐藏内部实现细节，只暴露必要的接口。在 Python 中，可以使用属性装饰器和访问控制命名约定实现封装。

**示例：**
```python
class BankAccount:
    def __init__(self, account_number, balance):
        self._account_number = account_number  # 保护属性
        self._balance = balance                # 保护属性
    
    @property
    def account_number(self):
        return self._account_number
    
    @property
    def balance(self):
        return self._balance
    
    def deposit(self, amount):
        if amount > 0:
            self._balance += amount
            return f"Deposited ${amount}. New balance: ${self._balance}"
        return "Invalid deposit amount."
    
    def withdraw(self, amount):
        if 0 < amount <= self._balance:
            self._balance -= amount
            return f"Withdrew ${amount}. New balance: ${self._balance}"
        return "Invalid withdrawal amount."

account = BankAccount("123456789", 1000)

print(account.account_number)  # 输出: 123456789
print(account.balance)         # 输出: 1000

print(account.deposit(500))    # 输出: Deposited $500. New balance: $1500
print(account.withdraw(200))   # 输出: Withdrew $200. New balance: $1300
print(account.withdraw(2000))  # 输出: Invalid withdrawal amount.

# 不能直接修改属性（不建议）
# account._balance = 2000  # 不建议直接修改保护属性
```

## 11. 最佳实践

### 11.1 类命名

- 类名使用驼峰命名法，首字母大写，如 `Person`、`BankAccount`
- 避免使用 Python 关键字和内置类型名

### 11.2 属性和方法命名

- 实例属性和实例方法使用蛇形命名法，如 `first_name`、`get_name`
- 类属性和类方法使用蛇形命名法
- 保护属性前加一个下划线，如 `_protected_attr`
- 私有属性前加两个下划线，如 `__private_attr`
- 特殊方法使用双下划线，如 `__init__`、`__str__`

### 11.3 继承

- 继承关系应符合 "is-a" 关系
- 避免深层继承，建议不超过 3 层
- 优先使用组合而不是继承

### 11.4 文档字符串

- 为类、属性和方法添加文档字符串，使用 `"""` 包围
- 文档字符串应描述类或方法的功能、参数和返回值

**示例：**
```python
class Person:
    """Person 类表示一个人。
    
    Attributes:
        name (str): 人的姓名
        age (int): 人的年龄
    """
    
    def __init__(self, name, age):
        """初始化 Person 对象。
        
        Args:
            name (str): 人的姓名
            age (int): 人的年龄
        """
        self.name = name
        self.age = age
    
    def greet(self):
        """返回问候语。
        
        Returns:
            str: 问候语
        """
        return f"Hello, my name is {self.name}."
```

### 11.5 避免全局状态

- 避免在类中使用全局变量
- 使用类属性或实例属性存储状态

### 11.6 保持类的单一职责

- 每个类应只负责一个功能
- 避免创建过于复杂的类

## 12. 总结

Python 是一种面向对象的编程语言，支持类、对象、继承、多态、封装等面向对象特性。通过学习 Python 的面向对象编程，可以编写出更加模块化、可维护和可扩展的代码。

面向对象编程的核心概念包括：

- **类**：用于定义对象的蓝图
- **对象**：类的实例
- **属性**：对象的数据
- **方法**：对象的行为
- **继承**：代码复用
- **多态**：灵活性和可扩展性
- **封装**：隐藏内部实现细节

通过掌握这些概念和最佳实践，可以编写出高质量的 Python 代码，提高开发效率和代码的可维护性。