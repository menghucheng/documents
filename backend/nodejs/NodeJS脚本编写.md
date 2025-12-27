# Node.js 脚本编写

## 1. 脚本基本结构

### 1.1 脚本文件格式
- Node.js 脚本文件扩展名为 `.js`
- 脚本第一行通常是 shebang 行，指定解释器（Linux/macOS）：
  ```javascript
  #!/usr/bin/env node
  ```
- **中文编码处理**：Node.js 默认支持 UTF-8 编码，无需额外设置

### 1.2 脚本注释
- 单行注释：使用 `//` 开头
- 多行注释：使用 `/* */` 包裹
- JSDoc 注释：用于生成文档的结构化注释

```javascript
// 这是单行注释

/*
这是多行注释
可以包含多行内容
*/

/**
 * 这是 JSDoc 注释
 * @param {string} name - 姓名
 * @param {number} age - 年龄
 * @returns {string} - 问候语
 */
function greet(name, age) {
    return `你好，${name}！你今年 ${age} 岁了。`;
}
```

### 1.3 脚本执行方式
1. 直接执行（需要执行权限）：
   ```bash
   ./脚本名.js
   ```
2. 通过 Node.js 解释器执行：
   ```bash
   node 脚本名.js
   ```
3. 使用 npx 执行（适用于局部安装的包）：
   ```bash
   npx 脚本名.js
   ```

## 2. 变量和数据类型

### 2.1 变量声明
Node.js 支持 ES6+ 语法，变量声明可以使用 `var`、`let` 或 `const`：

```javascript
// 基本变量声明
let name = "张三";  // 可变变量
const age = 25;  // 常量
var isStudent = true;  // 函数作用域变量（不推荐使用）

// 变量赋值
const number = 10 + 5;  // 结果为 15
const greeting = `Hello, ${name}`;  // 结果为 "Hello, 张三"
```

### 2.2 数据类型
JavaScript 支持多种数据类型：

| 数据类型 | 示例 | 说明 |
|---------|------|------|
| 字符串 | `"Hello"` | 文本数据 |
| 数字 | `123` 或 `3.14` | 整数或浮点数 |
| 布尔值 | `true`/`false` | 真/假 |
| 数组 | `[1, 2, 3]` | 有序可变集合 |
| 对象 | `{name: "张三", age: 25}` | 键值对集合 |
| null | `null` | 空值 |
| undefined | `undefined` | 未定义的值 |
| Symbol | `Symbol("id")` | 唯一标识符 |
| BigInt | `123n` | 大整数 |

## 3. 流程控制

### 3.1 条件语句

#### 3.1.1 if-else 语句
```javascript
const score = 85;

if (score >= 90) {
    console.log("优秀");
} else if (score >= 80) {
    console.log("良好");
} else if (score >= 60) {
    console.log("及格");
} else {
    console.log("不及格");
}
```

#### 3.1.2 条件表达式（三元运算符）
```javascript
const result = score >= 60 ? "及格" : "不及格";
console.log(result);
```

#### 3.1.3 switch 语句
```javascript
const day = "Monday";

switch (day) {
    case "Monday":
        console.log("星期一");
        break;
    case "Tuesday":
        console.log("星期二");
        break;
    default:
        console.log("其他星期");
}
```

### 3.2 循环结构

#### 3.2.1 for 循环
```javascript
// 打印 1 到 5
for (let i = 1; i <= 5; i++) {
    console.log(`数字：${i}`);
}

// 遍历数组
const fruits = ["苹果", "香蕉", "橘子"];
for (let i = 0; i < fruits.length; i++) {
    console.log(`水果：${fruits[i]}`);
}

// for...of 循环（ES6+）
for (const fruit of fruits) {
    console.log(`水果：${fruit}`);
}
```

#### 3.2.2 while 循环
```javascript
// 打印 1 到 5
let i = 1;
while (i <= 5) {
    console.log(`数字：${i}`);
    i++;
}
```

