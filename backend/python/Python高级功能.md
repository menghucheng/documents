# Python 高级功能

## 1. 装饰器

### 1.1 装饰器基础

装饰器是 Python 中的高级特性，它允许在不修改原函数代码的情况下，为函数添加新的功能。装饰器本质上是一个函数，它接受一个函数作为参数，并返回一个新的函数。

**基本语法**：
```python
def decorator(func):
    def wrapper(*args, **kwargs):
        # 在原函数执行前添加功能
        result = func(*args, **kwargs)
        # 在原函数执行后添加功能
        return result
    return wrapper

@decorator
def function():
    pass
```

**示例**：
```python
def log_decorator(func):
    def wrapper(*args, **kwargs):
        print(f"调用函数: {func.__name__}")
        print(f"参数: {args}, {kwargs}")
        result = func(*args, **kwargs)
        print(f"返回值: {result}")
        return result
    return wrapper

@log_decorator
def add(a, b):
    return a + b

# 调用函数
add(3, 5)
# 输出:
# 调用函数: add
# 参数: (3, 5), {}
# 返回值: 8
```

### 1.2 带参数的装饰器

装饰器可以接受参数，这需要在装饰器外层再包裹一层函数。

**示例**：
```python
def repeat(n):
    def decorator(func):
        def wrapper(*args, **kwargs):
            result = None
            for _ in range(n):
                result = func(*args, **kwargs)
            return result
        return wrapper
    return decorator

@repeat(3)
def say_hello(name):
    print(f"Hello, {name}!")

# 调用函数
say_hello("张三")
# 输出:
# Hello, 张三!
# Hello, 张三!
# Hello, 张三!
```

### 1.3 类装饰器

除了函数装饰器，还可以使用类作为装饰器。类装饰器需要实现 `__call__` 方法。

**示例**：
```python
class CountCalls:
    def __init__(self, func):
        self.func = func
        self.count = 0
    
    def __call__(self, *args, **kwargs):
        self.count += 1
        print(f"函数 {self.func.__name__} 已调用 {self.count} 次")
        return self.func(*args, **kwargs)

@CountCalls
def say_hello():
    print("Hello!")

# 调用函数
say_hello()  # 函数 say_hello 已调用 1 次
# Hello!
say_hello()  # 函数 say_hello 已调用 2 次
# Hello!
```

### 1.4 常用内置装饰器

Python 提供了一些常用的内置装饰器：

- `@staticmethod`：静态方法，不需要实例化即可调用
- `@classmethod`：类方法，接受类作为第一个参数
- `@property`：属性装饰器，将方法转换为属性
- `@functools.wraps`：保留原函数的元信息

**示例**：
```python
import functools

class Person:
    def __init__(self, name, age):
        self._name = name
        self._age = age
    
    @property
    def name(self):
        return self._name
    
    @name.setter
    def name(self, value):
        if not isinstance(value, str):
            raise ValueError("姓名必须是字符串")
        self._name = value
    
    @property
    def age(self):
        return self._age
    
    @age.setter
    def age(self, value):
        if not isinstance(value, int) or value < 0:
            raise ValueError("年龄必须是非负整数")
        self._age = value
    
    @staticmethod
    def is_adult(age):
        return age >= 18
    
    @classmethod
    def create_adult(cls, name):
        return cls(name, 18)

# 使用 property
person = Person("张三", 25)
print(person.name)  # 张三
person.name = "李四"
print(person.name)  # 李四

# 使用 staticmethod
print(Person.is_adult(20))  # True

# 使用 classmethod
adult = Person.create_adult("王五")
print(adult.age)  # 18
```

## 2. 上下文管理器

### 2.1 上下文管理器基础

上下文管理器用于管理资源的获取和释放，确保资源在使用后正确释放。最常见的使用场景是文件操作。

**基本语法**：
```python
with 上下文管理器 as 变量:
    # 使用资源
# 资源自动释放
```

**示例**：
```python
# 文件操作
with open('file.txt', 'w') as f:
    f.write('Hello, world!')
# 文件自动关闭

# 多上下文管理器
with open('file1.txt', 'w') as f1, open('file2.txt', 'w') as f2:
    f1.write('Hello')
    f2.write('World')
```

### 2.2 自定义上下文管理器

可以通过两种方式自定义上下文管理器：
1. 实现 `__enter__` 和 `__exit__` 方法的类
2. 使用 `contextlib.contextmanager` 装饰器

