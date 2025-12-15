# Windows 批处理脚本语法指南

## 1. 批处理语法概述

批处理脚本是一种解释型脚本语言，由一系列 Windows 命令行命令组成，按照顺序执行。批处理语法相对简单，但功能强大，适合自动化各种 Windows 系统任务。

## 2. 基本语法规则

### 2.1 命令大小写不敏感

批处理命令不区分大小写，以下命令是等效的：

```batch
echo Hello World
eCHO Hello World
ECHO Hello World
```

### 2.2 命令分隔符

- 使用换行符分隔命令（推荐）
- 使用 `&` 符号在同一行分隔多个命令
- 使用 `&&` 符号在同一行分隔多个命令，只有前一个命令成功执行后，后一个命令才会执行
- 使用 `||` 符号在同一行分隔多个命令，只有前一个命令失败执行后，后一个命令才会执行

**示例**：
```batch
:: 换行符分隔命令
echo 命令1
echo 命令2

:: & 符号分隔命令
echo 命令1 & echo 命令2

:: && 符号分隔命令（前一个成功，后一个才执行）
echo 命令1 && echo 命令2

:: || 符号分隔命令（前一个失败，后一个才执行）
invalid_command || echo 命令1执行失败
```

### 2.3 长命令换行

使用 `^` 符号可以将长命令分成多行：

**示例**：
```batch
xcopy "source" "dest" /E /I /Y /H /R ^
    /EXCLUDE:exclude.txt ^
    /LOG:copy.log
```

### 2.4 注释

- 使用 `rem` 命令添加注释
- 使用 `::` 添加注释（更常用，执行速度更快）
- 注释不能嵌套
- 注释不能放在命令后面

**示例**：
```batch
rem 这是一条注释
:: 这也是一条注释

:: 错误：注释不能放在命令后面
echo Hello World rem 这是错误的注释位置
```

## 3. 变量语法

### 3.1 变量定义

**语法**：
```batch
set 变量名=变量值
```

**规则**：
- 变量名只能包含字母、数字和下划线
- 变量名不能以数字开头
- 变量值中不能包含特殊字符，如 `&`, `|`, `>`, `<` 等，除非使用引号
- 等号 `=` 前后不能有空格

**示例**：
```batch
:: 正确的变量定义
set name=张三
set age=18
set user_name=李四

:: 错误的变量定义
set my var=value  :: 变量名包含空格
set 123var=value  :: 变量名以数字开头
set path=C:\Program Files  :: 路径包含空格，未使用引号
set name = 张三  :: 等号前后有空格
```

### 3.2 变量引用

**语法**：
```batch
%变量名%
```

**延迟扩展**：
在循环和条件语句中，需要使用延迟扩展：

```batch
:: 启用延迟扩展
setlocal enabledelayedexpansion

:: 使用延迟扩展引用变量
!变量名!
```

**示例**：
```batch
:: 普通变量引用
set name=张三
echo 姓名：%name%

:: 延迟扩展引用
setlocal enabledelayedexpansion
set count=0
for %%i in (1 2 3) do (
    set /a count+=1
    echo 第 !count! 次循环
)
endlocal
```

### 3.3 变量删除

**语法**：
```batch
set 变量名=
```

**示例**：
```batch
set name=张三
echo 姓名：%name%
set name=
echo 姓名：%name%  :: 变量已删除，输出空值
```

### 3.4 系统变量

Windows 预定义了许多系统变量，可以直接使用：

| 变量 | 说明 |
|------|------|
| `%CD%` | 当前目录 |
| `%DATE%` | 当前日期 |
| `%TIME%` | 当前时间 |
| `%USERNAME%` | 当前用户名 |
| `%COMPUTERNAME%` | 计算机名 |
| `%PATH%` | 系统路径 |
| `%TEMP%` | 临时目录 |
| `%ERRORLEVEL%` | 上一个命令的返回码 |
| `%~dp0` | 脚本所在目录的绝对路径 |

**示例**：
```batch
echo 当前目录：%CD%
echo 当前用户：%USERNAME%
echo 脚本目录：%~dp0
echo PATH变量：%PATH%
```

