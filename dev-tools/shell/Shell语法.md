# Shell 语法

## 1. 基础语法

### 1.1 Shebang 行
Shebang 行是脚本的第一行，用于指定解释器：
```bash
#!/bin/bash
# 或
#! /usr/bin/env bash
```

### 1.2 注释
- 单行注释：使用 `#` 开头
- 多行注释：使用 `:` 配合 `<<`

```bash
# 这是单行注释

: <<'EOF'
这是多行注释
第二行注释
EOF
```

### 1.3 命令分隔符
- `;`：命令分隔符，用于在同一行执行多个命令
- `&&`：逻辑与，前一个命令成功后执行后一个命令
- `||`：逻辑或，前一个命令失败后执行后一个命令

```bash
# 在同一行执行多个命令
echo "命令1"; echo "命令2"

# 前一个命令成功后执行后一个命令
echo "测试" && echo "前一个命令成功"

# 前一个命令失败后执行后一个命令
echo "测试" || echo "前一个命令失败"
```

### 1.4 命令分组
- `()`：创建子 shell，在子 shell 中执行命令，不影响当前 shell 环境
- `{}`：在当前 shell 中执行命令，影响当前 shell 环境

```bash
# 子 shell 执行，变量不影响当前环境
(cd /tmp; echo "当前目录：$PWD")
echo "回到原目录：$PWD"

# 当前 shell 执行，变量影响当前环境
{ cd /tmp; echo "当前目录：$PWD"; }
echo "当前目录已改变：$PWD"
```

## 2. 变量

### 2.1 变量定义
- 变量名只能包含字母、数字和下划线
- 不能以数字开头
- 区分大小写
- 等号两边不能有空格

```bash
# 变量定义
name="张三"
age=25
is_student=true
```

### 2.2 变量引用
- `$变量名` 或 `${变量名}`
- `${变量名}` 更安全，特别是在字符串拼接时

```bash
# 基本引用
echo $name
echo ${name}

# 字符串拼接
echo "My name is $name"
echo "文件：${HOME}/file.txt"
```

### 2.3 特殊变量
| 变量 | 描述 |
|------|------|
| `$0` | 脚本文件名 |
| `$1`, `$2`, ... | 位置参数 |
| `$#` | 位置参数个数 |
| `$*` | 所有位置参数，作为一个字符串 |
| `$@` | 所有位置参数，作为单独的字符串 |
| `$?` | 上一个命令的退出码 |
| `$$` | 当前脚本的进程 ID |
| `$!` | 上一个后台命令的进程 ID |
| `$-` | 当前 Shell 的选项标志 |

### 2.4 变量作用域
- 默认是全局变量
- 使用 `local` 关键字声明局部变量

```bash
# 全局变量
global_var="全局变量"

function test_scope {
    # 局部变量
    local local_var="局部变量"
}
```

## 3. 运算符

### 3.1 算术运算符
| 运算符 | 描述 | 示例 |
|--------|------|------|
| `+` | 加法 | `$((10 + 5))` |
| `-` | 减法 | `$((10 - 5))` |
| `*` | 乘法 | `$((10 * 5))` |
| `/` | 除法 | `$((10 / 5))` |
| `%` | 取余 | `$((10 % 3))` |
| `**` | 幂运算 | `$((2 ** 3))` |
| `++` | 自增 | `$((i++))` |
| `--` | 自减 | `$((i--))` |

**示例**：
```bash
# 基本算术运算
a=10
b=5
echo "$a + $b = $((a + b))"
echo "$a - $b = $((a - b))"
echo "$a * $b = $((a * b))"
echo "$a / $b = $((a / b))"
echo "$a % $b = $((a % b))"
echo "$a ** $b = $((a ** b))"

# 赋值运算
i=1
i=$((i + 1))  # i 变为 2
echo "i = $i"

# 自增自减
i=1
echo "i++ = $((i++))"  # 输出 1，i 变为 2
echo "++i = $((++i))"  # 输出 3，i 变为 3
echo "i-- = $((i--))"  # 输出 3，i 变为 2
echo "--i = $((--i))"  # 输出 1，i 变为 1
```

### 3.2 比较运算符

