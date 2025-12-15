# Windows 批处理脚本编写指南

## 1. 批处理脚本基础

### 1.1 脚本文件格式

批处理脚本是扩展名为 `.bat` 或 `.cmd` 的文本文件，包含一系列 Windows 命令行命令。

- `.bat`：兼容所有 Windows 版本
- `.cmd`：针对 Windows NT 系列优化，推荐使用

### 1.2 创建和运行脚本

**创建脚本**：
1. 使用文本编辑器（如 Notepad、VS Code）创建新文件
2. 编写批处理命令
3. 保存为 `.bat` 或 `.cmd` 文件

**运行脚本**：
1. 双击脚本文件
2. 在命令提示符中输入脚本路径
3. 使用 `CMD /K` 命令运行脚本（保持窗口打开）

**示例**：
```batch
@echo off
rem 这是一个简单的批处理脚本
echo Hello, World!
pause
```

### 1.3 脚本编码

- 建议使用 ANSI 编码保存批处理脚本，以确保在所有 Windows 版本上正常运行
- 如果需要支持 Unicode 字符，可以使用 UTF-8 编码，但需要在脚本开头添加 `chcp 65001` 命令

## 2. 脚本结构和规范

### 2.1 脚本头部信息

良好的脚本应该包含头部信息，说明脚本的用途、作者、版本等。

**示例**：
```batch
@echo off
rem ==============================================
rem 脚本名称：backup_files.cmd
rem 脚本用途：备份指定目录下的所有文件到备份目录
rem 作者：张三
rem 创建时间：2023-01-01
rem 版本：1.0
rem ==============================================
```

### 2.2 脚本注释

- 使用 `rem` 或 `::` 添加注释
- `::` 是更常用的注释方式，执行速度更快
- 注释应该清晰说明代码的功能和逻辑

**示例**：
```batch
:: 定义变量
set source_dir=C:\data
set backup_dir=D:\backup

:: 检查源目录是否存在
if not exist "%source_dir%" (
    echo 源目录不存在，退出脚本
    exit /b 1
)
```

### 2.3 脚本布局

- 使用缩进（通常是 4 个空格或 1 个制表符）来表示代码块
- 空行分隔不同的逻辑部分
- 长命令可以使用 `^` 符号换行

**示例**：
```batch
:: 长命令换行示例
xcopy "%source_dir%" "%backup_dir%" /E /I /Y /H /R ^
    /EXCLUDE:exclude.txt
```

## 3. 变量和参数处理

### 3.1 变量定义和引用

**定义变量**：
```batch
set variable_name=value
```

**引用变量**：
```batch
echo %variable_name%
```

**示例**：
```batch
set name=张三
echo 姓名：%name%
```

### 3.2 系统变量

Windows 提供了许多预定义的系统变量，可以直接使用：

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

**示例**：
```batch
echo 当前目录：%CD%
echo 当前用户：%USERNAME%
echo 当前日期：%DATE%
echo 当前时间：%TIME%
```

### 3.3 命令行参数

批处理脚本可以接受命令行参数，使用 `%1`、`%2`、`%3` 等表示：

- `%0`：脚本本身的路径
- `%1`：第一个参数
- `%2`：第二个参数
- `%*`：所有参数
- `%~n1`：第一个参数的文件名（不含扩展名）
- `%~x1`：第一个参数的扩展名
- `%~dp1`：第一个参数的驱动器和路径

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
```

### 3.4 变量延迟扩展

在循环和条件语句中，变量需要使用延迟扩展才能正确更新：

**启用延迟扩展**：
```batch
setlocal enabledelayedexpansion
```

**使用延迟扩展**：
```batch
echo !variable_name!
```

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

set count=0
for %%i in (1 2 3) do (
    set /a count+=1
    echo 第 !count! 次循环
)

echo 总循环次数：!count!
endlocal
```

### 3.5 变量运算

使用 `set /a` 命令进行数值运算：

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
```

## 4. 流程控制

### 4.1 条件判断

**IF 语句**：
```batch
:: 字符串比较
if [not] string1==string2 command [else command]

:: 数值比较
if [not] number1 operator number2 command [else command]

