# PowerShell 完整学习文档

## 1. PowerShell 简介

PowerShell 是 Microsoft 开发的跨平台任务自动化解决方案，由命令行 shell、脚本语言和配置管理框架组成。它基于 .NET 框架（Windows PowerShell）和 .NET Core（PowerShell Core）构建，提供了强大的命令行环境和脚本编写能力。

### 1.1 PowerShell 的主要特点

- **对象导向**：处理的是对象而不是文本
- **强大的管道功能**：可以将一个命令的输出直接传递给另一个命令
- **丰富的内置命令（Cmdlet）**：超过 1300 个内置命令
- **脚本语言**：支持复杂的脚本编写
- **跨平台**：Windows、macOS、Linux 都可以运行
- **可扩展性**：支持自定义 Cmdlet、模块和函数

## 2. PowerShell 基础

### 2.1 启动 PowerShell

- **Windows**：
  - 搜索 "PowerShell" 或 "Windows PowerShell"
  - 右键点击选择 "以管理员身份运行"（获取管理员权限）

- **macOS/Linux**：
  - 打开终端，输入 `pwsh` 或 `powershell`

### 2.2 基本概念

- **Cmdlet**：PowerShell 内置命令，遵循 "动词-名词" 命名规则（如 `Get-Process`）
- **参数**：Cmdlet 后面的选项，以 `-` 开头（如 `-Name`）
- **管道**：使用 `|` 将一个命令的输出传递给另一个命令
- **对象**：PowerShell 处理的基本单位，包含属性和方法
- **变量**：使用 `$` 符号定义（如 `$var = "value"`）
- **模块**：包含一组相关 Cmdlet 的包
- **脚本**：包含 PowerShell 命令的文本文件，扩展名为 `.ps1`

## 3. 常用 PowerShell 命令

### 3.1 帮助命令

#### Get-Help

**功能**：显示 PowerShell 命令的帮助信息，是学习 PowerShell 的最重要命令。

**语法**：
```powershell
Get-Help [[-Name] <String>] [-Full] [-Online] [-Examples] [-Detailed] [-ShowWindow]
```

**参数说明**：
- `-Name`：指定要获取帮助的命令名称
- `-Full`：显示完整的帮助信息，包括参数、示例等所有内容
- `-Online`：在浏览器中打开在线帮助文档
- `-Examples`：仅显示命令的示例部分
- `-Detailed`：显示详细帮助信息（比基本帮助更详细，但比完整帮助简洁）
- `-ShowWindow`：在新窗口中显示帮助信息

**详细例子**：
```powershell
# 获取 Get-Process 命令的基本帮助
Get-Help Get-Process

# 获取 Get-Process 命令的完整帮助（包括参数、示例等所有信息）
Get-Help Get-Process -Full

# 仅获取 Get-Process 命令的示例部分
Get-Help Get-Process -Examples

# 获取 Get-Process 命令的详细帮助
Get-Help Get-Process -Detailed

# 在浏览器中打开 Get-Process 命令的在线帮助文档
Get-Help Get-Process -Online

# 在新窗口中显示 Get-Help 的帮助信息
Get-Help Get-Help -ShowWindow
```

### 3.2 文件和文件夹操作

#### New-Item

**功能**：创建新的文件或文件夹。

**语法**：
```powershell
New-Item [-Path] <String> [-ItemType <String>] [-Value <Object>] [-Force]
```

**参数说明**：
- `-Path`：指定新项目的路径（必需）
- `-ItemType`：指定项目类型（File、Directory、SymbolicLink 等）
- `-Value`：指定新项目的值（如果是文件，则为文件内容）
- `-Force`：强制创建项目（即使存在同名项目或需要创建父目录）

**详细例子**：
```powershell
# 在当前目录创建名为 "TestFolder" 的文件夹
New-Item -Path ".\TestFolder" -ItemType Directory

# 在 C:\Temp 目录创建名为 "TestFile.txt" 的文件
New-Item -Path "C:\Temp\TestFile.txt" -ItemType File

# 创建文件并直接写入内容
New-Item -Path "C:\Temp\Content.txt" -ItemType File -Value "这是文件的内容"

# 使用相对路径创建嵌套文件夹
New-Item -Path ".\Folder1\Folder2\Folder3" -ItemType Directory -Force

# 使用别名 "ni" 快速创建文件
ni "QuickFile.txt" -ItemType File
```

#### Remove-Item

**功能**：删除文件或文件夹。

**语法**：
```powershell
Remove-Item [-Path] <String> [-Recurse] [-Force] [-Confirm] [-WhatIf]
```

**参数说明**：
- `-Path`：指定要删除的项目路径（必需）
- `-Recurse`：递归删除（包括子文件夹和文件）
- `-Force`：强制删除（包括只读文件，不提示确认）
- `-Confirm`：删除前提示确认
- `-WhatIf`：预览删除操作（不实际执行）

**详细例子**：
```powershell
# 删除单个文件（会提示确认）
Remove-Item -Path "C:\Temp\TestFile.txt"

# 删除文件夹及其所有内容（使用 -Recurse 参数递归删除）
Remove-Item -Path "C:\Temp\TestFolder" -Recurse

# 强制删除只读文件（不提示确认）
Remove-Item -Path "C:\Temp\ReadOnly.txt" -Force

# 使用通配符删除所有 .txt 文件
Remove-Item -Path "C:\Temp\*.txt"

# 使用 -WhatIf 参数预览删除操作（不实际执行）
Remove-Item -Path "C:\Temp\*.log" -WhatIf

# 使用别名 "rm" 删除文件
rm "FileToDelete.txt"
```

#### Copy-Item

**功能**：复制文件或文件夹。

**语法**：
```powershell
Copy-Item [-Path] <String> [-Destination] <String> [-Recurse] [-Force]
```

**参数说明**：
- `-Path`：指定要复制的项目路径（必需）
- `-Destination`：指定复制目标路径（必需）
- `-Recurse`：递归复制（包括子文件夹和文件）
- `-Force`：强制复制（覆盖现有文件）

