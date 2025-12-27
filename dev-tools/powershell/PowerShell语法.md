# PowerShell 语法

## 1. 基本语法

### 1.1 命令结构

PowerShell 命令（cmdlet）通常遵循 "动词-名词" 的命名规范，例如：

```powershell
Get-Process
Set-Service
New-Item
Remove-Item
```

### 1.2 参数

命令可以包含参数，参数以 `-` 符号开头，例如：

```powershell
Get-Process -Name "chrome"
New-Item -Path "C:\temp\test.txt" -ItemType "File" -Value "Hello World"
```

#### 1.2.1 参数语法符号解释

在PowerShell命令语法中，有一些特殊符号用于表示参数的不同特性：

##### 方括号 `[-Name]` 的含义

**方括号 `[ ]` 表示可选参数**，即这个参数可以使用也可以不使用。

**详细说明：**
- `[-Name]` 中的 `-Name` 是参数名
- 整个 `[-Name]` 被方括号包围，表示这个参数是可选的
- 参数名前的连字符 `-` 是PowerShell参数的标准前缀

**示例：**
在 `Get-Help [-Name] <String>` 中：
- `[-Name]` 是可选的参数名
- 如果你想明确指定参数名，可以写成 `Get-Help -Name "Get-Process"`
- 如果你省略参数名，PowerShell会根据位置自动识别，写成 `Get-Help "Get-Process"`

##### 双重方括号 `[[-Path] <String>]` 的含义

双重方括号 `[[ ]]` 表示**位置参数的可选性**，这种格式通常用于有多个位置参数的命令。

**详细说明：**
- 外层方括号 `[ ]` 表示整个参数（包括参数名和参数值）是可选的
- 内层方括号 `[-Path]` 表示参数名是可选的
- `<String>` 表示参数值的类型

**示例：**
在 `Get-Help [-Name] <String> [[-Path] <String>]` 中：
- `[-Name] <String>` 是第一个位置参数，参数名 `-Name` 可选，参数值是字符串类型
- `[[-Path] <String>]` 是第二个位置参数，整个参数可选，参数名 `-Path` 可选，参数值是字符串类型

**位置参数的使用方法：**
1. 使用参数名：`Get-Help -Name "Get-Process" -Path "C:\Scripts"`
2. 省略参数名（按位置）：`Get-Help "Get-Process" "C:\Scripts"`
3. 省略可选参数：`Get-Help "Get-Process"`（只使用第一个参数）

##### 尖括号 `<String>` 的含义

尖括号 `< >` 表示**参数值的数据类型**。

**常见的数据类型：**
- `<String>`：字符串类型
- `<Int32>`：32位整数类型
- `<Boolean>`：布尔类型（True/False）
- `<Object>`：对象类型
- `<SwitchParameter>`：开关参数（不需要值，只要出现就表示True）

**示例：**
在 `Get-Help [-Name] <String>` 中：
- `<String>` 表示 `-Name` 参数的值必须是字符串类型

##### 开关参数 `-Full`、`-Online` 等

不带尖括号的参数名，如 `-Full`、`-Online`、`-ShowWindow`，表示**开关参数**。

**详细说明：**
- 开关参数不需要值，只要在命令中出现就表示启用该功能
- 开关参数通常用于启用命令的特定选项或模式

**示例：**
- `Get-Help Get-Process -Full`：显示完整的帮助信息
- `Get-Help Get-Process -Online`：在浏览器中打开在线帮助
- `Get-Help Get-Process -ShowWindow`：在新窗口中显示帮助信息

##### 综合示例：Get-Help命令完整语法

命令：`Get-Help [-Name] <String> [[-Path] <String>] [-Category <String[]>] [-Component <String[]>] [-Functionality <String[]>] [-Role <String[]>] [-Full] [-Online] [-ShowWindow]`