:: 文件/目录存在判断
if [not] exist filename/directory command [else command]

:: 错误码判断
if [not] errorlevel number command [else command]
```

**数值比较运算符**：
- `EQU`：等于
- `NEQ`：不等于
- `LSS`：小于
- `LEQ`：小于等于
- `GTR`：大于
- `GEQ`：大于等于

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

:: 错误码判断
dir nonexistent_file >nul 2>&1
if errorlevel 1 (
    echo 命令执行失败
) else (
    echo 命令执行成功
)
```

### 4.2 循环结构

**FOR 循环**：

1. **基本 FOR 循环**：
```batch
for %%variable in (set) do command
```

**示例**：
```batch
@echo off
:: 遍历集合中的元素
for %%i in (1 2 3 4 5) do (
    echo 元素：%%i
)

:: 遍历文件
for %%i in (*.txt) do (
    echo 文本文件：%%i
)
```

2. **FOR /F 循环**（处理文件内容、命令输出或字符串）：
```batch
for /f [options] %%variable in (file) do command
for /f [options] %%variable in ('command') do command
for /f [options] %%variable in ("string") do command
```

**常用选项**：
- `tokens`：指定要提取的字段
- `delims`：指定分隔符
- `skip`：跳过前 N 行
- `eol`：指定行注释符

**示例**：
```batch
@echo off
:: 处理文件内容
for /f "tokens=1,2 delims=," %%i in (data.csv) do (
    echo 第一列：%%i，第二列：%%j
)

:: 处理命令输出
for /f "tokens=*" %%i in ('dir /b') do (
    echo 文件：%%i
)

:: 处理字符串
for /f "tokens=1-3 delims= " %%i in ("张三 18 男") do (
    echo 姓名：%%i，年龄：%%j，性别：%%k
)
```

3. **FOR /R 循环**（递归遍历目录）：
```batch
for /r [path] %%variable in (set) do command
```

**示例**：
```batch
@echo off
:: 递归遍历当前目录及其子目录中的所有 .txt 文件
for /r %%i in (*.txt) do (
    echo 文本文件：%%i
)
```

4. **FOR /L 循环**（数值范围循环）：
```batch
for /l %%variable in (start,step,end) do command
```

**示例**：
```batch
@echo off
:: 从 1 到 10，步长为 2 的循环
for /l %%i in (1,2,10) do (
    echo 数值：%%i
)
```

### 4.3 跳转语句

**GOTO 语句**：
```batch
:label
:: 代码块
goto label
```

**示例**：
```batch
@echo off

echo 1. 备份文件
echo 2. 恢复文件
echo 3. 退出
set /p choice=请输入您的选择：

if "%choice%"=="1" goto backup
if "%choice%"=="2" goto restore
if "%choice%"=="3" goto exit

echo 无效选择
goto end

:backup
echo 执行备份操作...
goto end

:restore
echo 执行恢复操作...
goto end

:exit
echo 退出脚本
exit /b

:end
echo 脚本结束
```

## 5. 函数和模块化

### 5.1 函数定义和调用

**定义函数**：
```batch
:function_name
:: 函数代码
:: ...
goto :eof
```

**调用函数**：
```batch
call :function_name [arguments]
```

**示例**：
```batch
@echo off

:: 调用函数
call :say_hello 张三
call :calculate 10 5

goto end

:: 定义函数：输出问候语
:say_hello
echo 你好，%1！
goto :eof

:: 定义函数：计算两数之和
:calculate
set /a sum=%1+%2
echo %1 + %2 = %sum%
goto :eof

:end
echo 脚本结束
```

### 5.2 函数参数

函数参数使用 `%1`、`%2` 等引用，与脚本命令行参数类似。

**示例**：
```batch
@echo off

call :print_info 张三 18 男

goto end

:print_info
echo 姓名：%1
echo 年龄：%2
echo 性别：%3
goto :eof

:end
```

### 5.3 函数返回值

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

## 6. 错误处理

### 6.1 检查命令执行结果

使用 `%ERRORLEVEL%` 变量或 `IF ERRORLEVEL` 语句检查命令执行结果。

