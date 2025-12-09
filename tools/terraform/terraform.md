# Terraform 文档

## 1. 基础概念

### 1.1 什么是 Terraform？

Terraform 是一个开源的基础设施即代码 (IaC) 工具，由 HashiCorp 开发，允许用户使用声明式配置语言定义、部署和管理云基础设施。它支持多种云服务提供商，如 AWS、Azure、GCP、阿里云等，以及本地基础设施。

### 1.2 Terraform 的核心特性

- **声明式配置**：使用 HCL (HashiCorp Configuration Language) 编写配置文件，描述基础设施的期望状态
- **多云支持**：支持 100+ 云服务提供商和基础设施平台
- **基础设施即代码**：将基础设施定义为代码，便于版本控制、复用和协作
- **状态管理**：维护基础设施的当前状态，跟踪资源变化
- **计划执行**：在实际部署前预览变更，减少错误
- **模块化设计**：支持创建可复用的模块
- **自动化部署**：自动处理资源创建、更新和删除
- **团队协作**：支持远程状态存储和锁定，便于团队协作

### 1.3 Terraform 的核心概念

- **提供者 (Provider)**：与云服务提供商或基础设施平台的接口，如 `aws`、`azurerm`、`google` 等
- **资源 (Resource)**：基础设施的具体组件，如 EC2 实例、S3 存储桶、VPC 等
- **变量 (Variable)**：用于参数化配置，便于复用和环境管理
- **输出 (Output)**：从 Terraform 配置中提取值，如资源 ID、IP 地址等
- **模块 (Module)**：可复用的配置单元，包含多个资源和配置
- **状态 (State)**：记录基础设施的当前状态，用于跟踪资源变化
- **计划 (Plan)**：预览即将执行的变更
- **应用 (Apply)**：执行变更，部署或更新基础设施
- **销毁 (Destroy)**：删除由 Terraform 管理的基础设施

### 1.4 Terraform 的应用场景

- **云基础设施部署**：自动化部署和管理云资源
- **多云管理**：统一管理多个云服务提供商的资源
- **环境管理**：快速创建和销毁开发、测试、生产环境
- **基础设施即代码**：将基础设施定义为代码，便于版本控制和协作
- **CI/CD 集成**：与持续集成/持续部署流程集成，实现基础设施自动化
- **资源标准化**：确保基础设施资源的一致性和标准化

## 2. 安装

### 2.1 Linux 系统安装

#### 2.1.1 使用官方安装脚本

```bash
# 下载并执行官方安装脚本
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform

# 验证安装
terraform -version
```

#### 2.1.2 使用二进制文件安装

```bash
# 下载最新版本的 Terraform
wget https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_amd64.zip

# 解压
unzip terraform_1.6.0_linux_amd64.zip

# 移动到系统路径
sudo mv terraform /usr/local/bin/

# 验证安装
terraform -version
```

### 2.2 Windows 系统安装

#### 2.2.1 使用 Chocolatey

```bash
# 使用 Chocolatey 安装 Terraform
choco install terraform
```

#### 2.2.2 使用二进制文件安装