#### 3.2.3 do-while 循环
```javascript
// 至少执行一次
let j = 1;
do {
    console.log(`数字：${j}`);
    j++;
} while (j <= 5);
```

#### 3.2.4 循环控制语句
- `break`：退出当前循环
- `continue`：跳过当前循环的剩余部分，继续下一次循环

```javascript
for (let i = 1; i < 10; i++) {
    if (i === 5) {
        break;  // 退出循环
    }
    if (i % 2 === 0) {
        continue;  // 跳过偶数
    }
    console.log(i);
}
```

## 4. 函数

### 4.1 函数定义
```javascript
// 函数声明
function add(a, b) {
    return a + b;
}

// 函数表达式
const multiply = function(a, b) {
    return a * b;
};

// 箭头函数（ES6+）
const subtract = (a, b) => {
    return a - b;
};

// 简化箭头函数
const divide = (a, b) => a / b;
```

### 4.2 带参数的函数
```javascript
// 带默认参数（ES6+）
function greet(name, age = 18) {
    console.log(`你好，${name}！你今年 ${age} 岁了。`);
}

// 调用函数
greet("张三", 25);
greet("李四");  // 使用默认年龄 18

// 带剩余参数（ES6+）
function sum(...numbers) {
    return numbers.reduce((total, num) => total + num, 0);
}

console.log(sum(1, 2, 3, 4, 5));  // 输出：15
```

### 4.3 异步函数
使用 `async` 和 `await` 处理异步操作（ES2017+）：

```javascript
// 异步函数
async function fetchData(url) {
    try {
        const response = await fetch(url);
        const data = await response.json();
        return data;
    } catch (error) {
        console.error("获取数据失败：", error);
        throw error;
    }
}

// 调用异步函数
fetchData("https://api.example.com/data")
    .then(data => console.log("数据：", data))
    .catch(error => console.error("错误：", error));
```

## 5. 错误处理

### 5.1 try-catch-finally
```javascript
try {
    // 可能出错的代码
    const result = 10 / 0;
} catch (error) {
    // 捕获错误
    console.error("发生错误：", error.message);
} finally {
    // 无论是否出错都会执行
    console.log("操作完成");
}
```

### 5.2 抛出异常
```javascript
function checkAge(age) {
    if (age < 0 || age > 120) {
        throw new Error("年龄必须在 0 到 120 之间");
    }
    return `年龄有效：${age}`;
}

try {
    const result = checkAge(150);
    console.log(result);
} catch (error) {
    console.error("错误：", error.message);
}
```

## 6. 命令行参数处理

### 6.1 使用 process.argv
`process.argv` 是一个数组，包含 Node.js 执行路径、脚本路径和所有命令行参数：

```javascript
// 基本命令行参数处理
console.log(`脚本路径：${process.argv[0]}`);
console.log(`脚本名称：${process.argv[1]}`);
console.log(`参数数量：${process.argv.length - 2}`);
console.log(`所有参数：${process.argv.slice(2)}`);

// 访问单个参数
if (process.argv.length > 2) {
    const name = process.argv[2];
    console.log(`你好，${name}！`);
}
```

执行方式：
```bash
node 脚本名.js 张三 25
```

### 6.2 使用 yargs（推荐）
`yargs` 是一个功能强大的命令行参数解析库，支持选项参数、位置参数、帮助信息等：

#### 6.2.1 安装 yargs
```bash
npm install yargs
```

#### 6.2.2 使用 yargs
```javascript
const yargs = require('yargs');

// 配置命令行参数
const argv = yargs
    .command('greet', '打招呼', (yargs) => {
        yargs
            .option('name', {
                alias: 'n',
                describe: '姓名',
                type: 'string',
                demandOption: true
            })
            .option('age', {
                alias: 'a',
                describe: '年龄',
                type: 'number',
                default: 18
            });
    })
    .help()
    .alias('help', 'h')
    .alias('version', 'v')
    .parse();

// 使用参数
if (argv._[0] === 'greet') {
    console.log(`你好，${argv.name}！你今年 ${argv.age} 岁了。`);
}
```