### 3.5 命令行参数

批处理脚本可以接受命令行参数，使用 `%1`、`%2` 等引用：

| 参数 | 说明 |
|------|------|
| `%0` | 脚本本身的路径 |
| `%1` | 第一个参数 |
| `%2` | 第二个参数 |
| `%*` | 所有参数 |
| `%~n1` | 第一个参数的文件名（不含扩展名） |
| `%~x1` | 第一个参数的扩展名 |
| `%~dp1` | 第一个参数的驱动器和路径 |
| `%~f1` | 第一个参数的完整路径 |

**示例**：
```batch
@echo off
echo 脚本名称：%0
echo 第一个参数：%1
echo 第二个参数：%2
echo 所有参数：%*
echo 第一个参数的文件名：%~n1
echo 第一个参数的扩展名：%~x1
echo 第一个参数的路径：%~dp1
echo 第一个参数的完整路径：%~f1
```

## 4. 运算符

### 4.1 赋值运算符

使用 `=` 符号进行赋值：

**示例**：
```batch
set name=张三
```

### 4.2 数值运算符

使用 `set /a` 命令进行数值运算，支持以下运算符：

| 运算符 | 说明 | 示例 |
|--------|------|------|
| `+` | 加法 | `set /a sum=1+2` |
| `-` | 减法 | `set /a diff=3-1` |
| `*` | 乘法 | `set /a mul=2*3` |
| `/` | 除法（整数除法） | `set /a div=10/3` |
| `%` | 取模 | `set /a mod=10%3` |
| `++` | 递增 | `set /a count+=1` 或 `set /a count++` |
| `--` | 递减 | `set /a count-=1` 或 `set /a count--` |
| `&` | 按位与 | `set /a result=5&3` |
| `|` | 按位或 | `set /a result=5|3` |
| `^` | 按位异或 | `set /a result=5^3` |
| `~` | 按位非 | `set /a result=~5` |
| `<<` | 左移 | `set /a result=5<<1` |
| `>>` | 右移 | `set /a result=5>>1` |
| `=` | 赋值 | `set /a var=5` |
| `+=` | 加法赋值 | `set /a var+=5` |
| `-=` | 减法赋值 | `set /a var-=5` |
| `*=` | 乘法赋值 | `set /a var*=5` |
| `/=` | 除法赋值 | `set /a var/=5` |
| `%=` | 取模赋值 | `set /a var%=5` |
| `&=` | 按位与赋值 | `set /a var&=5` |
| `|=` | 按位或赋值 | `set /a var|=5` |
| `^=` | 按位异或赋值 | `set /a var^=5` |
| `<<=` | 左移赋值 | `set /a var<<=1` |
| `>>=` | 右移赋值 | `set /a var>>=1` |

**示例**：
```batch
@echo off
set /a num1=10
set /a num2=5

set /a sum=num1+num2
echo 两数之和：%sum%

set /a diff=num1-num2
echo 两数之差：%diff%

set /a mul=num1*num2
echo 两数之积：%mul%

set /a div=num1/num2
echo 两数之商：%div%

set /a mod=num1%%num2
echo 两数取模：%mod%

set /a count=0
set /a count+=1
echo 递增后：%count%

set /a count--
echo 递减后：%count%
```

### 4.3 字符串运算符

批处理支持以下字符串运算符：

| 运算符 | 说明 | 示例 |
|--------|------|------|
| `%变量名:~开始位置%` | 从开始位置截取到字符串末尾 | `set str=Hello & echo %str:~2%` → `llo` |
| `%变量名:~开始位置,长度%` | 从开始位置截取指定长度的字符串 | `set str=Hello & echo %str:~1,3%` → `ell` |
| `%变量名:~-开始位置%` | 从字符串末尾开始截取指定长度 | `set str=Hello & echo %str:~-2%` → `lo` |
| `%变量名:~-开始位置,长度%` | 从字符串末尾开始截取指定长度 | `set str=Hello & echo %str:~-3,2%` → `ll` |
| `%变量名:查找字符串=替换字符串%` | 替换字符串中的指定子串 | `set str=Hello World & echo %str:World=Batch%` → `Hello Batch` |