**示例**：
```batch
@echo off

:: 方法 1：使用 IF ERRORLEVEL
dir nonexistent_file >nul 2>&1
if errorlevel 1 (
    echo 命令执行失败
)

:: 方法 2：使用 %ERRORLEVEL%
dir nonexistent_file >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo 命令执行失败
)
```

### 6.2 重定向错误输出

使用 `2>` 或 `2>&1` 重定向错误输出：

- `command >nul 2>&1`：将标准输出和错误输出都重定向到空设备
- `command 2>error.log`：将错误输出重定向到文件

**示例**：
```batch
@echo off
:: 将错误输出重定向到文件
xcopy "source" "dest" /E /I /Y 2>error.log

:: 检查命令是否成功执行
if errorlevel 1 (
    echo 复制失败，请查看 error.log
) else (
    echo 复制成功
)
```

### 6.3 脚本错误处理

使用 `setlocal` 和 `endlocal` 创建局部环境，防止错误影响整个脚本：

**示例**：
```batch
@echo off
setlocal

:: 执行可能失败的命令
xcopy "source" "dest" /E /I /Y
if errorlevel 1 (
    echo 复制失败
    endlocal
    exit /b 1
)

echo 复制成功
endlocal
exit /b 0
```

## 7. 调试和测试

### 7.1 启用命令回显

在脚本开头使用 `@echo on` 或删除 `@echo off` 来查看脚本执行的详细过程。

**示例**：
```batch
@echo on
:: 脚本代码...
```

### 7.2 添加调试信息

使用 `echo` 命令输出变量值和执行状态：

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

set count=0
for %%i in (*.txt) do (
    set /a count+=1
    echo [DEBUG] 处理文件：%%i，当前计数：!count!
    :: 处理文件的代码...
)

echo [DEBUG] 总处理文件数：!count!
endlocal
```

### 7.3 逐行执行脚本

在脚本中关键位置添加 `pause` 命令，逐行执行脚本：

**示例**：
```batch
@echo off

:: 第一步
echo 执行第一步
pause

:: 第二步
echo 执行第二步
pause

:: 第三步
echo 执行第三步
pause
```

### 7.4 使用临时文件

将中间结果保存到临时文件，便于检查：

**示例**：
```batch
@echo off
:: 将命令输出保存到临时文件
dir /s >temp.txt

:: 查看临时文件内容
type temp.txt

:: 删除临时文件
del temp.txt
```

## 8. 最佳实践

### 8.1 脚本设计原则

1. **简洁明了**：脚本应该简洁易懂，避免复杂的逻辑
2. **模块化**：将复杂功能拆分为多个函数
3. **可维护性**：使用清晰的变量名、函数名和注释
4. **可靠性**：添加错误处理和边界条件检查
5. **可移植性**：避免使用特定版本的命令或功能

### 8.2 变量命名规范

- 使用有意义的变量名
- 变量名使用小写或驼峰命名法
- 避免使用系统保留变量名
- 使用常量时，变量名全部大写

**示例**：
```batch
:: 好的命名
set source_dir=C:\data
set backup_dir=D:\backup
set MAX_RETRY=3

:: 不好的命名
set s=C:\data
set b=D:\backup
set m=3
```

### 8.3 路径处理

- 始终使用引号包裹包含空格的路径
- 尽量使用绝对路径
- 使用 `%~dp0` 获取脚本所在目录的绝对路径

**示例**：
```batch
@echo off
:: 获取脚本所在目录
set script_dir=%~dp0

:: 使用绝对路径
set config_file="%script_dir%config.ini"
set log_file="%script_dir%logs\script.log"
```

### 8.4 权限处理

- 明确脚本需要的权限
- 在脚本开头检查是否以管理员身份运行

**示例**：
```batch
@echo off
:: 检查是否以管理员身份运行
net session >nul 2>&1
if errorlevel 1 (
    echo 请以管理员身份运行此脚本
    exit /b 1
)

