# PowerShell 常用命令指南

## 1. PowerShell 基础命令

### 1.1 `Get-Help` - 获取命令帮助

**功能**：获取 PowerShell 命令的帮助信息。

**语法**：
```powershell
Get-Help [-Name] <String> [[-Path] <String>] [-Category <String[]>] [-Component <String[]>] [-Functionality <String[]>] [-Role <String[]>] [-Full] [-Online] [-ShowWindow]
```

**常用参数**：
- `-Name`：指定要获取帮助的命令名称
- `-Full`：显示完整的帮助信息
- `-Online`：在浏览器中打开在线帮助
- `-ShowWindow`：在单独的窗口中显示帮助信息

**示例**：
```powershell
# 获取 Get-Process 命令的基本帮助
Get-Help Get-Process

# 获取 Get-Process 命令的完整帮助
Get-Help Get-Process -Full

# 在浏览器中打开 Get-Process 命令的在线帮助
Get-Help Get-Process -Online

# 搜索包含 "file" 的命令
Get-Help *file*
```

### 1.2 `Get-Command` - 获取命令列表

**功能**：获取 PowerShell 命令、函数、别名、脚本等。

**语法**：
```powershell
Get-Command [[-Name] <String[]>] [-CommandType <CommandTypes[]>] [-Module <String[]>] [-TotalCount <Int32>] [-Syntax]
```

**常用参数**：
- `-Name`：指定要获取的命令名称
- `-CommandType`：指定命令类型（Alias, Function, Cmdlet, Script, Application）
- `-Module`：指定模块名称
- `-Syntax`：仅显示命令语法

**示例**：
```powershell
# 获取所有命令
Get-Command

# 获取所有 Cmdlet 命令
Get-Command -CommandType Cmdlet

# 获取所有包含 "Get" 的命令
Get-Command *Get*

# 获取 Get-Process 命令的语法
Get-Command Get-Process -Syntax
```

### 1.3 `Get-Member` - 获取对象成员

**功能**：获取 PowerShell 对象的属性和方法。

**语法**：
```powershell
Get-Member [-InputObject] <PSObject> [-Name <String[]>] [-MemberType <MemberTypes[]>] [-Static] [-View <PSMemberViewTypes>]
```

**常用参数**：
- `-InputObject`：指定要检查的对象
- `-Name`：指定要获取的成员名称
- `-MemberType`：指定成员类型（Property, Method, NoteProperty, ScriptProperty, ScriptMethod）
- `-Static`：获取静态成员

**示例**：
```powershell
# 获取 Get-Process 返回对象的成员
Get-Process | Get-Member

# 获取 Get-Service 返回对象的属性
Get-Service | Get-Member -MemberType Property

# 获取字符串对象的方法
"Hello" | Get-Member -MemberType Method
```

### 1.4 `Clear-Host` - 清屏

**功能**：清除 PowerShell 控制台的内容。

**别名**：`cls`

**示例**：
```powershell
Clear-Host
# 或使用别名
cls
```

### 1.5 `Exit` - 退出 PowerShell

**功能**：退出 PowerShell 会话。

**示例**：
```powershell
Exit
```

## 2. 文件和目录操作

### 2.1 `Get-ChildItem` - 列出目录内容

**功能**：获取指定位置的项目（文件、目录等）。

**别名**：`ls`, `dir`, `gci`

**语法**：
```powershell
Get-ChildItem [[-Path] <String[]>] [[-Filter] <String>] [-Include <String[]>] [-Exclude <String[]>] [-Recurse] [-Depth <UInt32>] [-Force] [-Name]
```

**常用参数**：
- `-Path`：指定要列出的路径
- `-Filter`：指定过滤条件
- `-Recurse`：递归列出子目录内容
- `-Depth`：指定递归深度
- `-Force`：显示隐藏项目
- `-Name`：仅显示项目名称

**示例**：
```powershell
# 列出当前目录内容
Get-ChildItem
# 或使用别名
ls

# 列出指定目录内容
Get-ChildItem C:\Windows

# 递归列出当前目录及其子目录内容
Get-ChildItem -Recurse

# 列出当前目录下的所有 .txt 文件
Get-ChildItem -Filter *.txt

# 列出当前目录下的隐藏文件
Get-ChildItem -Force
```

### 2.2 `Set-Location` - 切换目录

**功能**：更改当前工作目录。

**别名**：`cd`, `chdir`, `sl`

**语法**：
```powershell
Set-Location [[-Path] <String>] [-PassThru]
```

**示例**：
```powershell
# 切换到 D 盘
Set-Location D:
# 或使用别名
cd D:

# 切换到指定目录
Set-Location C:\Windows\System32

# 返回上一级目录
Set-Location ..

# 返回根目录
Set-Location \
```