#### 3.2.1 数值比较
| 运算符 | 描述 | 示例 |
|--------|------|------|
| `-eq` | 等于 | `[ $a -eq $b ]` |
| `-ne` | 不等于 | `[ $a -ne $b ]` |
| `-lt` | 小于 | `[ $a -lt $b ]` |
| `-le` | 小于等于 | `[ $a -le $b ]` |
| `-gt` | 大于 | `[ $a -gt $b ]` |
| `-ge` | 大于等于 | `[ $a -ge $b ]` |

#### 3.2.2 字符串比较
| 运算符 | 描述 | 示例 |
|--------|------|------|
| `==` 或 `=` | 等于 | `[ "$a" == "$b" ]` |
| `!=` | 不等于 | `[ "$a" != "$b" ]` |
| `<` | 小于（字典序） | `[ "$a" \< "$b" ]` |
| `>` | 大于（字典序） | `[ "$a" \> "$b" ]` |
| `-z` | 字符串长度为 0 | `[ -z "$a" ]` |
| `-n` | 字符串长度不为 0 | `[ -n "$a" ]` |

#### 3.2.3 文件比较
| 运算符 | 描述 | 示例 |
|--------|------|------|
| `-e` | 文件或目录存在 | `[ -e "$file" ]` |
| `-f` | 普通文件存在 | `[ -f "$file" ]` |
| `-d` | 目录存在 | `[ -d "$dir" ]` |
| `-s` | 文件大小不为 0 | `[ -s "$file" ]` |
| `-r` | 文件可读 | `[ -r "$file" ]` |
| `-w` | 文件可写 | `[ -w "$file" ]` |
| `-x` | 文件可执行 | `[ -x "$file" ]` |
| `-L` | 符号链接 | `[ -L "$file" ]` |
| `-nt` | 第一个文件比第二个文件新 | `[ "$file1" -nt "$file2" ]` |
| `-ot` | 第一个文件比第二个文件旧 | `[ "$file1" -ot "$file2" ]` |

### 3.3 逻辑运算符
| 运算符 | 描述 | 示例 |
|--------|------|------|
| `!` | 逻辑非 | `[ ! -f "$file" ]` |
| `-a` | 逻辑与（在 `[ ]` 中使用） | `[ -f "$file" -a -r "$file" ]` |
| `-o` | 逻辑或（在 `[ ]` 中使用） | `[ -f "$file" -o -d "$file" ]` |
| `&&` | 逻辑与（推荐使用） | `[ -f "$file" ] && echo "文件存在"` |
| `||` | 逻辑或（推荐使用） | `[ -f "$file" ] || echo "文件不存在"` |

## 4. 字符串处理

### 4.1 字符串长度
```bash
str="Hello World"
length=${#str}
echo "字符串长度：$length"
```

### 4.2 字符串截取
```bash
str="Hello World"

# 从索引 0 开始，截取 5 个字符
echo ${str:0:5}  # 输出 "Hello"

# 从索引 6 开始，截取到末尾
echo ${str:6}  # 输出 "World"

# 从末尾开始，截取 5 个字符
echo ${str: -5}  # 输出 "World"
# 或
echo ${str:(-5)}  # 输出 "World"

# 从末尾开始，截取到倒数第 6 个字符
echo ${str:0:-6}  # 输出 "Hello"
```

### 4.3 字符串替换
```bash
str="Hello World"

# 替换第一个匹配项
echo ${str/World/PowerShell}  # 输出 "Hello PowerShell"

# 替换所有匹配项
echo ${str//o/O}  # 输出 "HellO WOrld"

# 从开头替换
echo ${str/#Hello/HI}  # 输出 "HI World"

# 从结尾替换
echo ${str/%World/Shell}  # 输出 "Hello Shell"
```

### 4.4 字符串删除
```bash
str="Hello World Hello"

# 删除第一个匹配项
echo ${str/Hello/}  # 输出 " World Hello"

# 删除所有匹配项
echo ${str//Hello/}  # 输出 " World "

# 从开头删除
echo ${str/#Hello/}  # 输出 " World Hello"

# 从结尾删除
echo ${str/%Hello/}  # 输出 "Hello World "

# 删除匹配的前缀
echo ${str##* }  # 输出 "Hello"（贪婪匹配）
echo ${str#* }  # 输出 "World Hello"（非贪婪匹配）

# 删除匹配的后缀
echo ${str%% *}  # 输出 "Hello"（贪婪匹配）
echo ${str% *}  # 输出 "Hello World"（非贪婪匹配）
```

