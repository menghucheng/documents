# JavaScript ES6 特性

## 1. 概述

ES6（ECMAScript 2015）是 JavaScript 语言的一次重大更新，引入了许多新特性和语法糖，使 JavaScript 代码更加简洁、易读和可维护。ES6 是现代 JavaScript 开发的基础，掌握 ES6 特性对于成为一名优秀的 JavaScript 开发者至关重要。

## 2. 块级作用域

### 2.1 let 声明

`let` 声明用于声明块级作用域的变量，与 `var` 相比，具有以下特点：
- 块级作用域，只在声明的块或函数内有效
- 不能重复声明同一个变量
- 不存在变量提升
- 暂时性死区

```javascript
// 示例 1：块级作用域
function test() {
    if (true) {
        let x = 10;
        console.log(x); // 10
    }
    console.log(x); // ReferenceError: x is not defined
}

// 示例 2：不能重复声明
let y = 10;
let y = 20; // SyntaxError: Identifier 'y' has already been declared

// 示例 3：不存在变量提升
console.log(z); // ReferenceError: Cannot access 'z' before initialization
let z = 30;
```

### 2.2 const 声明

`const` 声明用于声明常量，具有以下特点：
- 块级作用域
- 一旦声明，值不能改变（对于对象和数组，引用不能改变，但内容可以改变）
- 必须初始化
- 不能重复声明

```javascript
// 示例 1：基本使用
const PI = 3.14159;
console.log(PI); // 3.14159
PI = 3.14; // TypeError: Assignment to constant variable.

// 示例 2：对象常量
const person = {
    name: '张三',
    age: 25
};

// 可以修改对象属性
person.age = 26;
console.log(person.age); // 26

// 但不能重新赋值
person = {}; // TypeError: Assignment to constant variable.

// 示例 3：数组常量
const numbers = [1, 2, 3];
numbers.push(4); // 可以修改数组内容
console.log(numbers); // [1, 2, 3, 4]

numbers = [5, 6, 7]; // TypeError: Assignment to constant variable.
```

## 3. 箭头函数

箭头函数提供了一种更简洁的函数声明方式，具有以下特点：
- 更简洁的语法
- 没有自己的 `this`，继承外层作用域的 `this`
- 不能用作构造函数
- 没有 `arguments` 对象
- 不能使用 `yield` 关键字

### 3.1 基本语法

```javascript
// 基本语法
const add = (a, b) => a + b;
console.log(add(1, 2)); // 3

// 单个参数可以省略括号
const square = x => x * x;
console.log(square(5)); // 25

// 无参数需要括号
const sayHello = () => console.log('Hello');
sayHello(); // Hello

// 多行函数体需要大括号和 return
const multiply = (a, b) => {
    const result = a * b;
    return result;
};
console.log(multiply(3, 4)); // 12
```

### 3.2 this 绑定

箭头函数没有自己的 `this`，它会继承外层作用域的 `this`：

```javascript
// 示例 1：普通函数
const obj1 = {
    name: '张三',
    sayHello: function() {
        setTimeout(function() {
            console.log(this.name); // undefined，this 指向 window
        }, 1000);
    }
};
obj1.sayHello();

// 示例 2：箭头函数
const obj2 = {
    name: '李四',
    sayHello: function() {
        setTimeout(() => {
            console.log(this.name); // 李四，继承外层作用域的 this
        }, 1000);
    }
};
obj2.sayHello();
```

## 4. 模板字符串

模板字符串使用反引号（`）包裹，支持插值和多行字符串：

### 4.1 基本使用

```javascript
// 示例 1：插值
const name = '张三';
const age = 25;
const greeting = `你好，我是 ${name}，今年 ${age} 岁。`;
console.log(greeting); // 你好，我是 张三，今年 25 岁。

// 示例 2：多行字符串
const multiLine = `这是第一行
这是第二行
这是第三行`;
console.log(multiLine);
// 这是第一行
// 这是第二行
// 这是第三行

