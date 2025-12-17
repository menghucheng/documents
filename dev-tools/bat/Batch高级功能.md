# Windows 批处理脚本高级功能

## 1. 高级字符串处理

### 1.1 字符串长度计算

批处理没有直接计算字符串长度的命令，但可以使用循环或字符串截取来实现：

**方法 1：使用循环计算**
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

**方法 2：使用字符串截取和比较**
```batch
@echo off
setlocal enabledelayedexpansion

set str=Hello, World!
set len=0

:loop
if defined str (
    set "str=!str:~1!"
    set /a len+=1
    goto loop
)

echo 字符串长度：%len%
endlocal
```

### 1.2 字符串反转

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

set str=Hello
set reversed=

set len=0
for %%i in ("%str%") do (
    set "tmp=%%i"
    for /l %%j in (1,1,100) do (
        if "!tmp!"=="" goto :break
        set "char=!tmp:~-1!"
        set "reversed=!reversed!!char!"
        set "tmp=!tmp:~0,-1!"
    )
    :break
)

echo 原始字符串：%str%
echo 反转字符串：%reversed%
endlocal
```

### 1.3 字符串包含检查

**方法 1：使用 `findstr` 命令**
```batch
@echo off
setlocal enabledelayedexpansion

set str=Hello, World!
set substr=World

echo %str% | findstr /i "%substr%" > nul
if %errorlevel% equ 0 (
    echo 字符串包含 "%substr%"
) else (
    echo 字符串不包含 "%substr%"
)
endlocal
```

**方法 2：使用字符串替换**
```batch
@echo off
setlocal enabledelayedexpansion

set str=Hello, World!
set substr=World
set test=!str:%substr%=!

if not "!test!"=="!str!" (
    echo 字符串包含 "%substr%"
) else (
    echo 字符串不包含 "%substr%"
)
endlocal
```

### 1.4 字符串分割

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

set str=张三,18,男,北京
set delims=,

:loop
for /f "tokens=1* delims=%delims%" %%a in ("%str%") do (
    echo 分割结果：%%a
    set str=%%b
)
if defined str goto loop

endlocal
```

## 2. 数组模拟

批处理没有原生数组支持，但可以使用变量名后缀模拟数组：

### 2.1 定义和访问数组

**示例**：
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

:: 访问单个元素
echo 第一个元素：%arr[0]%
echo 第二个元素：%arr[1]%

:: 遍历数组
for /l %%i in (0,1,%arr_len%-1) do (
    echo 数组元素 [%%i]：!arr[%%i]!
)
endlocal
```

### 2.2 数组追加元素

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

:: 初始数组
set arr[0]=张三
set arr_len=1

:: 追加元素
set arr[%arr_len%]=李四
set /a arr_len+=1
set arr[%arr_len%]=王五
set /a arr_len+=1

:: 遍历数组
for /l %%i in (0,1,%arr_len%-1) do (
    echo 数组元素 [%%i]：!arr[%%i]!
)
endlocal
```

### 2.3 数组排序

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

:: 初始数组（无序）
set arr[0]=5
set arr[1]=2
set arr[2]=8
set arr[3]=1
set arr[4]=9
set arr_len=5

:: 冒泡排序
echo 排序前：
for /l %%i in (0,1,%arr_len%-1) do (
    echo !arr[%%i]!
)

for /l %%i in (0,1,%arr_len%-2) do (
    for /l %%j in (%%i,1,%arr_len%-1) do (
        if !arr[%%i]! gtr !arr[%%j]! (
            set tmp=!arr[%%i]!
            set arr[%%i]=!arr[%%j]!
            set arr[%%j]=!tmp!
        )
    )
)

echo 排序后：
for /l %%i in (0,1,%arr_len%-1) do (
    echo !arr[%%i]!
)
endlocal
```

## 3. 日期和时间高级处理

### 3.1 格式化日期和时间

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

:: 获取当前日期和时间
set current_date=%date%
set current_time=%time%

:: 格式化日期为 YYYY-MM-DD 格式
set formatted_date=%current_date:~0,4%-%current_date:~5,2%-%current_date:~8,2%

:: 格式化时间为 HH:MM:SS 格式（去除前导空格）
set formatted_time=%current_time:~0,2%:%current_time:~3,2%:%current_time:~6,2%
set formatted_time=!formatted_time: =0!

:: 格式化日期时间为 YYYY-MM-DD HH:MM:SS 格式
set formatted_datetime=%formatted_date% %formatted_time%

echo 当前日期：%formatted_date%
echo 当前时间：%formatted_time%
echo 当前日期时间：%formatted_datetime%
endlocal
```

