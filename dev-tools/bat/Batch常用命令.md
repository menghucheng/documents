# Windows 批处理常用命令

## 1. 基本命令

### 1.1 `echo` - 输出文本

**功能**：在命令行窗口中显示文本或控制命令回显。

**语法**：
```batch
# 显示文本
ECHO [文本]

# 开启命令回显（默认）
ECHO ON

# 关闭命令回显
ECHO OFF

# 显示当前目录
ECHO %cd%

# 输出空行
ECHO.
```

**示例**：
```batch
ECHO 欢迎使用批处理脚本！
ECHO 当前目录是：%cd%
```

### 1.2 `@` - 隐藏命令本身

**功能**：在命令前添加 `@` 符号可以隐藏该命令本身，只显示命令执行结果。

**语法**：
```batch
@命令
```

**示例**：
```batch
@ECHO 这条命令不会显示自身
```

### 1.3 `rem` 或 `::` - 注释

**功能**：添加注释，提高脚本可读性。

**语法**：
```batch
REM 这是一条注释
:: 这也是一条注释（更常用）
```

**示例**：
```batch
:: 备份文件脚本
REM 作者：张三
REM 创建时间：2023-01-01
```

### 1.4 `pause` - 暂停执行

**功能**：暂停脚本执行，显示 "请按任意键继续. . ."，等待用户按键后继续。

**语法**：
```batch
PAUSE
```

**示例**：
```batch
ECHO 执行到这里会暂停
PAUSE
ECHO 继续执行
```

### 1.5 `exit` - 退出脚本

**功能**：退出当前批处理脚本或命令行窗口。

**语法**：
```batch
EXIT [退出码]
```

**示例**：
```batch
ECHO 执行完毕，退出脚本
EXIT 0
```

## 2. 文件和目录操作

### 2.1 `dir` - 列出目录内容

**功能**：列出指定目录中的文件和子目录。

**语法**：
```batch
DIR [驱动器:][路径][文件名] [/A[[:]属性]] [/B] [/C] [/D] [/L] [/N] [/O[[:]排序顺序]] [/P] [/Q] [/R] [/S] [/T[[:]时间字段]] [/W] [/X] [/4]
```

**常用参数**：
- `/S`：列出指定目录及其所有子目录中的文件
- `/B`：使用裸格式（仅文件名）
- `/A`：显示具有指定属性的文件
  - `D`：目录
  - `H`：隐藏文件
  - `R`：只读文件
  - `S`：系统文件

**示例**：
```batch
:: 列出当前目录所有文件和子目录
DIR

:: 列出当前目录及其所有子目录中的文件
DIR /S

:: 仅列出当前目录下的文件名
DIR /B

:: 列出当前目录下的所有隐藏文件
DIR /A:H
```

### 2.2 `cd` - 切换目录

**功能**：改变当前目录或显示当前目录。

**语法**：
```batch
CD [/D] [驱动器:][路径]
CD..
CD\
```

**参数说明**：
- `/D`：同时改变驱动器和目录
- `CD..`：返回上一级目录
- `CD\`：返回根目录

**示例**：
```batch
:: 切换到 D 盘
CD /D D:

:: 切换到 D 盘的 tmp 目录
CD /D D:\tmp

:: 返回上一级目录
CD..

:: 返回根目录
CD\
```

### 2.3 `md` 或 `mkdir` - 创建目录

**功能**：创建一个或多个目录。

**语法**：
```batch
MD [驱动器:][路径]
MKDIR [驱动器:][路径]
```

**示例**：
```batch
:: 创建单个目录
MD test

:: 创建多级目录
MD test\sub1\sub2
```

### 2.4 `rd` 或 `rmdir` - 删除目录

**功能**：删除目录。

**语法**：
```batch
RD [/S] [/Q] [驱动器:][路径]
RMDIR [/S] [/Q] [驱动器:][路径]
```

**参数说明**：
- `/S`：删除指定目录及其所有子目录和文件
- `/Q`：安静模式，不询问确认

**示例**：
```batch
:: 删除空目录
RD test