### 2.3 `New-Item` - 创建新项

**功能**：创建新的文件、目录或符号链接。

**别名**：`ni`

**语法**：
```powershell
New-Item [-Path] <String[]> [-ItemType <String>] [-Value <Object>] [-Force] [-Credential <PSCredential>]
```

**常用参数**：
- `-Path`：指定要创建的项的路径
- `-ItemType`：指定要创建的项类型（File, Directory, SymbolicLink, Junction, HardLink）
- `-Value`：指定项的值（仅适用于文件）
- `-Force`：强制创建项

**示例**：
```powershell
# 创建新目录
New-Item -Path .\NewFolder -ItemType Directory

# 创建新文件
New-Item -Path .\NewFile.txt -ItemType File

# 创建包含内容的新文件
New-Item -Path .\NewFile.txt -ItemType File -Value "Hello, PowerShell!"

# 创建符号链接
New-Item -Path .\Link -ItemType SymbolicLink -Value .\Target
```

### 2.4 `Remove-Item` - 删除项

**功能**：删除文件、目录或其他项。

**别名**：`del`, `erase`, `rm`, `ri`

**语法**：
```powershell
Remove-Item [-Path] <String[]> [-Filter <String>] [-Include <String[]>] [-Exclude <String[]>] [-Recurse] [-Force] [-Confirm]
```

**常用参数**：
- `-Path`：指定要删除的项的路径
- `-Recurse`：递归删除子项
- `-Force`：强制删除项（包括隐藏项）
- `-Confirm`：在删除前提示确认

**示例**：
```powershell
# 删除单个文件
Remove-Item .\File.txt

# 删除目录及其所有内容
Remove-Item .\Folder -Recurse

# 删除所有 .tmp 文件
Remove-Item *.tmp

# 强制删除文件
Remove-Item .\ProtectedFile.txt -Force
```

### 2.5 `Copy-Item` - 复制项

**功能**：复制文件、目录或其他项。

**别名**：`copy`, `cp`, `cpi`

**语法**：
```powershell
Copy-Item [-Path] <String[]> [[-Destination] <String>] [-Filter <String>] [-Include <String[]>] [-Exclude <String[]>] [-Recurse] [-Force] [-Credential <PSCredential>]
```

**常用参数**：
- `-Path`：指定要复制的项的路径
- `-Destination`：指定目标位置
- `-Recurse`：递归复制子项
- `-Force`：强制复制项

**示例**：
```powershell
# 复制单个文件
Copy-Item .\File.txt .\Destination\

# 复制目录及其所有内容
Copy-Item .\Source\ .\Destination\ -Recurse

# 复制所有 .txt 文件
Copy-Item *.txt .\Destination\
```

### 2.6 `Move-Item` - 移动项

**功能**：移动或重命名文件、目录或其他项。

**别名**：`move`, `mv`, `mi`

**语法**：
```powershell
Move-Item [-Path] <String[]> [[-Destination] <String>] [-Filter <String>] [-Include <String[]>] [-Exclude <String[]>] [-Force] [-Credential <PSCredential>]
```

**示例**：
```powershell
# 移动文件到指定目录
Move-Item .\File.txt .\Destination\

# 重命名文件
Move-Item .\OldName.txt .\NewName.txt

# 移动目录
Move-Item .\Source\ .\Destination\
```

### 2.7 `Rename-Item` - 重命名项

**功能**：重命名文件、目录或其他项。

**别名**：`ren`, `rni`

**语法**：
```powershell
Rename-Item [-Path] <String> [-NewName] <String> [-Force] [-Confirm]
```

**示例**：
```powershell
# 重命名文件
Rename-Item .\OldName.txt .\NewName.txt

# 重命名目录
Rename-Item .\OldFolder .\NewFolder
```

### 2.8 `Get-Content` - 获取文件内容

**功能**：获取文件的内容。

**别名**：`cat`, `gc`, `type`

**语法**：
```powershell
Get-Content [-Path] <String[]> [-Filter <String>] [-Include <String[]>] [-Exclude <String[]>] [-TotalCount <Int64>] [-Tail <Int64>] [-ReadCount <Int64>] [-Force]
```

**常用参数**：
- `-Path`：指定要读取的文件路径
- `-TotalCount`：指定要读取的行数（从文件开头）
- `-Tail`：指定要读取的行数（从文件末尾）
- `-ReadCount`：指定一次读取的行数
- `-Force`：读取隐藏文件

**示例**：
```powershell
# 读取整个文件
Get-Content .\File.txt

# 读取文件的前 10 行
Get-Content .\File.txt -TotalCount 10

# 读取文件的最后 5 行
Get-Content .\File.txt -Tail 5

# 实时读取文件内容（类似 tail -f）
Get-Content .\Log.txt -Tail 10 -Wait
```

