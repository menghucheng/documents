# Shell 脚本编写

## 1. 脚本基本结构

### 1.1 脚本文件格式
- Shell 脚本文件扩展名为 `.sh`
- 脚本第一行通常是 shebang 行，指定解释器：
  ```bash
  #!/bin/bash
  # 或
  #!/usr/bin/env bash
  ```
- **中文编码处理**：
  - 推荐使用 UTF-8 编码保存脚本文件
  - 在脚本开头添加编码声明（可选，但推荐）：
    ```bash
    # 确保脚本使用 UTF-8 编码
    export LANG="zh_CN.UTF-8"
    export LC_ALL="zh_CN.UTF-8"
    ```
  - 在 Windows 系统上，确保终端使用 UTF-8 编码：
    ```bash
    # 在 PowerShell 中设置 UTF-8
    chcp 65001
    ```
  - 在 Linux/macOS 上，确保终端配置为 UTF-8 编码

### 1.2 脚本注释
- 单行注释：使用 `#` 开头
- 多行注释：使用 `:` 配合 `<<` 或使用 `/* */`（在某些 Shell 中支持）

```bash
# 这是单行注释

: <<'EOF'
这是多行注释
第二行注释
EOF

# 另一种多行注释方式（在 bash 中支持）
<<'COMMENT'
这也是多行注释
COMMENT
```

### 1.3 脚本执行方式
1. 直接执行（需要执行权限）：
   ```bash
   ./脚本名.sh
   ```
2. 通过解释器执行（不需要执行权限）：
   ```bash
   bash 脚本名.sh
   # 或
   sh 脚本名.sh
   ```
3. 作为源文件执行（在当前 Shell 环境中执行，影响当前环境）：
   ```bash
   source 脚本名.sh
   # 或
   . 脚本名.sh
   ```

## 2. 变量和数据类型

### 2.1 变量声明
- 变量名规则：
  - 只能包含字母、数字和下划线
  - 不能以数字开头
  - 区分大小写
- 变量赋值：使用 `=` 符号，等号两边不能有空格

```bash
# 基本变量声明
name="张三"
age=25
is_student=true

# 变量赋值
number=$((10 + 5))  # 结果为 15
greeting="Hello, $name"  # 结果为 "Hello, 张三"

# 命令替换（获取命令输出）
date=$(date +%Y-%m-%d)
# 或使用反引号（不推荐，兼容旧版本）
date=`date +%Y-%m-%d`
```

### 2.2 变量引用
- 使用 `$变量名` 或 `${变量名}` 引用变量
- `${变量名}` 形式更安全，特别是在字符串拼接时

```bash
# 基本引用
echo $name
echo ${name}

# 字符串拼接
echo "My name is $name and I'm $age years old"
echo "文件路径：${HOME}/documents/file.txt"

# 变量默认值
echo ${undefined_var:-"默认值"}  # 如果 undefined_var 未定义，输出 "默认值"
echo ${defined_var:-"默认值"}  # 如果 defined_var 已定义，输出 defined_var 的值

# 变量赋值默认值
echo ${undefined_var:="默认值"}  # 如果未定义，赋值并输出 "默认值"

# 变量存在性检查
echo ${undefined_var:?"变量未定义"}  # 如果未定义，输出错误信息并退出
echo ${defined_var:?"变量未定义"}  # 如果已定义，输出 defined_var 的值
```

### 2.3 变量作用域
- **局部变量**：在函数内部使用 `local` 关键字声明，只在函数内部可见
- **全局变量**：默认所有变量都是全局变量，在脚本的任何地方都可见
- **环境变量**：使用 `export` 关键字声明，可被子进程继承

```bash
# 全局变量
global_var="我是全局变量"

# 函数定义
function test_scope() {
    # 局部变量
    local local_var="我是局部变量"
    echo "函数内访问局部变量：$local_var"
    echo "函数内访问全局变量：$global_var"
    
    # 修改全局变量
    global_var="全局变量被修改"
}

# 调用函数
test_scope

echo "函数外访问全局变量：$global_var"  # 输出：全局变量被修改
echo "函数外访问局部变量：$local_var"  # 输出为空，因为局部变量在函数外不可见

# 环境变量
export env_var="我是环境变量"
```