**示例**：
```batch
@echo off
set str=Hello, World!

:: 从第 2 个字符开始截取到末尾（索引从 0 开始）
echo 从第 2 个字符开始：%str:~1%

:: 从第 2 个字符开始截取 5 个字符
echo 从第 2 个字符开始截取 5 个字符：%str:~1,5%

:: 从末尾开始截取 5 个字符
echo 从末尾开始截取 5 个字符：%str:~-5%

:: 从末尾第 6 个字符开始截取 3 个字符
echo 从末尾第 6 个字符开始截取 3 个字符：%str:~-6,3%

:: 替换字符串
echo 替换 World 为 Batch：%str:World=Batch%

:: 替换所有空格为下划线
echo 替换所有空格为下划线：%str: =_%
```

### 4.4 比较运算符

#### 4.4.1 字符串比较运算符

| 运算符 | 说明 |
|--------|------|
| `==` | 等于 |
| `EQU` | 等于（与 `==` 等效） |
| `NEQ` | 不等于 |
| `/I` | 忽略大小写比较（用于 `IF` 命令） |

**示例**：
```batch
@echo off
set str1=Hello
set str2=hello

:: 大小写敏感比较
if %str1%==%str2% (
    echo 字符串相等
) else (
    echo 字符串不相等
)

:: 忽略大小写比较
if /I %str1%==%str2% (
    echo 字符串相等（忽略大小写）
) else (
    echo 字符串不相等（忽略大小写）
)
```

#### 4.4.2 数值比较运算符

| 运算符 | 说明 |
|--------|------|
| `EQU` | 等于 |
| `NEQ` | 不等于 |
| `LSS` | 小于 |
| `LEQ` | 小于等于 |
| `GTR` | 大于 |
| `GEQ` | 大于等于 |

**示例**：
```batch
@echo off
set num1=10
set num2=20

if %num1% EQU %num2% (
    echo %num1% 等于 %num2%
) else (
    echo %num1% 不等于 %num2%
)

if %num1% LSS %num2% (
    echo %num1% 小于 %num2%
) else (
    echo %num1% 不小于 %num2%
)

if %num1% LEQ %num2% (
    echo %num1% 小于等于 %num2%
) else (
    echo %num1% 大于 %num2%
)

if %num1% GTR %num2% (
    echo %num1% 大于 %num2%
) else (
    echo %num1% 不大于 %num2%
)

if %num1% GEQ %num2% (
    echo %num1% 大于等于 %num2%
) else (
    echo %num1% 小于 %num2%
)
```

## 5. 流程控制语法

### 5.1 IF 语句

**语法**：

```batch
:: 基本 IF 语句
if 条件 命令

:: IF-ELSE 语句
if 条件 (
    命令1
    命令2
) else (
    命令3
    命令4
)

:: 字符串比较
if [not] string1==string2 命令 [else 命令]

:: 数值比较
if [not] number1 operator number2 命令 [else 命令]

:: 文件/目录存在判断
if [not] exist filename/directory 命令 [else 命令]

:: 错误码判断
if [not] errorlevel number 命令 [else 命令]

:: 变量是否已定义判断
if [not] defined 变量名 命令 [else 命令]
```

**示例**：
```batch
@echo off

:: 字符串比较
set name=张三
if /i %name%==张三 (
    echo 姓名匹配
) else (
    echo 姓名不匹配
)

:: 数值比较
set age=18
if %age% GEQ 18 (
    echo 成年人
) else (
    echo 未成年人
)

:: 文件存在判断
if exist "file.txt" (
    echo 文件存在
) else (
    echo 文件不存在
)

:: 变量是否已定义
if defined name (
    echo 变量 name 已定义，值为：%name%
) else (
    echo 变量 name 未定义
)

:: 错误码判断
dir nonexistent_file >nul 2>&1
if errorlevel 1 (
    echo 命令执行失败
) else (
    echo 命令执行成功
)
```

### 5.2 FOR 循环

**语法**：

#### 5.2.1 基本 FOR 循环