:: 删除目录及其所有内容，不询问确认
RD /S /Q test
```

### 2.5 `copy` - 复制文件

**功能**：复制一个或多个文件到指定位置。

**语法**：
```batch
COPY [/D] [/V] [/N] [/Y | /-Y] [/Z] [/A | /B] 源 [/A | /B] [+ 源 [/A | /B] [+ ...]] [目标 [/A | /B]]
```

**常用参数**：
- `/Y`：不提示确认覆盖现有目标文件
- `/S`：复制目录和子目录中的文件（除了空目录）

**示例**：
```batch
:: 复制单个文件
COPY file1.txt file2.txt

:: 复制文件到指定目录
COPY file.txt D:\backup\

:: 复制多个文件
COPY *.txt D:\backup\
```

### 2.6 `xcopy` - 扩展复制

**功能**：复制文件和目录树，功能比 `copy` 更强大。

**语法**：
```batch
XCOPY source [destination] [/A | /M] [/D[:date]] [/P] [/S [/E]] [/V] [/W] [/C] [/I] [/Q] [/F] [/L] [/G] [/H] [/R] [/T] [/U] [/K] [/N] [/O] [/X] [/Y | /-Y] [/Z] [/B] [/J]
```

**常用参数**：
- `/S`：复制目录和子目录中的文件（除了空目录）
- `/E`：复制目录和子目录中的文件，包括空目录
- `/I`：如果目标不存在且复制多个文件，则假定目标是目录
- `/Y`：不提示确认覆盖现有文件
- `/H`：复制隐藏文件和系统文件

**示例**：
```batch
:: 复制目录及其所有内容
XCOPY source_dir dest_dir /E /I /Y

:: 复制目录及其所有内容，包括隐藏文件
XCOPY source_dir dest_dir /E /I /Y /H
```

### 2.7 `del` 或 `erase` - 删除文件

**功能**：删除一个或多个文件。

**语法**：
```batch
DEL [/P] [/F] [/S] [/Q] [/A[[:]属性]] 文件名
ERASE [/P] [/F] [/S] [/Q] [/A[[:]属性]] 文件名
```

**常用参数**：
- `/F`：强制删除只读文件
- `/S`：删除指定目录及其所有子目录中的匹配文件
- `/Q`：安静模式，不询问确认

**示例**：
```batch
:: 删除单个文件
DEL file.txt

:: 删除所有 .tmp 文件
DEL *.tmp

:: 强制删除所有 .tmp 文件，不询问确认
DEL /F /Q *.tmp
```

### 2.8 `move` - 移动或重命名文件/目录

**功能**：移动文件或目录，或重命名文件或目录。

**语法**：
```batch
MOVE [/Y | /-Y] [驱动器:][路径]源 [驱动器:][路径][目标文件名]
MOVE [/Y | /-Y] [驱动器:][路径]源 [驱动器:][路径][目标目录]
```

**常用参数**：
- `/Y`：不提示确认覆盖现有目标文件

**示例**：
```batch
:: 重命名文件
MOVE file1.txt file2.txt

:: 移动文件到指定目录
MOVE file.txt D:\backup\

:: 移动目录
MOVE source_dir dest_dir
```

### 2.9 `ren` 或 `rename` - 重命名文件/目录

**功能**：重命名文件或目录。

**语法**：
```batch
REN [驱动器:][路径]旧文件名 新文件名
RENAME [驱动器:][路径]旧文件名 新文件名
```

**示例**：
```batch
:: 重命名单个文件
REN file1.txt file2.txt