### 2.9 `Set-Content` - 设置文件内容

**功能**：设置文件的内容，会覆盖现有内容。

**别名**：`sc`

**语法**：
```powershell
Set-Content [-Path] <String[]> [-Value] <Object[]> [-Force] [-Credential <PSCredential>]
```

**示例**：
```powershell
# 设置文件内容
Set-Content .\File.txt -Value "Hello, PowerShell!"

# 将命令输出写入文件
Get-Process | Set-Content .\Processes.txt
```

### 2.10 `Add-Content` - 追加文件内容

**功能**：向文件追加内容。

**别名**：`ac`

**语法**：
```powershell
Add-Content [-Path] <String[]> [-Value] <Object[]> [-Force] [-Credential <PSCredential>]
```

**示例**：
```powershell
# 向文件追加内容
Add-Content .\File.txt -Value "Additional content"

# 向多个文件追加内容
Add-Content -Path .\File1.txt, .\File2.txt -Value "Common content"
```

## 3. 系统管理命令

### 3.1 `Get-Process` - 获取进程

**功能**：获取当前运行的进程。

**别名**：`ps`, `gps`

**语法**：
```powershell
Get-Process [[-Name] <String[]>] [-Id <Int32[]>] [-IncludeUserName] [-FileVersionInfo]
```

**示例**：
```powershell
# 获取所有进程
Get-Process

# 获取指定名称的进程
Get-Process -Name notepad

# 获取指定 ID 的进程
Get-Process -Id 1234

# 获取进程的文件版本信息
Get-Process -Name notepad -FileVersionInfo
```

### 3.2 `Stop-Process` - 终止进程

**功能**：终止一个或多个运行中的进程。

**别名**：`kill`, `sps`

**语法**：
```powershell
Stop-Process [-Id] <Int32[]> [-Force] [-Confirm]
Stop-Process -Name <String[]> [-Force] [-Confirm]
```

**示例**：
```powershell
# 根据进程 ID 终止进程
Stop-Process -Id 1234

# 根据进程名称终止进程
Stop-Process -Name notepad

# 强制终止进程
Stop-Process -Name chrome -Force

# 终止多个进程
Stop-Process -Name notepad, calculator
```

### 3.3 `Get-Service` - 获取服务

**功能**：获取 Windows 服务。

**别名**：`gsv`

**语法**：
```powershell
Get-Service [[-Name] <String[]>] [-ComputerName <String[]>] [-Include <String[]>] [-Exclude <String[]>] [-DependentServices] [-RequiredServices] [-Status <String>]
```

**示例**：
```powershell
# 获取所有服务
Get-Service

# 获取指定名称的服务
Get-Service -Name WinRM

# 获取正在运行的服务
Get-Service -Status Running

# 获取服务的依赖服务
Get-Service -Name WinRM -DependentServices
```

### 3.4 `Start-Service` - 启动服务

**别名**：`sasv`

**语法**：
```powershell
Start-Service [-Name] <String[]> [-PassThru] [-Include <String[]>] [-Exclude <String[]>]
```

**示例**：
```powershell
# 启动指定服务
Start-Service -Name WinRM

# 启动多个服务
Start-Service -Name WinRM, W32Time
```

### 3.5 `Stop-Service` - 停止服务

**别名**：`spsv`

**语法**：
```powershell
Stop-Service [-Name] <String[]> [-Force] [-PassThru] [-Include <String[]>] [-Exclude <String[]>]
```

**示例**：
```powershell
# 停止指定服务
Stop-Service -Name WinRM

# 强制停止服务
Stop-Service -Name WinRM -Force
```

### 3.6 `Restart-Service` - 重启服务

**别名**：`rsv`

**语法**：
```powershell
Restart-Service [-Name] <String[]> [-Force] [-PassThru] [-Include <String[]>] [-Exclude <String[]>]
```

**示例**：
```powershell
# 重启指定服务
Restart-Service -Name WinRM

# 强制重启服务
Restart-Service -Name WinRM -Force
```

### 3.7 `Get-EventLog` - 获取事件日志

**功能**：获取 Windows 事件日志。

**语法**：
```powershell
Get-EventLog [-LogName] <String> [[-InstanceId] <Int64>] [-ComputerName <String[]>] [-Newest <Int32>] [-After <DateTime>] [-Before <DateTime>] [-UserName <String[]>] [-Index <Int32[]>] [-EntryType <String[]>]
```