```batch
for %%变量 in (集合) do 命令
```

**示例**：
```batch
@echo off
:: 遍历数字集合
for %%i in (1 2 3 4 5) do (
    echo 数字：%%i
)

:: 遍历文件
for %%i in (*.txt) do (
    echo 文本文件：%%i
)

:: 遍历字符串集合
for %%i in (张三 李四 王五) do (
    echo 姓名：%%i
)
```

#### 5.2.2 FOR /F 循环（处理文件内容、命令输出或字符串）

```batch
:: 处理文件内容
for /f [选项] %%变量 in (文件名) do 命令

:: 处理命令输出
for /f [选项] %%变量 in ('命令') do 命令

:: 处理字符串
for /f [选项] %%变量 in ("字符串") do 命令
```

**常用选项**：

| 选项 | 说明 |
|------|------|
| `tokens=数值列表` | 指定要提取的字段，如 `tokens=1,3` 表示提取第 1 和第 3 个字段 |
| `delims=分隔符` | 指定字段分隔符，默认是空格和制表符 |
| `skip=数值` | 跳过文件开头的指定行数 |
| `eol=字符` | 指定行注释符，默认是 `;` |
| `usebackq` | 允许使用反引号 ` 执行命令，使用双引号 " 处理文件路径 |

**示例**：
```batch
@echo off
:: 处理字符串，提取字段
for /f "tokens=1-3 delims=," %%i in ("张三,18,男") do (
    echo 姓名：%%i，年龄：%%j，性别：%%k
)

:: 处理命令输出
for /f "tokens=*" %%i in ('dir /b *.txt') do (
    echo 文本文件：%%i
)

:: 处理文件内容（假设 data.csv 包含类似 "张三,18,男" 的内容）
for /f "tokens=1-3 delims=, skip=1" %%i in (data.csv) do (
    echo 姓名：%%i，年龄：%%j，性别：%%k
)
```

#### 5.2.3 FOR /R 循环（递归遍历目录）

```batch
for /r [路径] %%变量 in (集合) do 命令
```

**示例**：
```batch
@echo off
:: 递归遍历当前目录及其子目录中的所有 .txt 文件
for /r %%i in (*.txt) do (
    echo 文本文件：%%i
)

:: 递归遍历指定目录及其子目录中的所有 .txt 文件
for /r "C:\data" %%i in (*.txt) do (
    echo 文本文件：%%i
)
```

#### 5.2.4 FOR /L 循环（数值范围循环）

```batch
for /l %%变量 in (开始值,步长,结束值) do 命令
```

**示例**：
```batch
@echo off
:: 从 1 到 10，步长为 1 的循环
for /l %%i in (1,1,10) do (
    echo 数值：%%i
)

:: 从 10 到 1，步长为 -2 的循环
for /l %%i in (10,-2,1) do (
    echo 数值：%%i
)
```

### 5.3 GOTO 语句

**语法**：
```batch
:标签名
:: 代码块
goto 标签名
```

**示例**：
```batch
@echo off

echo 1. 选项一
echo 2. 选项二
echo 3. 退出
set /p choice=请输入您的选择：

if "%choice%"=="1" goto option1
if "%choice%"=="2" goto option2
if "%choice%"=="3" goto exit

echo 无效选择
goto end

:option1
echo 您选择了选项一
goto end

:option2
echo 您选择了选项二
goto end

:exit
echo 退出脚本
exit /b

:end
echo 脚本结束
```

### 5.4 CALL 语句

**语法**：
```batch
:: 调用批处理文件
call 脚本路径 [参数]

:: 调用标签（函数）
call :标签名 [参数]
```

**示例**：
```batch
@echo off
:: 调用外部批处理文件
call other_script.cmd param1 param2

:: 调用标签（函数）
call :say_hello 张三

goto end

:say_hello
echo 你好，%1！
goto :eof