// 示例 3：表达式
const a = 10;
const b = 20;
const result = `${a} + ${b} = ${a + b}`;
console.log(result); // 10 + 20 = 30
```

### 4.2 标签模板

模板字符串可以跟在一个函数名后面，该函数会处理模板字符串：

```javascript
function highlight(strings, ...values) {
    let result = '';
    strings.forEach((string, i) => {
        result += string;
        if (values[i]) {
            result += `<span style="color: red;">${values[i]}</span>`;
        }
    });
    return result;
}

const name = '张三';
const age = 25;
const html = highlight`你好，我是 ${name}，今年 ${age} 岁。`;
console.log(html); // 你好，我是 <span style="color: red;">张三</span>，今年 <span style="color: red;">25</span> 岁。
```

## 5. 解构赋值

解构赋值允许从数组或对象中提取值，并赋值给变量。

### 5.1 数组解构

```javascript
// 示例 1：基本使用
const [a, b, c] = [1, 2, 3];
console.log(a, b, c); // 1 2 3

// 示例 2：跳过元素
const [d, , f] = [4, 5, 6];
console.log(d, f); // 4 6

// 示例 3：默认值
const [g, h = 10, i] = [7, undefined, 9];
console.log(g, h, i); // 7 10 9

// 示例 4：剩余参数
const [j, ...rest] = [10, 20, 30, 40];
console.log(j, rest); // 10 [20, 30, 40]

// 示例 5：交换变量
let x = 1;
let y = 2;
[x, y] = [y, x];
console.log(x, y); // 2 1
```

### 5.2 对象解构

```javascript
// 示例 1：基本使用
const person = {
    name: '张三',
    age: 25,
    city: '北京'
};

const { name, age, city } = person;
console.log(name, age, city); // 张三 25 北京

// 示例 2：重命名变量
const { name: fullName, age: years } = person;
console.log(fullName, years); // 张三 25

// 示例 3：默认值
const { country = '中国' } = person;
console.log(country); // 中国

// 示例 4：剩余参数
const { name: pName, ...otherInfo } = person;
console.log(pName, otherInfo); // 张三 { age: 25, city: '北京' }

// 示例 5：嵌套对象
const user = {
    id: 1,
    info: {
        name: '李四',
        address: {
            city: '上海',
            street: '南京路'
        }
    }
};

const { info: { name: uName, address: { city: uCity } } } = user;
console.log(uName, uCity); // 李四 上海
```

### 5.3 函数参数解构

```javascript
// 示例 1：对象参数解构
function printPerson({ name, age, city = '北京' }) {
    console.log(`${name} 今年 ${age} 岁，住在 ${city}。`);
}

printPerson({ name: '张三', age: 25 }); // 张三 今年 25 岁，住在 北京。
printPerson({ name: '李四', age: 30, city: '上海' }); // 李四 今年 30 岁，住在 上海。

// 示例 2：数组参数解构
function sum([a, b, c]) {
    return a + b + c;
}

console.log(sum([1, 2, 3])); // 6
```

## 6. 扩展运算符

扩展运算符（`...`）允许将数组或对象展开为多个元素。

### 6.1 数组扩展

```javascript
// 示例 1：合并数组
const arr1 = [1, 2, 3];
const arr2 = [4, 5, 6];
const combined = [...arr1, ...arr2];
console.log(combined); // [1, 2, 3, 4, 5, 6]

// 示例 2：复制数组
const original = [1, 2, 3];
const copy = [...original];
console.log(copy); // [1, 2, 3]
console.log(copy === original); // false

// 示例 3：将类数组转换为数组
function printArgs() {
    const args = [...arguments];
    console.log(args);
}

printArgs(1, 2, 3, 4); // [1, 2, 3, 4]