**详细例子**：
```powershell
# 将单个文件复制到目标位置
Copy-Item -Path "C:\Temp\Source.txt" -Destination "D:\Backup\"

# 将文件复制到目标位置并改名
Copy-Item -Path "C:\Temp\Source.txt" -Destination "D:\Backup\Renamed.txt"

# 复制文件夹及其所有内容
Copy-Item -Path "C:\Temp\SourceFolder" -Destination "D:\Backup\" -Recurse

# 使用通配符复制所有 .txt 文件
Copy-Item -Path "C:\Temp\*.txt" -Destination "D:\Backup\" 

# 覆盖已存在的文件（使用 -Force 参数）
Copy-Item -Path "C:\Temp\Updated.txt" -Destination "D:\Backup\" -Force

# 使用别名 "cp" 复制文件
cp "FileToCopy.txt" "Destination\" 
```

#### Move-Item

**功能**：移动或重命名文件或文件夹。

**语法**：
```powershell
Move-Item [-Path] <String> [-Destination] <String> [-Force]
```

**参数说明**：
- `-Path`：指定要移动的项目路径（必需）
- `-Destination`：指定移动目标路径（必需）
- `-Force`：强制移动（覆盖现有文件）

**详细例子**：
```powershell
# 移动文件到另一个目录
Move-Item -Path "C:\Temp\File.txt" -Destination "D:\Archive\" 

# 重命名文件（保持在同一目录）
Move-Item -Path "C:\Temp\OldName.txt" -Destination "C:\Temp\NewName.txt"

# 移动并重命名文件
Move-Item -Path "C:\Temp\File.txt" -Destination "D:\Archive\Renamed.txt"

# 移动文件夹
Move-Item -Path "C:\Temp\Folder" -Destination "D:\Archive\" 

# 覆盖已存在的文件
Move-Item -Path "C:\Temp\NewVersion.txt" -Destination "D:\Backup\OldVersion.txt" -Force

# 使用别名 "mv" 移动文件
mv "FileToMove.txt" "NewLocation\" 
```

#### Get-Content

**功能**：获取文件的内容。

**语法**：
```powershell
Get-Content [-Path] <String> [-TotalCount <Int64>] [-Tail <Int32>] [-ReadCount <Int64>]
```

**参数说明**：
- `-Path`：指定要读取的文件路径（必需）
- `-TotalCount`：指定要读取的总行数（从文件开头开始）
- `-Tail`：指定要读取的行数（从文件末尾开始）
- `-ReadCount`：指定一次读取的行数

**详细例子**：
```powershell
# 获取文件的所有内容
Get-Content -Path "C:\Temp\File.txt"

# 获取文件的前 5 行
Get-Content -Path "C:\Temp\File.txt" -TotalCount 5

# 获取文件的最后 3 行
Get-Content -Path "C:\Temp\File.txt" -Tail 3

# 实时监控文件变化（类似 Linux 的 tail -f）
Get-Content -Path "C:\Temp\Log.txt" -Tail 10 -Wait

# 一次读取 2 行内容
Get-Content -Path "C:\Temp\File.txt" -ReadCount 2

# 使用别名 "cat" 查看文件内容
cat "File.txt"
```

#### Set-Content

**功能**：将内容写入文件（会覆盖现有内容）。

**语法**：
```powershell
Set-Content [-Path] <String> [-Value] <Object> [-Encoding <String>]
```

**参数说明**：
- `-Path`：指定要写入的文件路径（必需）
- `-Value`：指定要写入的内容（必需）
- `-Encoding`：指定文件编码（ASCII、UTF8、UTF7、UTF32、Unicode 等）

**详细例子**：
```powershell
# 将文本写入文件（覆盖现有内容）
Set-Content -Path "C:\Temp\File.txt" -Value "这是新的内容"

# 使用管道写入内容
"通过管道写入的内容" | Set-Content -Path "C:\Temp\File.txt"

# 写入多行内容
@"
第一行
第二行
第三行
"@ | Set-Content -Path "C:\Temp\MultiLine.txt"

# 指定编码格式（如 UTF-8）
Set-Content -Path "C:\Temp\UTF8.txt" -Value "UTF-8 编码的内容" -Encoding UTF8

# 将命令输出写入文件
Get-Process | Set-Content -Path "C:\Temp\ProcessList.txt"
```

#### Add-Content

**功能**：将内容追加到文件末尾（不会覆盖现有内容）。

**语法**：
```powershell
Add-Content [-Path] <String> [-Value] <Object> [-Encoding <String>]
```

**参数说明**：
- `-Path`：指定要追加内容的文件路径（必需）
- `-Value`：指定要追加的内容（必需）
- `-Encoding`：指定文件编码

**详细例子**：
```powershell
# 在文件末尾追加一行内容
Add-Content -Path "C:\Temp\File.txt" -Value "这是追加的内容"

# 使用管道追加内容
"通过管道追加的内容" | Add-Content -Path "C:\Temp\File.txt"

# 追加多行内容
@"
追加的第一行
追加的第二行
"@ | Add-Content -Path "C:\Temp\File.txt"

# 追加命令输出到文件
Get-Date | Add-Content -Path "C:\Temp\Log.txt"

# 使用别名 "ac" 追加内容
ac "File.txt" "Another line"
```

### 3.3 进程管理

#### Get-Process

**功能**：获取当前运行的进程信息。

**语法**：
```powershell
Get-Process [[-Name] <String>] [-Id <Int32>] [-ComputerName <String>]
```

**参数说明**：
- `-Name`：指定要获取的进程名称
- `-Id`：指定要获取的进程 ID
- `-ComputerName`：指定远程计算机名称

**详细例子**：
```powershell
# 获取所有正在运行的进程
Get-Process

# 获取指定名称的进程（如 Chrome 浏览器）
Get-Process -Name Chrome

# 获取多个指定名称的进程
Get-Process -Name Chrome, Firefox, Edge

# 通过进程 ID 获取进程
Get-Process -Id 1234

# 获取远程计算机上的进程
Get-Process -Name Chrome -ComputerName RemoteServer

# 只显示进程的名称和 ID
Get-Process | Select-Object Name, Id

# 按内存使用量排序进程
Get-Process | Sort-Object WorkingSet -Descending | Select-Object -First 10

# 使用别名 "ps" 获取进程
ps Chrome
```