**各部分解释：**
1. `Get-Help`：命令名
2. `[-Name] <String>`：第一个位置参数，参数名可选，值为字符串
3. `[[-Path] <String>]`：第二个位置参数，整个参数可选，参数名可选，值为字符串
4. `[-Category <String[]>]`：可选参数，参数名为 `-Category`，值为字符串数组
5. `[-Component <String[]>]`：可选参数，参数名为 `-Component`，值为字符串数组
6. `[-Functionality <String[]>]`：可选参数，参数名为 `-Functionality`，值为字符串数组
7. `[-Role <String[]>]`：可选参数，参数名为 `-Role`，值为字符串数组
8. `[-Full]`：开关参数，启用完整帮助
9. `[-Online]`：开关参数，打开在线帮助
10. `[-ShowWindow]`：开关参数，在新窗口显示帮助

**使用示例：**
```powershell
# 使用参数名和位置参数
Get-Help -Name "Get-Process" -Path "C:\Scripts" -Full

# 省略参数名，按位置传递
Get-Help "Get-Process" "C:\Scripts" -Online

# 只使用必要的参数
Get-Help "Get-Process"
```

##### PowerShell语法符号表

| 符号 | 含义 | 示例 |
|------|------|------|
| `[ ]` | 可选参数 | `[-Name]` |
| `[[ ]]` | 位置参数的可选性（整个参数可选，参数名也可选） | `[[-Path] <String>]` |
| `< >` | 参数值的数据类型 | `<String>` |
| `-` | 参数名前缀 | `-Name` |
| 无尖括号的参数 | 开关参数 | `-Full` |

### 1.3 管道

管道允许将一个命令的输出作为另一个命令的输入，使用 `|` 符号表示：

```powershell
Get-Process | Where-Object {$_.CPU -gt 100} | Select-Object -Property Name, CPU
```

### 1.4 注释

PowerShell 支持两种注释方式：

1. **单行注释**：使用 `#` 符号
2. **多行注释**：使用 `<#` 和 `#>` 符号

**示例：**
```powershell
# 这是单行注释

<#
这是多行注释
可以包含多行内容
#>
```

## 2. 变量

### 2.1 变量的声明

PowerShell 中的变量以 `$` 符号开头，声明变量时不需要指定数据类型：

```powershell
$name = "John Doe"
$age = 30
$isActive = $true
```

### 2.2 变量的命名规则

- 变量名可以包含字母、数字和下划线
- 变量名不能以数字开头
- 变量名区分大小写
- 变量名最好具有描述性，便于理解

### 2.3 变量的作用域

PowerShell 中的变量有不同的作用域：

- **全局作用域**：在所有脚本和函数中可见，使用 `$global:` 前缀
- **脚本作用域**：在当前脚本中可见，使用 `$script:` 前缀
- **局部作用域**：在当前函数或脚本块中可见，默认作用域
- **私有作用域**：仅在当前作用域中可见，使用 `$private:` 前缀

**示例：**
```powershell
$global:globalVar = "This is a global variable"
$script:scriptVar = "This is a script variable"
$localVar = "This is a local variable"
$private:privateVar = "This is a private variable"
```

### 2.4 自动变量

PowerShell 包含一些自动变量，这些变量由 PowerShell 自动创建和维护：

| 变量名 | 描述 |
|-------|------|
| `$PSVersionTable` | 包含 PowerShell 版本信息 |
| `$PWD` | 包含当前工作目录 |
| `$HOME` | 包含用户的主目录 |
| `$NULL` | 表示空值 |
| `$True` / `$False` | 表示布尔值 |
| `$Error` | 包含最近的错误信息 |
| `$LastExitCode` | 包含上一个外部命令的退出代码 |

## 3. 数据类型

### 3.1 基本数据类型

PowerShell 支持以下基本数据类型：

| 数据类型 | 描述 | 示例 |
|---------|------|------|
| `String` | 字符串 | `"Hello World"` |
| `Int32` / `Int64` | 整数 | `30` |
| `Double` | 浮点数 | `3.14` |
| `Boolean` | 布尔值 | `$true` / `$false` |
| `DateTime` | 日期时间 | `Get-Date` |
| `Array` | 数组 | `@(1, 2, 3)` |
| `Hashtable` | 哈希表 | `@{Name = "John"; Age = 30}` |
| `PSObject` | PowerShell 对象 | `[PSCustomObject]@{Name = "John"; Age = 30}` |