**示例 1：类实现**
```python
class Timer:
    def __enter__(self):
        import time
        self.start = time.time()
        return self
    
    def __exit__(self, exc_type, exc_val, exc_tb):
        import time
        self.end = time.time()
        self.duration = self.end - self.start
        print(f"执行时间: {self.duration:.4f}秒")

# 使用自定义上下文管理器
with Timer() as timer:
    # 模拟耗时操作
    import time
    time.sleep(1)

# 输出: 执行时间: 1.0001秒
```

**示例 2：装饰器实现**
```python
from contextlib import contextmanager

@contextmanager
def timer():
    import time
    start = time.time()
    yield
    end = time.time()
    duration = end - start
    print(f"执行时间: {duration:.4f}秒")

# 使用上下文管理器
with timer():
    import time
    time.sleep(1)

# 输出: 执行时间: 1.0001秒
```

### 2.3 常用上下文管理器

- `open()`：文件操作
- `threading.Lock()`：线程锁
- `multiprocessing.Lock()`：进程锁
- `tempfile.TemporaryFile()`：临时文件
- `contextlib.nullcontext()`：空上下文管理器，用于条件上下文

## 3. 异步编程

### 3.1 异步编程基础

异步编程允许程序在等待 I/O 操作时执行其他任务，提高程序的并发性能。Python 3.5+ 引入了 `asyncio` 模块和 `async/await` 语法。

**基本概念**：
- `async def`：定义异步函数
- `await`：等待异步操作完成
- `asyncio.run()`：运行异步函数
- `coroutine`：协程，可暂停和恢复的函数

**示例**：
```python
import asyncio

async def say_hello():
    print("Hello")
    await asyncio.sleep(1)  # 模拟耗时操作
    print("World")

# 运行异步函数
asyncio.run(say_hello())
# 输出:
# Hello
# (等待 1 秒)
# World
```

### 3.2 并发执行任务

可以使用 `asyncio.gather()` 并发执行多个异步任务。

**示例**：
```python
import asyncio

async def task(name, duration):
    print(f"任务 {name} 开始")
    await asyncio.sleep(duration)
    print(f"任务 {name} 完成")
    return f"任务 {name} 结果"

async def main():
    # 并发执行多个任务
    results = await asyncio.gather(
        task("A", 2),
        task("B", 1),
        task("C", 3)
    )
    print(f"所有任务完成，结果: {results}")

asyncio.run(main())
# 输出:
# 任务 A 开始
# 任务 B 开始
# 任务 C 开始
# 任务 B 完成
# 任务 A 完成
# 任务 C 完成
# 所有任务完成，结果: ['任务 A 结果', '任务 B 结果', '任务 C 结果']
```

### 3.3 异步 I/O

异步编程最适合 I/O 密集型任务，如网络请求、文件读写等。

**示例：异步网络请求**
```python
import asyncio
import aiohttp

async def fetch(url):
    async with aiohttp.ClientSession() as session:
        async with session.get(url) as response:
            return await response.text()

async def main():
    urls = [
        "https://httpbin.org/get?name=A",
        "https://httpbin.org/get?name=B",
        "https://httpbin.org/get?name=C"
    ]
    
    # 并发获取多个 URL
    tasks = [fetch(url) for url in urls]
    results = await asyncio.gather(*tasks)
    
    for i, result in enumerate(results):
        print(f"URL {i+1} 结果长度: {len(result)}")

asyncio.run(main())
```

### 3.4 异步生成器和异步迭代

Python 3.6+ 支持异步生成器和异步迭代。

**示例**：
```python
import asyncio

async def async_generator():
    for i in range(5):
        await asyncio.sleep(0.5)
        yield i

async def main():
    # 异步迭代
    async for value in async_generator():
        print(f"获取到值: {value}")

asyncio.run(main())
# 输出:
# 获取到值: 0
# 获取到值: 1
# 获取到值: 2
# 获取到值: 3
# 获取到值: 4
```

## 4. 元编程

### 4.1 元类

元类是创建类的类，它控制类的创建过程。

**基本概念**：
- `type` 是 Python 中所有类的元类
- 可以通过继承 `type` 来创建自定义元类
- `__new__` 方法用于创建类
- `__init__` 方法用于初始化类

**示例**：
```python
class MetaClass(type):
    def __new__(cls, name, bases, attrs):
        # 在创建类之前修改属性
        attrs['added_by_metaclass'] = True
        attrs['created_at'] = '2025-01-01'
        return super().__new__(cls, name, bases, attrs)
    
    def __init__(cls, name, bases, attrs):
        super().__init__(name, bases, attrs)
        print(f"类 {name} 已创建")

# 使用元类
class MyClass(metaclass=MetaClass):
    def __init__(self, value):
        self.value = value

# 测试
obj = MyClass(10)
print(obj.added_by_metaclass)  # True
print(obj.created_at)  # 2025-01-01
```