### 3.2 计算日期差

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

:: 定义两个日期（格式：YYYY-MM-DD）
set date1=2023-01-01
set date2=2023-12-31

:: 转换日期为 Julian 天数
call :date_to_julian %date1% julian1
call :date_to_julian %date2% julian2

:: 计算日期差
set /a days_diff=julian2-julian1

echo %date1% 到 %date2% 相差 %days_diff% 天
endlocal
exit /b

:: 日期转换为 Julian 天数函数
:date_to_julian
sets date_str=%1
sets julian_var=%2

set year=%date_str:~0,4%
set month=%date_str:~5,2%
set day=%date_str:~8,2%

:: 转换为 Julian 天数的简化算法（仅适用于 1900 年以后）
set /a a=(14-month)/12
set /a y=year+4800-a
set /a m=month+12*a-3
set /a julian=day+(153*m+2)/5+365*y+y/4-y/100+y/400-32045

set %julian_var%=%julian%
goto :eof
```

### 3.3 获取星期几

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

:: 获取当前日期
set current_date=%date%
set year=%current_date:~0,4%
set month=%current_date:~5,2%
set day=%current_date:~8,2%

:: 使用 WMIC 命令获取星期几
for /f "skip=1 tokens=1-4" %%a in ('wmic path win32_localtime get day^,month^,year^,dayofweek') do (
    if not defined dayofweek (
        set dayofweek=%%d
        set month=%%b
        set day=%%a
        set year=%%c
    )
)

:: 星期几映射
set weekdays=星期日 星期一 星期二 星期三 星期四 星期五 星期六
set /a index=dayofweek
for /f "tokens=%index%" %%i in ("%weekdays%") do (
    set weekday=%%i
)

echo 当前日期：%year%-%month%-%day%
echo 当前星期：%weekday%
endlocal
```

## 4. 高级错误处理

### 4.1 自定义错误处理函数

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

:: 错误处理函数
:error_handler
echo 错误：%1
echo 错误码：%errorlevel%
:: 可以添加更多错误处理逻辑，如日志记录、清理操作等
exit /b %errorlevel%

:: 主脚本逻辑
echo 执行命令 1...
invalid_command1 || call :error_handler "命令 1 执行失败"

echo 执行命令 2...
invalid_command2 || call :error_handler "命令 2 执行失败"

echo 所有命令执行成功
endlocal
exit /b 0
```

### 4.2 异常捕获和恢复

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

:: 保存当前目录
set original_dir=%cd%

:: 尝试执行可能失败的操作
echo 尝试切换到不存在的目录...
cd /d "nonexistent_dir" 2>nul
if errorlevel 1 (
    echo 切换目录失败，恢复到原始目录...
    cd /d "%original_dir%"
    echo 当前目录：%cd%
)

echo 脚本继续执行...
endlocal
exit /b 0
```

### 4.3 错误日志记录

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

:: 定义日志文件
set log_file="%~dp0error_log.txt"

:: 日志记录函数
:log
set timestamp=%date:~0,4%-%date:~5,2%-%date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%
set timestamp=!timestamp: =0!
echo [!timestamp!] %* >> %log_file%
echo [!timestamp!] %*
goto :eof

:: 主脚本逻辑
call :log "脚本开始执行"

:: 执行可能失败的命令
echo 执行命令 1...
call :log "执行命令 1"
invalid_command1 2>&1 >> %log_file%
if errorlevel 1 (
    call :log "命令 1 执行失败，错误码：%errorlevel%"
) else (
    call :log "命令 1 执行成功"
)

echo 执行命令 2...
call :log "执行命令 2"
invalid_command2 2>&1 >> %log_file%
if errorlevel 1 (
    call :log "命令 2 执行失败，错误码：%errorlevel%"
) else (
    call :log "命令 2 执行成功"
)

call :log "脚本执行完成"
endlocal
exit /b 0
```

## 5. 网络操作

### 5.1 检查网络连接

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

:: 检查网络连接
echo 检查网络连接...
ping -n 1 www.baidu.com >nul 2>&1
if errorlevel 1 (
    echo 网络连接失败
) else (
    echo 网络连接正常
)
endlocal
exit /b 0
```

### 5.2 获取 IP 地址

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

:: 获取本地 IP 地址
for /f "tokens=2 delims=:" %%i in ('ipconfig ^| findstr /i "ipv4 address"') do (
    set ip=%%i
    set ip=!ip:~1!
    echo IP 地址：!ip!
)
endlocal
exit /b 0
```

### 5.3 下载文件

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

:: 使用 certutil 命令下载文件（Windows 7 及以上版本内置）
set url=https://www.example.com/file.txt
set output_file=file.txt

echo 下载文件：%url%
certutil -urlcache -f %url% %output_file%
if errorlevel 1 (
    echo 下载失败
    exit /b 1
) else (
    echo 下载成功，保存到：%output_file%
)
endlocal
exit /b 0
```