#### Stop-Process

**功能**：停止一个或多个正在运行的进程。

**语法**：
```powershell
Stop-Process [-Name] <String> [-Id] <Int32> [-Force] [-Confirm] [-WhatIf]
```

**参数说明**：
- `-Name`：指定要停止的进程名称
- `-Id`：指定要停止的进程 ID
- `-Force`：强制停止进程（不提示确认）
- `-Confirm`：停止前提示确认
- `-WhatIf`：预览停止操作（不实际执行）

**详细例子**：
```powershell
# 通过名称停止进程
Stop-Process -Name Notepad

# 通过 ID 停止进程
Stop-Process -Id 1234

# 强制停止进程（不提示确认）
Stop-Process -Name Chrome -Force

# 停止多个进程
Stop-Process -Name Notepad, Calculator

# 使用通配符停止所有以 "Test" 开头的进程
Stop-Process -Name Test*

# 使用 -WhatIf 参数预览将要停止的进程
Stop-Process -Name Chrome -WhatIf

# 使用别名 "kill" 停止进程
kill -Name Notepad
```

### 3.4 服务管理

#### Get-Service

**功能**：获取计算机上的服务信息。

**语法**：
```powershell
Get-Service [[-Name] <String>] [-DisplayName <String>] [-ComputerName <String>]
```

**参数说明**：
- `-Name`：指定要获取的服务名称
- `-DisplayName`：指定要获取的服务显示名称
- `-ComputerName`：指定远程计算机名称

**详细例子**：
```powershell
# 获取所有服务
Get-Service

# 获取指定名称的服务
Get-Service -Name WinDefend

# 通过显示名称获取服务
Get-Service -DisplayName "Windows Defender*"

# 获取远程计算机上的服务
Get-Service -Name WinDefend -ComputerName RemoteServer

# 只显示运行中的服务
Get-Service | Where-Object Status -eq "Running"

# 按服务名称排序
Get-Service | Sort-Object Name

# 使用别名 "gsv" 获取服务
gsv WinDefend
```

#### Start-Service/Stop-Service

**功能**：启动或停止服务。

**语法**：
```powershell
Start-Service [-Name] <String> [-Confirm] [-WhatIf]
Stop-Service [-Name] <String> [-Force] [-Confirm] [-WhatIf]
```

**参数说明**：
- `-Name`：指定要启动/停止的服务名称（必需）
- `-Force`：强制停止服务（包括依赖于它的服务）
- `-Confirm`：操作前提示确认
- `-WhatIf`：预览操作（不实际执行）

**详细例子**：
```powershell
# 启动指定服务
Start-Service -Name WinDefend

# 停止指定服务
Stop-Service -Name WinDefend

# 强制停止服务（包括依赖于它的服务）
Stop-Service -Name WinDefend -Force

# 使用 -WhatIf 参数预览操作
Start-Service -Name WinDefend -WhatIf
Stop-Service -Name WinDefend -WhatIf

# 使用别名启动/停止服务
sasv WinDefend  # 启动服务
spsv WinDefend  # 停止服务
```

### 3.5 数据处理

#### Where-Object

**功能**：根据条件过滤对象。

**语法**：
```powershell
Where-Object [-FilterScript] <ScriptBlock>
```

**参数说明**：
- `-FilterScript`：定义过滤条件的脚本块（必需）

**详细例子**：
```powershell
# 过滤内存使用大于 100MB 的进程
Get-Process | Where-Object { $_.WorkingSet -gt 100MB }

# 过滤状态为 "Stopped" 的服务
Get-Service | Where-Object { $_.Status -eq "Stopped" }

# 使用简化语法（PowerShell 3.0+）
Get-Service | Where-Object Status -eq "Stopped"

# 多个条件的过滤（使用 -and/-or）
Get-Process | Where-Object { $_.WorkingSet -gt 100MB -and $_.Name -like "C*" }

# 过滤文件大小大于 1MB 的 .txt 文件
Get-ChildItem -Path "C:\Temp" -Recurse -Filter "*.txt" | Where-Object Length -gt 1MB

# 使用别名 "?" 过滤
Get-Process | ? Name -eq "Chrome"
```

#### ForEach-Object

**功能**：对集合中的每个对象执行操作。

**语法**：
```powershell
ForEach-Object [-Process] <ScriptBlock> [-Begin <ScriptBlock>] [-End <ScriptBlock>]
```

**参数说明**：
- `-Process`：对每个对象执行的脚本块（必需）
- `-Begin`：在处理对象之前执行的脚本块
- `-End`：在处理所有对象之后执行的脚本块

**详细例子**：
```powershell
# 对数组中的每个元素执行乘法操作
1, 2, 3, 4, 5 | ForEach-Object { $_ * 2 }

# 处理文本文件的每一行，添加行号
$i = 1
Get-Content -Path "C:\Temp\File.txt" | ForEach-Object { "$i: $_"; $i++ }

# 使用 Begin/Process/End 块
1, 2, 3, 4, 5 | ForEach-Object -Begin { $sum = 0 } -Process { $sum += $_ } -End { "总和: $sum" }

# 重命名所有 .txt 文件，添加时间戳
Get-ChildItem -Path "C:\Temp" -Filter "*.txt" | ForEach-Object {
    $newName = "{0}_{1}{2}" -f $_.BaseName, (Get-Date -Format "yyyyMMdd_HHmmss"), $_.Extension
    Rename-Item -Path $_.FullName -NewName $newName
}

# 使用别名 "%" 执行操作
1, 2, 3 | % { $_ * 2 }
```

## 4. PowerShell 脚本编写

### 4.1 脚本文件基础

PowerShell 脚本文件的扩展名为 `.ps1`。要运行脚本，需要设置执行策略：

```powershell
# 查看当前执行策略
Get-ExecutionPolicy

# 设置执行策略为 RemoteSigned（允许运行本地脚本，需要数字签名的远程脚本）
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# 运行脚本（需要指定完整路径或相对路径）
.\MyScript.ps1
```

