# PowerShell 高级功能

## 1. WMI/CIM 管理

### 1.1 WMI 概述
Windows Management Instrumentation (WMI) 是 Windows 系统的管理框架，PowerShell 提供了丰富的 WMI/CIM 访问接口。

### 1.2 使用 CIM 命令
PowerShell 3.0 引入了 CIM 命令，推荐使用 CIM 而非传统的 WMI 命令：

```powershell
# 获取操作系统信息
Get-CimInstance -ClassName Win32_OperatingSystem

# 获取处理器信息
Get-CimInstance -ClassName Win32_Processor

# 获取磁盘信息
Get-CimInstance -ClassName Win32_LogicalDisk | Where-Object {$_.DriveType -eq 3}

# 获取服务信息
Get-CimInstance -ClassName Win32_Service | Where-Object {$_.State -eq "Running"}
```

### 1.3 WMI 查询语言 (WQL)
```powershell
# 使用 WQL 查询正在运行的服务
Get-CimInstance -Query "SELECT * FROM Win32_Service WHERE State = 'Running'"

# 查询特定进程
Get-CimInstance -Query "SELECT * FROM Win32_Process WHERE Name = 'explorer.exe'"
```

### 1.4 WMI 方法调用
```powershell
# 重启计算机（需要管理员权限）
$os = Get-CimInstance -ClassName Win32_OperatingSystem
Invoke-CimMethod -InputObject $os -MethodName Reboot

# 关闭计算机
Invoke-CimMethod -InputObject $os -MethodName Shutdown
```

## 2. 远程管理

### 2.1 PowerShell 远程管理概述
PowerShell 远程管理基于 WS-Management 协议，允许从一台计算机管理多台远程计算机。

### 2.2 启用远程管理
```powershell
# 在本地计算机启用远程管理（需要管理员权限）
Enable-PSRemoting -Force

# 配置防火墙
Set-NetFirewallRule -Name "WINRM-HTTP-In-TCP" -Enabled True

# 测试远程连接
Test-WSMan 远程计算机名
```

### 2.3 远程会话
```powershell
# 创建远程会话
$session = New-PSSession -ComputerName 远程计算机名

# 进入远程会话
Enter-PSSession -Session $session

# 退出远程会话
Exit-PSSession

# 在远程会话执行命令
Invoke-Command -Session $session -ScriptBlock { Get-Process }

# 在多个远程计算机执行命令
Invoke-Command -ComputerName 计算机1, 计算机2 -ScriptBlock { Get-OSInfo }

# 关闭远程会话
Remove-PSSession -Session $session
```

### 2.4 远程复制文件
```powershell
# 从本地复制文件到远程计算机
Copy-Item -Path C:\本地文件.txt -Destination \\远程计算机名\C$\目标路径 -ToSession $session

# 从远程计算机复制文件到本地
Copy-Item -Path C:\远程文件.txt -Destination C:\本地路径 -FromSession $session
```

## 3. PowerShell 工作流

### 3.1 工作流概述
PowerShell 工作流是一种声明式脚本，可以处理长时间运行的任务，支持暂停、恢复和重试。

### 3.2 创建和运行工作流
```powershell
# 定义工作流
workflow Backup-Data {
    param(
        [string]$SourcePath,
        [string]$DestinationPath
    )
    
    # 检查源目录
    if (-not (Test-Path -Path $SourcePath)) {
        throw "源目录不存在：$SourcePath"
    }
    
    # 创建目标目录
    $timestamp = Get-Date -Format "yyyyMMddHHmmss"
    $backupDir = Join-Path -Path $DestinationPath -ChildPath "Backup_$timestamp"
    New-Item -Path $backupDir -ItemType Directory | Out-Null
    
    # 复制文件（工作流自动并行处理）
    Copy-Item -Path "$SourcePath\*" -Destination $backupDir -Recurse
    
    # 返回备份路径
    return $backupDir
}

# 运行工作流
$backupResult = Backup-Data -SourcePath "C:\Data" -DestinationPath "D:\Backup"
Write-Host "备份完成，路径：$backupResult"
```

### 3.3 工作流特性
- **并行执行**：使用 `Parallel` 块实现并行处理
- **检查点**：使用 `Checkpoint-Workflow` 保存工作流状态
- **恢复**：工作流中断后可从检查点恢复
- **持久化**：工作流可以持久化到磁盘

```powershell
workflow Test-Parallel {
    Parallel {
        # 并行执行的任务
        for ($i = 1; $i -le 5; $i++) {
            Write-Output "并行任务 $i：$(Get-Date)"
            Start-Sleep -Seconds 1
        }
    }
    
    # 串行执行的任务
    Write-Output "串行任务：$(Get-Date)"
}
```

## 4. 期望状态配置 (DSC)