// 示例 4：作为函数参数
const numbers = [1, 2, 3, 4, 5];
console.log(Math.max(...numbers)); // 5
```

### 6.2 对象扩展

```javascript
// 示例 1：合并对象
const obj1 = { a: 1, b: 2 };
const obj2 = { b: 3, c: 4 };
const merged = { ...obj1, ...obj2 };
console.log(merged); // { a: 1, b: 3, c: 4 }

// 示例 2：复制对象
const original = { name: '张三', age: 25 };
const copy = { ...original };
console.log(copy); // { name: '张三', age: 25 }
console.log(copy === original); // false

// 示例 3：添加新属性
const person = { name: '李四' };
const updatedPerson = { ...person, age: 30, city: '北京' };
console.log(updatedPerson); // { name: '李四', age: 30, city: '北京' }
```

## 7. 函数默认参数

ES6 允许为函数参数设置默认值：

```javascript
// 示例 1：基本使用
function greet(name = '匿名', message = '你好') {
    console.log(`${message}，${name}！`);
}

greet(); // 你好，匿名！
greet('张三'); // 你好，张三！
greet('李四', '欢迎'); // 欢迎，李四！

// 示例 2：默认参数与解构结合
function createPerson(name, { age = 18, city = '北京' } = {}) {
    return {
        name,
        age,
        city
    };
}

console.log(createPerson('张三')); // { name: '张三', age: 18, city: '北京' }
console.log(createPerson('李四', { age: 25 })); // { name: '李四', age: 25, city: '北京' }
console.log(createPerson('王五', { city: '上海' })); // { name: '王五', age: 18, city: '上海' }
```

## 8. 剩余参数

剩余参数（`...`）允许函数接收任意数量的参数，并将它们放入一个数组中：

```javascript
// 示例 1：基本使用
function sum(...numbers) {
    return numbers.reduce((total, num) => total + num, 0);
}

console.log(sum(1, 2)); // 3
console.log(sum(1, 2, 3, 4)); // 10
console.log(sum(1, 2, 3, 4, 5)); // 15

// 示例 2：与普通参数结合
function greet(firstName, ...restNames) {
    console.log(`你好，${firstName} 和 ${restNames.join('、')}！`);
}

greet('张三', '李四', '王五'); // 你好，张三 和 李四、王五！

// 示例 3：箭头函数中的剩余参数
const multiply = (...numbers) => {
    return numbers.reduce((product, num) => product * num, 1);
};

console.log(multiply(2, 3)); // 6
console.log(multiply(2, 3, 4)); // 24
```

## 9. 字符串方法

ES6 为字符串添加了一些新方法：

### 9.1 includes()

检查字符串是否包含指定的子字符串：

```javascript
const str = 'Hello, world!';
console.log(str.includes('world')); // true
console.log(str.includes('World')); // false
console.log(str.includes('o', 5)); // true（从索引 5 开始搜索）
```

### 9.2 startsWith()

检查字符串是否以指定的子字符串开头：

```javascript
const str = 'Hello, world!';
console.log(str.startsWith('Hello')); // true
console.log(str.startsWith('world')); // false
console.log(str.startsWith('world', 7)); // true（从索引 7 开始检查）
```

### 9.3 endsWith()

检查字符串是否以指定的子字符串结尾：

```javascript
const str = 'Hello, world!';
console.log(str.endsWith('!')); // true
console.log(str.endsWith('world')); // false
console.log(str.endsWith('world', 12)); // true（检查前 12 个字符是否以 'world' 结尾）
```

### 9.4 repeat()

返回一个新字符串，表示将原字符串重复指定次数：

```javascript
const str = 'abc';
console.log(str.repeat(3)); // abcabcabc
console.log(str.repeat(0)); // 空字符串
console.log(str.repeat(1.5)); // abcabc（小数会被向下取整）
```

## 10. 数组方法

ES6 为数组添加了一些新方法：

### 10.1 Array.from()

将类数组对象或可迭代对象转换为数组：

```javascript
// 示例 1：类数组对象
const arrayLike = {
    0: 'a',
    1: 'b',
    2: 'c',
    length: 3
};