### 4.5 字符串转换
```bash
str="Hello World"

# 转换为大写
echo ${str^^}  # 输出 "HELLO WORLD"

# 转换为小写
echo ${str,,}  # 输出 "hello world"

# 首字母大写（bash 4.0+）
echo ${str^}  # 输出 "Hello world"
```

## 5. 数组

### 5.1 数组定义
```bash
# 方法 1：直接定义
fruits=(苹果 香蕉 橘子 葡萄)

# 方法 2：单个元素赋值
fruits[0]=苹果
fruits[1]=香蕉
fruits[2]=橘子

# 方法 3：使用命令输出
dirs=($(ls -d */))
```

### 5.2 数组元素访问
```bash
# 访问单个元素
echo ${fruits[0]}  # 输出 "苹果"
echo ${fruits[1]}  # 输出 "香蕉"

# 访问所有元素
echo ${fruits[@]}  # 输出 "苹果 香蕉 橘子 葡萄"
echo ${fruits[*]}  # 输出 "苹果 香蕉 橘子 葡萄"

# 访问数组长度
echo ${#fruits[@]}  # 输出 4
echo ${#fruits[*]}  # 输出 4

# 访问单个元素的长度
echo ${#fruits[0]}  # 输出 2（"苹果"的长度）
```

### 5.3 数组元素修改
```bash
# 修改单个元素
fruits[0]=西瓜

# 添加元素
fruits[4]=草莓
fruits+=(猕猴桃 芒果)  # 追加多个元素

# 删除元素
unset fruits[1]  # 删除索引为 1 的元素
unset fruits     # 删除整个数组
```

### 5.4 数组切片
```bash
# 数组切片：从索引 1 开始，截取 2 个元素
echo ${fruits[@]:1:2}  # 输出 "香蕉 橘子"

# 从索引 2 开始，截取到末尾
echo ${fruits[@]:2}  # 输出 "橘子 葡萄"

# 从末尾开始，截取 2 个元素
echo ${fruits[@]: -2}  # 输出 "葡萄 草莓"
```

## 6. 流程控制

### 6.1 if 语句
```bash
# 基本 if 语句
if [ 条件 ]; then
    # 条件为真时执行
fi

# if-else 语句
if [ 条件 ]; then
    # 条件为真时执行
else
    # 条件为假时执行
fi

# if-elif-else 语句
if [ 条件1 ]; then
    # 条件1为真时执行
elif [ 条件2 ]; then
    # 条件2为真时执行
else
    # 所有条件为假时执行
fi
```

### 6.2 case 语句
```bash
case $变量 in
    模式1) 
        # 匹配模式1时执行
        ;;
    模式2 | 模式3) 
        # 匹配模式2或模式3时执行
        ;;
    *) 
        # 匹配所有其他模式时执行
        ;;
esac
```

### 6.3 for 循环
**语法 1**：遍历列表
```bash
for 变量 in 列表; do
    # 循环体
done
```

**语法 2**：类 C 风格
```bash
for ((初始化; 条件; 增量)); do
    # 循环体
done
```

### 6.4 while 循环
```bash
while [ 条件 ]; do
    # 循环体
done
```

### 6.5 until 循环
```bash
until [ 条件 ]; do
    # 循环体
done
```

### 6.6 select 循环
```bash
select 变量 in 列表; do
    # 循环体
    break  # 可选
    ;;
done
```

### 6.7 循环控制
- `break`：退出当前循环
- `continue`：跳过当前循环的剩余部分，进入下一次循环
- `break n`：退出 n 层循环
- `continue n`：跳过 n 层循环的剩余部分

```bash
# break 示例
for i in {1..10}; do
    if [ $i -eq 5 ]; then
        break  # 退出循环
    fi
    echo $i
done

# continue 示例
for i in {1..10}; do
    if [ $i -eq 5 ]; then
        continue  # 跳过第 5 次循环
    fi
    echo $i
done
```

## 7. 函数