执行方式：
```bash
node 脚本名.js greet --name 张三 --age 25
node 脚本名.js greet -n 李四  # 使用默认年龄
node 脚本名.js --help  # 显示帮助信息
```

### 6.3 使用 commander（推荐）
`commander` 是另一个流行的命令行参数解析库，API 简洁易用：

#### 6.3.1 安装 commander
```bash
npm install commander
```

#### 6.3.2 使用 commander
```javascript
const { Command } = require('commander');

const program = new Command();

// 配置命令行参数
program
    .name('greet')
    .description('打招呼脚本')
    .version('1.0.0')
    .option('-n, --name <string>', '姓名', '')
    .option('-a, --age <number>', '年龄', 18)
    .parse(process.argv);

const options = program.opts();

// 使用参数
console.log(`你好，${options.name || '陌生人'}！你今年 ${options.age} 岁了。`);
```

执行方式：
```bash
node 脚本名.js -n 张三 -a 25
node 脚本名.js --name 李四  # 使用默认年龄
node 脚本名.js --help  # 显示帮助信息
```

## 7. 用户输入处理

### 7.1 使用 readline 模块
`readline` 是 Node.js 内置模块，用于处理命令行输入输出：

```javascript
const readline = require('readline');

// 创建 readline 接口
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

// 基本输入
rl.question('请输入你的姓名：', (name) => {
    console.log(`你好，${name}！`);
    rl.close();
});

// 多次输入
const questions = [
    '请输入你的姓名：',
    '请输入你的年龄：',
    '请输入你的城市：'
];

const answers = [];

function askQuestion(index) {
    rl.question(questions[index], (answer) => {
        answers.push(answer);
        if (index < questions.length - 1) {
            askQuestion(index + 1);
        } else {
            console.log(`\n你好，${answers[0]}！你今年 ${answers[1]} 岁，来自 ${answers[2]}。`);
            rl.close();
        }
    });
}

askQuestion(0);
```

### 7.2 使用 inquirer（推荐）
`inquirer` 是一个功能丰富的交互式命令行工具，支持多种输入类型：

#### 7.2.1 安装 inquirer
```bash
npm install inquirer
```

#### 7.2.2 使用 inquirer
```javascript
const inquirer = require('inquirer');

// 配置问题
const questions = [
    {
        type: 'input',
        name: 'name',
        message: '请输入你的姓名：',
        validate: (value) => {
            if (value.trim()) {
                return true;
            }
            return '姓名不能为空';
        }
    },
    {
        type: 'number',
        name: 'age',
        message: '请输入你的年龄：',
        validate: (value) => {
            if (value >= 0 && value <= 120) {
                return true;
            }
            return '年龄必须在 0 到 120 之间';
        }
    },
    {
        type: 'list',
        name: 'gender',
        message: '请选择你的性别：',
        choices: ['男', '女', '其他']
    },
    {
        type: 'confirm',
        name: 'isStudent',
        message: '你是学生吗？',
        default: false
    }
];

// 执行交互
inquirer.prompt(questions).then((answers) => {
    console.log('\n你的信息：');
    console.log(`姓名：${answers.name}`);
    console.log(`年龄：${answers.age}`);
    console.log(`性别：${answers.gender}`);
    console.log(`是否是学生：${answers.isStudent ? '是' : '否'}`);
});
```

### 7.3 密码输入（隐藏输入）
```javascript
const inquirer = require('inquirer');

inquirer.prompt([
    {
        type: 'password',
        name: 'password',
        message: '请输入密码：',
        mask: '*'  // 使用 * 隐藏输入
    }
]).then((answers) => {
    console.log(`你输入的密码是：${answers.password}`);
});
```

## 8. 文件操作