### 4.2 变量和数据类型

**详细例子**：
```powershell
# 字符串变量
$name = "张三"
$message = 'Hello, PowerShell!'

# 数值变量
$age = 30
$price = 19.99

# 布尔变量
$isValid = $true
$isFinished = $false

# 数组变量
$colors = "红色", "绿色", "蓝色"
$numbers = 1, 2, 3, 4, 5

# 访问数组元素（索引从 0 开始）
$firstColor = $colors[0]
$lastNumber = $numbers[-1]  # 负数索引表示从末尾开始

# 哈希表（键值对集合）
$user = @{
    Name = "李四"
    Age = 25
    City = "北京"
    Skills = @("PowerShell", "Python", "C#")
}

# 访问哈希表元素
$userName = $user["Name"]
$userAge = $user.Age  # 也可以使用点表示法

# 对象变量
$process = Get-Process -Name Chrome | Select-Object -First 1
$processName = $process.Name
$processId = $process.Id
```

### 4.3 控制结构

#### If-Else 语句

**详细例子**：
```powershell
# 基本 If-Else
$score = 85

if ($score -ge 90) {
    Write-Host "优秀"
} elseif ($score -ge 80) {
    Write-Host "良好"
} elseif ($score -ge 60) {
    Write-Host "及格"
} else {
    Write-Host "不及格"
}

# 比较字符串
$name = "PowerShell"

if ($name -eq "PowerShell") {
    Write-Host "名称匹配"
}

# 检查文件是否存在
$filePath = "C:\Temp\File.txt"

if (Test-Path $filePath) {
    Write-Host "文件存在"
} else {
    Write-Host "文件不存在"
}

# 检查数组是否包含元素
$colors = "红", "绿", "蓝"

if ($colors -contains "红") {
    Write-Host "数组包含 '红'"
}
```

#### For 循环

**详细例子**：
```powershell
# 基本 For 循环
for ($i = 1; $i -le 5; $i++) {
    Write-Host "循环次数: $i"
}

# 使用 For 循环遍历数组
$colors = "红", "绿", "蓝", "黄", "紫"

for ($i = 0; $i -lt $colors.Length; $i++) {
    Write-Host "颜色 $i: $($colors[$i])"
}

# 倒计时循环
for ($i = 5; $i -ge 1; $i--) {
    Write-Host "倒计时: $i"
    Start-Sleep -Seconds 1
}
```

#### ForEach 循环

**详细例子**：
```powershell
# 基本 ForEach 循环
$colors = "红", "绿", "蓝", "黄", "紫"

foreach ($color in $colors) {
    Write-Host "颜色: $color"
}

# 遍历文件
$files = Get-ChildItem -Path "C:\Temp" -Filter "*.txt"

foreach ($file in $files) {
    Write-Host "文件: $($file.Name), 大小: $($file.Length) 字节"
}

# 遍历哈希表
$user = @{
    Name = "张三"
    Age = 30
    City = "北京"
}

foreach ($key in $user.Keys) {
    Write-Host "$key: $($user[$key])"
}
```

#### While 循环

**详细例子**：
```powershell
# 基本 While 循环
$i = 1

while ($i -le 5) {
    Write-Host "循环次数: $i"
    $i++
}

# 读取用户输入的 While 循环
$input = ""

while ($input -ne "exit") {
    $input = Read-Host "请输入命令 (输入 'exit' 退出)"
    Write-Host "你输入了: $input"
}

# 处理文件的 While 循环
$filePath = "C:\Temp\File.txt"
$reader = [System.IO.File]::OpenText($filePath)

while (-not $reader.EndOfStream) {
    $line = $reader.ReadLine()
    Write-Host "行内容: $line"
}

$reader.Close()
```

### 4.4 函数编写

**详细例子**：
```powershell
# 基本函数
function Get-Sum {
    param(
        [int]$a,
        [int]$b
    )
    
    $result = $a + $b
    return $result
}

# 调用函数
$total = Get-Sum -a 5 -b 3
Write-Host "5 + 3 = $total"

# 带管道输入的函数
function Convert-ToUpper {
    param(
        [Parameter(ValueFromPipeline = $true)]
        [string]$Text
    )
    
    process {
        $Text.ToUpper()
    }
}

# 调用带管道的函数
"hello", "world", "powershell" | Convert-ToUpper

# 带默认参数的函数
function Get-Greeting {
    param(
        [string]$Name = "世界"
    )
    
    Write-Host "你好, $Name!"
}

# 调用函数（使用默认参数）
Get-Greeting

# 调用函数（指定参数）
Get-Greeting -Name "PowerShell"

# 带参数验证的函数
function Set-Age {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateRange(0, 120)]
        [int]$Age
    )
    
    Write-Host "年龄设置为: $Age"
}

# 调用带验证的函数
Set-Age -Age 30  # 有效
Set-Age -Age 150  # 会报错，超出验证范围
```

## 5. PowerShell 高级功能

### 5.1 错误处理

PowerShell 提供了强大的错误处理机制，可以使用 `Try/Catch/Finally` 结构来捕获和处理错误：

```powershell
# 基本的 Try/Catch 结构
try {
    # 可能发生错误的代码
    Get-Content -Path "C:\NonExistent\File.txt" -ErrorAction Stop
} catch {
    # 处理错误
    Write-Host "发生错误: $($_.Exception.Message)" -ForegroundColor Red
}

# Try/Catch/Finally 结构
try {
    $file = New-Item -Path "C:\Temp\Test.txt" -ItemType File -Value "测试内容"
    # 其他操作
} catch {
    Write-Host "错误: $($_.Exception.Message)" -ForegroundColor Red
} finally {
    # 无论是否发生错误都会执行的代码
    if (Test-Path $file) {
        Remove-Item $file -Force
    }
}

# 捕获特定类型的错误
try {
    $result = 10 / 0
} catch [DivideByZeroException] {
    Write-Host "除数不能为零!"
} catch [System.Exception] {
    Write-Host "发生其他错误: $($_.Exception.Message)"
}

# 使用 ErrorRecord 对象的属性
try {
    Get-Item -Path "C:\Nonexistent.txt" -ErrorAction Stop
} catch {
    Write-Host "错误类型: $($_.Exception.GetType().FullName)"
    Write-Host "错误消息: $($_.Exception.Message)"
    Write-Host "脚本行号: $($_.InvocationInfo.ScriptLineNumber)"
    Write-Host "命令: $($_.InvocationInfo.MyCommand)"
}
```