:: 脚本主体...
```

### 8.5 日志记录

- 将脚本执行过程和结果记录到日志文件
- 包含时间戳、执行状态等信息

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

:: 定义日志文件
set log_file="%~dp0script.log"

:: 日志记录函数
:log
set timestamp=%date:~0,4%-%date:~5,2%-%date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%
echo [!timestamp!] %* >> %log_file%
echo [!timestamp!] %*
goto :eof

:: 使用日志函数
call :log "脚本开始执行"

:: 执行命令
xcopy "source" "dest" /E /I /Y
if errorlevel 1 (
    call :log "复制失败"
    exit /b 1
) else (
    call :log "复制成功"
)

call :log "脚本执行完成"
endlocal
exit /b 0
```

## 9. 示例脚本

### 9.1 文件备份脚本

```batch
@echo off
rem ==============================================
rem 脚本名称：backup_files.cmd
rem 脚本用途：备份指定目录下的所有文件到备份目录
rem ==============================================

setlocal enabledelayedexpansion

:: 配置参数
set source_dir=C:\data
set backup_dir=D:\backup
set log_file="%~dp0backup.log"

:: 日志函数
:log
set timestamp=%date:~0,4%-%date:~5,2%-%date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%
echo [!timestamp!] %* >> %log_file%
echo [!timestamp!] %*
goto :eof

:: 检查源目录是否存在
if not exist "%source_dir%" (
    call :log "错误：源目录不存在"
    exit /b 1
)

:: 创建备份目录（如果不存在）
if not exist "%backup_dir%" (
    call :log "创建备份目录：%backup_dir%"
    mkdir "%backup_dir%" >nul 2>&1
    if errorlevel 1 (
        call :log "错误：无法创建备份目录"
        exit /b 1
    )
)

:: 执行备份
call :log "开始备份文件..."
xcopy "%source_dir%" "%backup_dir%" /E /I /Y /H /R /C
if errorlevel 1 (
    call :log "错误：备份失败"
    exit /b 1
) else (
    call :log "备份成功"
)

call :log "脚本执行完成"
endlocal
exit /b 0
```

### 9.2 批量重命名脚本

```batch
@echo off
rem ==============================================
rem 脚本名称：rename_files.cmd
rem 脚本用途：批量重命名指定目录下的文件
rem ==============================================

setlocal enabledelayedexpansion

:: 配置参数
set target_dir=.  :: 当前目录
set file_pattern=*.jpg  :: 要重命名的文件类型
set prefix=photo_  :: 新文件名前缀

:: 检查目标目录是否存在
if not exist "%target_dir%" (
    echo 错误：目标目录不存在
    exit /b 1
)

:: 进入目标目录
cd /d "%target_dir%"

:: 批量重命名文件
set count=1
for %%i in (%file_pattern%) do (
    set /a count_padded=10000+!count!
    set new_name=%prefix%!count_padded:~-4!%%~xi
    echo 重命名：%%i → !new_name!
    rename "%%i" "!new_name!"
    set /a count+=1
)

echo 重命名完成，共处理 %count% 个文件
endlocal
exit /b 0
```

### 9.3 系统信息收集脚本

```batch
@echo off
rem ==============================================
rem 脚本名称：system_info.cmd
rem 脚本用途：收集系统信息并保存到文件
rem ==============================================

setlocal enabledelayedexpansion

:: 配置参数
set output_file="%~dp0system_info.txt"

:: 清除旧的输出文件
if exist %output_file% del %output_file%

:: 收集系统信息
echo ============================================== >> %output_file%
echo 系统信息报告 >> %output_file%
echo 生成时间：%date% %time% >> %output_file%
echo ============================================== >> %output_file%
echo. >> %output_file%

echo 1. 操作系统信息 >> %output_file%
echo ---------------------------------------------- >> %output_file%
ver >> %output_file%
echo. >> %output_file%

echo 2. 计算机名称和用户名 >> %output_file%
echo ---------------------------------------------- >> %output_file%
echo 计算机名：%COMPUTERNAME% >> %output_file%
echo 用户名：%USERNAME% >> %output_file%
echo. >> %output_file%

echo 3. 系统目录 >> %output_file%
echo ---------------------------------------------- >> %output_file%
echo 系统目录：%SystemRoot% >> %output_file%
echo 当前目录：%CD% >> %output_file%
echo 临时目录：%TEMP% >> %output_file%
echo. >> %output_file%

echo 4. 网络配置 >> %output_file%
echo ---------------------------------------------- >> %output_file%
ipconfig /all >> %output_file%
echo. >> %output_file%

echo 5. 已安装程序 >> %output_file%
echo ---------------------------------------------- >> %output_file%
reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall" /s | findstr /i "DisplayName" >> %output_file%
echo. >> %output_file%

echo 6. 正在运行的进程 >> %output_file%
echo ---------------------------------------------- >> %output_file%
tasklist >> %output_file%
echo. >> %output_file%

echo ============================================== >> %output_file%
echo 系统信息收集完成 >> %output_file%
echo ============================================== >> %output_file%

echo 系统信息已保存到：%output_file%
echo 按任意键查看报告...
pause >nul
type %output_file%

endlocal
exit /b 0
```