:end
echo 脚本结束
```

## 6. 函数语法

### 6.1 函数定义

**语法**：
```batch
:函数名
:: 函数代码
:: ...
goto :eof
```

**规则**：
- 函数名不能包含空格或特殊字符
- 函数必须以 `goto :eof` 或 `exit /b` 结束
- 函数可以放在脚本的任何位置

### 6.2 函数调用

**语法**：
```batch
call :函数名 [参数1] [参数2] ...
```

### 6.3 函数参数

函数参数使用 `%1`、`%2`、`%3` 等引用，与脚本命令行参数类似。

### 6.4 函数返回值

批处理函数没有直接的返回值机制，可以通过以下方式返回结果：

1. **使用全局变量**：
```batch
@echo off
call :add 10 5
echo 结果：%result%

goto end

:add
set /a result=%1+%2
goto :eof

:end
```

2. **使用 ERRORLEVEL**：
```batch
@echo off
call :is_file_exist "file.txt"
if errorlevel 1 (
    echo 文件不存在
) else (
    echo 文件存在
)

goto end

:is_file_exist
if exist "%1" (
    exit /b 0
) else (
    exit /b 1
)

:end
```

## 7. 特殊字符和转义

### 7.1 特殊字符

以下字符在批处理中有特殊含义，需要转义才能作为普通字符使用：

| 字符 | 含义 | 转义方式 |
|------|------|----------|
| `&` | 命令分隔符 | `^&` |
| `|` | 管道符号 | `^|` |
| `<` | 输入重定向 | `^<` |
| `>` | 输出重定向 | `^>` |
| `^` | 转义字符 | `^^` |
| `%` | 变量引用 | `%%` |
| `!` | 延迟变量引用 | `^!` |
| `(` | 括号开始 | `^(` |
| `)` | 括号结束 | `^)` |

### 7.2 转义字符

使用 `^` 符号转义特殊字符：

**示例**：
```batch
@echo off
:: 输出特殊字符
setlocal enabledelayedexpansion
echo 输出 & 符号：^&
echo 输出 | 符号：^|
echo 输出 < 符号：^<
echo 输出 > 符号：^>
echo 输出 ^ 符号：^^
echo 输出 %% 符号：%%
echo 输出 ! 符号：^!
echo 输出 ( ) 符号：^( ^)
endlocal
```

## 8. 命令语法规则

### 8.1 命令参数

- 命令参数之间使用空格分隔
- 如果参数包含空格，需要使用引号包裹
- 参数可以使用变量引用

**示例**：
```batch
:: 正确的命令参数
echo Hello World
copy "file with spaces.txt" "dest folder"
xcopy "%source_dir%" "%dest_dir%" /E /I /Y

:: 错误的命令参数（路径包含空格，未使用引号）
copy file with spaces.txt dest folder
```

### 8.2 命令输出重定向

| 符号 | 说明 |
|------|------|
| `>` | 将命令输出重定向到文件，覆盖现有文件 |
| `>>` | 将命令输出重定向到文件，追加到现有文件 |
| `<` | 将文件内容作为命令输入 |
| `2>` | 将错误输出重定向到文件 |
| `2>&1` | 将错误输出重定向到标准输出 |
| `>nul` | 将输出重定向到空设备（丢弃输出） |
| `2>nul` | 将错误输出重定向到空设备 |
| `>nul 2>&1` | 将标准输出和错误输出都重定向到空设备 |

**示例**：
```batch
:: 将输出重定向到文件
 echo Hello > output.txt

:: 将输出追加到文件
 echo World >> output.txt

:: 将错误输出重定向到文件
 invalid_command 2> error.log

:: 将标准输出和错误输出都重定向到文件
 command > all_output.log 2>&1

:: 丢弃输出
 command > nul

:: 丢弃标准输出和错误输出
 command > nul 2>&1
```

### 8.3 管道

使用 `|` 符号可以将一个命令的输出作为另一个命令的输入：

**示例**：
```batch
:: 查找包含 "error" 的行
dir /s | find "error"

:: 统计文件数量
dir /b *.txt | find /c ""

