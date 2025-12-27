# PowerShell 脚本编写

## 1. 脚本基本结构

### 1.1 脚本文件格式
- PowerShell 脚本文件扩展名为 `.ps1`
- 脚本第一行通常是解释器声明（可选，主要用于 Linux/macOS）：
  ```powershell
  #!/usr/bin/env pwsh
  ```
- **中文编码处理**：
  - PowerShell Core (pwsh) 默认使用 UTF-8 编码，完全支持中文
  - Windows PowerShell 默认使用 UTF-16LE 编码，建议显式设置为 UTF-8
  - 在脚本开头添加编码声明（可选，但推荐）：
    ```powershell
    # 确保使用 UTF-8 编码
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    [Console]::InputEncoding = [System.Text.Encoding]::UTF8
    ```

### 1.2 脚本注释
- 单行注释：使用 `#` 开头
- 多行注释：使用 `<#` 和 `#>` 包裹

```powershell
# 这是单行注释

<#
这是多行注释
第二行注释
#>
```

### 1.3 脚本执行方式
1. 直接在 PowerShell 中运行：
   ```powershell
   .\脚本名.ps1
   ```
2. 通过命令行参数运行：
   ```powershell
   PowerShell.exe -File .\脚本名.ps1 参数1 参数2
   ```
3. 作为模块导入：
   ```powershell
   Import-Module .\脚本名.ps1
   ```

## 2. 变量和数据类型

### 2.1 变量声明
- 使用 `$` 符号定义变量
- 变量名区分大小写
- 推荐使用驼峰命名法

```powershell
# 基本变量声明
$name = "张三"
$age = 25
$isStudent = $true

# 变量赋值
$number = 10 + 5  # 结果为 15
$greeting = "Hello, " + $name  # 结果为 "Hello, 张三"
```

### 2.2 数据类型
PowerShell 是弱类型语言，但也支持强类型声明：

| 数据类型 | 示例 | 说明 |
|---------|------|------|
| 字符串 | `"Hello"` | 文本数据 |
| 整数 | `123` | 整数数字 |
| 浮点数 | `3.14` | 小数 |
| 布尔值 | `$true`/`$false` | 真/假 |
| 数组 | `@(1, 2, 3)` | 有序集合 |
| 哈希表 | `@{Name="张三"; Age=25}` | 键值对集合 |
| 对象 | `Get-Process` | .NET 对象 |

### 2.3 强类型声明
使用 `[类型]` 语法声明强类型变量：

```powershell
[string]$name = "张三"
[int]$age = 25
[bool]$isStudent = $true
[array]$numbers = @(1, 2, 3)
[hashtable]$person = @{Name="张三"; Age=25}
```

## 3. 流程控制

### 3.1 条件语句

#### 3.1.1 if-else 语句
```powershell
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
```

#### 3.1.2 switch 语句
```powershell
$day = "Monday"

switch ($day) {
    "Monday" {
        Write-Host "星期一"
    }
    "Tuesday" {
        Write-Host "星期二"
    }
    "Wednesday" {
        Write-Host "星期三"
    }
    default {
        Write-Host "其他星期"
    }
}
```

### 3.2 循环结构

#### 3.2.1 for 循环
```powershell
# 打印 1 到 5
for ($i = 1; $i -le 5; $i++) {
    Write-Host $i
}
```

#### 3.2.2 foreach 循环
```powershell
# 遍历数组
$fruits = @("苹果", "香蕉", "橘子")
foreach ($fruit in $fruits) {
    Write-Host "水果：$fruit"
}

# 遍历哈希表
$person = @{Name="张三"; Age=25; City="北京"}
foreach ($item in $person.GetEnumerator()) {
    Write-Host "$($item.Key): $($item.Value)"
}
```

#### 3.2.3 while 循环
```powershell
# 打印 1 到 5
$i = 1
while ($i -le 5) {
    Write-Host $i
    $i++
}
```

#### 3.2.4 do-while 循环
```powershell
# 至少执行一次
$i = 1
do {
    Write-Host $i
    $i++
} while ($i -le 5)
```

## 4. 函数

### 4.1 函数定义
使用 `function` 关键字定义函数：

```powershell
# 基本函数
function Get-Hello {
    Write-Host "Hello, World!"
}

# 调用函数
Get-Hello
```