### 8.1 使用 fs 模块
`fs` 是 Node.js 内置模块，用于文件系统操作：

#### 8.1.1 读取文件
```javascript
const fs = require('fs');

// 同步读取文件
try {
    const content = fs.readFileSync('test.txt', 'utf8');
    console.log(content);
} catch (error) {
    console.error('读取文件失败：', error.message);
}

// 异步读取文件
fs.readFile('test.txt', 'utf8', (error, content) => {
    if (error) {
        console.error('读取文件失败：', error.message);
        return;
    }
    console.log(content);
});

// 流式读取大文件
const readStream = fs.createReadStream('large_file.txt', 'utf8');

readStream.on('data', (chunk) => {
    console.log('读取到数据：', chunk);
});

readStream.on('end', () => {
    console.log('文件读取完成');
});

readStream.on('error', (error) => {
    console.error('读取文件失败：', error.message);
});
```

#### 8.1.2 写入文件
```javascript
const fs = require('fs');

// 同步写入文件（覆盖）
try {
    fs.writeFileSync('output.txt', '这是写入的内容', 'utf8');
    console.log('文件写入成功');
} catch (error) {
    console.error('文件写入失败：', error.message);
}

// 异步写入文件（覆盖）
fs.writeFile('output.txt', '这是写入的内容', 'utf8', (error) => {
    if (error) {
        console.error('文件写入失败：', error.message);
        return;
    }
    console.log('文件写入成功');
});

// 异步追加写入
fs.appendFile('output.txt', '\n这是追加的内容', 'utf8', (error) => {
    if (error) {
        console.error('文件追加失败：', error.message);
        return;
    }
    console.log('文件追加成功');
});

// 流式写入文件
const writeStream = fs.createWriteStream('output.txt', 'utf8');

writeStream.write('这是第一行\n');
writeStream.write('这是第二行\n');
writeStream.end();

writeStream.on('finish', () => {
    console.log('文件写入完成');
});

writeStream.on('error', (error) => {
    console.error('文件写入失败：', error.message);
});
```

## 9. 中文编码处理

### 9.1 文件编码
Node.js 默认使用 UTF-8 编码，在读取和写入文件时，明确指定编码为 UTF-8 即可：

```javascript
const fs = require('fs');

// 读取文件时指定编码
fs.readFile('test.txt', 'utf8', (error, content) => {
    if (error) {
        console.error('读取文件失败：', error.message);
        return;
    }
    console.log(content);
});

// 写入文件时指定编码
fs.writeFile('output.txt', '中文内容', 'utf8', (error) => {
    if (error) {
        console.error('写入文件失败：', error.message);
        return;
    }
    console.log('文件写入成功');
});
```

### 9.2 终端编码
在 Windows 终端中，可能需要设置终端编码为 UTF-8：

```bash
# 在 PowerShell 中设置 UTF-8 编码
chcp 65001
```

### 9.3 字符串编码转换
如果需要处理其他编码的文件，可以使用 `iconv-lite` 库：

#### 9.3.1 安装 iconv-lite
```bash
npm install iconv-lite
```

#### 9.3.2 使用 iconv-lite
```javascript
const fs = require('fs');
const iconv = require('iconv-lite');

// 读取 GBK 编码的文件
const buffer = fs.readFileSync('gbk_file.txt');
const content = iconv.decode(buffer, 'gbk');
console.log(content);

// 写入 GBK 编码的文件
const gbkBuffer = iconv.encode('中文内容', 'gbk');
fs.writeFileSync('gbk_output.txt', gbkBuffer);
```

## 10. 模块系统

### 10.1 CommonJS 模块（默认）
Node.js 默认使用 CommonJS 模块系统，使用 `require()` 和 `module.exports`：

#### 10.1.1 创建模块
创建一个名为 `utils.js` 的文件：
```javascript
// utils.js

// 导出单个函数
const add = (a, b) => a + b;
const multiply = (a, b) => a * b;

// 导出方式 1
module.exports = {
    add,
    multiply
};

// 导出方式 2
// module.exports.add = add;
// module.exports.multiply = multiply;
```