const arr1 = Array.from(arrayLike);
console.log(arr1); // ['a', 'b', 'c']

// 示例 2：字符串
const str = 'hello';
const arr2 = Array.from(str);
console.log(arr2); // ['h', 'e', 'l', 'l', 'o']

// 示例 3：Set 对象
const set = new Set(['x', 'y', 'z']);
const arr3 = Array.from(set);
console.log(arr3); // ['x', 'y', 'z']

// 示例 4：映射函数
const arr4 = Array.from([1, 2, 3], x => x * 2);
console.log(arr4); // [2, 4, 6]
```

### 10.2 Array.of()

创建一个包含任意数量参数的数组：

```javascript
console.log(Array.of(1, 2, 3)); // [1, 2, 3]
console.log(Array.of(0)); // [0]
console.log(Array.of()); // []
```

### 10.3 find()

返回数组中第一个满足条件的元素：

```javascript
const numbers = [10, 20, 30, 40, 50];
const result = numbers.find(num => num > 25);
console.log(result); // 30
```

### 10.4 findIndex()

返回数组中第一个满足条件的元素的索引：

```javascript
const numbers = [10, 20, 30, 40, 50];
const index = numbers.findIndex(num => num > 25);
console.log(index); // 2
```

### 10.5 fill()

用指定值填充数组的所有元素：

```javascript
// 示例 1：基本使用
const arr1 = [1, 2, 3, 4, 5];
arr1.fill(0);
console.log(arr1); // [0, 0, 0, 0, 0]

// 示例 2：指定起始位置
const arr2 = [1, 2, 3, 4, 5];
arr2.fill(0, 2);
console.log(arr2); // [1, 2, 0, 0, 0]

// 示例 3：指定起始和结束位置
const arr3 = [1, 2, 3, 4, 5];
arr3.fill(0, 1, 4);
console.log(arr3); // [1, 0, 0, 0, 5]
```

### 10.6 includes()

检查数组是否包含指定元素：

```javascript
const numbers = [1, 2, 3, 4, 5];
console.log(numbers.includes(3)); // true
console.log(numbers.includes(6)); // false
console.log(numbers.includes(3, 3)); // false（从索引 3 开始搜索）
```

## 11. 类

ES6 引入了类（Class）语法，使 JavaScript 可以更像传统面向对象语言一样定义类：

### 11.1 基本语法

```javascript
// 示例 1：基本类定义
class Person {
    // 构造函数
    constructor(name, age) {
        this.name = name;
        this.age = age;
    }
    
    // 实例方法
    sayHello() {
        console.log(`你好，我是 ${this.name}，今年 ${this.age} 岁。`);
    }
    
    // 静态方法
    static createPerson(name, age) {
        return new Person(name, age);
    }
}

// 创建实例
const person1 = new Person('张三', 25);
person1.sayHello(); // 你好，我是 张三，今年 25 岁。

// 使用静态方法创建实例
const person2 = Person.createPerson('李四', 30);
person2.sayHello(); // 你好，我是 李四，今年 30 岁。
```

### 11.2 继承

使用 `extends` 关键字实现类的继承：

```javascript
// 父类
class Animal {
    constructor(name) {
        this.name = name;
    }
    
    eat() {
        console.log(`${this.name} 在吃东西。`);
    }
}

// 子类
class Dog extends Animal {
    constructor(name, breed) {
        super(name); // 调用父类构造函数
        this.breed = breed;
    }
    
    bark() {
        console.log(`${this.name} 在汪汪叫。`);
    }
    
    // 重写父类方法
    eat() {
        super.eat(); // 调用父类方法
        console.log(`${this.name} 喜欢吃肉。`);
    }
}