### 7.1 函数定义
```bash
# 方式 1
function function_name {
    # 函数体
}

# 方式 2
function_name() {
    # 函数体
}
```

### 7.2 函数参数
- `$1`, `$2`, ...：位置参数
- `$#`：参数个数
- `$*` 和 `$@`：所有参数

```bash
function greet {
    echo "你好，$1！"
    echo "参数个数：$#"
    echo "所有参数：$@"
}

# 调用函数
greet 张三 25
```

### 7.3 函数返回值
- `return`：返回退出码（0-255）
- `echo`：输出结果，然后捕获

```bash
# 返回退出码
function is_adult {
    local age=$1
    if [ $age -ge 18 ]; then
        return 0
    else
        return 1
    fi
}

# 使用 echo 返回值
function get_sum {
    local a=$1
    local b=$2
    echo $((a + b))
}

# 捕获返回值
sum=$(get_sum 10 20)
echo "和为：$sum"
```

## 8. 正则表达式

### 8.1 正则表达式基础
| 元字符 | 描述 |
|--------|------|
| `.` | 匹配任意单个字符（除了换行符） |
| `*` | 匹配前面的字符 0 次或多次 |
| `+` | 匹配前面的字符 1 次或多次 |
| `?` | 匹配前面的字符 0 次或 1 次 |
| `^` | 匹配行首 |
| `$` | 匹配行尾 |
| `[abc]` | 匹配方括号中的任意一个字符 |
| `[^abc]` | 匹配除了方括号中的字符之外的任意字符 |
| `[a-z]` | 匹配 a 到 z 之间的任意字符 |
| `\d` | 匹配数字（等价于 [0-9]） |
| `\D` | 匹配非数字（等价于 [^0-9]） |
| `\w` | 匹配字母、数字或下划线（等价于 [a-zA-Z0-9_]） |
| `\W` | 匹配非字母、数字或下划线（等价于 [^a-zA-Z0-9_]） |
| `\s` | 匹配空白字符（空格、制表符、换行符等） |
| `\S` | 匹配非空白字符 |
| `{n}` | 匹配前面的字符恰好 n 次 |
| `{n,}` | 匹配前面的字符至少 n 次 |
| `{n,m}` | 匹配前面的字符至少 n 次，最多 m 次 |
| `(pattern)` | 捕获组，匹配括号内的模式 |
| `\1, \2, ...` | 反向引用，引用之前的捕获组 |

### 8.2 正则表达式应用

#### 8.2.1 grep 命令
```bash
# 搜索包含 "error" 的行
grep "error" file.txt

# 忽略大小写
grep -i "error" file.txt

# 显示行号
grep -n "error" file.txt

# 显示匹配的上下文
grep -A 2 -B 2 "error" file.txt  # 显示匹配行及其前后 2 行

# 使用正则表达式
grep "^[0-9]" file.txt  # 匹配以数字开头的行
grep "[a-z]+@[a-z]+\.[a-z]+" file.txt  # 匹配邮箱地址
```

#### 8.2.2 sed 命令
```bash
# 替换匹配的字符串
sed 's/old/new/' file.txt

# 全局替换
sed 's/old/new/g' file.txt

# 使用正则表达式
sed 's/^[0-9]*/行号：&/' file.txt  # 在每行开头添加 "行号："

# 删除匹配的行
sed '/^#/d' file.txt  # 删除注释行
```

#### 8.2.3 bash 中的正则表达式匹配
```bash
str="user@example.com"

# 使用 =~ 运算符进行正则表达式匹配
if [[ $str =~ [a-z]+@[a-z]+\.[a-z]+ ]]; then
    echo "是有效的邮箱地址"
else
    echo "不是有效的邮箱地址"
fi

# 提取匹配的部分
echo "匹配的邮箱：${BASH_REMATCH[0]}"
```

## 9. 输入输出

### 9.1 标准输入输出
- **stdin**：标准输入，文件描述符 0
- **stdout**：标准输出，文件描述符 1
- **stderr**：标准错误，文件描述符 2