:: 批量重命名文件
REN *.txt *.bak
```

## 3. 系统信息命令

### 3.1 `ver` - 显示系统版本

**功能**：显示 Windows 系统版本信息。

**语法**：
```batch
VER
```

**示例**：
```batch
VER
```

### 3.2 `systeminfo` - 显示系统详细信息

**功能**：显示计算机的操作系统配置信息。

**语法**：
```batch
SYSTEMINFO [/S 系统 [/U 用户名 [/P [密码]]]] [/FO 格式] [/NH]
```

**常用参数**：
- `/S`：指定远程系统
- `/U`：指定用户上下文
- `/P`：指定密码
- `/FO`：指定输出格式（TABLE、LIST、CSV）

**示例**：
```batch
:: 显示当前系统信息
SYSTEMINFO

:: 以列表格式显示系统信息，不显示标题
SYSTEMINFO /FO LIST /NH
```

### 3.3 `date` 和 `time` - 显示或设置日期和时间

**功能**：显示或设置系统日期和时间。

**语法**：
```batch
:: 显示或设置日期
DATE [日期]

:: 显示或设置时间
TIME [时间]
```

**示例**：
```batch
:: 显示当前日期
DATE

:: 显示当前时间
TIME
```

## 4. 网络命令

### 4.1 `ipconfig` - 显示网络配置

**功能**：显示所有当前的 TCP/IP 网络配置值。

**语法**：
```batch
IPCONFIG [/ALL] [/RELEASE [适配器]] [/RENEW [适配器]] [/FLUSHDNS] [/REGISTERDNS] [/DISPLAYDNS] [/SHOWCLASSID 适配器] [/SETCLASSID 适配器 [类 ID]]
```

**常用参数**：
- `/ALL`：显示完整配置信息
- `/RELEASE`：释放指定适配器的 IP 地址
- `/RENEW`：更新指定适配器的 IP 地址
- `/FLUSHDNS`：清除 DNS 解析缓存

**示例**：
```batch
:: 显示基本网络配置
IPCONFIG

:: 显示完整网络配置
IPCONFIG /ALL

:: 清除 DNS 缓存
IPCONFIG /FLUSHDNS
```

### 4.2 `ping` - 测试网络连接

**功能**：向网络主机发送 ICMP 回显请求，测试网络连接性。

**语法**：
```batch
PING [-t] [-a] [-n 计数] [-l 大小] [-f] [-i TTL] [-v TOS] [-r 计数] [-s 计数] [[-j 主机列表] | [-k 主机列表]] [-w 超时] [-R] [-S 源地址] [-c 隔间] [-p] [-4] [-6] 目标名
```

**常用参数**：
- `-t`：持续发送回显请求，直到按 Ctrl+C 停止
- `-n 计数`：发送指定数量的回显请求
- `-l 大小`：指定发送的数据包大小

**示例**：
```batch
:: 向百度发送 4 个回显请求
PING www.baidu.com

:: 持续向百度发送回显请求
PING -t www.baidu.com

:: 发送 10 个回显请求，每个数据包大小为 1000 字节
PING -n 10 -l 1000 www.baidu.com
```

### 4.3 `netstat` - 显示网络连接状态

**功能**：显示协议统计信息和当前 TCP/IP 网络连接。

**语法**：
```batch
NETSTAT [-a] [-b] [-e] [-f] [-n] [-o] [-p 协议] [-r] [-s] [-t] [-x] [-y] [interval]
```

**常用参数**：
- `-a`：显示所有连接和监听端口
- `-n`：以数字形式显示地址和端口号
- `-o`：显示拥有的与每个连接关联的进程 ID
- `-p 协议`：显示指定协议的连接

**示例**：
```batch
:: 显示所有连接和监听端口
NETSTAT -a

:: 以数字形式显示所有连接和进程 ID
NETSTAT -n -o

:: 显示 TCP 连接
NETSTAT -a -p TCP
```

## 5. 进程管理命令

### 5.1 `tasklist` - 显示进程列表

**功能**：显示当前运行的进程列表。

**语法**：
```batch
TASKLIST [/S 系统 [/U 用户名 [/P [密码]]]] [/M [模块名]] [/SVC] [/V] [/FO 格式] [/NH]
```

**常用参数**：
- `/SVC`：显示每个进程的服务
- `/V`：显示详细信息
- `/FO`：指定输出格式（TABLE、LIST、CSV）

**示例**：
```batch
:: 显示所有进程
TASKLIST