// 创建实例
const dog = new Dog('小白', '金毛');
dog.eat(); // 小白 在吃东西。小白 喜欢吃肉。
dog.bark(); // 小白 在汪汪叫。
```

### 11.3 getter 和 setter

使用 `get` 和 `set` 关键字定义属性的 getter 和 setter：

```javascript
class Person {
    constructor(firstName, lastName) {
        this.firstName = firstName;
        this.lastName = lastName;
    }
    
    // getter
    get fullName() {
        return `${this.firstName} ${this.lastName}`;
    }
    
    // setter
    set fullName(name) {
        const [firstName, lastName] = name.split(' ');
        this.firstName = firstName;
        this.lastName = lastName;
    }
}

const person = new Person('张', '三');
console.log(person.fullName); // 张 三

person.fullName = '李 四';
console.log(person.firstName); // 李
console.log(person.lastName); // 四
```

## 12. 模块

ES6 引入了模块化系统，允许将代码分割为独立的模块，并通过 `import` 和 `export` 关键字进行模块间的导入和导出。

### 12.1 导出

#### 12.1.1 命名导出

```javascript
// module.js

// 导出变量
export const PI = 3.14159;

// 导出函数
export function add(a, b) {
    return a + b;
}

// 导出类
export class Person {
    constructor(name) {
        this.name = name;
    }
}

// 导出多个
export { PI as PI_VALUE, add as sum };
```

#### 12.1.2 默认导出

```javascript
// module.js

// 默认导出函数
export default function multiply(a, b) {
    return a * b;
}

// 默认导出类
export default class Person {
    constructor(name) {
        this.name = name;
    }
}

// 默认导出对象
export default {
    name: '张三',
    age: 25
};
```

### 12.2 导入

#### 12.2.1 导入命名导出

```javascript
// app.js

// 导入单个
import { add } from './module.js';
console.log(add(1, 2)); // 3

// 导入多个
import { add, PI, Person } from './module.js';

// 重命名导入
import { add as sum, PI as PI_VALUE } from './module.js';

// 导入所有
import * as math from './module.js';
console.log(math.PI); // 3.14159
console.log(math.add(1, 2)); // 3
```

#### 12.2.2 导入默认导出

```javascript
// app.js

// 基本导入
import multiply from './module.js';
console.log(multiply(2, 3)); // 6

// 重命名导入
import calcMultiply from './module.js';

// 混合导入（默认导出 + 命名导出）
import multiply, { add, PI } from './module.js';
```

## 13. Promise

Promise 是异步编程的一种解决方案，用于处理异步操作：

### 13.1 基本语法

```javascript
// 示例 1：创建 Promise
const promise = new Promise((resolve, reject) => {
    // 异步操作
    setTimeout(() => {
        const success = true;
        if (success) {
            resolve('操作成功');
        } else {
            reject('操作失败');
        }
    }, 1000);
});

// 示例 2：使用 Promise
promise
    .then(result => {
        console.log(result); // 操作成功
    })
    .catch(error => {
        console.error(error); // 操作失败
    });

// 示例 3：链式调用
const promise2 = new Promise((resolve, reject) => {
    setTimeout(() => {
        resolve(10);
    }, 500);
});

promise2
    .then(result => {
        console.log(result); // 10
        return result * 2;
    })
    .then(result => {
        console.log(result); // 20
        return result * 3;
    })
    .then(result => {
        console.log(result); // 60
    });
```

### 13.2 Promise 方法

#### 13.2.1 Promise.all()

当所有 Promise 都成功时才会成功，否则失败：

```javascript
const promise1 = Promise.resolve(1);
const promise2 = Promise.resolve(2);
const promise3 = Promise.resolve(3);

Promise.all([promise1, promise2, promise3])
    .then(results => {
        console.log(results); // [1, 2, 3]
    })
    .catch(error => {
        console.error(error);
    });