### 5.4 映射网络驱动器

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

:: 映射网络驱动器
set server=\\server\share
set drive=Z:
set username=user
set password=pass

echo 映射网络驱动器 %drive% 到 %server%
net use %drive% %server% /user:%username% %password%
if errorlevel 1 (
    echo 映射失败
    exit /b 1
) else (
    echo 映射成功
)

echo 列出映射的驱动器
net use

echo 断开映射的驱动器
net use %drive% /delete /yes
if errorlevel 1 (
    echo 断开失败
    exit /b 1
) else (
    echo 断开成功
)
endlocal
exit /b 0
```

## 6. 注册表操作

### 6.1 读取注册表值

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

:: 读取注册表值
set reg_path=HKLM\Software\Microsoft\Windows\CurrentVersion
set reg_value=ProgramFilesDir

echo 读取注册表值：%reg_path%\%reg_value%
for /f "tokens=2* delims= " %%i in ('reg query "%reg_path%" /v "%reg_value%" 2^>nul') do (
    set value=%%j
)

if defined value (
    echo 注册表值：%value%
) else (
    echo 注册表值不存在或无法读取
)
endlocal
exit /b 0
```

### 6.2 设置注册表值

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

:: 设置注册表值（需要管理员权限）
set reg_path=HKCU\Software\MyApp
set reg_value=Setting
set reg_data=Value
set reg_type=REG_SZ

echo 创建注册表项：%reg_path%
reg add "%reg_path%" /f >nul 2>&1
if errorlevel 1 (
    echo 创建注册表项失败
    exit /b 1
)

echo 设置注册表值：%reg_path%\%reg_value% = %reg_data%
reg add "%reg_path%" /v "%reg_value%" /t %reg_type% /d "%reg_data%" /f >nul 2>&1
if errorlevel 1 (
    echo 设置注册表值失败
    exit /b 1
) else (
    echo 设置注册表值成功
)

echo 读取设置的注册表值
for /f "tokens=2* delims= " %%i in ('reg query "%reg_path%" /v "%reg_value%" 2^>nul') do (
    set value=%%j
)

echo 读取到的注册表值：%value%
endlocal
exit /b 0
```

### 6.3 删除注册表项

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

:: 删除注册表值
echo 删除注册表值...
reg delete "HKCU\Software\MyApp" /v "Setting" /f >nul 2>&1
if errorlevel 1 (
    echo 删除注册表值失败
) else (
    echo 删除注册表值成功
)

:: 删除注册表项（包括所有子项和值）
echo 删除注册表项...
reg delete "HKCU\Software\MyApp" /f >nul 2>&1
if errorlevel 1 (
    echo 删除注册表项失败
) else (
    echo 删除注册表项成功
)
endlocal
exit /b 0
```

## 7. 服务管理

### 7.1 列出服务

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

:: 列出所有服务
echo 列出所有服务：
sc query state= all | findstr /i "service_name display_name state" > services.txt
type services.txt

echo.
echo 列出正在运行的服务：
sc query state= running | findstr /i "service_name display_name"
endlocal
exit /b 0
```

### 7.2 启动和停止服务

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

:: 服务名称
set service_name=wuauserv  :: Windows Update 服务

:: 检查服务状态
echo 检查服务状态：
sc query %service_name% | findstr /i "state"

:: 停止服务
echo 停止服务 %service_name%...
sc stop %service_name% >nul 2>&1
if errorlevel 1 (
    echo 停止服务失败
) else (
    echo 停止服务成功
)

:: 启动服务
echo 启动服务 %service_name%...
sc start %service_name% >nul 2>&1
if errorlevel 1 (
    echo 启动服务失败
) else (
    echo 启动服务成功
)

:: 再次检查服务状态
echo 检查服务状态：
sc query %service_name% | findstr /i "state"
endlocal
exit /b 0
```

### 7.3 设置服务启动类型

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

:: 服务名称
set service_name=wuauserv  :: Windows Update 服务

:: 设置服务启动类型为自动
echo 设置服务 %service_name% 启动类型为自动...
sc config %service_name% start= auto >nul 2>&1
if errorlevel 1 (
    echo 设置服务启动类型失败
) else (
    echo 设置服务启动类型成功
)