### 2.4 特殊变量
| 变量 | 描述 |
|------|------|
| `$0` | 脚本文件名 |
| `$1, $2, ...` | 位置参数（脚本参数） |
| `$#` | 位置参数的个数 |
| `$*` | 所有位置参数，作为一个字符串 |
| `$@` | 所有位置参数，作为单独的字符串 |
| `$?` | 上一个命令的退出码（0 表示成功，非 0 表示失败） |
| `$$` | 当前脚本的进程 ID |
| `$!` | 上一个后台命令的进程 ID |
| `$-` | 当前 Shell 的选项标志 |
| `_` | 上一个命令的最后一个参数 |

## 3. 流程控制

### 3.1 条件语句

#### 3.1.1 if-else 语句
```bash
# 基本 if 语句
if [ 条件 ]; then
    # 条件为真时执行的命令
fi

# if-else 语句
if [ 条件 ]; then
    # 条件为真时执行的命令
else
    # 条件为假时执行的命令
fi

# if-elif-else 语句
if [ 条件1 ]; then
    # 条件1为真时执行的命令
elif [ 条件2 ]; then
    # 条件2为真时执行的命令
else
    # 所有条件都为假时执行的命令
fi
```

**条件表达式**：
- 使用 `[ ]` 或 `[[ ]]` 包裹条件（`[[ ]]` 是 bash 扩展，更强大）
- 字符串比较：`==`, `!=`, `<`, `>`
- 数值比较：`-eq`（等于）, `-ne`（不等于）, `-lt`（小于）, `-le`（小于等于）, `-gt`（大于）, `-ge`（大于等于）
- 文件测试：`-f`（普通文件）, `-d`（目录）, `-e`（存在）, `-r`（可读）, `-w`（可写）, `-x`（可执行）
- 逻辑运算：`&&`（与）, `||`（或）, `!`（非）

**示例**：
```bash
# 字符串比较
name="张三"
if [ "$name" == "张三" ]; then
    echo "你好，张三！"
fi

# 数值比较
age=25
if [ $age -ge 18 ]; then
    echo "你是成年人"
else
    echo "你是未成年人"
fi

# 文件测试
file="test.txt"
if [ -f "$file" ]; then
    echo "文件存在"
else
    echo "文件不存在"
fi

# 逻辑运算
if [ -f "$file" ] && [ -r "$file" ]; then
    echo "文件存在且可读"
fi

# 使用 [[ ]]（支持正则表达式）
if [[ $name =~ ^张 ]]; then
    echo "你姓张"
fi
```

#### 3.1.2 case 语句
用于多条件匹配，类似于其他语言的 switch-case 语句：

```bash
case $变量 in
    模式1) 
        # 匹配模式1时执行的命令
        ;;
    模式2 | 模式3) 
        # 匹配模式2或模式3时执行的命令
        ;;
    *) 
        # 匹配所有其他模式时执行的命令
        ;;
esac
```

**示例**：
```bash
#!/bin/bash

read -p "请输入一个数字（1-3）：" num

case $num in
    1)
        echo "你输入了数字 1"
        ;;
    2)
        echo "你输入了数字 2"
        ;;
    3)
        echo "你输入了数字 3"
        ;;
    *)
        echo "你输入的数字不在 1-3 范围内"
        ;;
esac
```

### 3.2 循环语句

#### 3.2.1 for 循环
**语法 1**：遍历列表
```bash
for 变量 in 列表; do
    # 循环体
    echo $变量
done
```

**示例**：
```bash
# 遍历字符串列表
for fruit in 苹果 香蕉 橘子 葡萄; do
    echo "水果：$fruit"
done

# 遍历数字列表
for i in {1..5}; do
    echo "数字：$i"
done

# 遍历文件列表
for file in *.txt; do
    echo "文件：$file"
done

# 遍历命令输出
for dir in $(ls -d */); do
    echo "目录：$dir"
done
```

**语法 2**：类 C 风格的 for 循环
```bash
for ((初始化; 条件; 增量)); do
    # 循环体
done
```

