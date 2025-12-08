# PowerShell 基础概念

## 1. PowerShell 是什么

PowerShell 是微软开发的一种任务自动化和配置管理框架，它结合了命令行界面和脚本语言的功能。PowerShell 基于 .NET Framework（Windows PowerShell）或 .NET Core（PowerShell Core），可以在 Windows、macOS 和 Linux 上运行。

## 2. PowerShell 的特点

### 2.1 跨平台

- **Windows PowerShell**：基于 .NET Framework，仅支持 Windows 系统
- **PowerShell Core**：基于 .NET Core，支持 Windows、macOS 和 Linux 系统

### 2.2 对象导向

PowerShell 操作的是对象，而不是文本。这意味着命令输出的是结构化对象，可以直接访问对象的属性和方法。

### 2.3 强大的管道

PowerShell 的管道允许将一个命令的输出传递给另一个命令，并且管道传递的是对象，而不是文本。这使得命令组合更加灵活和强大。

### 2.4 丰富的命令集

PowerShell 包含了丰富的内置命令（称为 cmdlet），用于管理系统、网络、文件系统等。

### 2.5 脚本支持

PowerShell 支持脚本编写，可以将一系列命令组合成脚本文件（.ps1），实现复杂的自动化任务。

### 2.6 与 .NET 集成

PowerShell 可以直接调用 .NET 类和方法，扩展了其功能和灵活性。

## 3. PowerShell 的核心概念

### 3.1 Cmdlet

Cmdlet（Command Let）是 PowerShell 中的基本命令单元，通常遵循 "动词-名词" 的命名规范，如 `Get-Process`、`Set-Service` 等。

### 3.2 管道（Pipeline）

管道允许将一个命令的输出作为另一个命令的输入，使用 `|` 符号表示。

**示例：**
```powershell
Get-Process | Where-Object {$_.CPU -gt 100}
```

### 3.3 对象（Object）

PowerShell 中的命令输出的是 .NET 对象，每个对象都有属性和方法。

### 3.4 模块（Module）

模块是 PowerShell 命令和功能的集合，可以通过 `Import-Module` 命令导入。

### 3.5 脚本（Script）

脚本是包含一系列 PowerShell 命令的文本文件，扩展名为 `.ps1`。

### 3.6 配置文件（Profile）

配置文件是在 PowerShell 启动时自动执行的脚本，用于自定义 PowerShell 环境。

## 4. PowerShell 的版本

| 版本 | 发布时间 | 基于框架 | 支持平台 |
|------|---------|---------|---------|
| Windows PowerShell 1.0 | 2006 | .NET Framework 2.0 | Windows |
| Windows PowerShell 2.0 | 2009 | .NET Framework 3.5 | Windows |
| Windows PowerShell 3.0 | 2012 | .NET Framework 4.0 | Windows |
| Windows PowerShell 4.0 | 2013 | .NET Framework 4.5 | Windows |
| Windows PowerShell 5.0 | 2015 | .NET Framework 4.5 | Windows |
| Windows PowerShell 5.1 | 2016 | .NET Framework 4.6 | Windows |
| PowerShell Core 6.0 | 2018 | .NET Core 2.0 | Windows, macOS, Linux |
| PowerShell Core 7.0 | 2020 | .NET Core 3.1 | Windows, macOS, Linux |
| PowerShell 7.1 | 2020 | .NET 5.0 | Windows, macOS, Linux |
| PowerShell 7.2 | 2021 | .NET 6.0 | Windows, macOS, Linux |
| PowerShell 7.3 | 2022 | .NET 7.0 | Windows, macOS, Linux |

## 5. PowerShell 的应用场景

### 5.1 系统管理

- 管理 Windows 服务、进程、事件日志等
- 配置系统设置和注册表
- 管理用户和组

### 5.2 网络管理

- 管理网络适配器、防火墙规则等
- 测试网络连接和性能
- 管理远程计算机

### 5.3 文件系统管理

- 复制、移动、删除文件和目录
- 搜索和过滤文件
- 管理文件权限

### 5.4 自动化任务

- 批量处理文件和数据
- 定期执行系统维护任务
- 自动化部署和配置

### 5.5 开发和调试

- 与 .NET 应用程序集成
- 调试 PowerShell 脚本
- 管理开发环境

## 6. PowerShell 运行环境

### 6.1 Windows PowerShell

- 默认安装在 Windows 系统中
- 可通过 "开始菜单" -> "Windows PowerShell" 启动
- 或使用快捷键 `Win + X`，然后选择 "Windows PowerShell"

### 6.2 PowerShell Core

- 需要单独下载安装
- 可从 [PowerShell 官网](https://github.com/PowerShell/PowerShell/releases) 下载
- 安装后可通过 "PowerShell" 启动

### 6.3 PowerShell ISE

PowerShell 集成脚本环境（ISE）是 Windows PowerShell 的图形化编辑器，提供语法高亮、代码补全和调试功能。

### 6.4 VS Code

Visual Studio Code 是一个轻量级的代码编辑器，通过安装 PowerShell 扩展，可以提供强大的 PowerShell 脚本编辑和调试功能。

## 7. PowerShell 的基本命令

### 7.1 查看 PowerShell 版本

**语法：**
```powershell
$PSVersionTable
```

**输出示例：**
```
Name                           Value
----                           -----
PSVersion                      7.3.0
PSEdition                      Core
GitCommitId                    7.3.0
OS                             Microsoft Windows 10.0.19045
Platform                       Win32NT
PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0…}
PSRemotingProtocolVersion      2.3
SerializationVersion           1.1.0.1
WSManStackVersion              3.0
```

### 7.2 查看当前目录

**语法：**
```powershell
Get-Location
```

**别名：** `pwd`

**输出示例：**
```
Path
----
C:\Users\Administrator
```

### 7.3 列出目录内容

**语法：**
```powershell
Get-ChildItem
```

**别名：** `ls`、`dir`

**输出示例：**
```
    Directory: C:\Users\Administrator

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-----        2025-12-08     22:06                vscodeprojects
d-r---        2025-12-07     14:30                Desktop
d-r---        2025-12-07     14:30                Documents
d-r---        2025-12-07     14:30                Downloads
```

### 7.4 查看命令帮助

**语法：**
```powershell
Get-Help <命令名>
```

**示例：**
```powershell
Get-Help Get-ChildItem
```

**输出示例：**
```
NAME
    Get-ChildItem

SYNOPSIS
    Gets the items and child items in one or more specified locations.

SYNTAX
    Get-ChildItem [[-Path] <string[]>] [[-Filter] <string>] [-Attributes <FlagsExpression[FileAttributes]>] [-Depth <uint32>] [-Directory] [-Exclude <string[]>] [-File] [-Force] [-Hidden] [-Include <string[]>] [-Name] [-ReadOnly] [-Recurse] [-System] [<CommonParameters>]

...
```

## 8. 总结

PowerShell 是一种强大的任务自动化和配置管理框架，具有跨平台、对象导向、强大的管道和丰富的命令集等特点。它广泛应用于系统管理、网络管理、文件系统管理和自动化任务等领域。

通过学习 PowerShell，您可以提高工作效率，实现复杂的自动化任务，更好地管理和配置系统。

接下来，我们将学习 PowerShell 的语法、常用命令、脚本编写等内容，逐步掌握 PowerShell 的使用方法和最佳实践。