:: 显示进程和对应的服务
TASKLIST /SVC

:: 显示详细的进程信息
TASKLIST /V
```

### 5.2 `taskkill` - 终止进程

**功能**：终止一个或多个运行中的进程。

**语法**：
```batch
TASKKILL [/S 系统 [/U 用户名 [/P [密码]]]] { [/FI 过滤器] [/PID 进程 ID | /IM 映像名称] } [/T] [/F]
```

**常用参数**：
- `/PID 进程 ID`：指定要终止的进程 ID
- `/IM 映像名称`：指定要终止的进程名称
- `/T`：终止指定进程及其所有子进程
- `/F`：强制终止进程

**示例**：
```batch
:: 根据进程 ID 终止进程
TASKKILL /PID 1234

:: 根据进程名称终止进程
TASKKILL /IM notepad.exe

:: 强制终止进程及其所有子进程
TASKKILL /IM chrome.exe /T /F

:: 终止所有 NOT RESPONDING 状态的进程
TASKKILL /FI "STATUS eq NOT RESPONDING" /F
```

## 6. 其他常用命令

### 6.1 `find` - 在文件中查找字符串

**功能**：在文件中搜索指定字符串。

**语法**：
```batch
FIND [/V] [/C] [/N] [/I] [/OFF[LINE]] "字符串" [[驱动器:][路径]文件名[ ...]]
```

**常用参数**：
- `/V`：显示不包含指定字符串的所有行
- `/C`：显示包含指定字符串的行数
- `/N`：在每行前显示行号
- `/I`：忽略大小写

**示例**：
```batch
:: 在文件中查找字符串 "error"
FIND "error" log.txt

:: 在文件中查找字符串 "error"，忽略大小写，显示行号
FIND /I /N "error" log.txt

:: 统计文件中包含 "error" 的行数
FIND /C "error" log.txt
```

### 6.2 `findstr` - 字符串查找工具

**功能**：在文件中查找字符串，功能比 `find` 更强大，支持正则表达式。

**语法**：
```batch
FINDSTR [/B] [/E] [/L] [/R] [/S] [/I] [/X] [/V] [/N] [/M] [/O] [/P] [/F:file] [/C:string] [/G:file] [/D:dir list] [/A:color attributes] [/OFF[LINE]] strings [[drive:][path]filename[ ...]]
```

**常用参数**：
- `/S`：在当前目录和所有子目录中搜索
- `/I`：忽略大小写
- `/R`：将搜索字符串视为正则表达式
- `/N`：在每行前显示行号
- `/M`：仅显示包含匹配项的文件名

**示例**：
```batch
:: 在当前目录和子目录中查找包含 "error" 的文件
FINDSTR /S "error" *.txt

:: 使用正则表达式查找以 "ERROR" 开头的行
FINDSTR /R /I /N "^ERROR" log.txt

:: 查找包含 "error" 或 "warning" 的行
FINDSTR /I "error warning" log.txt
```

### 6.3 `type` - 显示文件内容

**功能**：显示文本文件的内容。

**语法**：
```batch
TYPE [驱动器:][路径]文件名
```

**示例**：
```batch
:: 显示文本文件内容
TYPE readme.txt
```

### 6.4 `more` - 分页显示文件内容

**功能**：分页显示文本文件内容，按空格键显示下一页，按 Enter 键显示下一行。

**语法**：
```batch
MORE [/E [/C] [/P] [/S] [/Tn] [+n]] [[驱动器:][路径]文件名] [...]
```

**示例**：
```batch
:: 分页显示文件内容
MORE readme.txt

:: 从第 10 行开始分页显示文件内容
MORE +10 readme.txt