### 3.2 数据类型转换

可以使用类型转换运算符或 `[类型]` 语法进行数据类型转换：

```powershell
# 使用类型转换运算符
$number = "123" -as [int]

# 使用 [类型] 语法
$number = [int]"123"

# 转换为字符串
$string = [string]123

# 转换为布尔值
$bool = [bool]1
```

## 4. 运算符

### 4.1 算术运算符

| 运算符 | 描述 | 示例 |
|-------|------|------|
| `+` | 加法 | `2 + 3` → `5` |
| `-` | 减法 | `5 - 2` → `3` |
| `*` | 乘法 | `2 * 3` → `6` |
| `/` | 除法 | `6 / 2` → `3` |
| `%` | 取余 | `7 % 3` → `1` |
| `++` | 自增 | `$i++` |
| `--` | 自减 | `$i--` |

### 4.2 比较运算符

| 运算符 | 描述 | 示例 |
|-------|------|------|
| `-eq` | 等于 | `1 -eq 1` → `$true` |
| `-ne` | 不等于 | `1 -ne 2` → `$true` |
| `-gt` | 大于 | `3 -gt 2` → `$true` |
| `-ge` | 大于等于 | `2 -ge 2` → `$true` |
| `-lt` | 小于 | `2 -lt 3` → `$true` |
| `-le` | 小于等于 | `2 -le 2` → `$true` |
| `-like` | 通配符匹配 | `"abc" -like "a*"` → `$true` |
| `-notlike` | 不匹配通配符 | `"abc" -notlike "x*"` → `$true` |
| `-match` | 正则表达式匹配 | `"abc" -match "a.*c"` → `$true` |
| `-notmatch` | 不匹配正则表达式 | `"abc" -notmatch "x.*z"` → `$true` |
| `-contains` | 包含 | `@(1, 2, 3) -contains 2` → `$true` |
| `-notcontains` | 不包含 | `@(1, 2, 3) -notcontains 4` → `$true` |
| `-in` | 成员关系 | `2 -in @(1, 2, 3)` → `$true` |
| `-notin` | 非成员关系 | `4 -notin @(1, 2, 3)` → `$true` |

### 4.3 逻辑运算符

| 运算符 | 描述 | 示例 |
|-------|------|------|
| `-and` | 逻辑与 | `$true -and $false` → `$false` |
| `-or` | 逻辑或 | `$true -or $false` → `$true` |
| `-not` | 逻辑非 | `-not $true` → `$false` |
| `!` | 逻辑非（简写） | `!$true` → `$false` |

### 4.4 赋值运算符

| 运算符 | 描述 | 示例 |
|-------|------|------|
| `=` | 赋值 | `$x = 10` |
| `+=` | 加法赋值 | `$x += 5` → `$x = $x + 5` |
| `-=` | 减法赋值 | `$x -= 5` → `$x = $x - 5` |
| `*=` | 乘法赋值 | `$x *= 5` → `$x = $x * 5` |
| `/=` | 除法赋值 | `$x /= 5` → `$x = $x / 5` |
| `%=` | 取余赋值 | `$x %= 5` → `$x = $x % 5` |

## 5. 流程控制

### 5.1 If-Else 语句

**语法：**
```powershell
if (条件) {
    # 条件为真时执行的代码
} elseif (条件) {
    # 条件为真时执行的代码
} else {
    # 所有条件都为假时执行的代码
}
```

**示例：**
```powershell
$age = 18

if ($age -lt 18) {
    Write-Output "未成年"
} elseif ($age -ge 18 -and $age -lt 65) {
    Write-Output "成年人"
} else {
    Write-Output "老年人"
}
```

### 5.2 Switch 语句