**示例**：
```powershell
# 获取应用程序日志的最新 10 条记录
Get-EventLog -LogName Application -Newest 10

# 获取系统日志中的错误记录
Get-EventLog -LogName System -EntryType Error

# 获取特定日期之后的安全日志记录
Get-EventLog -LogName Security -After (Get-Date).AddDays(-7)
```

### 3.8 `Get-WmiObject` - 获取 WMI 对象

**功能**：获取 Windows Management Instrumentation (WMI) 对象。

**别名**：`gwmi`

**语法**：
```powershell
Get-WmiObject [-Class] <String> [[-Property] <String[]>] [-Filter <String>] [-ComputerName <String[]>] [-Credential <PSCredential>]
```

**示例**：
```powershell
# 获取操作系统信息
Get-WmiObject -Class Win32_OperatingSystem

# 获取磁盘信息
Get-WmiObject -Class Win32_LogicalDisk

# 获取已安装的软件
Get-WmiObject -Class Win32_Product
```

### 3.9 `Get-CimInstance` - 获取 CIM 对象

**功能**：获取 Common Information Model (CIM) 对象，是 `Get-WmiObject` 的替代命令。

**别名**：`gcim`

**语法**：
```powershell
Get-CimInstance [-ClassName] <String> [[-Property] <String[]>] [-Filter <String>] [-ComputerName <String[]>] [-Credential <PSCredential>]
```

**示例**：
```powershell
# 获取操作系统信息
Get-CimInstance -ClassName Win32_OperatingSystem

# 获取磁盘信息
Get-CimInstance -ClassName Win32_LogicalDisk
```

## 4. 网络操作命令

### 4.1 `Test-Connection` - 测试网络连接

**功能**：测试与远程计算机的网络连接（类似 ping 命令）。

**别名**：`ping`, `tc`

**语法**：
```powershell
Test-Connection [-ComputerName] <String[]> [-Count <Int32>] [-Delay <Int32>] [-TTL <Int32>] [-BufferSize <Int32>] [-DontFragment] [-Quiet]
```

**示例**：
```powershell
# 测试与本地计算机的连接
Test-Connection localhost

# 测试与远程计算机的连接，发送 5 个数据包
Test-Connection www.baidu.com -Count 5

# 仅返回布尔值结果
Test-Connection www.baidu.com -Quiet
```

### 4.2 `Get-NetIPAddress` - 获取 IP 地址配置

**功能**：获取计算机的 IP 地址配置。

**语法**：
```powershell
Get-NetIPAddress [-InterfaceAlias <String[]>] [-AddressFamily <AddressFamily[]>] [-PrefixOrigin <PrefixOrigin[]>] [-SuffixOrigin <SuffixOrigin[]>] [-Type <Type[]>]
```

**示例**：
```powershell
# 获取所有 IP 地址配置
Get-NetIPAddress

# 获取 IPv4 地址配置
Get-NetIPAddress -AddressFamily IPv4

# 获取特定网络适配器的 IP 地址配置
Get-NetIPAddress -InterfaceAlias "Ethernet"
```

### 4.3 `Get-NetAdapter` - 获取网络适配器

**功能**：获取计算机的网络适配器。

**语法**：
```powershell
Get-NetAdapter [[-Name] <String[]>] [-InterfaceIndex <UInt32[]>] [-InterfaceDescription <String[]>] [-PhysicalMediaType <PhysicalMediaType[]>] [-Status <String[]>]
```

**示例**：
```powershell
# 获取所有网络适配器
Get-NetAdapter

# 获取启用的网络适配器
Get-NetAdapter -Status Up

# 获取特定名称的网络适配器
Get-NetAdapter -Name Ethernet
```

### 4.4 `Get-NetRoute` - 获取路由表

**功能**：获取计算机的路由表。

**语法**：
```powershell
Get-NetRoute [-DestinationPrefix <String[]>] [-InterfaceAlias <String[]>] [-NextHop <String[]>] [-AddressFamily <AddressFamily[]>]
```

**示例**：
```powershell
# 获取所有路由表项
Get-NetRoute

# 获取 IPv4 路由表项
Get-NetRoute -AddressFamily IPv4

# 获取默认网关
Get-NetRoute -DestinationPrefix "0.0.0.0/0"
```

### 4.5 `Resolve-DnsName` - 解析 DNS 名称

**功能**：解析 DNS 名称为 IP 地址，或反向解析 IP 地址为 DNS 名称。

**语法**：
```powershell
Resolve-DnsName [-Name] <String> [[-Type] <RecordType>] [-Server <String[]>] [-DnsOnly] [-NoHostsFile] [-DnsSecOk] [-DnsSecCd] [-DnsSecValidation] [-LlmnrNetbiosOnly] [-LlmnrFallback] [-LlmnrOnly] [-NetbiosFallback] [-NetbiosOnly]
```