### 9.2 重定向
| 符号 | 描述 |
|------|------|
| `>` | 将 stdout 重定向到文件（覆盖） |
| `>>` | 将 stdout 重定向到文件（追加） |
| `<` | 将文件内容作为 stdin |
| `2>` | 将 stderr 重定向到文件 |
| `2>&1` | 将 stderr 重定向到 stdout |
| `&>` | 将 stdout 和 stderr 都重定向到文件 |
| `<<` | Here Document，输入多行文本 |
| `<<<` | Here String，输入单行文本 |

```bash
# 重定向到文件
echo "Hello" > output.txt

# 追加到文件
echo "World" >> output.txt

# 将文件内容作为输入
cat < input.txt

# 将 stderr 重定向到文件
ls non_existent_file 2> error.txt

# 将 stdout 和 stderr 都重定向到文件
echo "测试" &> output.txt
```

### 9.3 管道
使用 `|` 将一个命令的 stdout 作为另一个命令的 stdin：

```bash
# 查找包含 "error" 的行并显示行号
grep "error" file.txt | grep -n ""

# 统计文件中单词个数
cat file.txt | wc -w

# 排序并去重
echo -e "3\n1\n2\n1" | sort | uniq
```

### 9.4 命令替换
- `` `命令` ``：旧语法
- `$(命令)`：新语法（推荐）

```bash
# 获取当前日期
date=$(date +%Y-%m-%d)
echo "今天是 $date"

# 获取文件数量
file_count=$(ls -l | wc -l)
echo "文件数量：$file_count"
```

## 10. 其他语法特性

### 10.1 算术扩展
- `$((表达式))`：算术扩展，用于计算算术表达式

```bash
# 基本算术运算
echo $((10 + 5))
echo $((10 * 5))

# 变量运算
a=10
b=5
echo $((a + b))
```

### 10.2  brace 扩展
- `{}`：用于生成字符串序列

```bash
# 生成数字序列
echo {1..5}  # 输出 "1 2 3 4 5"
echo {5..1}  # 输出 "5 4 3 2 1"
echo {1..10..2}  # 输出 "1 3 5 7 9"

# 生成字符串序列
echo {a..e}  # 输出 "a b c d e"
echo {file1,file2,file3}.txt  # 输出 "file1.txt file2.txt file3.txt"
echo file{1..3}.txt  # 输出 "file1.txt file2.txt file3.txt"
```

### 10.3 历史扩展
- `!!`：执行上一条命令
- `!n`：执行历史中的第 n 条命令
- `!string`：执行以 string 开头的最后一条命令
- `!?string?`：执行包含 string 的最后一条命令

```bash
# 执行上一条命令
!!

# 执行历史中的第 100 条命令
!100

# 执行以 "ls" 开头的最后一条命令
!ls

# 执行包含 "error" 的最后一条命令
!?error?
```

### 10.4 变量展开
| 语法 | 描述 |
|------|------|
| `${var:-default}` | 如果 var 未定义或为空，使用 default 值 |
| `${var:=default}` | 如果 var 未定义或为空，将其设置为 default 值 |
| `${var:?message}` | 如果 var 未定义或为空，输出 message 并退出 |
| `${var:+value}` | 如果 var 已定义且不为空，使用 value 值，否则为空 |

```bash
# 使用默认值
undefined_var=""
echo ${undefined_var:-"默认值"}  # 输出 "默认值"

defined_var="已定义"
echo ${defined_var:-"默认值"}  # 输出 "已定义"

# 设置默认值
echo ${undefined_var:="新值"}  # 输出 "新值"，并将 undefined_var 设置为 "新值"

echo $undefined_var  # 输出 "新值"
```

## 11. 脚本调试

### 11.1 调试模式
- `bash -x script.sh`：运行脚本并显示执行的每个命令
- `set -x`：在脚本中启用调试模式
- `set +x`：在脚本中禁用调试模式
- `bash -n script.sh`：检查脚本语法错误

```bash
#!/bin/bash

set -x  # 启用调试模式
echo "调试模式"
ls -la
set +x  # 禁用调试模式
echo "调试模式已禁用"
```

### 11.2 调试选项
| 选项 | 描述 |
|------|------|
| `-n` | 检查语法错误，不执行脚本 |
| `-v` | 执行前显示脚本内容 |
| `-x` | 执行时显示每个命令及其参数 |
| `-e` | 命令失败时退出脚本 |
| `-u` | 使用未定义变量时退出脚本 |
| `-o pipefail` | 管道中的命令失败时，整个管道失败 |