**语法：**
```powershell
switch (表达式) {
    值1 {
        # 表达式等于值1时执行的代码
    }
    值2 {
        # 表达式等于值2时执行的代码
    }
    default {
        # 表达式不匹配任何值时执行的代码
    }
}
```

**示例：**
```powershell
$day = "Monday"

switch ($day) {
    "Monday" {
        Write-Output "星期一"
    }
    "Tuesday" {
        Write-Output "星期二"
    }
    default {
        Write-Output "其他星期"
    }
}
```

### 5.3 For 循环

**语法：**
```powershell
for (初始化; 条件; 迭代) {
    # 循环体
}
```

**示例：**
```powershell
for ($i = 0; $i -lt 5; $i++) {
    Write-Output $i
}
```

### 5.4 ForEach 循环

**语法：**
```powershell
foreach (变量 in 集合) {
    # 循环体
}
```

**示例：**
```powershell
$numbers = @(1, 2, 3, 4, 5)

foreach ($num in $numbers) {
    Write-Output $num
}
```

### 5.5 While 循环

**语法：**
```powershell
while (条件) {
    # 循环体
}
```

**示例：**
```powershell
$i = 0

while ($i -lt 5) {
    Write-Output $i
    $i++
}
```

### 5.6 Do-While 循环

**语法：**
```powershell
do {
    # 循环体
} while (条件)
```

**示例：**
```powershell
$i = 0

do {
    Write-Output $i
    $i++
} while ($i -lt 5)
```

### 5.7 Break 和 Continue

- `Break`：退出当前循环
- `Continue`：跳过当前循环的剩余部分，继续下一次循环

**示例：**
```powershell
for ($i = 0; $i -lt 10; $i++) {
    if ($i -eq 5) {
        break  # 退出循环
    }
    if ($i -eq 3) {
        continue  # 跳过当前循环，继续下一次循环
    }
    Write-Output $i
}
```

## 6. 函数

### 6.1 函数的定义

**语法：**
```powershell
function 函数名 {
    # 函数体
}
```

**示例：**
```powershell
function Get-Hello {
    Write-Output "Hello, World!"
}
```

### 6.2 函数的参数

**语法：**
```powershell
function 函数名 {
    param(
        [类型]$参数1,
        [类型]$参数2 = 默认值
    )
    # 函数体
}
```

**示例：**
```powershell
function Get-Greeting {
    param(
        [string]$Name,
        [int]$Age = 18
    )
    Write-Output "Hello, $Name! You are $Age years old."
}
```

### 6.3 函数的调用

**语法：**
```powershell
函数名 -参数1 值1 -参数2 值2
```

**示例：**
```powershell
Get-Greeting -Name "John" -Age 30
```

### 6.4 函数的返回值

PowerShell 函数可以通过 `return` 关键字返回值，也可以直接输出值：

**示例：**
```powershell
function Add-Numbers {
    param(
        [int]$Num1,
        [int]$Num2
    )
    return $Num1 + $Num2
}

$result = Add-Numbers -Num1 2 -Num2 3
Write-Output $result  # 输出 5
```

## 7. 脚本块

脚本块是一段可执行的 PowerShell 代码，用 `{}` 括起来：

**语法：**
```powershell
$脚本块 = {
    # 脚本块内容
}
```

**示例：**
```powershell
$myScriptBlock = {
    param($Name)
    Write-Output "Hello, $Name!"
}

# 执行脚本块
& $myScriptBlock -Name "John"
```

## 8. 模块

### 8.1 导入模块

**语法：**
```powershell
Import-Module 模块名
```

**示例：**
```powershell
Import-Module ActiveDirectory
```

### 8.2 查看已导入的模块

**语法：**
```powershell
Get-Module
```

### 8.3 查看可用的模块

**语法：**
```powershell
Get-Module -ListAvailable
```

## 9. 错误处理

### 9.1 Try-Catch-Finally