### 4.1 DSC 概述
Desired State Configuration (DSC) 是 PowerShell 的配置管理框架，用于确保系统处于期望状态。

### 4.2 DSC 配置
```powershell
# 定义 DSC 配置
configuration WebServerConfig {
    param(
        [string[]]$ComputerName = "localhost"
    )
    
    # 导入模块
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName xWebAdministration
    
    Node $ComputerName {
        # 安装 IIS
        WindowsFeature IIS {
            Ensure = "Present"
            Name = "Web-Server"
        }
        
        # 创建网站目录
        File WebsiteDir {
            Ensure = "Present"
            Type = "Directory"
            DestinationPath = "C:\inetpub\wwwroot\MyWebsite"
            DependsOn = "[WindowsFeature]IIS"
        }
        
        # 创建默认网页
        File DefaultPage {
            Ensure = "Present"
            Type = "File"
            DestinationPath = "C:\inetpub\wwwroot\MyWebsite\index.html"
            Contents = "<html><body><h1>Hello, DSC!</h1></body></html>"
            DependsOn = "[File]WebsiteDir"
        }
        
        # 配置网站
        xWebsite MyWebsite {
            Ensure = "Present"
            Name = "MyWebsite"
            PhysicalPath = "C:\inetpub\wwwroot\MyWebsite"
            State = "Started"
            DependsOn = "[File]DefaultPage"
        }
    }
}

# 生成 MOF 文件
WebServerConfig -ComputerName "WebServer1"

# 应用配置
Start-DscConfiguration -Path .\WebServerConfig -Wait -Verbose -Force

# 测试配置
Test-DscConfiguration -Path .\WebServerConfig
```

### 4.3 DSC 资源
DSC 资源是 DSC 配置的基本构建块，常见的 DSC 资源包括：
- `WindowsFeature`：管理 Windows 功能
- `File`：管理文件和目录
- `Service`：管理 Windows 服务
- `Registry`：管理注册表
- `User`：管理用户账户

## 5. 并行处理

### 5.1 并行处理方法
PowerShell 提供了多种并行处理方式：

#### 5.1.1 ForEach-Object -Parallel（PowerShell 7+）
```powershell
# 使用 ForEach-Object -Parallel 并行处理
1..10 | ForEach-Object -Parallel {
    $number = $_
    Start-Sleep -Seconds 1
    Write-Output "数字：$number，线程 ID：$PID"
} -ThrottleLimit 5  # 限制并发数为 5
```

#### 5.1.2 Start-Job（后台作业）
```powershell
# 创建后台作业
$jobs = @()
for ($i = 1; $i -le 5; $i++) {
    $job = Start-Job -ScriptBlock {
        $number = $using:i
        Start-Sleep -Seconds 2
        return "结果：$number"
    }
    $jobs += $job
}

# 等待所有作业完成
Wait-Job -Job $jobs

# 获取作业结果
$results = Receive-Job -Job $jobs

# 清理作业
Remove-Job -Job $jobs
```

#### 5.1.3 ThreadJob 模块（轻量级线程）
```powershell
# 安装 ThreadJob 模块
Install-Module -Name ThreadJob -Scope CurrentUser

# 使用 ThreadJob 并行处理
$jobs = 1..10 | ForEach-Object {
    Start-ThreadJob -ScriptBlock {
        $number = $_
        Start-Sleep -Seconds 1
        return "线程结果：$number"
    }
}

# 获取结果
$results = $jobs | Receive-Job -Wait
```

## 6. 正则表达式

### 6.1 正则表达式基础
PowerShell 支持完整的正则表达式语法，用于字符串匹配、替换和提取。

### 6.2 正则表达式操作

#### 6.2.1 匹配操作
```powershell
# 使用 -match 运算符
$text = "我的邮箱是 user@example.com"
if ($text -match '\b[\w.-]+@[\w.-]+\.\w+\b') {
    Write-Host "匹配到邮箱：$Matches[0]"
}

# 使用 Select-String 查找匹配项
Get-Content -Path .\日志文件.txt | Select-String -Pattern 'Error|Warning'

# 使用 [regex] 类
$regex = [regex]'\d{3}-\d{4}-\d{4}'
$match = $regex.Match("电话号码：138-1234-5678")
if ($match.Success) {
    Write-Host "匹配到电话号码：$($match.Value)"
}
```

#### 6.2.2 替换操作
```powershell
# 使用 -replace 运算符替换文本
$text = "Hello World"
$newText = $text -replace 'World', 'PowerShell'
Write-Host $newText  # 输出：Hello PowerShell

# 使用正则表达式替换
$phone = "13812345678"
$formattedPhone = $phone -replace '(\d{3})(\d{4})(\d{4})', '$1-$2-$3'
Write-Host $formattedPhone  # 输出：138-1234-5678

# 使用脚本块替换
$text = "今天是 2023-01-01"
$newText = $text -replace '\d{4}-\d{2}-\d{2}', {
    $date = [DateTime]::Parse($_.Value)
    return $date.ToString("yyyy年MM月dd日")
}
Write-Host $newText  # 输出：今天是 2023年01月01日
```