### 4.2 带参数的函数
```powershell
# 带参数的函数
function Get-Greeting {
    param(
        [string]$Name,
        [int]$Age = 18  # 默认值
    )
    
    Write-Host "你好，$Name，今年 $Age 岁！"
}

# 调用函数
Get-Greeting -Name "张三" -Age 25
Get-Greeting -Name "李四"  # 使用默认年龄 18
```

### 4.3 带返回值的函数
```powershell
# 带返回值的函数
function Add-Numbers {
    param(
        [int]$a,
        [int]$b
    )
    
    # 使用 return 返回值
    return $a + $b
}

# 调用函数并获取返回值
$result = Add-Numbers -a 10 -b 5
Write-Host "结果：$result"  # 输出：结果：15
```

### 4.4 管道函数
使用 `process` 块处理管道输入：

```powershell
# 管道函数示例
function Get-Doubled {
    param(
        [Parameter(ValueFromPipeline=$true)]
        [int]$Number
    )
    
    process {
        return $Number * 2
    }
}

# 使用管道调用函数
1, 2, 3 | Get-Doubled  # 输出：2 4 6
```

## 5. 错误处理

### 5.1 Try-Catch-Finally
```powershell
try {
    # 可能出错的代码
    Get-Item -Path "不存在的文件.txt" -ErrorAction Stop
} catch {
    # 捕获错误
    Write-Host "发生错误：$($_.Exception.Message)"
} finally {
    # 无论是否出错都会执行
    Write-Host "操作完成"
}
```

### 5.2 错误类型
常见的 PowerShell 错误类型：
- `System.Management.Automation.CommandNotFoundException`：命令未找到
- `System.Management.Automation.ItemNotFoundException`：项目未找到
- `System.UnauthorizedAccessException`：权限不足

### 5.3 自定义错误
```powershell
# 抛出自定义错误
function Test-Age {
    param([int]$Age)
    
    if ($Age -lt 0 -or $Age -gt 120) {
        throw [System.ArgumentException]"年龄必须在 0 到 120 之间"
    }
    
    Write-Host "年龄有效：$Age"
}

# 测试自定义错误
try {
    Test-Age -Age 150
} catch {
    Write-Host "错误：$($_.Exception.Message)"
}
```

## 6. 脚本参数

### 6.1 基本参数
使用 `param()` 块定义脚本参数：

```powershell
# 脚本参数示例
param(
    [string]$Name,
    [int]$Age,
    [switch]$Verbose  # 开关参数
)

Write-Host "姓名：$Name"
Write-Host "年龄：$Age"
if ($Verbose) {
    Write-Host "详细模式已开启"
}
```

## 7. 用户输入处理

### 7.1 基本输入
使用 `Read-Host` 命令获取用户输入：

```powershell
# 基本文本输入
$name = Read-Host "请输入你的姓名"
Write-Host "你好，$name！"

# 数字输入（需要转换类型）
$age = Read-Host "请输入你的年龄"
$age = [int]$age  # 转换为整数类型
Write-Host "你今年 $age 岁了。"
```

### 7.2 密码输入（隐藏输入）
使用 `Read-Host -AsSecureString` 命令获取隐藏的密码输入：

```powershell
# 密码输入
$securePassword = Read-Host "请输入密码" -AsSecureString

# 将安全字符串转换为普通字符串（谨慎使用）
$password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($securePassword)
)
Write-Host "你输入的密码是：$password"
```

### 7.3 输入验证
```powershell
# 验证数字输入
function Get-ValidAge {
    while ($true) {
        $age = Read-Host "请输入你的年龄"
        if ([int]::TryParse($age, [ref]$null) -and $age -ge 0 -and $age -le 120) {
            return [int]$age
        }
        Write-Host "年龄必须是 0 到 120 之间的数字，请重新输入。" -ForegroundColor Red
    }
}

$validAge = Get-ValidAge
Write-Host "你今年 $validAge 岁了。"

# 验证字符串输入
function Get-ValidName {
    while ($true) {
        $name = Read-Host "请输入你的姓名"
        if ($name -match '^[\p{Han}a-zA-Z]{2,20}$') {
            return $name
        }
        Write-Host "姓名必须是 2-20 个中文字符或英文字母，请重新输入。" -ForegroundColor Red
    }
}

$validName = Get-ValidName
Write-Host "你好，$validName！"
```

### 7.4 交互式菜单
使用 `switch` 和 `Read-Host` 创建简单的交互式菜单：