#### 10.1.2 使用模块
```javascript
// app.js

// 导入模块
const utils = require('./utils');

// 使用模块中的函数
console.log(utils.add(10, 5));  // 输出：15
console.log(utils.multiply(10, 5));  // 输出：50

// 解构导入
const { add, multiply } = require('./utils');
console.log(add(10, 5));  // 输出：15
```

### 10.2 ES 模块（ES6+）
Node.js 12+ 支持 ES 模块，使用 `import` 和 `export`：

#### 10.2.1 配置 ES 模块
在 `package.json` 中添加：
```json
{
    "type": "module"
}
```

或使用 `.mjs` 扩展名。

#### 10.2.2 创建 ES 模块
创建一个名为 `utils.mjs` 的文件：
```javascript
// utils.mjs

// 导出单个函数
export const add = (a, b) => a + b;
export const multiply = (a, b) => a * b;

// 导出默认值
export default {
    add,
    multiply
};
```

#### 10.2.3 使用 ES 模块
```javascript
// app.mjs

// 导入默认值
import utils from './utils.mjs';
console.log(utils.add(10, 5));  // 输出：15

// 导入命名导出
import { add, multiply } from './utils.mjs';
console.log(add(10, 5));  // 输出：15
console.log(multiply(10, 5));  // 输出：50
```

## 11. 脚本最佳实践

### 11.1 命名规范
- 脚本名：使用小写字母和连字符，如 `file-backup.js`
- 变量名：使用驼峰命名法，如 `backupPath`
- 函数名：使用驼峰命名法，如 `backupFiles()`
- 类名：使用 PascalCase，如 `FileBackup`
- 常量名：使用全大写，如 `MAX_RETRY_COUNT = 5`

### 11.2 代码结构
```javascript
#!/usr/bin/env node

/**
 * 脚本描述
 * 脚本功能说明
 */

// 导入模块
const fs = require('fs');
const path = require('path');
const yargs = require('yargs');

// 定义常量
const MAX_RETRY_COUNT = 5;
const DEFAULT_OUTPUT_DIR = './output';

// 定义函数
/**
 * 函数描述
 * @param {string} param1 - 参数1描述
 * @param {number} param2 - 参数2描述
 * @returns {boolean} - 返回值描述
 */
function function1(param1, param2) {
    // 函数体
    return true;
}

/**
 * 主函数
 */
function main() {
    // 解析命令行参数
    // 执行主要逻辑
}

// 执行主函数
if (require.main === module) {
    main();
}

// 导出模块
module.exports = {
    function1
};
```

### 11.3 错误处理
- 始终使用 `try-catch` 处理可能的错误
- 提供清晰的错误信息
- 使用 `process.exit(code)` 表示脚本执行结果
- 记录错误日志

### 11.4 日志记录
使用 `winston` 或 `pino` 等日志库记录日志：

#### 11.4.1 安装 winston
```bash
npm install winston
```

#### 11.4.2 使用 winston
```javascript
const winston = require('winston');

// 配置日志
const logger = winston.createLogger({
    level: 'info',
    format: winston.format.combine(
        winston.format.timestamp(),
        winston.format.printf(info => `${info.timestamp} ${info.level}: ${info.message}`)
    ),
    transports: [
        new winston.transports.Console(),
        new winston.transports.File({ filename: 'app.log' })
    ]
});

// 使用日志
logger.info('程序开始执行');
try {
    // 可能出错的代码
    const result = 10 / 0;
    logger.info(`结果：${result}`);
} catch (error) {
    logger.error(`发生错误：${error.message}`);
    process.exit(1);
}
logger.info('程序执行完成');
```

### 11.5 环境变量
使用 `.env` 文件管理环境变量，配合 `dotenv` 库使用：