```bash
# 同时使用多个调试选项
set -euxo pipefail
```

## 12. 最佳实践

1. **使用 Shebang 行**：始终在脚本开头添加 `#!/bin/bash`
2. **使用 `set -euxo pipefail`**：提高脚本健壮性
3. **使用局部变量**：在函数中使用 `local` 关键字声明变量
4. **引用变量**：始终使用双引号引用变量，避免空格和特殊字符问题
5. **使用 `[[ ]]` 替代 `[ ]`**：`[[ ]]` 支持正则表达式和更丰富的语法
6. **使用 `$()` 替代反引号**：`$()` 支持嵌套，更易读
7. **编写注释**：为复杂逻辑添加注释，提高可维护性
8. **使用函数**：将重复代码封装为函数
9. **处理错误**：检查命令执行结果，提供清晰的错误信息
10. **使用版本控制**：将脚本存储在 Git 等版本控制系统中

## 13. 常见问题解决方案

### 13.1 端口占用解决方案

在开发过程中，经常会遇到端口被占用的问题。以下是几种解决方法：

#### 13.1.1 查找占用端口的进程

```bash
# Linux/macOS
lsof -i :8000

# 只显示进程 ID
lsof -t -i :8000

# Windows
netstat -ano | findstr :8000
```

#### 13.1.2 终止占用端口的进程

```bash
# Linux/macOS
kill -9 $(lsof -t -i :8000)

# Windows
# 先查找 PID，然后终止进程
taskkill /PID <PID> /F
```

#### 13.1.3 使用脚本查找和终止占用端口的进程

```bash
#!/bin/bash

# 终止占用指定端口的进程
kill_port() {
    local port=$1
    local pid
    
    if command -v lsof &> /dev/null; then
        # Linux/macOS
        pid=$(lsof -t -i :$port)
        if [ -n "$pid" ]; then
            kill -9 "$pid"
            echo "已终止占用端口 $port 的进程，PID: $pid"
        else
            echo "端口 $port 未被占用"
        fi
    elif command -v netstat &> /dev/null; then
        # Windows
        pid=$(netstat -ano | findstr :$port | awk '{print $5}' | head -n 1)
        if [ -n "$pid" ] && [ "$pid" != "0" ]; then
            taskkill /PID "$pid" /F
            echo "已终止占用端口 $port 的进程，PID: $pid"
        else
            echo "端口 $port 未被占用"
        fi
    else
        echo "无法检测端口占用情况，缺少 lsof 或 netstat 命令"
    fi
}

# 使用示例
kill_port 8000
```

#### 13.1.4 自动查找可用端口

```bash
#!/bin/bash

# 查找可用端口
find_available_port() {
    local start_port=${1:-8000}
    local max_port=${2:-9000}
    local port
    
    for port in $(seq "$start_port" "$max_port"); do
        if ! lsof -i :"$port" &> /dev/null; then
            echo "$port"
            return 0
        fi
    done
    
    echo ""  # 未找到可用端口
    return 1
}

# 使用示例
available_port=$(find_available_port 8000 9000)
if [ -n "$available_port" ]; then
    echo "找到可用端口: $available_port"
    # 在这里启动你的服务，使用找到的端口
else
    echo "没有找到可用端口"
fi
```

## 14. Excel 处理

### 14.1 使用 xlsx2csv 转换 Excel 文件

```bash
# 安装 xlsx2csv
sudo apt-get install xlsx2csv  # Debian/Ubuntu
brew install xlsx2csv          # macOS

# 将 Excel 文件转换为 CSV
xlsx2csv input.xlsx output.csv

# 指定工作表
xlsx2csv input.xlsx -s 2 output.csv  # 使用第 2 个工作表

# 使用工作表名称
xlsx2csv input.xlsx -n "Sheet2" output.csv
```

### 14.2 使用 Python 脚本处理 Excel 文件

```bash
#!/bin/bash

# 创建一个 Python 脚本来处理 Excel 文件
cat > excel_processor.py << 'EOF'
import pandas as pd

# 读取 Excel 文件
df = pd.read_excel('input.xlsx')

# 筛选数据
filtered_df = df[df['Age'] > 25]

# 写入 CSV
filtered_df.to_csv('output.csv', index=False)
EOF

# 运行脚本
python3 excel_processor.py
```