**示例**：
```bash
# 输出 1 到 5
for ((i=1; i<=5; i++)); do
    echo "数字：$i"
done

# 输出 10 到 1（递减）
for ((i=10; i>=1; i--)); do
    echo "数字：$i"
done
```

#### 3.2.2 while 循环
当条件为真时，重复执行循环体：

```bash
while [ 条件 ]; do
    # 循环体
done
```

**示例**：
```bash
# 输出 1 到 5
i=1
while [ $i -le 5 ]; do
    echo "数字：$i"
    i=$((i+1))
done

# 读取文件内容（逐行读取）
while read line; do
    echo "行内容：$line"
done < file.txt

# 无限循环（需要手动中断）
while true; do
    echo "按 Ctrl+C 退出"
    sleep 1
done
```

#### 3.2.3 until 循环
当条件为假时，重复执行循环体（与 while 循环相反）：

```bash
until [ 条件 ]; do
    # 循环体
done
```

**示例**：
```bash
# 输出 1 到 5
i=1
until [ $i -gt 5 ]; do
    echo "数字：$i"
    i=$((i+1))
done
```

#### 3.2.4 select 循环
用于创建交互式菜单：

```bash
select 变量 in 列表; do
    # 循环体
    echo "你选择了：$变量"
    break  # 可选，用于退出循环
done
```

**示例**：
```bash
#!/bin/bash

echo "请选择一种水果："
select fruit in 苹果 香蕉 橘子 葡萄 退出; do
    case $fruit in
        苹果)
            echo "你选择了苹果"
            ;;
        香蕉)
            echo "你选择了香蕉"
            ;;
        橘子)
            echo "你选择了橘子"
            ;;
        葡萄)
            echo "你选择了葡萄"
            ;;
        退出)
            echo "退出程序"
            break
            ;;
        *)
            echo "无效选择，请重新选择"
            ;;
    esac
done
```

## 4. 函数

### 4.1 函数定义
Shell 函数有两种定义方式：

```bash
# 方式 1
function 函数名 {
    # 函数体
}

# 方式 2
函数名() {
    # 函数体
}
```

### 4.2 函数参数
- 函数参数通过 `$1`, `$2`, ... 访问，与脚本参数类似
- `$0` 仍然是脚本文件名，不是函数名
- `$#` 表示参数个数
- `$*` 和 `$@` 表示所有参数

**示例**：
```bash
# 定义函数
function greet {
    echo "你好，$1！你今年 $2 岁了。"
    echo "函数参数个数：$#"
    echo "所有参数：$*"
}

# 调用函数
greet "张三" 25
```

### 4.3 函数返回值
- 使用 `return` 语句返回退出码（0-255，0 表示成功，非 0 表示失败）
- 如果需要返回其他类型的值，可以使用 `echo` 输出，然后在调用时捕获

**示例**：
```bash
# 返回退出码
function is_adult {
    local age=$1
    if [ $age -ge 18 ]; then
        return 0  # 成功，是成年人
    else
        return 1  # 失败，不是成年人
    fi
}

# 调用函数并检查返回值
is_adult 20
if [ $? -eq 0 ]; then
    echo "是成年人"
else
    echo "不是成年人"
fi

# 返回字符串值
function get_greeting {
    local name=$1
    echo "Hello, $name!"  # 使用 echo 输出返回值
}

# 捕获函数返回值
result=$(get_greeting "张三")
echo "函数返回值：$result"
```

### 4.4 函数作用域
- 函数内部的变量默认是全局变量
- 使用 `local` 关键字声明局部变量

```bash
# 全局变量
global_var="全局变量"

function test_scope {
    # 局部变量
    local local_var="局部变量"
    echo "函数内：local_var = $local_var"
    echo "函数内：global_var = $global_var"
    
    # 修改全局变量
    global_var="修改后的全局变量"
}

test_scope
echo "函数外：local_var = $local_var"  # 输出为空，局部变量不可见
echo "函数外：global_var = $global_var"  # 输出修改后的值
```

## 5. 错误处理

### 5.1 错误退出码
- 每个命令执行后都会返回一个退出码
- `$?` 表示上一个命令的退出码
- 0 表示成功，非 0 表示失败