### 5.2 自定义对象

在 PowerShell 中，你可以创建自定义对象来组织和处理数据：

```powershell
# 使用 New-Object 创建自定义对象
$person = New-Object -TypeName PSObject
$person | Add-Member -MemberType NoteProperty -Name "Name" -Value "张三"
$person | Add-Member -MemberType NoteProperty -Name "Age" -Value 30
$person | Add-Member -MemberType NoteProperty -Name "City" -Value "北京"

Write-Host "姓名: $($person.Name), 年龄: $($person.Age), 城市: $($person.City)"

# 使用 [PSCustomObject] 类型加速器（PowerShell 3.0+）
$employee = [PSCustomObject]@{
    Name = "李四"
    Department = "IT"
    Position = "开发工程师"
    Salary = 8000
}

$employee | Format-Table -AutoSize

# 自定义对象数组
$employees = @(
    [PSCustomObject]@{ Name = "张三"; Department = "销售"; Salary = 6000 }
    [PSCustomObject]@{ Name = "李四"; Department = "IT"; Salary = 8000 }
    [PSCustomObject]@{ Name = "王五"; Department = "人力资源"; Salary = 5500 }
)

# 过滤和排序自定义对象数组
$employees | Where-Object { $_.Salary -gt 6000 } | Sort-Object Salary -Descending
```

### 5.3 字符串处理

PowerShell 提供了丰富的字符串处理功能：

```powershell
# 字符串连接
$firstName = "张"
$lastName = "三"
$fullName = $firstName + " " + $lastName
Write-Host $fullName

# 字符串格式化
$name = "PowerShell"
$version = 7.2
$formatted = "{0} 版本 {1}" -f $name, $version
Write-Host $formatted

# 字符串替换
$text = "Hello World"
$newText = $text -replace "World", "PowerShell"
Write-Host $newText

# 字符串分割
$csv = "张三,30,北京"
$fields = $csv -split ","
Write-Host "姓名: $($fields[0]), 年龄: $($fields[1]), 城市: $($fields[2])"

# 字符串截取
$text = "PowerShell"
$substring = $text.Substring(0, 5)  # 从索引0开始，截取5个字符
Write-Host $substring  # 输出 "Power"

# 字符串方法
$text = "hello powershell"
Write-Host $text.ToUpper()  # 转换为大写
Write-Host $text.ToLower()  # 转换为小写
Write-Host $text.Trim()     # 去除首尾空白
Write-Host $text.StartsWith("hello")  # 检查是否以 "hello" 开头
Write-Host $text.EndsWith("shell")    # 检查是否以 "shell" 结尾
Write-Host $text.IndexOf("powershell")  # 查找子字符串的索引
```

### 5.4 日期和时间处理

PowerShell 提供了强大的日期和时间处理功能：

```powershell
# 获取当前日期和时间
$now = Get-Date
Write-Host $now

# 格式化日期和时间
$formattedDate = Get-Date -Format "yyyy-MM-dd"
$formattedTime = Get-Date -Format "HH:mm:ss"
$formattedDateTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Write-Host "日期: $formattedDate"
Write-Host "时间: $formattedTime"
Write-Host "日期时间: $formattedDateTime"

# 创建特定日期和时间
$specificDate = Get-Date -Year 2023 -Month 12 -Day 25 -Hour 10 -Minute 30 -Second 0
Write-Host $specificDate

# 日期计算
$tomorrow = (Get-Date).AddDays(1)
$nextWeek = (Get-Date).AddDays(7)
$lastMonth = (Get-Date).AddMonths(-1)
Write-Host "明天: $tomorrow"
Write-Host "下周: $nextWeek"
Write-Host "上个月: $lastMonth"

# 日期比较
$date1 = Get-Date -Year 2023 -Month 1 -Day 1
$date2 = Get-Date -Year 2023 -Month 12 -Day 31

if ($date1 -lt $date2) {
    Write-Host "$date1 在 $date2 之前"
}

# 计算两个日期之间的差值
$startDate = Get-Date -Year 2023 -Month 1 -Day 1
$endDate = Get-Date -Year 2023 -Month 12 -Day 31
$difference = $endDate - $startDate
Write-Host "两个日期之间的天数: $($difference.Days)"
Write-Host "两个日期之间的总小时数: $($difference.TotalHours)"
```

### 5.5 WMI/CIM

WMI (Windows Management Instrumentation) 和 CIM (Common Information Model) 是 PowerShell 中用于管理系统的重要工具：

```powershell
# 使用 WMI 获取系统信息
Get-WmiObject -Class Win32_OperatingSystem | Select-Object Caption, Version, BuildNumber

# 使用 WMI 获取磁盘信息
Get-WmiObject -Class Win32_LogicalDisk | Select-Object DeviceID, VolumeName, Size, FreeSpace

# 使用 CIM 获取系统信息（推荐，跨平台支持）
Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object Caption, Version, BuildNumber

# 使用 CIM 获取处理器信息
Get-CimInstance -ClassName Win32_Processor | Select-Object Name, Manufacturer, MaxClockSpeed

# 使用 CIM 获取服务信息
Get-CimInstance -ClassName Win32_Service | Where-Object { $_.State -eq "Running" } | Select-Object -First 10

# 使用 WMI 执行操作（重启计算机）
# 注意：这会立即重启计算机，请谨慎使用
# Get-WmiObject -Class Win32_OperatingSystem -ComputerName . | Invoke-WmiMethod -Name Reboot
```

### 5.6 配置文件

PowerShell 配置文件允许你自定义 PowerShell 环境：