**示例**：
```powershell
# 解析域名到 IP 地址
Resolve-DnsName www.baidu.com

# 反向解析 IP 地址到域名
Resolve-DnsName 8.8.8.8 -Type PTR

# 解析 MX 记录
Resolve-DnsName example.com -Type MX
```

### 4.6 `Invoke-WebRequest` - 发送 HTTP 请求

**功能**：发送 HTTP 或 HTTPS 请求到 Web 服务器。

**别名**：`curl`, `wget`, `iwr`

**语法**：
```powershell
Invoke-WebRequest [-Uri] <Uri> [-Method <WebRequestMethod>] [-Headers <IDictionary>] [-Body <Object>] [-ContentType <String>] [-UserAgent <String>] [-Credential <PSCredential>] [-UseBasicParsing] [-OutFile <String>] [-PassThru]
```

**常用参数**：
- `-Uri`：指定请求的 URL
- `-Method`：指定 HTTP 方法（GET, POST, PUT, DELETE 等）
- `-Headers`：指定请求头
- `-Body`：指定请求体
- `-ContentType`：指定请求的内容类型
- `-OutFile`：将响应保存到文件
- `-UseBasicParsing`：使用基本解析（适用于旧版本 PowerShell）

**示例**：
```powershell
# 发送 GET 请求
Invoke-WebRequest -Uri https://www.example.com

# 下载文件
Invoke-WebRequest -Uri https://www.example.com/file.txt -OutFile .\file.txt

# 发送 POST 请求
Invoke-WebRequest -Uri https://api.example.com/data -Method Post -Body @{Name="Value"} -ContentType "application/json"

# 使用基本解析发送请求
Invoke-WebRequest -Uri https://www.example.com -UseBasicParsing
```

### 4.7 `Invoke-RestMethod` - 调用 REST API

**功能**：发送 HTTP 请求到 REST API 并处理响应。

**别名**：`irm`

**语法**：
```powershell
Invoke-RestMethod [-Uri] <Uri> [-Method <WebRequestMethod>] [-Headers <IDictionary>] [-Body <Object>] [-ContentType <String>] [-UserAgent <String>] [-Credential <PSCredential>] [-UseBasicParsing] [-OutFile <String>]
```

**示例**：
```powershell
# 调用 REST API
Invoke-RestMethod -Uri https://api.github.com/users/octocat

# 发送 POST 请求到 REST API
Invoke-RestMethod -Uri https://api.example.com/data -Method Post -Body @{Name="Value"} -ContentType "application/json"

# 下载 JSON 文件并转换为对象
$json = Invoke-RestMethod -Uri https://api.example.com/data.json
```

## 5. 注册表操作命令

### 5.1 `Get-Item` - 获取注册表项

**功能**：获取注册表项或注册表项属性。

**别名**：`gi`

**语法**：
```powershell
Get-Item [-Path] <String[]> [-Force]
```

**示例**：
```powershell
# 获取注册表项
Get-Item -Path HKLM:\Software\Microsoft\Windows

# 获取注册表项的属性
Get-Item -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion
```

### 5.2 `Get-ItemProperty` - 获取注册表项属性

**功能**：获取注册表项的属性和值。

**别名**：`gp`

**语法**：
```powershell
Get-ItemProperty [-Path] <String[]> [-Name <String[]>] [-Force]
```

**示例**：
```powershell
# 获取注册表项的所有属性
Get-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion

# 获取特定注册表项属性
Get-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion -Name ProgramFilesDir
```

### 5.3 `Set-ItemProperty` - 设置注册表项属性

**功能**：创建或修改注册表项的属性和值。

**别名**：`sp`

**语法**：
```powershell
Set-ItemProperty [-Path] <String[]> [-Name] <String> [-Value] <Object> [-Type <RegistryValueKind>] [-Force]
```

**常用参数**：
- `-Type`：指定注册表值类型（String, ExpandString, Binary, DWord, QWord, MultiString, Unknown）

**示例**：
```powershell
# 设置注册表项属性
Set-ItemProperty -Path HKCU:\Software\MyApp -Name Setting -Value "Value" -Type String

# 修改现有注册表项属性
Set-ItemProperty -Path HKCU:\Software\MyApp -Name Setting -Value "NewValue"
```

### 5.4 `New-ItemProperty` - 创建注册表项属性

**功能**：创建新的注册表项属性。

**别名**：`np`

**语法**：
```powershell
New-ItemProperty [-Path] <String[]> [-Name] <String> [-Value] <Object> [-Type <RegistryValueKind>] [-Force]
```