#### 11.5.1 安装 dotenv
```bash
npm install dotenv
```

#### 11.5.2 使用 dotenv
创建一个名为 `.env` 的文件：
```env
# .env
PORT=3000
DATABASE_URL=mongodb://localhost:27017/mydb
API_KEY=your_api_key
```

在脚本中使用：
```javascript
require('dotenv').config();

// 访问环境变量
const port = process.env.PORT || 3000;
const databaseUrl = process.env.DATABASE_URL;
const apiKey = process.env.API_KEY;

console.log(`端口：${port}`);
console.log(`数据库 URL：${databaseUrl}`);
console.log(`API 密钥：${apiKey}`);
```

## 12. 示例脚本

### 12.1 文件备份脚本
```javascript
#!/usr/bin/env node

/**
 * 文件备份脚本
 * 将指定目录下的文件备份到目标目录，并添加时间戳
 */

const fs = require('fs');
const path = require('path');
const { Command } = require('commander');

const program = new Command();

// 配置命令行参数
program
    .name('file-backup')
    .description('文件备份脚本')
    .version('1.0.0')
    .option('-s, --source <path>', '源目录路径', '.')
    .option('-d, --dest <path>', '目标目录路径', './backup')
    .option('-v, --verbose', '启用详细模式')
    .parse(process.argv);

const options = program.opts();

/**
 * 备份文件
 * @param {string} source - 源目录路径
 * @param {string} dest - 目标目录路径
 * @param {boolean} verbose - 是否启用详细模式
 */
function backupFiles(source, dest, verbose) {
    try {
        // 检查源目录是否存在
        if (!fs.existsSync(source)) {
            console.error(`错误：源目录不存在：${source}`);
            process.exit(1);
        }

        // 创建目标目录
        const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
        const backupDir = path.join(dest, `backup-${timestamp}`);
        fs.mkdirSync(backupDir, { recursive: true });

        if (verbose) {
            console.log(`开始备份 ${source} 到 ${backupDir}...`);
        }

        // 遍历源目录
        const files = fs.readdirSync(source);
        for (const file of files) {
            const sourcePath = path.join(source, file);
            const destPath = path.join(backupDir, file);

            // 检查是否为文件
            if (fs.lstatSync(sourcePath).isFile()) {
                fs.copyFileSync(sourcePath, destPath);
                if (verbose) {
                    console.log(`已复制文件：${file}`);
                }
            }
        }

        console.log(`备份成功！备份路径：${backupDir}`);
        process.exit(0);
    } catch (error) {
        console.error(`备份失败：${error.message}`);
        process.exit(1);
    }
}

// 执行备份
backupFiles(options.source, options.dest, options.verbose);
```

执行方式：
```bash
node backup.js -s ./source -d ./dest -v
```