#### 6.2.3 提取操作
```powershell
# 提取所有匹配项
$text = "邮箱1：user1@example.com，邮箱2：user2@test.com"
$matches = [regex]'\b[\w.-]+@[\w.-]+\.\w+\b'.Matches($text)
foreach ($match in $matches) {
    Write-Host "提取到邮箱：$($match.Value)"
}

# 使用命名捕获组
$text = "张三，30岁，男"
$pattern = '(?<姓名>[\w]+)，(?<年龄>\d+)岁，(?<性别>[\w]+)'
if ($text -match $pattern) {
    Write-Host "姓名：$($Matches.姓名)"
    Write-Host "年龄：$($Matches.年龄)"
    Write-Host "性别：$($Matches.性别)"
}
```

## 7. COM 对象

### 7.1 COM 对象概述
PowerShell 可以访问 Windows 系统中的 COM 对象，用于自动化 Office、IE 等应用程序。

### 7.2 使用 COM 对象

#### 7.2.1 自动化 Excel
```powershell
# 创建 Excel COM 对象
$excel = New-Object -ComObject Excel.Application
$excel.Visible = $true

# 创建工作簿
$workbook = $excel.Workbooks.Add()
$worksheet = $workbook.Worksheets.Item(1)

# 写入数据
$worksheet.Cells.Item(1, 1) = "姓名"
$worksheet.Cells.Item(1, 2) = "年龄"
$worksheet.Cells.Item(2, 1) = "张三"
$worksheet.Cells.Item(2, 2) = 25
$worksheet.Cells.Item(3, 1) = "李四"
$worksheet.Cells.Item(3, 2) = 30

# 保存工作簿
$workbook.SaveAs("C:\Data\测试.xlsx")

# 关闭 Excel
$workbook.Close()
$excel.Quit()

# 释放 COM 对象
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($worksheet) | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($workbook) | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel) | Out-Null
[System.GC]::Collect()
[System.GC]::WaitForPendingFinalizers()
```

#### 7.2.2 自动化 Internet Explorer
```powershell
# 创建 IE COM 对象
$ie = New-Object -ComObject InternetExplorer.Application
$ie.Visible = $true

# 导航到网页
$ie.Navigate("https://www.example.com")

# 等待页面加载完成
while ($ie.Busy -or $ie.ReadyState -ne 4) {
    Start-Sleep -Milliseconds 100
}

# 获取页面标题
Write-Host "页面标题：$($ie.Document.Title)"

# 关闭 IE
$ie.Quit()

# 释放 COM 对象
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($ie) | Out-Null
```

## 8. .NET 集成

### 8.1 .NET 类使用
PowerShell 可以直接调用 .NET Framework 和 .NET Core 类：

```powershell
# 使用 .NET 字符串类
$string = "Hello PowerShell"
$string.ToUpper()  # 输出：HELLO POWERSHELL
$string.Substring(6)  # 输出：PowerShell

# 使用 .NET 日期时间类
$date = [DateTime]::Now
$date.ToString("yyyy-MM-dd HH:mm:ss")  # 格式化日期

# 使用 .NET 文件操作类
[System.IO.File]::ReadAllText("C:\Data\test.txt")
[System.IO.File]::WriteAllText("C:\Data\test.txt", "Hello .NET")
[System.IO.Directory]::GetFiles("C:\Data")

# 使用 .NET 加密类
$bytes = [System.Text.Encoding]::UTF8.GetBytes("Hello")
$base64 = [System.Convert]::ToBase64String($bytes)
Write-Host "Base64 编码：$base64"

# 使用 .NET 网络类
$client = [System.Net.WebClient]::new()
$content = $client.DownloadString("https://www.example.com")
```

### 8.2 自定义 .NET 类型
```powershell
# 定义 C# 代码
$csharpCode = @'
using System;

public class Person {
    public string Name { get; set; }
    public int Age { get; set; }
    
    public string GetInfo() {
        return $"姓名：{Name}，年龄：{Age}岁";
    }
}
'@

# 编译 C# 代码
Add-Type -TypeDefinition $csharpCode

# 使用自定义类型
$person = New-Object -TypeName Person
$person.Name = "张三"
$person.Age = 25
Write-Host $person.GetInfo()  # 输出：姓名：张三，年龄：25岁
```

## 9. 事件处理

### 9.1 PowerShell 事件模型
PowerShell 支持事件驱动编程，可以订阅和处理系统事件、应用程序事件和自定义事件。