```bash
# 检查命令执行结果
ls non_existent_file
if [ $? -ne 0 ]; then
    echo "命令执行失败"
fi

# 简化写法
if ls non_existent_file; then
    echo "命令执行成功"
else
    echo "命令执行失败"
fi
```

### 5.2 脚本错误处理
- 使用 `set -e` 让脚本在命令失败时自动退出
- 使用 `set -u` 让脚本在使用未定义变量时自动退出
- 使用 `set -x` 让脚本执行时显示每个命令（用于调试）

```bash
#!/bin/bash

# 脚本错误处理设置
set -e  # 命令失败时退出
set -u  # 使用未定义变量时退出
set -x  # 显示执行的命令

echo "开始执行脚本"
ls non_existent_file  # 命令失败，脚本自动退出
echo "这行不会执行"
```

### 5.3 trap 命令
用于捕获信号并执行相应的处理函数：

```bash
#!/bin/bash

# 定义信号处理函数
function cleanup {
    echo "捕获到信号，正在清理..."
    # 执行清理操作，如删除临时文件
    rm -f /tmp/temp_file.txt
    exit 1
}

# 捕获信号
# SIGINT (2)：Ctrl+C
# SIGTERM (15)：终止信号
trap cleanup SIGINT SIGTERM

echo "脚本正在运行，按 Ctrl+C 测试信号处理"

# 模拟长时间运行
while true; do
    echo "运行中..."
    sleep 1
done
```

### 5.4 try-catch 结构（bash 4.0+）
bash 4.0 及以上版本支持 try-catch 结构：

```bash
#!/bin/bash

# 定义 try-catch 函数
function try {
    [[ $- = *e* ]]; SAVED_OPT_E=$?
    set +e
}

function throw() {
    exit "$1"
}

function catch() {
    export ex_code=$?
    (( $SAVED_OPT_E )) && set -e
    return $ex_code
}

# 使用 try-catch
try {
    echo "尝试执行命令"
    ls non_existent_file  # 这会失败
    throw 1  # 如果命令成功，手动抛出错误
} catch {
    echo "捕获到错误，退出码：$ex_code"
}
```

## 6. 脚本参数

### 6.1 位置参数
- `$1`, `$2`, ... 表示第 1 个、第 2 个参数，依此类推
- `$0` 表示脚本文件名
- `$#` 表示参数个数
- `$*` 和 `$@` 表示所有参数

**示例**：
```bash
#!/bin/bash

echo "脚本文件名：$0"
echo "参数个数：$#"
echo "第 1 个参数：$1"
echo "第 2 个参数：$2"
echo "所有参数（$*）：$*"
echo "所有参数（$@）：$@"

# 遍历所有参数
echo "遍历所有参数："
for arg in "$@"; do
    echo "- $arg"
done
```

### 6.2 选项参数（getopts）
使用 `getopts` 命令处理带有选项的参数：

```bash
#!/bin/bash

# 定义默认值
verbose=0
output_file="output.txt"

# 解析选项
while getopts "vo:h" opt; do
    case $opt in
        v) 
            verbose=1  # 启用详细模式
            ;;
        o) 
            output_file=$OPTARG  # 设置输出文件
            ;;
        h) 
            echo "用法：$0 [-v] [-o output_file] [files...]"
            echo "-v：启用详细模式"
            echo "-o：指定输出文件（默认：output.txt）"
            echo "-h：显示帮助信息"
            exit 0
            ;;
        \?) 
            echo "无效选项：-\$OPTARG"
            echo "使用 -h 查看帮助信息"
            exit 1
            ;;
    esac
done

# 跳过选项，处理位置参数
shift $((OPTIND-1))

# 输出解析结果
echo "详细模式：$verbose"
echo "输出文件：$output_file"
echo "位置参数：$@"
```

### 6.3 帮助信息
为脚本添加帮助信息，方便用户使用：