### 12.2 系统信息收集脚本
```javascript
#!/usr/bin/env node

/**
 * 系统信息收集脚本
 * 收集计算机的硬件、软件、网络等信息
 */

const os = require('os');
const fs = require('fs');
const { execSync } = require('child_process');
const inquirer = require('inquirer');

/**
 * 获取操作系统信息
 * @returns {object} - 操作系统信息
 */
function getOsInfo() {
    return {
        系统名称: os.type(),
        系统版本: os.release(),
        系统架构: os.arch(),
        Node版本: process.version,
        CPU数量: os.cpus().length,
        总内存: `${(os.totalmem() / 1024 / 1024).toFixed(2)} MB`,
        可用内存: `${(os.freemem() / 1024 / 1024).toFixed(2)} MB`,
        主机名: os.hostname(),
        运行时间: `${os.uptime().toFixed(0)} 秒`
    };
}

/**
 * 获取网络信息
 * @returns {object} - 网络信息
 */
function getNetworkInfo() {
    const interfaces = os.networkInterfaces();
    const networkInfo = {};
    
    for (const [name, addresses] of Object.entries(interfaces)) {
        networkInfo[name] = addresses
            .filter(addr => addr.family === 'IPv4')
            .map(addr => addr.address);
    }
    
    return networkInfo;
}

/**
 * 获取磁盘信息
 * @returns {string} - 磁盘信息
 */
function getDiskInfo() {
    try {
        if (os.type() === 'Windows_NT') {
            return execSync('wmic logicaldisk get caption,size,freespace', { encoding: 'utf8' });
        } else {
            return execSync('df -h', { encoding: 'utf8' });
        }
    } catch (error) {
        return `获取磁盘信息失败：${error.message}`;
    }
}

/**
 * 主函数
 */
async function main() {
    console.log('=== 系统信息收集 ===\n');
    
    // 获取操作系统信息
    console.log('1. 操作系统信息：');
    const osInfo = getOsInfo();
    for (const [key, value] of Object.entries(osInfo)) {
        console.log(`   ${key}：${value}`);
    }
    
    // 获取网络信息
    console.log('\n2. 网络信息：');
    const networkInfo = getNetworkInfo();
    for (const [name, addresses] of Object.entries(networkInfo)) {
        console.log(`   ${name}：${addresses.join(', ')}`);
    }
    
    // 获取磁盘信息
    console.log('\n3. 磁盘信息：');
    console.log(getDiskInfo());
    
    // 询问用户是否保存信息
    const answers = await inquirer.prompt([
        {
            type: 'confirm',
            name: 'save',
            message: '是否将信息保存到文件？',
            default: false
        }
    ]);
    
    if (answers.save) {
        const filename = `system-info-${new Date().toISOString().split('T')[0]}.txt`;
        let content = '=== 系统信息 ===\n\n';
        
        content += '1. 操作系统信息：\n';
        for (const [key, value] of Object.entries(osInfo)) {
            content += `   ${key}：${value}\n`;
        }
        
        content += '\n2. 网络信息：\n';
        for (const [name, addresses] of Object.entries(networkInfo)) {
            content += `   ${name}：${addresses.join(', ')}\n`;
        }
        
        content += '\n3. 磁盘信息：\n';
        content += getDiskInfo();
        
        fs.writeFileSync(filename, content, 'utf8');
        console.log(`\n信息已保存到文件：${filename}`);
    }
}

// 执行主函数
main();
```

## 13. 调试技巧

### 13.1 使用 console.log() 调试
在关键位置添加 `console.log()` 语句，输出变量值：

```javascript
function add(a, b) {
    console.log(`调试信息：a=${a}, b=${b}`);
    return a + b;
}
```

### 13.2 使用调试器
1. 在代码中添加 `debugger;` 语句设置断点
2. 使用 `node inspect` 命令启动调试：
   ```bash
   node inspect 脚本名.js
   ```
3. 使用 Chrome DevTools 调试：
   ```bash
   node --inspect-brk 脚本名.js
   ```
   然后在 Chrome 中打开 `chrome://inspect`

### 13.3 使用 VS Code 调试
1. 在 VS Code 中打开脚本文件
2. 点击行号左侧设置断点
3. 按 F5 启动调试
4. 使用调试面板查看变量值、调用栈等

### 13.4 使用 ndb
`ndb` 是一个改进的 Node.js 调试器，提供更好的调试体验：

#### 13.4.1 安装 ndb
```bash
npm install -g ndb
```

#### 13.4.2 使用 ndb
```bash
ndb 脚本名.js
```

## 14. 资源推荐

- [Node.js 官方文档](https://nodejs.org/zh-cn/docs/)
- [yargs 官方文档](https://yargs.js.org/)
- [commander 官方文档](https://github.com/tj/commander.js)
- [inquirer 官方文档](https://github.com/SBoudrias/Inquirer.js)
- [winston 官方文档](https://github.com/winstonjs/winston)
- [dotenv 官方文档](https://github.com/motdotla/dotenv)
- [Node.js 最佳实践](https://github.com/goldbergyoni/nodebestpractices)