:: 查看服务启动类型
echo 查看服务启动类型：
sc qc %service_name% | findstr /i "start_type"

:: 设置服务启动类型为手动
echo 设置服务 %service_name% 启动类型为手动...
sc config %service_name% start= demand >nul 2>&1
if errorlevel 1 (
    echo 设置服务启动类型失败
) else (
    echo 设置服务启动类型成功
)

:: 再次查看服务启动类型
echo 查看服务启动类型：
sc qc %service_name% | findstr /i "start_type"
endlocal
exit /b 0
```

## 8. 高级文件操作

### 8.1 批量重命名文件（带序号）

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

:: 配置参数
set target_dir=.  :: 当前目录
set file_pattern=*.jpg  :: 要重命名的文件类型
set prefix=photo_  :: 新文件名前缀
set start_num=1  :: 起始序号

:: 进入目标目录
cd /d "%target_dir%"

:: 批量重命名文件
set count=%start_num%
for %%i in (%file_pattern%) do (
    :: 生成带前导零的序号
    set /a padded_num=10000+!count!
    set new_name=%prefix%!padded_num:~-4!%%~xi
    echo 重命名：%%i → !new_name!
    rename "%%i" "!new_name!"
    set /a count+=1
)

echo 重命名完成，共处理 %count% 个文件
endlocal
exit /b 0
```

### 8.2 搜索并替换文件内容

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

:: 配置参数
set search_str=old_text
set replace_str=new_text
set file_pattern=*.txt

:: 备份原始文件
echo 备份原始文件...
for %%i in (%file_pattern%) do (
    copy "%%i" "%%i.bak" >nul 2>&1
)

:: 搜索并替换文件内容
echo 搜索并替换文件内容...
for %%i in (%file_pattern%) do (
    echo 处理文件：%%i
    (for /f "delims=" %%j in ("%%i") do (
        set line=%%j
        set line=!line:%search_str%=%replace_str%!
        echo !line!
    )) > "%%i.tmp"
    move /y "%%i.tmp" "%%i" >nul 2>&1
)

echo 替换完成
endlocal
exit /b 0
```

### 8.3 计算文件哈希值

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

:: 计算文件的 MD5 哈希值
echo 计算文件哈希值...
for /f "skip=1 tokens=2" %%i in ('certutil -hashfile "file.txt" md5') do (
    set md5=%%i
    goto :break
)
:break
echo MD5: %md5%

:: 计算文件的 SHA-1 哈希值
echo SHA-1: 
certutil -hashfile "file.txt" sha1

:: 计算文件的 SHA-256 哈希值
echo SHA-256: 
certutil -hashfile "file.txt" sha256
endlocal
exit /b 0
```

## 9. 多线程模拟

批处理本身不支持真正的多线程，但可以使用 `start` 命令模拟多线程效果：

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

:: 模拟多线程下载
echo 开始多线程下载...
set urls=
set urls=!urls! "https://example.com/file1.txt"
set urls=!urls! "https://example.com/file2.txt"
set urls=!urls! "https://example.com/file3.txt"

:: 启动多个下载任务
for %%i in (!urls!) do (
    echo 启动下载：%%i
    start /min cmd /c "certutil -urlcache -f %%i %%~nxi && echo 下载完成：%%i"
)

echo 所有下载任务已启动
endlocal
exit /b 0
```

## 10. 与其他脚本语言交互

### 10.1 调用 VBScript

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

:: 创建临时 VBScript 文件
set vbscript=%temp%\temp.vbs
echo WScript.Echo "Hello from VBScript" > %vbscript%

:: 调用 VBScript
echo 调用 VBScript：
cscript //nologo %vbscript%

:: 删除临时文件
del %vbscript% >nul 2>&1
endlocal
exit /b 0
```

### 10.2 调用 PowerShell

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

:: 调用 PowerShell 命令
echo 调用 PowerShell 命令：
powershell -Command "Write-Host 'Hello from PowerShell' -ForegroundColor Green"

:: 调用 PowerShell 脚本
set ps_script=%temp%\temp.ps1
echo Write-Host 'Hello from PowerShell Script' -ForegroundColor Blue > %ps_script%
echo 调用 PowerShell 脚本：
powershell -File %ps_script%

:: 删除临时文件
del %ps_script% >nul 2>&1
endlocal
exit /b 0
```

### 10.3 调用 Python

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

:: 检查 Python 是否安装
python --version >nul 2>&1
if errorlevel 1 (
    echo Python 未安装
    exit /b 1
)

:: 调用 Python 命令
echo 调用 Python 命令：
python -c "print('Hello from Python')"

:: 调用 Python 脚本
set py_script=%temp%\temp.py
echo print('Hello from Python Script') > %py_script%
echo 调用 Python 脚本：
python %py_script%

:: 删除临时文件
del %py_script% >nul 2>&1
endlocal
exit /b 0
```