```bash
#!/bin/bash

# 显示帮助信息
function show_help {
    echo "用法：$0 [选项] [参数]"
    echo ""
    echo "选项："
    echo "  -h, --help     显示帮助信息"
    echo "  -v, --verbose  启用详细模式"
    echo "  -o, --output   指定输出文件"
    echo ""
    echo "示例："
    echo "  $0 -v -o output.txt file1.txt file2.txt"
}

# 解析长选项
for arg in "$@"; do
    case $arg in
        -h|--help) 
            show_help
            exit 0
            ;;
        -v|--verbose) 
            verbose=1
            shift
            ;;
        -o|--output) 
            output_file=$2
            shift 2
            ;;
        --) 
            shift
            break
            ;;
        *) 
            # 未知选项
            break
            ;;
    esac
done
```

## 7. 输入输出

### 7.1 标准输入输出
- **标准输入（stdin）**：文件描述符 0，默认从键盘输入
- **标准输出（stdout）**：文件描述符 1，默认输出到终端
- **标准错误（stderr）**：文件描述符 2，默认输出到终端

### 7.2 重定向
- `>`：将标准输出重定向到文件（覆盖）
- `>>`：将标准输出重定向到文件（追加）
- `<`：将文件内容作为标准输入
- `2>`：将标准错误重定向到文件
- `2>&1`：将标准错误重定向到标准输出
- `&>`：将标准输出和标准错误都重定向到文件

**示例**：
```bash
# 将输出重定向到文件（覆盖）
echo "Hello" > output.txt

# 将输出重定向到文件（追加）
echo "World" >> output.txt

# 将文件内容作为输入
cat < input.txt

# 将错误重定向到文件
ls non_existent_file 2> error.txt

# 将输出和错误都重定向到文件
echo "正常输出" > output.txt 2>&1
# 或
echo "正常输出" &> output.txt
```

### 7.3 管道
使用 `|` 将一个命令的输出作为另一个命令的输入：

```bash
# 查找包含 "error" 的行并显示行号
grep -n "error" log.txt | head -10

# 统计文件中单词个数
cat file.txt | wc -w

# 排序并去重
echo -e "3\n1\n2\n1" | sort | uniq
```

### 7.4 Here Document 和 Here String
- **Here Document**：使用 `<<` 标记输入多行文本
- **Here String**：使用 `<<<` 标记输入单行文本

**示例**：
```bash
# Here Document：创建文件
cat > file.txt << 'EOF'
这是第一行
这是第二行
这是第三行
EOF

# Here Document：作为命令输入
wc -l << 'EOF'
行1
行2
行3
EOF

# Here String：作为命令输入
echo "Hello" | wc -c  # 输出 6（包括换行符）
wc -c <<< "Hello"     # 输出 5（不包括换行符）

# 使用 Here String 传递变量
ame="张三"
grep "张" <<< "$name"
```

## 8. 用户输入处理

### 8.1 基本输入
使用 `read` 命令获取用户输入：

```bash
# 基本文本输入
read -p "请输入你的姓名：" name
echo "你好，$name！"

# 数字输入（需要验证）
read -p "请输入你的年龄：" age
echo "你今年 $age 岁了。"

# 不显示输入提示
read -p "请按 Enter 键继续..." -t 5  # -t 5 表示 5 秒超时

# 隐藏输入（用于密码）
read -s -p "请输入密码：" password
echo -e "\n密码已输入。"
```

### 8.2 输入验证

```bash
# 验证数字输入
function get_valid_age {
    local age
    while true; do
        read -p "请输入你的年龄：" age
        if [[ $age =~ ^[0-9]+$ ]] && [ "$age" -ge 0 ] && [ "$age" -le 120 ]; then
            echo "$age"
            return 0
        fi
        echo "年龄必须是 0 到 120 之间的数字，请重新输入。" >&2
    done
}

valid_age=$(get_valid_age)
echo "你今年 $valid_age 岁了。"

# 验证字符串输入
function get_valid_name {
    local name
    while true; do
        read -p "请输入你的姓名：" name
        if [[ $name =~ ^[\p{Han}a-zA-Z]{2,20}$ ]]; then
            echo "$name"
            return 0
        fi
        echo "姓名必须是 2-20 个中文字符或英文字母，请重新输入。" >&2
    done
}

valid_name=$(get_valid_name)
echo "你好，$valid_name！"
```

### 8.3 交互式菜单