```powershell
function Show-Menu {
    Write-Host "=== 主菜单 ===" -ForegroundColor Green
    Write-Host "1. 查看系统信息"
    Write-Host "2. 备份文件"
    Write-Host "3. 清理临时文件"
    Write-Host "4. 退出"
    Write-Host "============="
}

function Show-SystemInfo {
    Write-Host "=== 系统信息 ==="
    Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object Caption, Version
}

function Backup-Files {
    Write-Host "=== 文件备份 ==="
    $source = Read-Host "请输入源目录路径"
    $dest = Read-Host "请输入目标目录路径"
    Write-Host "开始备份 $source 到 $dest..."
    # 这里可以添加实际的备份逻辑
}

function Clean-TempFiles {
    Write-Host "=== 清理临时文件 ==="
    Write-Host "开始清理临时文件..."
    # 这里可以添加实际的清理逻辑
}

# 主循环
while ($true) {
    Show-Menu
    $choice = Read-Host "请选择操作（1-4）"
    
    switch ($choice) {
        "1" {
            Show-SystemInfo
        }
        "2" {
            Backup-Files
        }
        "3" {
            Clean-TempFiles
        }
        "4" {
            Write-Host "再见！" -ForegroundColor Green
            break
        }
        default {
            Write-Host "无效选择，请重新输入。" -ForegroundColor Red
        }
    }
    
    if ($choice -eq "4") {
        break
    }
    
    Read-Host "按 Enter 键继续..."  # 暂停，等待用户按 Enter 键
}
```

### 6.2 参数验证
```powershell
param(
    [Parameter(Mandatory=$true)]  # 必填参数
    [string]$Name,
    
    [ValidateRange(0, 120)]  # 范围验证
    [int]$Age,
    
    [ValidateSet("男", "女")]  # 枚举验证
    [string]$Gender
)
```

### 6.3 参数别名
```powershell
param(
    [Alias("n", "Name")]
    [string]$FullName,
    
    [Alias("a", "Age")]
    [int]$YearsOld
)
```

## 8. 脚本模块化

### 8.1 模块结构
PowerShell 模块通常包含：
- 模块清单文件（`.psd1`）
- 模块脚本文件（`.psm1`）
- 帮助文件
- 示例文件

### 8.2 创建简单模块
1. 创建模块脚本文件 `MyModule.psm1`：
   ```powershell
   # MyModule.psm1
   function Get-Hello {
       Write-Host "Hello from MyModule"
   }
   
   function Get-Goodbye {
       Write-Host "Goodbye from MyModule"
   }
   
   # 导出函数
   Export-ModuleMember -Function Get-Hello, Get-Goodbye
   ```

2. 导入并使用模块：
   ```powershell
   # 导入模块
   Import-Module .\MyModule.psm1
   
   # 使用模块中的函数
   Get-Hello
   Get-Goodbye
   ```

## 9. 脚本最佳实践

### 9.1 命名规范
- 脚本名：使用 PascalCase，如 `Backup-Data.ps1`
- 函数名：使用 Verb-Noun 格式，如 `Get-Content`
- 变量名：使用驼峰命名法，如 `$backupPath`
- 常量名：使用全大写，如 `$MAX_RETRY_COUNT = 5`

### 9.2 注释规范
- 为复杂逻辑添加注释
- 为函数添加帮助文档
- 为脚本添加说明

```powershell
<#
.SYNOPSIS
这是脚本的简要描述

.DESCRIPTION
这是脚本的详细描述，包括功能、使用方法等

.PARAMETER Name
参数 Name 的描述

.PARAMETER Age
参数 Age 的描述

.EXAMPLE
.\脚本名.ps1 -Name "张三" -Age 25

.NOTES
作者：张三
创建时间：2023-01-01
版本：1.0
#>
```

### 9.3 错误处理
- 始终使用 `try-catch` 处理可能的错误
- 使用 `ErrorAction` 参数控制错误处理方式
- 记录详细的错误信息

### 9.4 性能优化
- 减少管道使用，尤其是在循环中
- 避免在循环中使用 `Write-Host`
- 使用变量存储重复计算的结果
- 对于大文件处理，使用流式处理

## 10. 示例脚本