## 10. 高级技巧

### 10.1 字符串处理

1. **字符串长度**：
```batch
@echo off
setlocal enabledelayedexpansion

set str=Hello, World!
set len=0
for %%i in ("!str!") do (
    set "str=!str:~1!"
    set /a len+=1
    if not defined str goto :done
)

:done
echo 字符串长度：%len%
endlocal
```

2. **字符串截取**：
```batch
@echo off
set str=Hello, World!

:: 截取前 5 个字符
echo 前 5 个字符：%str:~0,5%

:: 截取从第 7 个字符开始的所有字符
echo 从第 7 个字符开始：%str:~6%

:: 截取最后 5 个字符
echo 最后 5 个字符：%str:~-5%

:: 截取从第 7 个字符开始的 5 个字符
echo 从第 7 个字符开始的 5 个字符：%str:~6,5%
```

3. **字符串替换**：
```batch
@echo off
set str=Hello, World!

:: 替换字符串
echo 替换前：%str%
echo 替换后：%str:World=Batch%

:: 替换所有匹配的字符串
echo 替换所有空格：%str: =_%
```

### 10.2 数组模拟

批处理没有原生数组支持，可以使用变量名后缀模拟数组：

```batch
@echo off
setlocal enabledelayedexpansion

:: 定义数组元素
set arr[0]=张三
set arr[1]=李四
set arr[2]=王五
set arr[3]=赵六

:: 数组长度
set arr_len=4

:: 遍历数组
for /l %%i in (0,1,%arr_len%-1) do (
    echo 数组元素 [%i%]：!arr[%%i]!
)

endlocal
```

### 10.3 日期和时间处理

```batch
@echo off
setlocal enabledelayedexpansion

:: 获取当前日期和时间
set current_date=%date%
set current_time=%time%

:: 格式化日期（YYYY-MM-DD）
set formatted_date=%current_date:~0,4%-%current_date:~5,2%-%current_date:~8,2%

:: 格式化时间（HH:MM:SS）
set formatted_time=%current_time:~0,2%:%current_time:~3,2%:%current_time:~6,2%

:: 去除时间中的前导空格（如果时间小于 10:00）
set formatted_time=!formatted_time: =0!

echo 当前日期：%formatted_date%
echo 当前时间：%formatted_time%

endlocal
```

## 11. 常见陷阱和注意事项

1. **路径中的空格**：始终使用引号包裹包含空格的路径
2. **变量延迟扩展**：在循环和条件语句中使用 `setlocal enabledelayedexpansion`
3. **命令执行顺序**：某些命令（如 `cd`）会影响后续命令的执行
4. **权限问题**：确保脚本有足够的权限执行操作
5. **文件锁定**：避免操作正在被其他进程使用的文件
6. **错误处理**：始终检查命令执行结果
7. **脚本编码**：使用 ANSI 编码保存脚本，避免乱码问题
8. **命令兼容性**：避免使用特定版本的命令，确保脚本在所有目标系统上兼容

## 总结

批处理脚本是 Windows 系统中自动化任务的强大工具。通过学习和掌握批处理脚本编写，可以提高工作效率，自动化各种重复性任务。

编写高质量的批处理脚本需要注意：
- 清晰的脚本结构和规范
- 良好的变量命名和注释
- 完善的错误处理
- 充分的调试和测试
- 遵循最佳实践

随着对批处理脚本的深入学习，可以逐步掌握更高级的技巧，编写更复杂、更可靠的脚本。