**示例**：
```powershell
# 创建新的注册表项属性
New-ItemProperty -Path HKCU:\Software\MyApp -Name NewSetting -Value "NewValue" -Type String
```

### 5.5 `Remove-ItemProperty` - 删除注册表项属性

**功能**：删除注册表项的属性。

**别名**：`rp`

**语法**：
```powershell
Remove-ItemProperty [-Path] <String[]> [-Name] <String[]> [-Force] [-Confirm]
```

**示例**：
```powershell
# 删除注册表项属性
Remove-ItemProperty -Path HKCU:\Software\MyApp -Name Setting
```

### 5.6 `New-Item` - 创建注册表项

**功能**：创建新的注册表项。

**示例**：
```powershell
# 创建新的注册表项
New-Item -Path HKCU:\Software\NewApp -Force
```

## 6. 环境变量管理

### 6.1 `Get-ChildItem` - 获取环境变量

**功能**：获取环境变量。

**示例**：
```powershell
# 获取所有环境变量
Get-ChildItem Env:

# 获取特定环境变量
Get-ChildItem Env:PATH
```

### 6.2 `Set-Item` - 设置环境变量

**功能**：设置环境变量。

**示例**：
```powershell
# 设置临时环境变量
Set-Item -Path Env:MY_VARIABLE -Value "MyValue"

# 修改现有环境变量
Set-Item -Path Env:PATH -Value "$($env:PATH);C:\NewPath"
```

### 6.3 `Remove-Item` - 删除环境变量

**功能**：删除环境变量。

**示例**：
```powershell
# 删除环境变量
Remove-Item -Path Env:MY_VARIABLE
```

### 6.4 `[Environment]::SetEnvironmentVariable` - 设置永久性环境变量

**功能**：设置永久性的用户或系统环境变量。

**语法**：
```powershell
[Environment]::SetEnvironmentVariable(String variableName, String variableValue, EnvironmentVariableTarget target)
```

**参数**：
- `variableName`：环境变量名称
- `variableValue`：环境变量值
- `target`：环境变量目标（Process, User, Machine）

**示例**：
```powershell
# 设置永久性用户环境变量
[Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Java\jdk1.8.0_201", [EnvironmentVariableTarget]::User)

# 设置永久性系统环境变量（需要管理员权限）
[Environment]::SetEnvironmentVariable("PATH", "$env:PATH;C:\NewPath", [EnvironmentVariableTarget]::Machine)
```

## 7. 字符串和文本处理

### 7.1 `Split` - 分割字符串

**功能**：将字符串分割为子字符串数组。

**语法**：
```powershell
[String]::Split(String s, Char[] separator, StringSplitOptions options)
```

**示例**：
```powershell
# 分割字符串
"a,b,c" -Split ","

# 使用多个分隔符分割字符串
"a,b;c" -Split ",|;"

# 分割并移除空元素
"a,,b,c" -Split "," -ne ""
```

### 7.2 `Join` - 连接字符串

**功能**：将字符串数组合并为单个字符串。

**语法**：
```powershell
[String]::Join(String separator, String[] value)
```

**示例**：
```powershell
# 连接字符串数组
$array = "a", "b", "c"
$array -Join ","

# 连接字符串数组
[String]::Join(",", $array)
```

### 7.3 `Replace` - 替换字符串

**功能**：替换字符串中的指定子字符串。

**语法**：
```powershell
[String]::Replace(String oldValue, String newValue)
```

**示例**：
```powershell
# 替换字符串
"Hello World" -Replace "World", "PowerShell"

# 使用正则表达式替换
"Hello 123" -Replace "\d+", "456"
```

### 7.4 `Select-String` - 查找字符串

**功能**：在字符串或文件中查找匹配的文本。

**别名**：`sls`

**语法**：
```powershell
Select-String [-Pattern] <String[]> [-Path] <String[]> [-SimpleMatch] [-CaseSensitive] [-Quiet] [-List] [-NoEmphasis] [-AllMatches] [-Context <Int32[]>]
```

**示例**：
```powershell
# 在文件中查找字符串
Select-String -Path .\File.txt -Pattern "error"

# 在多个文件中查找字符串
Select-String -Path *.txt -Pattern "error"

# 使用正则表达式查找
Select-String -Path .\File.txt -Pattern "\d{3}-\d{2}-\d{4}"

# 仅返回匹配的行
Select-String -Path .\File.txt -Pattern "error" -List
```

### 7.5 `Format-Table` - 格式化表格输出

**功能**：将输出格式化为表格。

**别名**：`ft`

**语法**：
```powershell
Format-Table [[-Property] <Object[]>] [-AutoSize] [-Wrap] [-GroupBy <Object>] [-ShowError] [-DisplayError] [-Force] [-Expand <String>]
```