## 11. 高级调试技巧

### 11.1 启用命令行调试

**示例**：
```batch
@echo on
:: 脚本代码...
echo 调试信息：变量值为 %var%
:: 更多脚本代码...
@echo off
```

### 11.2 使用日志文件进行调试

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

:: 定义日志文件
set log_file=%temp%\debug.log

:: 调试日志函数
:debug
set timestamp=%date:~0,4%-%date:~5,2%-%date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%
set timestamp=!timestamp: =0!
echo [!timestamp!] DEBUG: %* >> %log_file%
goto :eof

:: 主脚本逻辑
call :debug "脚本开始执行"

set var=value
call :debug "变量 var 设置为 %var%"

:: 更多脚本代码...
call :debug "脚本执行完成"

:: 显示日志文件内容
echo 调试日志已保存到：%log_file%
echo 查看日志文件？(y/n)
set /p answer=
if /i "%answer%"=="y" (
    type %log_file%
)
endlocal
exit /b 0
```

### 11.3 使用 `pause` 进行逐行调试

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

## 12. 性能优化

### 12.1 减少命令执行次数

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

:: 慢：循环中执行多次命令
echo 慢版本：
set start_time=%time%
set count=0
for %%i in (*.txt) do (
    set /a count+=1
    echo 处理文件：%%i
    :: 更多命令...
)
set end_time=%time%
echo 处理文件数：%count%
echo 执行时间：%start_time% - %end_time%

:: 快：减少命令执行次数
echo.
echo 快版本：
set start_time=%time%
set count=0
(for %%i in (*.txt) do (
    set /a count+=1
    echo 处理文件：%%i
    :: 更多命令...
)) > temp.txt
type temp.txt
del temp.txt
set end_time=%time%
echo 处理文件数：%count%
echo 执行时间：%start_time% - %end_time%
endlocal
exit /b 0
```

### 12.2 避免不必要的变量扩展

**示例**：
```batch
@echo off
setlocal enabledelayedexpansion

:: 慢：不必要的变量扩展
set start_time=%time%
set str=Hello
for /l %%i in (1,1,1000) do (
    echo %str%
)
set end_time=%time%
echo 慢版本执行时间：%start_time% - %end_time%

:: 快：避免不必要的变量扩展
set start_time=%time%
set str=Hello
for /l %%i in (1,1,1000) do (
    echo Hello
)
set end_time=%time%
echo 快版本执行时间：%start_time% - %end_time%
endlocal
exit /b 0
```

### 12.3 使用更高效的命令

**示例**：
```batch
@echo off
:: 慢：使用多个命令完成同一任务
echo 慢版本：
set start_time=%time%
for %%i in (*) do (
    if exist "%%i" (
        echo %%i
    )
)
set end_time=%time%
echo 执行时间：%start_time% - %end_time%

:: 快：使用单个命令完成同一任务
echo.
echo 快版本：
set start_time=%time%
dir /b
set end_time=%time%
echo 执行时间：%start_time% - %end_time%
```

## 总结

批处理脚本虽然是一种相对简单的脚本语言，但通过掌握其高级功能，可以编写出功能强大、高效可靠的自动化脚本。本文介绍的高级功能包括：

1. **高级字符串处理**：字符串长度计算、反转、包含检查、分割等
2. **数组模拟**：定义、访问、追加、排序等
3. **日期和时间处理**：格式化、日期差计算、星期几获取等
4. **高级错误处理**：自定义错误处理函数、异常捕获和恢复、错误日志记录等
5. **网络操作**：检查网络连接、获取 IP 地址、下载文件、映射网络驱动器等
6. **注册表操作**：读取、设置、删除注册表值和项
7. **服务管理**：列出、启动、停止服务，设置服务启动类型
8. **高级文件操作**：批量重命名、搜索替换文件内容、计算文件哈希值等
9. **多线程模拟**：使用 `start` 命令模拟多线程效果
10. **与其他脚本语言交互**：调用 VBScript、PowerShell、Python 等
11. **高级调试技巧**：启用命令行调试、使用日志文件、逐行调试等
12. **性能优化**：减少命令执行次数、避免不必要的变量扩展、使用更高效的命令等

通过学习和实践这些高级功能，可以提高批处理脚本的开发效率和执行效率，编写出更强大、更可靠的自动化脚本，满足各种复杂的 Windows 系统管理需求。