1. 从 [Terraform 官网](https://www.terraform.io/downloads.html) 下载适用于 Windows 的二进制文件
2. 解压文件，将 `terraform.exe` 移动到系统路径（如 `C:\Windows\System32`）
3. 打开命令提示符或 PowerShell，运行 `terraform -version` 验证安装

### 2.3 macOS 系统安装

#### 2.3.1 使用 Homebrew

```bash
# 使用 Homebrew 安装 Terraform
brew tap hashicorp/tap
brew install hashicorp/tap/terraform

# 验证安装
terraform -version
```

#### 2.3.2 使用二进制文件安装

```bash
# 下载最新版本的 Terraform
curl -O https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_darwin_amd64.zip

# 解压
unzip terraform_1.6.0_darwin_amd64.zip

# 移动到系统路径
sudo mv terraform /usr/local/bin/

# 验证安装
terraform -version
```

## 3. 基本配置

### 3.1 配置文件结构

Terraform 配置文件通常使用 `.tf` 扩展名，主要包含以下类型的文件：

- **main.tf**：主配置文件，包含资源定义
- **variables.tf**：变量定义
- **outputs.tf**：输出定义
- **providers.tf**：提供者配置
- **terraform.tf**：Terraform 设置，如后端配置
- **modules/**：模块目录

### 3.2 HCL 语法基础

Terraform 使用 HCL (HashiCorp Configuration Language) 编写配置文件，语法简洁明了：

```hcl
# 注释

# 资源定义
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  
  tags = {
    Name = "ExampleInstance"
  }
}

# 变量定义
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

# 输出定义
output "instance_id" {
  value = aws_instance.example.id
}
```

### 3.3 基本配置示例

#### 3.3.1 AWS 示例

```hcl
# providers.tf
provider "aws" {
  region = "us-west-2"
}

# main.tf
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"
  
  tags = {
    Name = "public-subnet"
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public.id
  
  tags = {
    Name = "web-server"
  }
}

# outputs.tf
output "instance_id" {
  value = aws_instance.web.id
}

output "instance_public_ip" {
  value = aws_instance.web.public_ip
}
```

#### 3.3.2 Azure 示例

```hcl
# providers.tf
provider "azurerm" {
  features {}
}

# main.tf
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_linux_virtual_machine" "example" {
  name                = "example-vm"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_B2s"
  admin_username      = "adminuser"

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  network_interface_ids = [azurerm_network_interface.example.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example.id
  }
}

resource "azurerm_public_ip" "example" {
  name                = "example-pip"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Dynamic"
}

# outputs.tf
output "vm_public_ip" {
  value = azurerm_public_ip.example.ip_address
}
```

## 4. 高级配置

### 4.1 变量和环境变量

#### 4.1.1 变量类型

Terraform 支持多种变量类型：

- **字符串 (string)**：如 `"t2.micro"`
- **数字 (number)**：如 `80`、`443`
- **布尔值 (bool)**：如 `true`、`false`
- **列表 (list)**：如 `["us-west-2a", "us-west-2b"]`
- **映射 (map)**：如 `{ "key1" = "value1", "key2" = "value2" }`
- **对象 (object)**：如 `{ name = "example", size = "t2.micro" }`
- **集合 (set)**：如 `toset(["a", "b", "c"])`

#### 4.1.2 变量定义

```hcl
# variables.tf
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b"]
}
```

#### 4.1.3 变量使用

```hcl
# main.tf
provider "aws" {
  region = var.region
}

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = var.instance_type
  
  tags = merge(var.tags, {
    Name = "web-server"
  })
}
```

#### 4.1.4 环境变量

Terraform 支持使用环境变量设置变量值：

```bash
# 设置 AWS 凭证
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"

# 设置 Terraform 变量
export TF_VAR_region="us-east-1"
export TF_VAR_instance_type="t3.micro"
```

### 4.2 模块

模块是可复用的配置单元，包含多个资源和配置。模块可以是本地的，也可以是来自 Terraform Registry 的公共模块。

#### 4.2.1 创建本地模块

```hcl
# modules/vpc/main.tf
variable "cidr_block" {
  description = "VPC CIDR block"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  
  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "public" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, count.index)
  availability_zone = var.availability_zones[count.index]
  
  tags = {
    Name = "public-subnet-${count.index}"
  }
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_ids" {
  value = aws_subnet.public[*].id
}
```

#### 4.2.2 使用模块

```hcl
# main.tf
provider "aws" {
  region = "us-west-2"
}

module "vpc" {
  source              = "./modules/vpc"
  cidr_block          = "10.0.0.0/16"
  availability_zones  = ["us-west-2a", "us-west-2b"]
}

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = module.vpc.subnet_ids[0]
  
  tags = {
    Name = "web-server"
  }
}
```

#### 4.2.3 使用 Terraform Registry 模块

```hcl
# main.tf
provider "aws" {
  region = "us-west-2"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.18.0"
  
  name                 = "my-vpc"
  cidr                 = "10.0.0.0/16"
  azs                  = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets       = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_vpn_gateway   = true
  
  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
```

### 4.3 状态管理

#### 4.3.1 本地状态

默认情况下，Terraform 将状态存储在本地文件 `terraform.tfstate` 中。

#### 4.3.2 远程状态

对于团队协作，建议使用远程状态存储，如 S3、Azure Blob Storage、GCS 或 Terraform Cloud。

##### 4.3.2.1 S3 远程状态示例

```hcl
# terraform.tf
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
```

##### 4.3.2.2 Terraform Cloud 远程状态示例

```hcl
# terraform.tf
terraform {
  cloud {
    organization = "my-organization"
    
    workspaces {
      name = "my-workspace"
    }
  }
}
```

### 4.4 条件资源创建

使用 `count` 或 `for_each` 可以根据条件创建资源：

#### 4.4.1 使用 count

```hcl
variable "create_instance" {
  type    = bool
  default = true
}

resource "aws_instance" "web" {
  count = var.create_instance ? 1 : 0
  
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  
  tags = {
    Name = "web-server"
  }
}
```

#### 4.4.2 使用 for_each

```hcl
variable "instances" {
  type = map(object({
    instance_type = string
    ami           = string
  }))
  default = {
    web1 = {
      instance_type = "t2.micro"
      ami           = "ami-0c55b159cbfafe1f0"
    }
    web2 = {
      instance_type = "t2.small"
      ami           = "ami-0c55b159cbfafe1f0"
    }
  }
}

resource "aws_instance" "web" {
  for_each = var.instances
  
  ami           = each.value.ami
  instance_type = each.value.instance_type
  
  tags = {
    Name = each.key
  }
}
```

## 5. 常用命令

```bash
# 初始化 Terraform 配置
terraform init

# 预览变更
terraform plan

# 执行变更
terraform apply

# 执行变更（自动确认）
terraform apply -auto-approve

# 销毁资源
terraform destroy

# 销毁资源（自动确认）
terraform destroy -auto-approve

# 验证配置文件
terraform validate

# 格式化配置文件
terraform fmt

# 查看状态
terraform show

# 查看状态详情
terraform state list
terraform state show <resource>

# 输出所有输出值
terraform output

# 输出特定输出值
terraform output <output-name>

# 刷新状态
terraform refresh

# 导入现有资源到状态
terraform import <resource> <id>

# 升级提供者插件
terraform init -upgrade

# 查看版本
terraform version
```

## 6. 使用示例

### 6.1 部署 AWS EC2 实例

1. **创建配置文件**：
   ```hcl
   # main.tf
   provider "aws" {
     region = "us-west-2"
   }
   
   resource "aws_instance" "web" {
     ami           = "ami-0c55b159cbfafe1f0"
     instance_type = "t2.micro"
     
     tags = {
       Name = "web-server"
     }
   }
   
   output "instance_id" {
     value = aws_instance.web.id
   }
   
   output "instance_public_ip" {
     value = aws_instance.web.public_ip
   }
   ```

2. **初始化 Terraform**：
   ```bash
   terraform init
   ```

3. **预览变更**：
   ```bash
   terraform plan
   ```

4. **执行变更**：
   ```bash
   terraform apply
   ```

5. **查看输出**：
   ```bash
   terraform output
   ```

6. **销毁资源**：
   ```bash
   terraform destroy
   ```

### 6.2 部署 AWS S3 存储桶

```hcl
# main.tf
provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "example" {
  bucket = "my-unique-bucket-name-12345"
  
  tags = {
    Name        = "example-bucket"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.example.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.example.id
  acl    = "private"
}

output "bucket_id" {
  value = aws_s3_bucket.example.id
}

output "bucket_arn" {
  value = aws_s3_bucket.example.arn
}
```

## 7. 最佳实践

### 7.1 代码组织

1. **模块化设计**：将配置拆分为多个模块，提高复用性
2. **环境分离**：为不同环境（开发、测试、生产）创建独立的配置目录
3. **分层配置**：将全局配置、提供者配置、资源配置分离
4. **使用变量**：参数化配置，便于环境管理和复用
5. **输出重要信息**：将资源 ID、IP 地址等重要信息作为输出

### 7.2 安全性

1. **保护敏感数据**：
   - 使用 Terraform Cloud 或 Vault 存储敏感数据
   - 避免在配置文件中硬编码敏感信息
   - 使用 `sensitive = true` 标记敏感变量

2. **最小权限原则**：
   - 为 Terraform 服务账户分配最小必要权限
   - 使用 IAM 角色而非长期凭证

3. **状态文件安全**：
   - 使用远程状态存储
   - 启用状态文件加密
   - 启用状态锁定，防止并发修改

### 7.3 版本控制

1. **将配置文件纳入版本控制**
2. **忽略临时文件**：在 `.gitignore` 中添加以下内容：
   ```
   # Terraform
   *.tfstate
   *.tfstate.backup
   .terraform/
   .terraform.lock.hcl
   *.tfvars
   ```
3. **使用工作区**：为不同环境使用不同的工作区
4. **标签管理**：为资源添加标签，便于识别和管理

### 7.4 测试和验证

1. **使用 terraform validate**：验证配置文件语法
2. **使用 terraform fmt**：格式化配置文件
3. **使用 terraform plan**：在部署前预览变更
4. **使用 Terratest**：编写自动化测试脚本
5. **定期审查**：定期审查 Terraform 配置和状态

### 7.5 CI/CD 集成

1. **自动化部署**：将 Terraform 集成到 CI/CD 流程中
2. **审批流程**：为生产环境添加审批步骤
3. **变更审计**：记录所有变更，便于追踪和回滚
4. **自动化测试**：在部署前运行测试

## 8. 常见问题

### 8.1 状态文件损坏

- **解决方案**：使用备份状态文件恢复，或重新初始化
  ```bash
  terraform init -reconfigure
  ```

### 8.2 资源创建失败

- **查看错误信息**：Terraform 会显示详细的错误信息
- **检查云服务提供商控制台**：查看资源创建失败的具体原因
- **检查权限**：确保 Terraform 服务账户有足够的权限
- **检查资源限制**：确保没有超过云服务提供商的资源限制

### 8.3 资源依赖问题

- **使用隐式依赖**：Terraform 会自动检测资源之间的依赖关系
- **使用显式依赖**：使用 `depends_on` 明确指定依赖关系
  ```hcl
  resource "aws_instance" "web" {
    depends_on = [aws_subnet.public]
    # ...
  }
  ```

### 8.4 版本冲突

- **固定提供者版本**：在配置中指定提供者版本
  ```hcl
  terraform {
    required_providers {
      aws = {
        source  = "hashicorp/aws"
        version = "~> 4.0"
      }
    }
  }
  ```

- **使用 terraform init -upgrade**：升级提供者插件

### 8.5 如何回滚变更

- **使用 terraform apply -auto-approve -refresh=false <tfplan-file>**：应用之前保存的计划文件
- **使用 terraform state rollback**：回滚到之前的状态（需要 Terraform Cloud）
- **手动修复**：修改配置文件，然后运行 `terraform apply`

## 9. 资源

- **官方网站**：https://www.terraform.io/
- **官方文档**：https://developer.hashicorp.com/terraform/docs
- **Terraform Registry**：https://registry.terraform.io/ （公共模块和提供者）
- **HCL 语法**：https://developer.hashicorp.com/terraform/language/syntax/configuration
- **AWS 提供者文档**：https://registry.terraform.io/providers/hashicorp/aws/latest/docs
- **Azure 提供者文档**：https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
- **GCP 提供者文档**：https://registry.terraform.io/providers/hashicorp/google/latest/docs
- **Terraform 教程**：https://learn.hashicorp.com/terraform
- **Terraform 社区**：https://www.terraform.io/community

## 10. 总结

Terraform 是一个强大的基础设施即代码工具，允许用户使用声明式配置语言定义、部署和管理云基础设施。它支持多种云服务提供商，具有模块化设计、状态管理、计划执行等核心特性。

本文档介绍了 Terraform 的基础概念、安装方法、配置示例、常用命令和最佳实践，希望能帮助你快速上手 Terraform，并在实际项目中灵活应用。

通过学习 Terraform，你可以实现基础设施的自动化部署和管理，提高开发效率，确保基础设施的一致性和可靠性。随着对 Terraform 的深入学习和实践，你会发现它的更多强大功能和便捷特性，从而构建出更加高效、可靠的基础设施。