**示例**：
```powershell
# 将进程列表格式化为表格
Get-Process | Format-Table -AutoSize

# 选择特定属性并格式化
Get-Process | Format-Table -Property Name, Id, CPU, Memory -AutoSize

# 分组显示
Get-Process | Format-Table -Property Name, Id -GroupBy Company
```

### 7.6 `Format-List` - 格式化列表输出

**功能**：将输出格式化为列表。

**别名**：`fl`

**语法**：
```powershell
Format-List [[-Property] <Object[]>] [-GroupBy <Object>] [-ShowError] [-DisplayError] [-Force] [-Expand <String>]
```

**示例**：
```powershell
# 将进程信息格式化为列表
Get-Process -Name notepad | Format-List

# 选择特定属性并格式化
Get-Process -Name notepad | Format-List -Property Name, Id, Path, Description
```

## 8. 其他常用命令

### 8.1 `Measure-Object` - 测量对象

**功能**：计算对象的数值属性，或计算字符串的字符数、单词数和行数。

**别名**：`measure`, `mo`

**语法**：
```powershell
Measure-Object [[-Property] <String[]>] [-InputObject <PSObject>] [-StandardDeviation] [-Sum] [-Average] [-Minimum] [-Maximum] [-AllStats] [-Line] [-Word] [-Character] [-IgnoreWhiteSpace]
```

**示例**：
```powershell
# 统计文件的行数、单词数和字符数
Get-Content .\File.txt | Measure-Object -Line -Word -Character

# 计算数字数组的总和、平均值、最小值和最大值
1, 2, 3, 4, 5 | Measure-Object -Sum -Average -Minimum -Maximum

# 统计进程的 CPU 使用率
Get-Process | Measure-Object -Property CPU -Sum -Average -Minimum -Maximum
```

### 8.2 `Sort-Object` - 排序对象

**功能**：对对象进行排序。

**别名**：`sort`, `so`

**语法**：
```powershell
Sort-Object [[-Property] <Object[]>] [-Descending] [-Unique] [-CaseSensitive] [-Culture <String>] [-IgnoreCase] [-InputObject <PSObject>]
```

**示例**：
```powershell
# 按名称排序进程
Get-Process | Sort-Object -Property Name

# 按 CPU 使用率降序排序
Get-Process | Sort-Object -Property CPU -Descending

# 按名称排序并去重
Get-Process | Sort-Object -Property Name -Unique
```

### 8.3 `Group-Object` - 分组对象

**功能**：根据指定的属性对对象进行分组。

**别名**：`group`, `go`

**语法**：
```powershell
Group-Object [[-Property] <Object[]>] [-NoElement] [-AsHashTable] [-AsString] [-InputObject <PSObject>]
```

**示例**：
```powershell
# 按公司分组进程
Get-Process | Group-Object -Property Company

# 按扩展名分组文件
Get-ChildItem | Group-Object -Property Extension

# 分组并只显示计数
Get-ChildItem | Group-Object -Property Extension -NoElement
```

### 8.4 `Where-Object` - 过滤对象

**功能**：根据指定的条件过滤对象。

**别名**：`where`, `?`

**语法**：
```powershell
Where-Object [-FilterScript] <ScriptBlock> [-InputObject <PSObject>]
```

**示例**：
```powershell
# 过滤 CPU 使用率大于 50 的进程
Get-Process | Where-Object { $_.CPU -gt 50 }

# 过滤名称包含 "note" 的进程
Get-Process | Where-Object { $_.Name -like "*note*" }

# 过滤正在运行的服务
Get-Service | Where-Object { $_.Status -eq "Running" }
```

### 8.5 `Select-Object` - 选择对象属性

**功能**：选择对象的特定属性或创建计算属性。

**别名**：`select`, `select-object`

**语法**：
```powershell
Select-Object [[-Property] <Object[]>] [-ExcludeProperty <String[]>] [-ExpandProperty <String>] [-First <Int32>] [-Last <Int32>] [-Skip <Int32>] [-Unique] [-InputObject <PSObject>]
```

**示例**：
```powershell
# 选择对象的特定属性
Get-Process | Select-Object -Property Name, Id, CPU

# 选择前 10 个对象
Get-Process | Select-Object -First 10

# 创建计算属性
Get-Process | Select-Object -Property Name, @{Name="MemoryMB"; Expression={$_.Memory / 1MB}}

# 展开嵌套属性
Get-Service | Select-Object -ExpandProperty DependentServices
```

### 8.6 `ForEach-Object` - 遍历对象

**功能**：对集合中的每个对象执行操作。

**别名**：`foreach`, `%`