:: 将命令输出分页显示
DIR /S | MORE
```

### 6.5 `cls` - 清屏

**功能**：清除命令行窗口的内容。

**语法**：
```batch
CLS
```

**示例**：
```batch
:: 清屏
CLS
```

## 7. 环境变量命令

### 7.1 `set` - 显示或设置环境变量

**功能**：显示、设置或删除环境变量。

**语法**：
```batch
:: 显示所有环境变量
SET

:: 显示指定环境变量
SET 变量名

:: 设置环境变量
SET 变量名=变量值

:: 删除环境变量
SET 变量名=
```

**示例**：
```batch
:: 显示所有环境变量
SET

:: 显示 PATH 环境变量
SET PATH

:: 设置临时环境变量
SET TEMP_DIR=D:\tmp

:: 删除环境变量
SET TEMP_DIR=
```

### 7.2 `setx` - 设置永久性环境变量

**功能**：设置用户或系统永久性环境变量。

**语法**：
```batch
SETX [/S 系统 [/U 用户名 [/P [密码]]]] 变量名 变量值 [/M]
```

**参数说明**：
- `/M`：设置系统环境变量（需要管理员权限）

**示例**：
```batch
:: 设置用户永久性环境变量
SETX JAVA_HOME "C:\Program Files\Java\jdk1.8.0_201"

:: 设置系统永久性环境变量（需要管理员权限）
SETX PATH "%PATH%;C:\Program Files\Java\jdk1.8.0_201\bin" /M
```

## 8. 批处理流程控制命令

### 8.1 `if` - 条件判断

**功能**：根据条件执行不同的命令。

**语法**：
```batch
:: 比较字符串
IF [NOT] 字符串1==字符串2 命令 [ELSE 命令]

:: 比较数值
IF [NOT] 数值1 EQU 数值2 命令 [ELSE 命令]
IF [NOT] 数值1 NEQ 数值2 命令 [ELSE 命令]
IF [NOT] 数值1 LSS 数值2 命令 [ELSE 命令]
IF [NOT] 数值1 LEQ 数值2 命令 [ELSE 命令]
IF [NOT] 数值1 GTR 数值2 命令 [ELSE 命令]
IF [NOT] 数值1 GEQ 数值2 命令 [ELSE 命令]

:: 检查文件是否存在
IF [NOT] EXIST [驱动器:][路径]文件名 命令 [ELSE 命令]
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
:: 比较字符串
IF "%USERNAME%"=="Administrator" (ECHO 你是管理员) ELSE (ECHO 你不是管理员)

:: 比较数值
IF %ERRORLEVEL% EQU 0 (ECHO 命令执行成功) ELSE (ECHO 命令执行失败)

:: 检查文件是否存在
IF EXIST "file.txt" (ECHO 文件存在) ELSE (ECHO 文件不存在)
```

### 8.2 `for` - 循环命令

**功能**：对一组文件或字符串执行循环操作。

**语法**：
```batch
:: 基本语法
FOR %%变量 IN (集合) DO 命令

:: 遍历目录中的文件
FOR %%变量 IN ([驱动器:][路径]文件名) DO 命令

:: 遍历命令输出
FOR /F [选项] %%变量 IN ('命令') DO 命令

:: 遍历字符串
FOR /F [选项] %%变量 IN ("字符串") DO 命令

:: 遍历文件内容
FOR /F [选项] %%变量 IN (文件名) DO 命令

:: 遍历目录树
FOR /R [[驱动器:]路径] %%变量 IN (集合) DO 命令
```

**示例**：
```batch
:: 遍历当前目录下的所有 .txt 文件
FOR %%i IN (*.txt) DO ECHO %%i

:: 遍历命令输出
FOR /F "tokens=*" %%i IN ('DIR /B') DO ECHO %%i

:: 遍历文件内容
FOR /F "tokens=1,2 delims=," %%i IN (data.csv) DO ECHO %%i - %%j