**语法：**
```powershell
try {
    # 可能出错的代码
} catch [异常类型] {
    # 处理特定类型的异常
    Write-Output $_.Exception.Message
} catch {
    # 处理所有其他异常
    Write-Output $_.Exception.Message
} finally {
    # 无论是否发生异常都会执行的代码
}
```

**示例：**
```powershell
try {
    Get-Content "C:\nonexistent.txt"
} catch [System.IO.FileNotFoundException] {
    Write-Output "文件不存在：$($_.Exception.Message)"
} catch {
    Write-Output "发生错误：$($_.Exception.Message)"
} finally {
    Write-Output "清理资源"
}
```

### 9.2 错误偏好设置

可以使用 `$ErrorActionPreference` 变量设置 PowerShell 的错误处理行为：

| 值 | 描述 |
|-----|------|
| `Continue` | 继续执行脚本，显示错误信息（默认） |
| `Stop` | 停止执行脚本，显示错误信息 |
| `SilentlyContinue` | 继续执行脚本，不显示错误信息 |
| `Inquire` | 询问用户如何处理错误 |
| `Ignore` | 忽略错误，继续执行脚本 |

**示例：**
```powershell
$ErrorActionPreference = "Stop"
Get-Content "C:\nonexistent.txt"  # 发生错误时停止执行
```

## 10. 常见问题解决方案

### 10.1 端口占用解决方案

在开发过程中，经常会遇到端口被占用的问题。以下是几种解决方法：

#### 10.1.1 查找占用端口的进程

使用 PowerShell 查找占用特定端口的进程：

```powershell
# 查找占用端口 8000 的进程
Get-NetTCPConnection -LocalPort 8000 | Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort, State, OwningProcess

# 查看进程详细信息
Get-Process -Id (Get-NetTCPConnection -LocalPort 8000).OwningProcess | Select-Object Id, ProcessName, Path
```

#### 10.1.2 终止占用端口的进程

```powershell
# 终止占用端口 8000 的进程
$processId = (Get-NetTCPConnection -LocalPort 8000).OwningProcess
if ($processId) {
    Stop-Process -Id $processId -Force
    Write-Host "已终止占用端口 8000 的进程，PID: $processId"
} else {
    Write-Host "端口 8000 未被占用"
}
```

#### 10.1.3 自动查找可用端口

```powershell
function Find-AvailablePort {
    param (
        [int]$StartPort = 8000,
        [int]$MaxPort = 9000
    )
    
    for ($port = $StartPort; $port -le $MaxPort; $port++) {
        $tcpListener = $null
        try {
            $tcpListener = New-Object System.Net.Sockets.TcpListener([System.Net.IPAddress]::Loopback, $port)
            $tcpListener.Start()
            return $port
        } catch {
            # 端口已被占用，继续尝试下一个端口
        } finally {
            if ($tcpListener) {
                $tcpListener.Stop()
            }
        }
    }
    
    return $null
}

# 使用示例
$availablePort = Find-AvailablePort
if ($availablePort) {
    Write-Host "找到可用端口: $availablePort"
    # 在这里启动你的服务，使用找到的端口
} else {
    Write-Host "没有找到可用端口"
}
```

## 11. Excel 处理

### 11.1 使用 ImportExcel 模块处理 Excel 文件

ImportExcel 是 PowerShell 中处理 Excel 文件的强大模块，基于 EPPlus 库。

#### 11.1.1 安装 ImportExcel 模块

```powershell
# 安装 ImportExcel 模块
Install-Module -Name ImportExcel -Scope CurrentUser
```

#### 11.1.2 读取 Excel 文件

```powershell
# 读取 Excel 文件
$excelData = Import-Excel -Path "C:\path\to\data.xlsx"

# 显示数据
$excelData | Format-Table

# 读取指定工作表
$excelData = Import-Excel -Path "C:\path\to\data.xlsx" -WorksheetName "Sheet2"

# 读取指定范围
$excelData = Import-Excel -Path "C:\path\to\data.xlsx" -StartRow 2 -EndRow 100
```

#### 11.1.3 写入 Excel 文件