### 4.2 动态属性

可以在运行时动态添加、修改或删除类或对象的属性。

**示例**：
```python
class Person:
    def __init__(self, name):
        self.name = name

# 创建对象
person = Person("张三")

# 动态添加属性
person.age = 25
print(person.age)  # 25

# 动态添加方法
import types

def say_hello(self):
    print(f"Hello, {self.name}!")

person.say_hello = types.MethodType(say_hello, person)
person.say_hello()  # Hello, 张三!

# 动态添加类属性
Person.species = "人类"
print(person.species)  # 人类

# 动态删除属性
del person.age
# print(person.age)  # 会抛出 AttributeError
```

### 4.3 `__slots__`

`__slots__` 用于限制类的实例可以拥有的属性，提高性能并节省内存。

**示例**：
```python
class Person:
    __slots__ = ['name', 'age']  # 限制只能有这两个属性
    
    def __init__(self, name, age):
        self.name = name
        self.age = age

person = Person("张三", 25)
print(person.name)  # 张三

# 尝试添加不在 __slots__ 中的属性
person.email = "zhangsan@example.com"  # 会抛出 AttributeError
```

### 4.4 `getattr`、`setattr` 和 `delattr`

这些内置函数用于动态访问、设置和删除属性。

**示例**：
```python
class Person:
    def __init__(self, name):
        self.name = name
    
    def __getattr__(self, name):
        # 当访问不存在的属性时调用
        return f"属性 {name} 不存在"
    
    def __setattr__(self, name, value):
        # 当设置属性时调用
        print(f"设置属性 {name} = {value}")
        super().__setattr__(name, value)
    
    def __delattr__(self, name):
        # 当删除属性时调用
        print(f"删除属性 {name}")
        super().__delattr__(name)

person = Person("张三")
print(person.name)  # 张三
print(person.age)  # 属性 age 不存在

person.age = 25  # 设置属性 age = 25
del person.age  # 删除属性 age
```

## 5. 多线程与多进程

### 5.1 多线程

多线程适用于 I/O 密集型任务，但受 GIL 限制，无法充分利用多核 CPU。

**示例**：
```python
import threading
import time

def task(name, duration):
    print(f"线程 {name} 开始")
    time.sleep(duration)  # 模拟 I/O 操作
    print(f"线程 {name} 完成")

# 创建线程
thread1 = threading.Thread(target=task, args=("A", 2))
thread2 = threading.Thread(target=task, args=("B", 1))

# 启动线程
thread1.start()
thread2.start()

# 等待线程完成
thread1.join()
thread2.join()

print("所有线程完成")
```

### 5.2 线程安全

多线程访问共享资源时需要注意线程安全，可以使用锁来保护共享资源。

**示例**：
```python
import threading

# 共享资源
counter = 0
lock = threading.Lock()

def increment():
    global counter
    for _ in range(1000000):
        with lock:  # 使用锁保护共享资源
            counter += 1

def decrement():
    global counter
    for _ in range(1000000):
        with lock:  # 使用锁保护共享资源
            counter -= 1

# 创建线程
thread1 = threading.Thread(target=increment)
thread2 = threading.Thread(target=decrement)

# 启动线程
thread1.start()
thread2.start()

# 等待线程完成
thread1.join()
thread2.join()

print(f"最终计数器值: {counter}")  # 0
```

### 5.3 多进程

多进程适用于 CPU 密集型任务，可以充分利用多核 CPU。

**示例**：
```python
import multiprocessing
import time

def cpu_bound_task(name, duration):
    print(f"进程 {name} 开始")
    # 模拟 CPU 密集型任务
    start = time.time()
    while time.time() - start < duration:
        pass
    print(f"进程 {name} 完成")

if __name__ == "__main__":
    # 创建进程
    process1 = multiprocessing.Process(target=cpu_bound_task, args=("A", 2))
    process2 = multiprocessing.Process(target=cpu_bound_task, args=("B", 2))
    
    # 启动进程
    process1.start()
    process2.start()
    
    # 等待进程完成
    process1.join()
    process2.join()
    
    print("所有进程完成")
```

### 5.4 进程池

进程池用于管理多个进程，适合处理大量任务。