:: 分页显示输出
dir /s | more
```

## 9. 环境变量语法

### 9.1 局部环境变量

使用 `setlocal` 和 `endlocal` 命令可以创建局部环境：

**语法**：
```batch
setlocal [选项]
:: 脚本代码
sendlocal
```

**常用选项**：

| 选项 | 说明 |
|------|------|
| `enabledelayedexpansion` | 启用变量延迟扩展 |
| `disabledelayedexpansion` | 禁用变量延迟扩展 |
| `enableextensions` | 启用命令扩展（默认） |
| `disableextensions` | 禁用命令扩展 |

**示例**：
```batch
@echo off
:: 全局变量
set global_var=global_value

echo 全局变量初始值：%global_var%

:: 创建局部环境
setlocal enabledelayedexpansion
set local_var=local_value
set global_var=local_modified_value

echo 局部环境中：
echo 全局变量：%global_var%
echo 局部变量：%local_var%

:: 退出局部环境
endlocal

echo 退出局部环境后：
echo 全局变量：%global_var%
echo 局部变量：%local_var%  :: 局部变量已失效
```

### 9.2 永久性环境变量

使用 `setx` 命令可以设置永久性环境变量：

**语法**：
```batch
setx 变量名 变量值 [/M]
```

**选项**：

| 选项 | 说明 |
|------|------|
| `/M` | 设置系统环境变量（需要管理员权限），默认是用户环境变量 |

**示例**：
```batch
:: 设置用户永久性环境变量
setx JAVA_HOME "C:\Program Files\Java\jdk1.8.0_201"

:: 设置系统永久性环境变量（需要管理员权限）
setx PATH "%PATH%;C:\Program Files\Java\jdk1.8.0_201\bin" /M
```

## 10. 批处理文件特殊语法

### 10.1 脚本文件扩展名

批处理脚本文件可以使用 `.bat` 或 `.cmd` 扩展名：

- `.bat`：兼容所有 Windows 版本
- `.cmd`：针对 Windows NT 系列优化，推荐使用

### 10.2 脚本头部

良好的脚本应该包含头部信息，说明脚本的用途、作者、版本等：

**示例**：
```batch
@echo off
rem ==============================================
rem 脚本名称：backup.cmd
rem 脚本用途：备份指定目录下的文件
rem 作者：张三
rem 创建时间：2023-01-01
rem 版本：1.0
rem ==============================================
```

### 10.3 脚本退出

使用 `exit` 或 `exit /b` 命令退出脚本：

| 命令 | 说明 |
|------|------|
| `exit` | 退出当前命令提示符窗口 |
| `exit /b [退出码]` | 退出当前脚本，返回指定的退出码，不关闭命令提示符窗口 |

**示例**：
```batch
@echo off
:: 正常退出脚本
echo 脚本执行完成
exit /b 0

:: 错误退出脚本
echo 脚本执行失败
exit /b 1
```

## 11. 语法最佳实践

1. **使用 `@echo off` 开头**：关闭命令回显，使输出更整洁
2. **使用 `setlocal enabledelayedexpansion`**：启用变量延迟扩展，避免循环中的变量问题
3. **使用有意义的变量名**：变量名应该清晰表达其用途
4. **使用引号包裹路径**：避免路径中包含空格导致的问题
5. **添加注释**：解释脚本的功能和逻辑
6. **使用 `goto :eof` 结束函数**：确保函数正确返回
7. **检查命令执行结果**：使用 `%ERRORLEVEL%` 或 `IF ERRORLEVEL` 检查命令是否成功执行
8. **使用 `setx` 仅用于设置永久性环境变量**：临时环境变量使用 `set` 命令
9. **避免使用 `goto` 过多**：过多的 `goto` 会使脚本逻辑混乱，难以维护
10. **使用函数模块化代码**：将复杂功能拆分为多个函数，提高代码的可维护性

## 总结

批处理语法虽然相对简单，但功能强大，适合自动化各种 Windows 系统任务。掌握批处理语法的关键点包括：

- 基本语法规则和命令格式
- 变量定义、引用和延迟扩展
- 数值和字符串运算符
- 流程控制语句（IF、FOR、GOTO、CALL）
- 函数定义和调用
- 特殊字符转义
- 环境变量管理

通过学习和实践批处理语法，可以编写出高效、可靠的自动化脚本，提高工作效率。