```bash
#!/bin/bash

function show_menu {
    echo "=== 主菜单 ==="
    echo "1. 查看系统信息"
    echo "2. 备份文件"
    echo "3. 清理临时文件"
    echo "4. 退出"
    echo "============="
}

function show_system_info {
    echo "=== 系统信息 ==="
    uname -a
    echo "CPU 信息："
    cat /proc/cpuinfo | grep "model name" | head -1
    echo "内存信息："
    free -h
}

function backup_files {
    echo "=== 文件备份 ==="
    read -p "请输入源目录路径：" source
    read -p "请输入目标目录路径：" dest
    echo "开始备份 $source 到 $dest..."
    # 这里可以添加实际的备份逻辑
}

function clean_temp_files {
    echo "=== 清理临时文件 ==="
    echo "开始清理临时文件..."
    # 这里可以添加实际的清理逻辑
}

# 主循环
while true; do
    show_menu
    read -p "请选择操作（1-4）：" choice
    
    case $choice in
        1) show_system_info ;;
        2) backup_files ;;
        3) clean_temp_files ;;
        4) echo "再见！"; exit 0 ;;
        *) echo "无效选择，请重新输入。" >&2 ;;
    esac
    
    echo -e "\n按 Enter 键继续..."
    read -n 1
    echo -e "\n"
done
```

### 8.4 批量输入处理

```bash
#!/bin/bash

# 从文件读取输入
function read_from_file {
    local file="$1"
    while IFS= read -r line; do
        echo "读取到行：$line"
    done < "$file"
}

# 从管道读取输入
function read_from_pipe {
    echo "请输入多行文本，按 Ctrl+D 结束："
    while IFS= read -r line; do
        echo "你输入了：$line"
    done
}

# 示例使用
read_from_pipe
```

## 9. 脚本调试

### 9.1 调试模式
- 使用 `bash -x script.sh` 运行脚本，显示执行的每个命令
- 在脚本中使用 `set -x` 启用调试模式，`set +x` 禁用调试模式
- 使用 `bash -n script.sh` 检查脚本语法错误

**示例**：
```bash
#!/bin/bash

echo "开始执行脚本"

# 启用调试模式
set -x

echo "调试模式：这行命令会显示"
ls -la

# 禁用调试模式
set +x

echo "调试模式已禁用：这行命令不会显示"
```

### 9.2 调试技巧
- 在关键位置添加 `echo` 语句，输出变量值
- 使用 `set -u` 检测未定义变量
- 使用 `set -e` 命令失败时自动退出
- 使用 `trap` 命令捕获错误

## 10. 脚本模块化

### 10.1 包含其他脚本
使用 `source` 或 `.` 命令包含其他脚本：

```bash
# 包含其他脚本
source ./lib/utils.sh
# 或
. ./lib/utils.sh
```

### 10.2 函数库
创建函数库文件，然后在多个脚本中包含使用：

**示例**：

1. 创建函数库文件 `lib/utils.sh`：
```bash
#!/bin/bash

# 日志函数
function log {
    local level=$1
    local message=$2
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] [$level] $message"
}

# 错误处理函数
function error_exit {
    log "ERROR" "$1"
    exit 1
}

# 文件检查函数
function check_file {
    local file=$1
    if [ ! -f "$file" ]; then
        error_exit "文件不存在：$file"
    fi
}
```

2. 在脚本中使用函数库：
```bash
#!/bin/bash

# 包含函数库
source ./lib/utils.sh

log "INFO" "脚本开始执行"

# 使用函数库中的函数
check_file "input.txt"

log "INFO" "脚本执行完成"
```

## 11. 最佳实践

### 11.1 脚本命名
- 使用有意义的名称，描述脚本功能
- 使用小写字母和下划线，避免使用空格和特殊字符
- 以 `.sh` 为扩展名

### 11.2 注释
- 在脚本开头添加脚本描述、作者、版本、创建日期等信息
- 为复杂逻辑添加注释
- 为函数添加注释，说明功能、参数和返回值

### 11.3 错误处理
- 使用 `set -e` 和 `set -u` 提高脚本健壮性
- 检查命令执行结果
- 提供清晰的错误信息
- 使用 `trap` 命令进行清理操作