```powershell
# 查看配置文件路径
$profile
$profile.CurrentUserAllHosts
$profile.CurrentUserCurrentHost
$profile.AllUsersAllHosts
$profile.AllUsersCurrentHost

# 创建当前用户当前主机的配置文件
if (-not (Test-Path $profile)) {
    New-Item -Path $profile -ItemType File -Force
}

# 编辑配置文件
notepad $profile

# 配置文件示例内容
# 设置别名
Set-Alias -Name ll -Value Get-ChildItem
Set-Alias -Name grep -Value Select-String

# 设置默认参数
$PSDefaultParameterValues['Out-File:Encoding'] = 'UTF8'
$PSDefaultParameterValues['Get-ChildItem:Force'] = $true

# 设置提示符
function prompt {
    $currentDirectory = Get-Location
    $currentTime = Get-Date -Format "HH:mm:ss"
    "$currentDirectory [$currentTime] > "
}

# 导入常用模块
Import-Module PSReadLine
```

### 5.7 输出格式化

PowerShell 提供了多种格式化输出的方式：

```powershell
# 格式化表格输出
Get-Process | Format-Table -AutoSize
Get-Process | Format-Table Name, Id, WorkingSet -AutoSize
Get-Process | Format-Table Name, @{Name='内存(MB)';Expression={[math]::round($_.WorkingSet/1MB, 2)}} -AutoSize

# 格式化列表输出
Get-Service | Where-Object { $_.Status -eq "Running" } | Format-List -Property *
Get-Service | Where-Object { $_.Status -eq "Running" } | Format-List Name, DisplayName, Status

# 格式化宽输出
Get-Command | Format-Wide -Column 3

# 格式化自定义对象
$person = [PSCustomObject]@{ Name = "张三"; Age = 30; City = "北京" }
$person | Format-Table -AutoSize

# 输出到文件并保持格式化
Get-Process | Format-Table Name, Id, WorkingSet -AutoSize | Out-File "C:\Temp\ProcessList.txt"

# 使用 Out-GridView 显示网格视图（仅 Windows）
# Get-Process | Out-GridView -Title "进程列表"
```

### 5.8 环境变量

PowerShell 允许你查看和管理环境变量：

```powershell
# 查看所有环境变量
Get-ChildItem Env:

# 查看特定环境变量
$env:Path
$env:USERNAME
$env:COMPUTERNAME

# 设置环境变量（当前会话）
$env:TEST_VAR = "测试值"
Write-Host $env:TEST_VAR

# 永久设置环境变量（Windows）
[System.Environment]::SetEnvironmentVariable("TEST_VAR", "永久值", "User")

# 永久设置环境变量（系统级别，需要管理员权限）
# [System.Environment]::SetEnvironmentVariable("TEST_VAR", "系统值", "Machine")

# 在 Path 环境变量中添加目录
$newPath = $env:Path + ";C:\MyScripts"
[System.Environment]::SetEnvironmentVariable("Path", $newPath, "User")

# 使用环境变量启动程序
Start-Process -FilePath $env:windir\system32\notepad.exe
```

### 5.9 模块管理

```powershell
# 列出已安装的模块
Get-Module -ListAvailable

# 导入模块
Import-Module ActiveDirectory

# 列出已导入的模块
Get-Module

# 导出模块中的函数和别名
Export-ModuleMember -Function * -Alias *

# 从 PowerShell Gallery 安装模块
Install-Module -Name Pester -Scope CurrentUser

# 更新模块
Update-Module -Name Pester

# 卸载模块
Remove-Module -Name ActiveDirectory
```

### 5.2 远程管理

```powershell
# 启用 PowerShell 远程管理（需要管理员权限）
Enable-PSRemoting -Force

# 在远程计算机上执行命令
Invoke-Command -ComputerName Server01 -ScriptBlock { Get-Process }

# 在多台计算机上执行命令
Invoke-Command -ComputerName Server01, Server02, Server03 -ScriptBlock { Get-Service }

# 建立持久会话
$session = New-PSSession -ComputerName Server01

# 在会话中执行命令
Invoke-Command -Session $session -ScriptBlock { Get-Process }

# 从远程计算机复制文件
Copy-Item -Path "C:\Temp\File.txt" -Destination "C:\Temp\" -FromSession $session

# 关闭会话
Remove-PSSession $session
```

### 5.3 正则表达式

```powershell
# 测试字符串是否匹配正则表达式
$email = "user@example.com"
$email -match "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"

# 提取匹配的部分
$text = "电话号码: 138-1234-5678"
$text -match "电话号码: (\d{3}-\d{4}-\d{4})"
$matches[1]  # 提取电话号码

# 替换字符串
$text = "Hello 123 World"
$text -replace "\d+", "456"  # 将数字替换为 456

# 分割字符串
$text = "a,b,c,d,e"
$text -split ","  # 按逗号分割

# 使用正则表达式过滤
Get-ChildItem -Path "C:\Temp" | Where-Object Name -match "^Test.*\.txt$"
```

## 6. 实用技巧和最佳实践

### 6.1 实用快捷键

- `Ctrl + C`：中断当前命令
- `Ctrl + D`：退出 PowerShell
- `Ctrl + L`：清屏
- `Tab`：自动补全命令、参数和路径
- `Up/Down Arrow`：浏览命令历史
- `Home/End`：移动到行首/行尾
- `Ctrl + Home/Ctrl + End`：移动到命令历史的开头/结尾
- `Ctrl + A`：选择当前行的所有内容

### 6.2 调试技巧

```powershell
# 设置断点
Set-PSBreakpoint -Script "C:\Temp\Script.ps1" -Line 5

# 开始调试
Debug-Script -Script "C:\Temp\Script.ps1"

# 单步执行
s  # 单步进入
v  # 单步跳过
o  # 单步跳出

# 查看变量值
$var

# 继续执行
c

# 退出调试
q
```

### 6.3 最佳实践