### 14.3 使用 LibreOffice 命令行转换 Excel 文件

```bash
# 将 Excel 文件转换为 CSV
libreoffice --headless --convert-to csv input.xlsx

# 指定输出目录
libreoffice --headless --convert-to csv input.xlsx --outdir /path/to/output
```

## 15. HTTP 请求与 OAuth2.0

### 15.1 使用 curl 发送 HTTP 请求

```bash
# 发送 GET 请求
curl https://api.example.com/data

# 发送 POST 请求
curl -X POST -H "Content-Type: application/json" -d '{"name":"张三","age":25}' https://api.example.com/users

# 保存响应到文件
curl -o response.json https://api.example.com/data
```

### 15.2 OAuth2.0 认证

#### 15.2.1 获取 OAuth2.0 令牌

```bash
#!/bin/bash

# 获取 OAuth2.0 令牌
get_oauth2_token() {
    local client_id="$1"
    local client_secret="$2"
    local token_endpoint="$3"
    local scope="$4"
    
    local response
    response=$(curl -s -X POST "$token_endpoint" \
        -H "Content-Type: application/x-www-form-urlencoded" \
        -d "grant_type=client_credentials" \
        -d "client_id=$client_id" \
        -d "client_secret=$client_secret" \
        -d "scope=$scope")
    
    # 解析 JSON 响应，提取访问令牌
    # 需要安装 jq 工具
    if command -v jq &> /dev/null; then
        echo "$response" | jq -r '.access_token'
    else
        # 不使用 jq，使用 grep 和 sed 解析
        echo "$response" | grep -o '"access_token":"[^"]*"' | sed 's/"access_token":"\(.*\)"/\1/'
    fi
}

# 使用示例
client_id="your-client-id"
client_secret="your-client-secret"
token_endpoint="https://auth.example.com/token"
scope="read write"

access_token=$(get_oauth2_token "$client_id" "$client_secret" "$token_endpoint" "$scope")
echo "访问令牌: $access_token"
```

#### 15.2.2 使用 OAuth2.0 令牌发送请求

```bash
#!/bin/bash

# 使用获取到的令牌发送请求
send_authenticated_request() {
    local access_token="$1"
    local url="$2"
    local method="${3:-GET}"
    local body="${4:-}"
    
    if [ -n "$body" ]; then
        curl -s -X "$method" "$url" \
            -H "Authorization: Bearer $access_token" \
            -H "Content-Type: application/json" \
            -d "$body"
    else
        curl -s -X "$method" "$url" \
            -H "Authorization: Bearer $access_token"
    fi
}

# 使用示例
access_token="your-access-token"
url="https://api.example.com/protected-resource"

response=$(send_authenticated_request "$access_token" "$url")
echo "响应: $response"
```

#### 15.2.3 解析 JSON 响应

```bash
#!/bin/bash

# 解析 JSON 响应，需要安装 jq 工具
parse_json_response() {
    local response="$1"
    local jq_query="$2"
    
    if command -v jq &> /dev/null; then
        echo "$response" | jq -r "$jq_query"
    else
        echo "错误: jq 工具未安装"
        return 1
    fi
}

# 使用示例
response='{"status":"success","data":{"count":10,"items":[{"id":1,"name":"张三"},{"id":2,"name":"李四"}]}}'

# 解析状态
status=$(parse_json_response "$response" ".status")
echo "状态: $status"

# 解析数据数量
count=$(parse_json_response "$response" ".data.count")
echo "数据数量: $count"

# 解析第一个项目的名称
first_item_name=$(parse_json_response "$response" ".data.items[0].name")
echo "第一个项目名称: $first_item_name"
```

## 16. 资源推荐

- [Bash 官方文档](https://www.gnu.org/software/bash/manual/)
- [Shell Scripting Tutorial](https://www.shellscript.sh/)
- [Advanced Bash-Scripting Guide](https://tldp.org/LDP/abs/html/)
- [ShellCheck - Shell 脚本静态分析工具](https://www.shellcheck.net/)