**示例**：
```python
import multiprocessing

def square(n):
    return n * n

if __name__ == "__main__":
    # 创建进程池
    with multiprocessing.Pool(processes=4) as pool:
        # 映射函数到数据
        results = pool.map(square, range(10))
        print(f"结果: {results}")  # [0, 1, 4, 9, 16, 25, 36, 49, 64, 81]
        
        # 异步映射
        async_results = pool.map_async(square, range(10))
        print(f"异步结果: {async_results.get()}")  # [0, 1, 4, 9, 16, 25, 36, 49, 64, 81]
```

## 6. 性能优化

### 6.1 代码优化技巧

- **使用局部变量**：局部变量访问速度比全局变量快
- **减少属性访问**：将频繁访问的属性存储在局部变量中
- **使用内置函数**：内置函数是用 C 实现的，速度更快
- **避免不必要的计算**：缓存计算结果
- **使用生成器**：生成器节省内存

**示例**：
```python
# 低效示例：频繁访问全局变量
result = []
for i in range(1000000):
    result.append(i * 2)

# 高效示例：使用列表推导式（内置函数）
result = [i * 2 for i in range(1000000)]

# 低效示例：频繁访问属性
class Calculator:
    def __init__(self):
        self.factor = 2
    
    def calculate(self, numbers):
        result = []
        for num in numbers:
            result.append(num * self.factor)  # 频繁访问属性
        return result

# 高效示例：将属性存储在局部变量中
    def calculate_optimized(self, numbers):
        result = []
        factor = self.factor  # 存储在局部变量中
        for num in numbers:
            result.append(num * factor)  # 访问局部变量
        return result
```

### 6.2 性能分析工具

- **`time` 模块**：简单的性能测试
- **`cProfile` 模块**：详细的性能分析
- **`line_profiler`**：逐行性能分析
- **`memory_profiler`**：内存使用分析

**示例：使用 `cProfile`**
```python
import cProfile

def slow_function():
    result = 0
    for i in range(1000000):
        result += i
    return result

def fast_function():
    return sum(range(1000000))

# 性能分析
cProfile.run('slow_function()')
cProfile.run('fast_function()')
```

### 6.3 并行计算

对于 CPU 密集型任务，可以使用以下库进行并行计算：

- **NumPy**：数值计算，底层使用 C 实现
- **Pandas**：数据分析，底层使用 NumPy
- **Dask**：并行计算库，支持大数据
- **Joblib**：简单的并行计算库

**示例：使用 Joblib 并行计算**
```python
from joblib import Parallel, delayed

def square(n):
    return n * n

# 并行计算
results = Parallel(n_jobs=4)(delayed(square)(i) for i in range(10))
print(results)  # [0, 1, 4, 9, 16, 25, 36, 49, 64, 81]
```

## 7. 高级数据结构

### 7.1 `collections` 模块

`collections` 模块提供了一些有用的高级数据结构：

- `defaultdict`：带有默认值的字典
- `OrderedDict`：有序字典
- `Counter`：计数工具
- `deque`：双端队列
- `namedtuple`：命名元组

**示例**：
```python
from collections import defaultdict, OrderedDict, Counter, deque, namedtuple

# defaultdict
word_counts = defaultdict(int)
words = ["apple", "banana", "apple", "orange", "banana", "apple"]
for word in words:
    word_counts[word] += 1
print(dict(word_counts))  # {'apple': 3, 'banana': 2, 'orange': 1}

# Counter
counter = Counter(words)
print(counter)  # Counter({'apple': 3, 'banana': 2, 'orange': 1})
print(counter.most_common(2))  # [('apple', 3), ('banana', 2)]

# deque
q = deque([1, 2, 3])
q.append(4)  # 添加到末尾
q.appendleft(0)  # 添加到开头
print(q)  # deque([0, 1, 2, 3, 4])
q.pop()  # 从末尾移除
q.popleft()  # 从开头移除
print(q)  # deque([1, 2, 3])

# namedtuple
Point = namedtuple("Point", ["x", "y"])
p = Point(1, 2)
print(p.x, p.y)  # 1 2
print(p)  # Point(x=1, y=2)
```

### 7.2 `heapq` 模块

`heapq` 模块提供了堆队列算法，用于实现优先队列。

**示例**：
```python
import heapq

# 创建最小堆
heap = []
heapq.heappush(heap, 3)
heapq.heappush(heap, 1)
heapq.heappush(heap, 4)
heapq.heappush(heap, 2)
print(heap)  # [1, 2, 4, 3]

# 获取堆顶元素
print(heapq.heappop(heap))  # 1
print(heapq.heappop(heap))  # 2

# 堆排序
numbers = [5, 3, 8, 1, 2, 9]
heapq.heapify(numbers)  # 原地转换为堆
print(numbers)  # [1, 2, 8, 3, 5, 9]

sorted_numbers = [heapq.heappop(numbers) for _ in range(len(numbers))]
print(sorted_numbers)  # [1, 2, 3, 5, 8, 9]
```