### 9.2 事件订阅

#### 9.2.1 订阅系统事件
```powershell
# 订阅进程创建事件
Register-CimIndicationEvent -Query "SELECT * FROM Win32_ProcessStartTrace" -SourceIdentifier "ProcessStarted" -Action {
    $processName = $Event.SourceEventArgs.NewEvent.ProcessName
    $processId = $Event.SourceEventArgs.NewEvent.ProcessId
    Write-Host "进程创建：$processName (PID: $processId)"
}

# 等待事件（按 Ctrl+C 停止）
Wait-Event -SourceIdentifier "ProcessStarted"

# 取消事件订阅
Unregister-Event -SourceIdentifier "ProcessStarted"
```

#### 9.2.2 自定义事件
```powershell
# 创建自定义事件源
$eventSource = New-Object -TypeName System.Management.Automation.PSEventArgs -ArgumentList @("CustomEvent", "CustomData")

# 订阅自定义事件
Register-EngineEvent -SourceIdentifier "CustomEvent" -Action {
    $data = $Event.SourceEventArgs.NewEvent
    Write-Host "收到自定义事件：$data"
}

# 触发自定义事件
New-Event -SourceIdentifier "CustomEvent" -MessageData "Hello from custom event"

# 取消订阅
Unregister-Event -SourceIdentifier "CustomEvent"
```

## 10. 性能监控和分析

### 10.1 性能计数器
```powershell
# 获取性能计数器类别
Get-Counter -ListSet * | Sort-Object CounterSetName

# 获取特定类别下的计数器
Get-Counter -ListSet Processor | Select-Object -ExpandProperty Paths

# 收集性能数据
$counters = @(
    "\Processor(_Total)\% Processor Time",
    "\Memory\Available MBytes",
    "\LogicalDisk(_Total)\% Free Space"
)

# 实时监控性能
Get-Counter -Counter $counters -SampleInterval 2 -MaxSamples 5

# 导出性能数据到文件
Get-Counter -Counter $counters -SampleInterval 1 -MaxSamples 10 | Export-Counter -Path "C:\PerfData.blg"
```

### 10.2 脚本性能分析
```powershell
# 使用 Measure-Command 分析脚本执行时间
Measure-Command {
    # 要分析的脚本代码
    for ($i = 1; $i -le 1000; $i++) {
        $result = $i * $i
    }
}

# 使用 PowerShell 7+ 的诊断命令
# 安装诊断模块
Install-Module -Name Microsoft.PowerShell.Diagnostics -Scope CurrentUser

# 生成脚本执行报告
Trace-Command -Name ParameterBinding -Expression {
    Get-Process | Sort-Object CPU -Descending | Select-Object -First 5
} -PSHost
```

## 11. 安全性最佳实践

### 11.1 脚本签名
PowerShell 支持脚本数字签名，提高脚本的安全性：

```powershell
# 查看当前签名策略
Get-ExecutionPolicy

# 生成自签名证书
$cert = New-SelfSignedCertificate -Subject "PowerShell Script Signing" -Type CodeSigningCert -CertStoreLocation "Cert:\CurrentUser\My"

# 查看证书
Get-ChildItem -Path "Cert:\CurrentUser\My" -CodeSigningCert

# 签名脚本
Set-AuthenticodeSignature -FilePath .\脚本名.ps1 -Certificate $cert

# 验证脚本签名
Get-AuthenticodeSignature -FilePath .\脚本名.ps1
```

### 11.2 最小权限原则
- 避免以管理员身份运行不必要的脚本
- 使用 `Start-Process -Verb RunAs` 按需提升权限
- 限制脚本的执行权限和访问权限

### 11.3 安全编码实践
- 验证用户输入，避免注入攻击
- 使用参数验证和类型检查
- 加密敏感数据，避免明文存储
- 清理临时文件和资源
- 记录脚本执行日志

## 12. 资源推荐

- [PowerShell 高级功能文档](https://docs.microsoft.com/zh-cn/powershell/scripting/learn/advanced-powershell?view=powershell-7.2)
- [PowerShell 工作流指南](https://docs.microsoft.com/zh-cn/powershell/scripting/developer/workflow/windows-powershell-workflow?view=powershell-7.2)
- [DSC 官方文档](https://docs.microsoft.com/zh-cn/powershell/scripting/dsc/overview/overview?view=powershell-7.2)
- [PowerShell 并行处理](https://docs.microsoft.com/zh-cn/powershell/scripting/learn/ps101/13-parallel-processing?view=powershell-7.2)
- [PowerShell 正则表达式](https://docs.microsoft.com/zh-cn/powershell/module/microsoft.powershell.core/about/about_regular_expressions?view=powershell-7.2)