1. **使用描述性的命令和变量名**：避免使用缩写或模糊的名称
2. **添加注释**：使用 `#` 添加注释，说明代码的功能和逻辑
3. **错误处理**：使用 `Try/Catch/Finally` 结构处理错误
4. **参数验证**：对函数参数进行验证，确保输入符合预期
5. **模块化**：将代码组织成函数和模块，提高可重用性
6. **测试**：使用 Pester 等工具测试代码的正确性
7. **版本控制**：使用 Git 等版本控制工具管理脚本
8. **安全性**：避免使用硬编码的密码和敏感信息，使用安全的方式存储凭证

## 7. 附录：常用 Cmdlet 速查表

| Cmdlet | 别名 | 功能 | 示例 |
|--------|------|------|------|
| Get-Command | gcm | 获取可用命令 | `gcm *process*` |
| Get-Help | gh | 获取帮助 | `gh Get-Process -Examples` |
| Set-Location | cd, sl | 更改目录 | `cd C:\Temp` |
| Get-Location | pwd, gl | 获取当前目录 | `pwd` |
| New-Item | ni | 创建文件/文件夹 | `ni Test.txt -ItemType File` |
| Remove-Item | rm, del | 删除文件/文件夹 | `rm Test.txt` |
| Copy-Item | cp, copy | 复制文件/文件夹 | `cp Source.txt Destination.txt` |
| Move-Item | mv | 移动/重命名 | `mv Old.txt New.txt` |
| Get-Content | cat, gc | 读取文件内容 | `gc Test.txt` |
| Set-Content | sc | 写入文件内容 | `sc Test.txt "Content"` |
| Add-Content | ac | 追加文件内容 | `ac Test.txt "More content"` |
| Get-Process | ps, gps | 获取进程 | `ps Chrome` |
| Stop-Process | kill, sps | 停止进程 | `kill -Name Chrome` |
| Get-Service | gsv | 获取服务 | `gsv WinDefend` |
| Start-Service | sasv | 启动服务 | `sasv WinDefend` |
| Stop-Service | spsv | 停止服务 | `spsv WinDefend` |
| Where-Object | ? | 过滤对象 | `Get-Process | ? WorkingSet -gt 100MB` |
| ForEach-Object | % | 遍历对象 | `1,2,3 | % { $_ * 2 }` |
| Select-Object | select | 选择属性 | `Get-Process | select Name, Id` |
| Sort-Object | sort | 排序对象 | `Get-Process | sort WorkingSet -Descending` |
| Group-Object | group | 分组对象 | `Get-Process | group PriorityClass` |
| Measure-Object | measure | 测量对象 | `Get-Process | measure Count` |

## 8. 实例项目：使用 OAuth 2.0 访问 API

在实际工作中，我们经常需要访问需要身份验证的 API。本实例将演示如何使用 PowerShell 实现完整的 OAuth 2.0 Client Credentials Grant 流程，包括获取访问令牌、使用令牌访问受保护 API 以及解析 JSON 响应。

### 8.1 OAuth 2.0 基本概念

OAuth 2.0 是一种开放标准，用于授权第三方应用访问受保护的资源，而无需暴露用户凭据。在本实例中，我们将使用 **Client Credentials Grant** 类型，适合机器对机器的身份验证场景。

### 8.2 完整实现步骤

#### 8.2.1 准备工作

1. 从 API 提供者处获取以下信息：
   - `ClientId`：客户端标识符
   - `ClientSecret`：客户端密钥
   - `TokenEndpoint`：令牌端点 URL
   - `ApiEndpoint`：受保护的 API 端点 URL

2. 确保 PowerShell 版本 >= 5.1，支持 `Invoke-RestMethod` 命令

#### 8.2.2 完整脚本示例

```powershell
# 1. 配置参数（建议使用环境变量或安全存储，避免硬编码）
$config = @{
    ClientId     = "your-client-id"        # 替换为实际的 Client ID
    ClientSecret = "your-client-secret"    # 替换为实际的 Client Secret
    TokenEndpoint = "https://api.example.com/oauth2/token"  # 替换为实际的令牌端点
    ApiEndpoint   = "https://api.example.com/v1/resource"  # 替换为实际的 API 端点
}

# 2. 获取访问令牌（AccessToken）
try {
    Write-Host "正在获取访问令牌..." -ForegroundColor Cyan
    
    # 构建请求体
    $tokenRequestBody = @{
        grant_type    = "client_credentials"
        client_id     = $config.ClientId
        client_secret = $config.ClientSecret
    }
    
    # 发送请求获取令牌
    $tokenResponse = Invoke-RestMethod -Uri $config.TokenEndpoint `
                                      -Method Post `
                                      -ContentType "application/x-www-form-urlencoded" `
                                      -Body $tokenRequestBody `
                                      -ErrorAction Stop
    
    # 提取访问令牌
    $accessToken = $tokenResponse.access_token
    $tokenType = $tokenResponse.token_type
    $expiresIn = $tokenResponse.expires_in
    
    Write-Host "成功获取访问令牌！" -ForegroundColor Green
    Write-Host "令牌类型: $tokenType" -ForegroundColor Yellow
    Write-Host "过期时间: $expiresIn 秒" -ForegroundColor Yellow
    Write-Host "访问令牌: $accessToken" -ForegroundColor Yellow
    
} catch {
    Write-Host "获取访问令牌失败: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# 3. 使用访问令牌访问受保护的 API
try {
    Write-Host "`n正在访问受保护的 API..." -ForegroundColor Cyan
    
    # 构建请求头，包含 Bearer 令牌
    $apiHeaders = @{
        "Authorization" = "Bearer $accessToken"
        "Content-Type" = "application/json"
    }
    
    # 发送请求到受保护的 API
    $apiResponse = Invoke-RestMethod -Uri $config.ApiEndpoint `
                                   -Method Get `
                                   -Headers $apiHeaders `
                                   -ErrorAction Stop
    
    Write-Host "API 访问成功！" -ForegroundColor Green
    
    # 4. 解析和处理 JSON 响应
    Write-Host "`n解析 API 响应..." -ForegroundColor Cyan
    
    # 输出格式化的 JSON 响应
    Write-Host "完整响应 (格式化):" -ForegroundColor Yellow
    $apiResponse | ConvertTo-Json -Depth 10 | Write-Host
    
    # 访问响应中的特定字段
    # 注意：这里的字段名称需要根据实际 API 响应结构调整
    Write-Host "`n响应中的特定字段:" -ForegroundColor Yellow
    # 示例：$apiResponse.data.items | ForEach-Object { Write-Host "ID: $($_.id), Name: $($_.name)" }
    
    # 如果响应是数组，遍历处理
    if ($apiResponse -is [array]) {
        Write-Host "`n遍历响应数组:" -ForegroundColor Yellow
        $index = 0
        foreach ($item in $apiResponse) {
            $index++
            Write-Host "项目 $index: $($item | ConvertTo-Json -Compress)"
        }
    }
    
} catch {
    Write-Host "API 访问失败: $($_.Exception.Message)" -ForegroundColor Red
    if ($_.ErrorDetails.Message) {
        Write-Host "API 错误详情: $($_.ErrorDetails.Message)" -ForegroundColor Red
    }
    exit 1
}