### 11.4 安全性
- 避免使用硬编码的密码和敏感信息
- 验证用户输入
- 使用绝对路径
- 避免使用 `eval` 命令（存在安全风险）
- 对文件路径和变量进行引号包裹，避免空格问题

### 11.5 性能优化
- 减少外部命令调用（外部命令比内部命令慢）
- 使用数组代替字符串拼接
- 避免在循环中使用 `echo` 等命令
- 使用 `read` 命令代替 `cat` 命令读取文件

## 12. 示例脚本

### 12.1 文件备份脚本
```bash
#!/bin/bash

# 脚本描述：文件备份脚本
# 作者：张三
# 版本：1.0
# 创建日期：2023-01-01

# 设置错误处理
set -e
set -u

# 定义变量
SOURCE_DIR="/home/user/docs"
BACKUP_DIR="/home/user/backup"
DATE=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="backup_${DATE}.tar.gz"

# 显示帮助信息
function show_help {
    echo "用法：$0 [选项]"
    echo ""
    echo "选项："
    echo "  -s, --source    指定源目录（默认：$SOURCE_DIR）"
    echo "  -d, --dest      指定备份目录（默认：$BACKUP_DIR）"
    echo "  -h, --help      显示帮助信息"
}

# 解析命令行参数
while getopts "s:d:h" opt; do
    case $opt in
        s) SOURCE_DIR=$OPTARG ;;
        d) BACKUP_DIR=$OPTARG ;;
        h) show_help ; exit 0 ;;
        \?) echo "无效选项：-\$OPTARG" ; show_help ; exit 1 ;;
    esac
done

# 检查源目录是否存在
if [ ! -d "$SOURCE_DIR" ]; then
    echo "错误：源目录不存在：$SOURCE_DIR"
    exit 1
fi

# 创建备份目录（如果不存在）
mkdir -p "$BACKUP_DIR"

# 执行备份
echo "开始备份..."
echo "源目录：$SOURCE_DIR"
echo "备份目录：$BACKUP_DIR"
echo "备份文件：$BACKUP_FILE"

# 使用 tar 命令备份
tar -czf "$BACKUP_DIR/$BACKUP_FILE" "$SOURCE_DIR" 2>/dev/null

# 检查备份结果
if [ $? -eq 0 ]; then
    echo "备份成功！"
    echo "备份文件大小：$(du -h "$BACKUP_DIR/$BACKUP_FILE" | cut -f1)"
else
    echo "备份失败！"
    exit 1
fi

# 清理旧备份（保留最近 7 天的备份）
echo "清理旧备份..."
find "$BACKUP_DIR" -name "backup_*.tar.gz" -mtime +7 -delete

echo "备份完成！"
```