:: 遍历目录树中的所有 .txt 文件
FOR /R %%i IN (*.txt) DO ECHO %%i
```

### 8.3 `goto` - 跳转到标签

**功能**：跳转到脚本中指定的标签位置。

**语法**：
```batch
:: 定义标签
:标签名

:: 跳转到标签
GOTO 标签名
```

**示例**：
```batch
@ECHO OFF
ECHO 1. 选项一
ECHO 2. 选项二
ECHO 3. 退出
SET /P choice=请输入您的选择：

IF "%choice%"=="1" GOTO OPTION1
IF "%choice%"=="2" GOTO OPTION2
IF "%choice%"=="3" GOTO EXIT
ECHO 无效选择
GOTO END

:OPTION1
ECHO 您选择了选项一
GOTO END

:OPTION2
ECHO 您选择了选项二
GOTO END

:EXIT
ECHO 退出程序
EXIT /B

:END
ECHO 程序结束
```

## 9. 常用命令组合示例

### 9.1 批量重命名文件

```batch
@ECHO OFF
SETLOCAL EnableDelayedExpansion
SET count=1
FOR %%f IN (*.jpg) DO (
    REN "%%f" "photo_!count!.jpg"
    SET /A count+=1
)
ECHO 批量重命名完成！
PAUSE
```

### 9.2 备份文件到指定目录

```batch
@ECHO OFF
SET backup_dir=D:\backup\%date:~0,4%%date:~5,2%%date:~8,2%
MD %backup_dir%
XCOPY C:\data %backup_dir% /E /I /Y /H
ECHO 备份完成！备份目录：%backup_dir%
PAUSE
```

### 9.3 清理临时文件

```batch
@ECHO OFF
ECHO 开始清理临时文件...
DEL /F /Q %TEMP%\*
RD /S /Q %TEMP%\* 2>NUL
ECHO 临时文件清理完成！
PAUSE
```

## 10. 命令速查表

| 命令 | 功能 | 示例 |
|------|------|------|
| `echo` | 输出文本 | `echo Hello World` |
| `cd` | 切换目录 | `cd /d D:\tmp` |
| `dir` | 列出目录内容 | `dir /s` |
| `md` | 创建目录 | `md test` |
| `rd` | 删除目录 | `rd /s /q test` |
| `copy` | 复制文件 | `copy file1.txt file2.txt` |
| `xcopy` | 扩展复制 | `xcopy source dest /e /i /y` |
| `del` | 删除文件 | `del /f /q *.tmp` |
| `move` | 移动/重命名 | `move file1.txt file2.txt` |
| `ren` | 重命名 | `ren *.txt *.bak` |
| `type` | 显示文件内容 | `type readme.txt` |
| `findstr` | 查找字符串 | `findstr /s "error" *.txt` |
| `tasklist` | 显示进程 | `tasklist` |
| `taskkill` | 终止进程 | `taskkill /im notepad.exe /f` |
| `systeminfo` | 系统信息 | `systeminfo` |
| `ipconfig` | 网络配置 | `ipconfig /all` |
| `ping` | 网络测试 | `ping www.baidu.com` |
| `netstat` | 网络连接 | `netstat -a -n` |
| `for` | 循环 | `for %%i in (*.txt) do echo %%i` |
| `if` | 条件判断 | `if exist file.txt echo 存在` |
| `goto` | 跳转 | `goto label` |

## 总结

以上是 Windows 批处理脚本中最常用的命令，涵盖了文件操作、系统信息、网络管理、进程管理等方面。通过灵活组合这些命令，可以编写功能强大的批处理脚本，自动化完成各种任务。

在编写批处理脚本时，建议：
1. 使用注释提高脚本可读性
2. 关闭命令回显（使用 `@echo off`）
3. 处理好路径中的空格（使用引号包裹）
4. 考虑脚本的健壮性和错误处理
5. 测试脚本在不同环境下的运行情况

随着对批处理命令的熟悉，可以逐步学习更高级的脚本编写技巧，如函数、变量延迟扩展、错误处理等。