Write-Host "`n操作完成！" -ForegroundColor Green
```

#### 8.2.3 脚本说明

1. **参数配置**：
   - 建议使用环境变量或安全存储（如 Azure Key Vault、Windows 凭据管理器）来存储敏感信息
   - 避免将 `ClientSecret` 等敏感信息硬编码在脚本中

2. **获取令牌**：
   - 使用 `Invoke-RestMethod` 发送 POST 请求到令牌端点
   - 请求体包含 `grant_type`、`client_id` 和 `client_secret`
   - 从响应中提取 `access_token`、`token_type` 和 `expires_in`

3. **访问 API**：
   - 在请求头中添加 `Authorization: Bearer <access_token>`
   - 发送 GET 请求到受保护的 API 端点

4. **解析 JSON 响应**：
   - 使用 `ConvertTo-Json` 格式化输出完整响应
   - 可以直接访问响应中的特定字段（如 `$apiResponse.data.items`）
   - 对于数组响应，可以使用循环遍历处理

#### 8.2.4 安全性考虑

1. **避免硬编码敏感信息**：
   ```powershell
   # 使用环境变量
   $clientId = $env:API_CLIENT_ID
   $clientSecret = $env:API_CLIENT_SECRET
   
   # 或使用 Windows 凭据管理器
   $credential = Get-Credential -Message "输入 API 凭据"
   $clientId = $credential.UserName
   $clientSecret = $credential.GetNetworkCredential().Password
   ```

2. **处理令牌过期**：
   ```powershell
   # 检查令牌是否即将过期
   $tokenExpiry = (Get-Date).AddSeconds($expiresIn - 60)  # 提前60秒刷新
   if ((Get-Date) -gt $tokenExpiry) {
       Write-Host "令牌即将过期，正在刷新..." -ForegroundColor Cyan
       # 重新获取令牌
       # ...
   }
   ```

3. **错误处理**：
   - 使用 `Try/Catch` 结构捕获所有可能的错误
   - 记录详细的错误信息，便于调试

#### 8.2.5 实际应用示例

以下是调用 GitHub API 的实际示例（需要创建 GitHub App 获取 Client ID 和 Secret）：

```powershell
# GitHub API 示例
$config = @{
    ClientId     = "your-github-app-client-id"
    ClientSecret = "your-github-app-client-secret"
    TokenEndpoint = "https://github.com/login/oauth/access_token"
    ApiEndpoint   = "https://api.github.com/user"
}

# 获取令牌（GitHub 使用不同的 grant_type）
$tokenRequestBody = @{
    client_id     = $config.ClientId
    client_secret = $config.ClientSecret
    code          = "authorization-code"  # 需要通过 OAuth 流程获取
}

# 其他步骤类似...
```

### 8.3 扩展功能

#### 8.3.1 保存和加载令牌

```powershell
# 保存令牌到文件（加密）
$tokenData = @{
    AccessToken = $accessToken
    TokenType = $tokenType
    ExpiresAt = (Get-Date).AddSeconds($expiresIn)
}

$tokenData | ConvertTo-Json | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString | Out-File "C:\Temp\Token.txt"

# 加载令牌
$encryptedToken = Get-Content "C:\Temp\Token.txt" | ConvertTo-SecureString
$tokenJson = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($encryptedToken))
$tokenData = $tokenJson | ConvertFrom-Json

if ((Get-Date) -lt $tokenData.ExpiresAt) {
    $accessToken = $tokenData.AccessToken
    Write-Host "使用缓存的令牌..." -ForegroundColor Green
} else {
    Write-Host "令牌已过期，重新获取..." -ForegroundColor Yellow
    # 重新获取令牌
    # ...
}
```

#### 8.3.2 支持代理

```powershell
# 配置代理
$proxySettings = @{
    Proxy = "http://proxy.example.com:8080"
    ProxyCredential = Get-Credential -Message "输入代理凭据"
}

# 在请求中使用代理
$tokenResponse = Invoke-RestMethod -Uri $config.TokenEndpoint `
                                  -Method Post `
                                  -ContentType "application/x-www-form-urlencoded" `
                                  -Body $tokenRequestBody `
                                  -Proxy $proxySettings.Proxy `
                                  -ProxyCredential $proxySettings.ProxyCredential `
                                  -ErrorAction Stop
```

## 9. 学习资源推荐

1. **官方文档**：[PowerShell 文档](https://docs.microsoft.com/zh-cn/powershell/)
2. **在线教程**：[PowerShell 入门](https://docs.microsoft.com/zh-cn/powershell/scripting/getting-started/getting-started-with-windows-powershell?view=powershell-7.1)
3. **书籍**：
   - 《Windows PowerShell 实战指南》
   - 《PowerShell 核心实战》
   - 《精通 Windows PowerShell 脚本编程》
4. **社区资源**：
   - [PowerShell Gallery](https://www.powershellgallery.com/)
   - [PowerShell.org](https://powershell.org/)
   - [Stack Overflow PowerShell 标签](https://stackoverflow.com/questions/tagged/powershell)
5. **视频教程**：
   - Microsoft Virtual Academy 的 PowerShell 课程
   - YouTube 上的 PowerShell 教程系列