```

#### 13.2.2 Promise.race()

返回第一个完成的 Promise 的结果：

```javascript
const promise1 = new Promise((resolve) => setTimeout(resolve, 100, '第一个'));
const promise2 = new Promise((resolve) => setTimeout(resolve, 50, '第二个'));

Promise.race([promise1, promise2])
    .then(result => {
        console.log(result); // 第二个
    });
```

#### 13.2.3 Promise.allSettled()

返回所有 Promise 的结果，无论成功或失败：

```javascript
const promise1 = Promise.resolve(1);
const promise2 = Promise.reject('错误');
const promise3 = Promise.resolve(3);

Promise.allSettled([promise1, promise2, promise3])
    .then(results => {
        console.log(results);
        // [
        //   { status: 'fulfilled', value: 1 },
        //   { status: 'rejected', reason: '错误' },
        //   { status: 'fulfilled', value: 3 }
        // ]
    });
```

#### 13.2.4 Promise.any()

返回第一个成功的 Promise 的结果，如果所有都失败则返回 AggregateError：

```javascript
const promise1 = Promise.reject('错误1');
const promise2 = Promise.reject('错误2');
const promise3 = Promise.resolve(3);

Promise.any([promise1, promise2, promise3])
    .then(result => {
        console.log(result); // 3
    });
```

## 14. 异步函数

异步函数（async/await）是基于 Promise 的语法糖，使异步代码看起来更像同步代码：

### 14.1 基本语法

```javascript
// 示例 1：基本使用
async function fetchData() {
    return '数据';
}

fetchData().then(result => {
    console.log(result); // 数据
});