### 10.1 文件备份脚本
```powershell
<#
.SYNOPSIS
备份指定目录下的文件

.DESCRIPTION
将指定目录下的文件备份到目标目录，并添加时间戳

.PARAMETER SourcePath
源目录路径

.PARAMETER DestinationPath
目标目录路径

.EXAMPLE
.\Backup-Files.ps1 -SourcePath "C:\Data" -DestinationPath "D:\Backup"
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$SourcePath,
    
    [Parameter(Mandatory=$true)]
    [string]$DestinationPath
)

try {
    # 检查源目录是否存在
    if (-not (Test-Path -Path $SourcePath -PathType Container)) {
        throw "源目录不存在：$SourcePath"
    }
    
    # 创建目标目录
    $timestamp = Get-Date -Format "yyyyMMddHHmmss"
    $backupDir = Join-Path -Path $DestinationPath -ChildPath "Backup_$timestamp"
    New-Item -Path $backupDir -ItemType Directory -ErrorAction Stop | Out-Null
    
    # 复制文件
    Write-Host "开始备份文件..."
    Copy-Item -Path "$SourcePath\*" -Destination $backupDir -Recurse -ErrorAction Stop
    
    Write-Host "备份完成！"
    Write-Host "备份路径：$backupDir"
} catch {
    Write-Host "备份失败：$($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
```

### 10.2 系统信息收集脚本
```powershell
<#
.SYNOPSIS
收集系统信息

.DESCRIPTION
收集计算机的硬件、软件、网络等信息
#>

function Get-SystemInfo {
    Write-Host "=== 系统信息收集 ===" -ForegroundColor Green
    
    # 操作系统信息
    Write-Host "\n1. 操作系统信息：" -ForegroundColor Yellow
    Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object Caption, Version, BuildNumber, OSArchitecture
    
    # 计算机硬件信息
    Write-Host "\n2. 硬件信息：" -ForegroundColor Yellow
    Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object Manufacturer, Model, TotalPhysicalMemory
    
    # CPU 信息
    Write-Host "\n3. CPU 信息：" -ForegroundColor Yellow
    Get-CimInstance -ClassName Win32_Processor | Select-Object Name, NumberOfCores, NumberOfLogicalProcessors
    
    # 内存信息
    Write-Host "\n4. 内存信息：" -ForegroundColor Yellow
    Get-CimInstance -ClassName Win32_PhysicalMemory | Select-Object Manufacturer, Capacity, Speed
    
    # 磁盘信息
    Write-Host "\n5. 磁盘信息：" -ForegroundColor Yellow
    Get-CimInstance -ClassName Win32_LogicalDisk | Where-Object {$_.DriveType -eq 3} | Select-Object DeviceID, Size, FreeSpace
    
    # 网络信息
    Write-Host "\n6. 网络信息：" -ForegroundColor Yellow
    Get-NetIPAddress | Where-Object {$_.AddressFamily -eq "IPv4" -and $_.PrefixOrigin -ne "WellKnown"} | Select-Object InterfaceAlias, IPAddress, PrefixLength
    
    # 安装的软件
    Write-Host "\n7. 已安装软件（前 10 个）：" -ForegroundColor Yellow
    Get-CimInstance -ClassName Win32_Product | Select-Object Name, Version | Sort-Object Name | Select-Object -First 10
}

# 调用函数
Get-SystemInfo
```

## 11. 调试技巧

### 11.1 输出调试信息
```powershell
# 使用 Write-Debug 输出调试信息
$DebugPreference = "Continue"
Write-Debug "这是调试信息"

# 使用 Write-Verbose 输出详细信息
[CmdletBinding()]
param()
Write-Verbose "这是详细信息" -Verbose
```

### 11.2 使用断点
1. 在 PowerShell ISE 中设置断点：点击行号左侧
2. 在 VS Code 中设置断点：安装 PowerShell 扩展后，点击行号左侧
3. 使用 `Set-PSBreakpoint` 命令设置断点：
   ```powershell
   Set-PSBreakpoint -Script .\脚本名.ps1 -Line 10
   ```

### 11.3 查看变量值
在调试模式下，可以使用 `$变量名` 查看变量当前值，或使用 `Get-Variable` 查看所有变量。

## 12. 资源推荐

- [PowerShell 脚本编写最佳实践](https://docs.microsoft.com/zh-cn/powershell/scripting/developer/cmdlet/best-practices-for-writing-powershell-scripts?view=powershell-7.2)
- [PowerShell 函数编写指南](https://docs.microsoft.com/zh-cn/powershell/scripting/developer/cmdlet/writing-a-windows-powershell-cmdlet?view=powershell-7.2)
- [PowerShell 模块开发](https://docs.microsoft.com/zh-cn/powershell/scripting/developer/module/how-to-write-a-powershell-module?view=powershell-7.2)