### 12.2 系统监控脚本
```bash
#!/bin/bash

# 脚本描述：系统监控脚本
# 作者：张三
# 版本：1.0
# 创建日期：2023-01-01

# 定义变量
LOG_FILE="/var/log/system_monitor.log"
THRESHOLD_CPU=80
THRESHOLD_MEM=80
THRESHOLD_DISK=80

# 显示帮助信息
function show_help {
    echo "用法：$0 [选项]"
    echo ""
    echo "选项："
    echo "  -l, --log      指定日志文件（默认：$LOG_FILE）"
    echo "  -h, --help     显示帮助信息"
}

# 解析命令行参数
while getopts "l:h" opt; do
    case $opt in
        l) LOG_FILE=$OPTARG ;;
        h) show_help ; exit 0 ;;
        \?) echo "无效选项：-\$OPTARG" ; show_help ; exit 1 ;;
    esac
done

# 日志函数
function log {
    local level=$1
    local message=$2
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] [$level] $message" >> "$LOG_FILE"
    echo "[$timestamp] [$level] $message"
}

# 获取 CPU 使用率
function get_cpu_usage {
    local cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
    echo "$cpu_usage"
}

# 获取内存使用率
function get_mem_usage {
    local mem_total=$(free -m | grep Mem | awk '{print $2}')
    local mem_used=$(free -m | grep Mem | awk '{print $3}')
    local mem_usage=$(echo "scale=2; $mem_used / $mem_total * 100" | bc)
    echo "$mem_usage"
}

# 获取磁盘使用率
function get_disk_usage {
    local disk_usage=$(df -h / | grep / | awk '{print $5}' | sed 's/%//')
    echo "$disk_usage"
}

# 发送告警（这里只是示例，实际可以发送邮件、短信等）
function send_alert {
    local metric=$1
    local usage=$2
    local threshold=$3
    log "ERROR" "${metric} 使用率过高：${usage}%，阈值：${threshold}%"
}

# 主函数
function main {
    log "INFO" "开始系统监控"
    
    # 获取使用率
    cpu_usage=$(get_cpu_usage)
    mem_usage=$(get_mem_usage)
    disk_usage=$(get_disk_usage)
    
    # 记录使用率
    log "INFO" "CPU 使用率：${cpu_usage}%"
    log "INFO" "内存使用率：${mem_usage}%"
    log "INFO" "磁盘使用率：${disk_usage}%"
    
    # 检查阈值
    if (( $(echo "$cpu_usage > $THRESHOLD_CPU" | bc -l) )); then
        send_alert "CPU" "$cpu_usage" "$THRESHOLD_CPU"
    fi
    
    if (( $(echo "$mem_usage > $THRESHOLD_MEM" | bc -l) )); then
        send_alert "内存" "$mem_usage" "$THRESHOLD_MEM"
    fi
    
    if [ $disk_usage -gt $THRESHOLD_DISK ]; then
        send_alert "磁盘" "$disk_usage" "$THRESHOLD_DISK"
    fi
    
    log "INFO" "系统监控完成"
}

# 执行主函数
main
```

### 12.3 日志分析脚本
```bash
#!/bin/bash

# 脚本描述：日志分析脚本
# 作者：张三
# 版本：1.0
# 创建日期：2023-01-01

# 定义变量
LOG_FILE="/var/log/syslog"

# 显示帮助信息
function show_help {
    echo "用法：$0 [选项]"
    echo ""
    echo "选项："
    echo "  -f, --file      指定日志文件（默认：$LOG_FILE）"
    echo "  -h, --help      显示帮助信息"
}

# 解析命令行参数
while getopts "f:h" opt; do
    case $opt in
        f) LOG_FILE=$OPTARG ;;
        h) show_help ; exit 0 ;;
        \?) echo "无效选项：-\$OPTARG" ; show_help ; exit 1 ;;
    esac
done

# 检查日志文件是否存在
if [ ! -f "$LOG_FILE" ]; then
    echo "错误：日志文件不存在：$LOG_FILE"
    exit 1
fi

# 统计错误数量
function count_errors {
    local error_count=$(grep -i "error" "$LOG_FILE" | wc -l)
    echo "错误数量：$error_count"
}

# 统计警告数量
function count_warnings {
    local warning_count=$(grep -i "warning" "$LOG_FILE" | wc -l)
    echo "警告数量：$warning_count"
}

# 显示最近的错误
function show_recent_errors {
    echo "最近的 10 个错误："
    grep -i "error" "$LOG_FILE" | tail -10
}

# 显示日志中出现最多的 IP 地址
function show_top_ips {
    echo "日志中出现最多的 10 个 IP 地址："
    grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -10
}

# 主函数
function main {
    echo "日志分析报告"
    echo "日志文件：$LOG_FILE"
    echo "分析时间：$(date +"%Y-%m-%d %H:%M:%S")"
    echo "----------------------------------------"
    
    count_errors
    count_warnings
    
    echo "----------------------------------------"
    show_recent_errors
    
    echo "----------------------------------------"
    show_top_ips
    
    echo "----------------------------------------"
    echo "分析完成！"
}

# 执行主函数
main
```

## 13. 资源推荐

- [Bash 官方文档](https://www.gnu.org/software/bash/manual/)
- [Shell Scripting Tutorial](https://www.shellscript.sh/)
- [Advanced Bash-Scripting Guide](https://tldp.org/LDP/abs/html/)
- [ShellCheck - Shell 脚本静态分析工具](https://www.shellcheck.net/)
- [Linux 命令行大全](https://linuxcommand.org/)