// 示例 2：await 关键字
function delay(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

async function countDown() {
    for (let i = 3; i > 0; i--) {
        console.log(i);
        await delay(1000);
    }
    console.log('倒计时结束！');
}

countDown(); // 3 2 1 倒计时结束！

// 示例 3：错误处理
async function fetchUser() {
    try {
        const response = await fetch('https://api.example.com/users/1');
        const user = await response.json();
        console.log(user);
    } catch (error) {
        console.error('获取用户失败：', error);
    }
}

fetchUser();
```

### 14.2 并行执行

使用 `Promise.all()` 实现异步函数的并行执行：

```javascript
async function fetchAllData() {
    const [user, posts, comments] = await Promise.all([
        fetch('https://api.example.com/users/1').then(res => res.json()),
        fetch('https://api.example.com/posts').then(res => res.json()),
        fetch('https://api.example.com/comments').then(res => res.json())
    ]);
    
    console.log(user, posts, comments);
}

fetchAllData();
```

## 15. 其他特性

### 15.1 Symbol

Symbol 是一种新的原始数据类型，表示独一无二的值：

```javascript
// 示例 1：基本使用
const sym1 = Symbol();
const sym2 = Symbol('description');
const sym3 = Symbol('description');

console.log(sym1); // Symbol()
console.log(sym2); // Symbol(description)
console.log(sym2 === sym3); // false（每个 Symbol 都是唯一的）

// 示例 2：作为对象属性
const person = {
    [Symbol('name')]: '张三',
    age: 25
};

// Symbol 属性不会出现在 for...in 循环中
for (let key in person) {
    console.log(key); // 只输出 age
}

// 使用 Object.getOwnPropertySymbols() 获取 Symbol 属性
const symbols = Object.getOwnPropertySymbols(person);
console.log(person[symbols[0]]); // 张三
```

### 15.2 Set 和 Map

#### 15.2.1 Set

Set 是一种数据结构，用于存储唯一值：

```javascript
// 示例 1：基本使用
const set = new Set();
set.add(1);
set.add(2);
set.add(2); // 重复值不会被添加
set.add('hello');
set.add({ name: '张三' });

console.log(set.size); // 4
console.log(set.has(1)); // true
set.delete(1);
console.log(set.has(1)); // false

// 示例 2：遍历 Set
for (let item of set) {
    console.log(item); // 2, 'hello', { name: '张三' }
}

// 示例 3：转换为数组
const array = Array.from(set);
console.log(array); // [2, 'hello', { name: '张三' }]
```

#### 15.2.2 Map

Map 是一种键值对数据结构，键可以是任意类型：

```javascript
// 示例 1：基本使用
const map = new Map();
const key1 = 'string';
const key2 = 123;
const key3 = { id: 1 };
const key4 = function() {};

map.set(key1, '字符串值');
map.set(key2, '数字值');
map.set(key3, '对象值');
map.set(key4, '函数值');

console.log(map.size); // 4
console.log(map.get(key1)); // 字符串值
console.log(map.has(key3)); // true
map.delete(key2);

// 示例 2：遍历 Map
for (let [key, value] of map) {
    console.log(key, value);
}

// 示例 3：转换为数组
const array = Array.from(map);
console.log(array); // [['string', '字符串值'], [{ id: 1 }, '对象值'], [function() {}, '函数值']]
```

### 15.3 迭代器和生成器

#### 15.3.1 迭代器

迭代器是一种接口，用于遍历数据结构：

```javascript
// 示例 1：基本迭代器
const iterable = {
    [Symbol.iterator]() {
        let count = 0;
        return {
            next() {
                count++;
                if (count <= 3) {
                    return {
                        value: count,
                        done: false
                    };
                } else {
                    return {
                        value: undefined,
                        done: true
                    };
                }
            }
        };
    }
};

for (let value of iterable) {
    console.log(value); // 1, 2, 3
}

// 示例 2：自定义类实现迭代器
class Range {
    constructor(start, end) {
        this.start = start;
        this.end = end;
    }
    
    [Symbol.iterator]() {
        let current = this.start;
        const end = this.end;
        return {
            next() {
                if (current <= end) {
                    return {
                        value: current++,
                        done: false
                    };
                } else {
                    return {
                        value: undefined,
                        done: true
                    };
                }
            }
        };
    }
}

for (let num of new Range(1, 5)) {
    console.log(num); // 1, 2, 3, 4, 5
}
```

#### 15.3.2 生成器

生成器是一种特殊的迭代器，使用 `function*` 语法定义：

```javascript
// 示例 1：基本生成器
function* generator() {
    yield 1;
    yield 2;
    yield 3;
    return 4;
}

const gen = generator();
console.log(gen.next()); // { value: 1, done: false }
console.log(gen.next()); // { value: 2, done: false }
console.log(gen.next()); // { value: 3, done: false }
console.log(gen.next()); // { value: 4, done: true }

// 示例 2：生成器函数
function* fibonacci(n) {
    let a = 0;
    let b = 1;
    for (let i = 0; i < n; i++) {
        yield a;
        [a, b] = [b, a + b];
    }
}

for (let num of fibonacci(5)) {
    console.log(num); // 0, 1, 1, 2, 3
}

// 示例 3：无限生成器
function* infiniteCounter() {
    let count = 0;
    while (true) {
        yield count++;
    }
}

const counter = infiniteCounter();
console.log(counter.next().value); // 0
console.log(counter.next().value); // 1
console.log(counter.next().value); // 2
```

## 16. 总结

ES6 引入了许多新特性，使 JavaScript 代码更加简洁、易读和可维护。本文介绍了 ES6 的主要特性，包括：

1. 块级作用域（let/const）
2. 箭头函数
3. 模板字符串
4. 解构赋值
5. 扩展运算符
6. 函数默认参数
7. 剩余参数
8. 字符串方法
9. 数组方法
10. 类
11. 模块
12. Promise
13. 异步函数
14. 其他特性（Symbol, Set, Map, 迭代器和生成器）

掌握这些特性对于成为一名现代 JavaScript 开发者至关重要。通过合理使用这些特性，可以编写更高效、更易维护的代码，提高开发效率和代码质量。