**语法**：
```powershell
ForEach-Object [-Process] <ScriptBlock> [-Begin <ScriptBlock>] [-End <ScriptBlock>] [-InputObject <PSObject>]
```

**示例**：
```powershell
# 遍历并处理每个文件
Get-ChildItem *.txt | ForEach-Object { Write-Host "处理文件: $($_.Name)" }

# 计算每个数字的平方
1, 2, 3, 4, 5 | ForEach-Object { $_ * $_ }

# 带有开始和结束脚本块
Get-ChildItem *.txt | ForEach-Object -Begin { Write-Host "开始处理文件" } -Process { Write-Host "处理文件: $($_.Name)" } -End { Write-Host "处理完成" }
```

## 9. 其他实用命令

### 9.1 `Get-Random` - 生成随机数

**功能**：生成随机数或随机选择对象。

**示例**：
```powershell
# 生成随机整数
Get-Random

# 生成指定范围内的随机整数
Get-Random -Minimum 1 -Maximum 100

# 从数组中随机选择元素
$array = "a", "b", "c", "d", "e"
Get-Random -InputObject $array
```

### 9.2 `Start-Sleep` - 暂停执行

**功能**：暂停脚本执行指定的时间。

**别名**：`sleep`

**语法**：
```powershell
Start-Sleep [-Seconds] <Int32> [-Milliseconds <Int32>]
```

**示例**：
```powershell
# 暂停 5 秒
Start-Sleep -Seconds 5

# 暂停 500 毫秒
Start-Sleep -Milliseconds 500
```

### 9.3 `Get-Date` - 获取日期和时间

**功能**：获取当前日期和时间，或创建日期时间对象。

**别名**：`date`

**语法**：
```powershell
Get-Date [[-Date] <DateTime>] [-Year <Int32>] [-Month <Int32>] [-Day <Int32>] [-Hour <Int32>] [-Minute <Int32>] [-Second <Int32>] [-Millisecond <Int32>] [-DisplayHint <DisplayHint>] [-Format <String>]
```

**示例**：
```powershell
# 获取当前日期和时间
Get-Date

# 格式化日期时间
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# 创建特定日期时间对象
Get-Date -Year 2023 -Month 1 -Day 1 -Hour 12 -Minute 0 -Second 0

# 获取日期时间的特定部分
(Get-Date).Year
(Get-Date).Month
(Get-Date).Day
```

### 9.4 `ConvertTo-Json` - 转换为 JSON

**功能**：将对象转换为 JSON 格式。

**别名**：`convertto-json`, `cjt`

**语法**：
```powershell
ConvertTo-Json [-InputObject] <Object> [-Depth <Int32>] [-Compress] [-EnumsAsStrings] [-AsArray]
```

**示例**：
```powershell
# 将对象转换为 JSON
Get-Process -Name notepad | ConvertTo-Json

# 转换为 JSON 并保存到文件
Get-Process | ConvertTo-Json | Set-Content .\Processes.json

# 压缩 JSON 输出
Get-Process | ConvertTo-Json -Compress
```

### 9.5 `ConvertFrom-Json` - 从 JSON 转换

**功能**：将 JSON 格式的字符串转换为 PowerShell 对象。

**别名**：`convertfrom-json`, `cjf`

**语法**：
```powershell
ConvertFrom-Json [-InputObject] <String>
```

**示例**：
```powershell
# 从 JSON 字符串转换为对象
$json = '{"Name":"John","Age":30}'
$obj = $json | ConvertFrom-Json

# 从 JSON 文件转换为对象
$obj = Get-Content .\Data.json | ConvertFrom-Json
```

## 总结

PowerShell 提供了丰富的命令集，可以用于系统管理、文件操作、网络管理、脚本编写等多种场景。本文介绍了 PowerShell 中最常用的命令，包括：

1. **基础命令**：`Get-Help`, `Get-Command`, `Get-Member` 等
2. **文件和目录操作**：`Get-ChildItem`, `Set-Location`, `New-Item`, `Copy-Item` 等
3. **系统管理**：`Get-Process`, `Stop-Process`, `Get-Service`, `Start-Service` 等
4. **网络操作**：`Test-Connection`, `Invoke-WebRequest`, `Resolve-DnsName` 等
5. **注册表操作**：`Get-ItemProperty`, `Set-ItemProperty` 等
6. **环境变量管理**：`Get-ChildItem Env:`, `Set-Item Env:` 等
7. **字符串和文本处理**：`Select-String`, `Format-Table`, `Sort-Object` 等
8. **其他实用命令**：`Get-Random`, `Start-Sleep`, `Get-Date` 等

通过掌握这些常用命令，可以提高在 PowerShell 环境中的工作效率，更好地管理 Windows 系统和编写自动化脚本。