```powershell
# 示例数据
$data = @(
    @{ Name = "张三"; Age = 25; City = "北京" },
    @{ Name = "李四"; Age = 30; City = "上海" },
    @{ Name = "王五"; Age = 28; City = "广州" }
)

# 写入 Excel 文件
$data | Export-Excel -Path "C:\path\to\output.xlsx" -AutoSize -BoldTopRow

# 写入指定工作表
$data | Export-Excel -Path "C:\path\to\output.xlsx" -WorksheetName "Sheet2" -AutoSize -BoldTopRow

# 追加到现有工作表
$data | Export-Excel -Path "C:\path\to\output.xlsx" -WorksheetName "Sheet1" -Append
```

#### 11.1.4 筛选和处理数据

```powershell
# 读取数据
$excelData = Import-Excel -Path "C:\path\to\data.xlsx"

# 筛选数据
$filteredData = $excelData | Where-Object { $_.Age -gt 25 }

# 添加计算列
$processedData = $filteredData | Select-Object *, @{Name="AgeGroup"; Expression={if ($_.Age -lt 30) {"青年"} else {"中年"}}}

# 写入处理后的数据
$processedData | Export-Excel -Path "C:\path\to\processed.xlsx" -AutoSize -BoldTopRow
```

## 12. HTTP 请求与 OAuth2.0

### 12.1 使用 Invoke-RestMethod 发送 HTTP 请求

```powershell
# 发送 GET 请求
$response = Invoke-RestMethod -Uri "https://api.example.com/data" -Method Get

# 发送 POST 请求
$body = @{
    name = "张三"
    age = 25
}
$response = Invoke-RestMethod -Uri "https://api.example.com/users" -Method Post -Body ($body | ConvertTo-Json) -ContentType "application/json"
```

### 12.2 OAuth2.0 认证

#### 12.2.1 获取 OAuth2.0 令牌

```powershell
function Get-OAuth2Token {
    param (
        [string]$ClientId,
        [string]$ClientSecret,
        [string]$TokenEndpoint,
        [string]$Scope = ""
    )
    
    $body = @{
        grant_type = "client_credentials"
        client_id = $ClientId
        client_secret = $ClientSecret
    }
    
    if ($Scope) {
        $body["scope"] = $Scope
    }
    
    $response = Invoke-RestMethod -Uri $TokenEndpoint -Method Post -Body $body -ContentType "application/x-www-form-urlencoded"
    return $response
}

# 使用示例
$token = Get-OAuth2Token -ClientId "your-client-id" -ClientSecret "your-client-secret" -TokenEndpoint "https://auth.example.com/token" -Scope "read write"
$accessToken = $token.access_token
```

#### 12.2.2 使用 OAuth2.0 令牌发送请求

```powershell
# 使用获取到的令牌发送请求
$headers = @{
    "Authorization" = "Bearer $accessToken"
    "Content-Type" = "application/json"
}

$response = Invoke-RestMethod -Uri "https://api.example.com/protected-resource" -Method Get -Headers $headers
```

#### 12.2.3 解析 JSON 响应

```powershell
# 发送请求并解析 JSON 响应
$response = Invoke-RestMethod -Uri "https://api.example.com/data" -Method Get -Headers $headers

# 访问响应数据
Write-Host "状态: $($response.status)"
Write-Host "数据总数: $($response.data.count)"

# 遍历数据
foreach ($item in $response.data.items) {
    Write-Host "ID: $($item.id), Name: $($item.name)"
}
```

## 13. 总结

PowerShell 语法基于 .NET，结合了命令行和脚本语言的特点。本文介绍了 PowerShell 的基本语法、变量、数据类型、运算符、流程控制语句、函数、脚本块、模块、错误处理以及常见问题解决方案。

掌握 PowerShell 语法是使用 PowerShell 进行自动化和配置管理的基础。通过学习和实践，可以逐步掌握 PowerShell 的强大功能，实现复杂的自动化任务，包括端口管理、Excel 处理和 OAuth2.0 认证等高级功能。