### 7.3 `bisect` 模块

`bisect` 模块提供了二分查找算法，用于在有序列表中查找和插入元素。

**示例**：
```python
import bisect

# 有序列表
numbers = [1, 3, 5, 7, 9]

# 查找插入位置
position = bisect.bisect(numbers, 4)
print(position)  # 2

# 插入元素
bisect.insort(numbers, 4)
print(numbers)  # [1, 3, 4, 5, 7, 9]

# 查找元素是否存在
position = bisect.bisect_left(numbers, 5)
if position < len(numbers) and numbers[position] == 5:
    print(f"元素 5 存在于位置 {position}")
else:
    print("元素 5 不存在")
```

## 8. 设计模式

### 8.1 单例模式

单例模式确保一个类只有一个实例，并提供全局访问点。

**示例**：
```python
class Singleton:
    _instance = None
    
    def __new__(cls):
        if cls._instance is None:
            cls._instance = super().__new__(cls)
        return cls._instance
    
    def __init__(self):
        self.value = None

# 测试单例
obj1 = Singleton()
obj2 = Singleton()

print(obj1 is obj2)  # True

obj1.value = 10
print(obj2.value)  # 10
```

### 8.2 工厂模式

工厂模式用于创建对象，隐藏对象创建的细节。

**示例**：
```python
class Shape:
    def draw(self):
        pass

class Circle(Shape):
    def draw(self):
        print("绘制圆形")

class Rectangle(Shape):
    def draw(self):
        print("绘制矩形")

class Triangle(Shape):
    def draw(self):
        print("绘制三角形")

class ShapeFactory:
    @staticmethod
    def create_shape(shape_type):
        if shape_type == "circle":
            return Circle()
        elif shape_type == "rectangle":
            return Rectangle()
        elif shape_type == "triangle":
            return Triangle()
        else:
            raise ValueError(f"不支持的形状类型: {shape_type}")

# 使用工厂创建对象
shape_factory = ShapeFactory()
circle = shape_factory.create_shape("circle")
circle.draw()  # 绘制圆形

rectangle = shape_factory.create_shape("rectangle")
rectangle.draw()  # 绘制矩形
```

### 8.3 观察者模式

观察者模式用于对象间的一对多依赖关系，当一个对象状态改变时，所有依赖它的对象都会得到通知。

**示例**：
```python
class Subject:
    def __init__(self):
        self._observers = []
    
    def attach(self, observer):
        if observer not in self._observers:
            self._observers.append(observer)
    
    def detach(self, observer):
        if observer in self._observers:
            self._observers.remove(observer)
    
    def notify(self, *args, **kwargs):
        for observer in self._observers:
            observer.update(self, *args, **kwargs)

class Observer:
    def update(self, subject, *args, **kwargs):
        pass

class ConcreteObserverA(Observer):
    def update(self, subject, *args, **kwargs):
        print(f"观察者 A 收到通知: {args}, {kwargs}")

class ConcreteObserverB(Observer):
    def update(self, subject, *args, **kwargs):
        print(f"观察者 B 收到通知: {args}, {kwargs}")

# 测试观察者模式
subject = Subject()
observer_a = ConcreteObserverA()
observer_b = ConcreteObserverB()

subject.attach(observer_a)
subject.attach(observer_b)

subject.notify("状态改变", value=10)
# 输出:
# 观察者 A 收到通知: ('状态改变',), {'value': 10}
# 观察者 B 收到通知: ('状态改变',), {'value': 10}

subject.detach(observer_a)
subject.notify("再次改变", value=20)
# 输出:
# 观察者 B 收到通知: ('再次改变',), {'value': 20}
```

## 9. 总结

Python 提供了丰富的高级功能，包括装饰器、上下文管理器、异步编程、元编程、多线程与多进程等。这些高级功能可以帮助开发者编写更加高效、优雅和可维护的代码。

在实际开发中，应根据具体需求选择合适的技术：

- **I/O 密集型任务**：优先使用异步编程或多线程
- **CPU 密集型任务**：优先使用多进程或并行计算库
- **资源管理**：使用上下文管理器确保资源正确释放
- **代码复用和扩展**：使用装饰器和设计模式
- **性能优化**：使用性能分析工具，优化热点代码

通过掌握这些高级功能，可以提高 Python 编程水平，编写更加高效、健壮的应用程序。