# Jenkins 基础概念

## 1. 概述

### 1.1 什么是 Jenkins
Jenkins 是一个开源的自动化构建、测试和部署工具，用于实现持续集成（CI）和持续交付（CD）。它提供了丰富的插件生态，可以与多种开发工具和技术栈集成。

### 1.2 Jenkins 的核心功能
- **自动化构建**：自动编译、打包代码
- **自动化测试**：自动运行测试用例
- **持续集成**：代码提交后自动构建和测试
- **持续交付**：自动部署到测试或生产环境
- **流水线管理**：可视化定义和管理构建、测试、部署流程
- **分布式构建**：支持多节点并行构建
- **丰富的插件生态**：支持与 GitHub、Docker、Kubernetes 等集成

### 1.3 Jenkins 的架构
Jenkins 采用主从架构（Master-Slave）：
- **Master**：负责管理 Jenkins 系统，调度构建任务
- **Slave**：执行实际的构建、测试和部署任务
- **Agent**：Slave 的新名称，用于执行构建任务

## 2. 安装与配置

### 2.1 安装方式

#### 2.1.1 Docker 安装
```bash
docker run -d \
  -p 8080:8080 \
  -p 50000:50000 \
  --name jenkins \
  -v jenkins_home:/var/jenkins_home \
  jenkins/jenkins:lts
```

#### 2.1.2 二进制安装
```bash
# 下载 Jenkins
wget https://get.jenkins.io/war-stable/latest/jenkins.war

# 启动 Jenkins
java -jar jenkins.war --httpPort=8080
```

#### 2.1.3 包管理器安装
```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install jenkins

# CentOS/RHEL
sudo yum install jenkins
```

### 2.2 初始配置
1. 访问 Jenkins 控制台：http://localhost:8080
2. 获取初始管理员密码：
   ```bash
   # Docker 安装
   docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
   
   # 二进制安装
   cat ~/.jenkins/secrets/initialAdminPassword
   ```
3. 安装推荐插件或选择自定义插件
4. 创建管理员用户
5. 完成配置，开始使用 Jenkins

### 2.3 插件管理
- **安装插件**：系统管理 → 插件管理 → 可选插件
- **更新插件**：系统管理 → 插件管理 → 更新
- **卸载插件**：系统管理 → 插件管理 → 已安装

## 3. 核心概念

### 3.1 任务（Job）
Jenkins 中的基本执行单元，用于定义一次构建或部署操作。

### 3.2 构建（Build）
任务的一次执行实例，包含构建日志、构建结果等信息。

### 3.3 流水线（Pipeline）
将构建、测试、部署等步骤定义为一个完整的工作流，支持可视化编辑和代码化定义。

### 3.4 节点（Node）
执行构建任务的机器，可以是 Master 或 Agent。

### 3.5 凭证（Credentials）
用于存储和管理访问外部系统的凭证，如用户名密码、SSH 密钥、API 令牌等。

### 3.6 触发器（Trigger）
触发 Jenkins 任务执行的事件，如代码提交、定时触发、手动触发等。

### 3.7 构建步骤（Build Step）
任务中的具体执行步骤，如执行 Shell 命令、调用 Maven、运行测试等。

### 3.8 构建后操作（Post-build Action）
构建完成后执行的操作，如发送邮件通知、部署到服务器、归档构建产物等。

## 4. 基本使用

### 4.1 创建第一个任务
1. 点击 "新建任务" → 输入任务名称 → 选择 "自由风格的软件项目" → 点击 "确定"
2. 配置任务：
   - **源码管理**：选择 Git，配置仓库 URL 和分支
   - **构建触发器**：选择触发方式
   - **构建环境**：配置构建环境变量
   - **构建步骤**：添加构建步骤，如执行 Shell 命令
   - **构建后操作**：添加构建后操作
3. 保存配置，点击 "立即构建" 执行任务

### 4.2 查看构建结果
- **构建历史**：查看任务的所有构建记录
- **控制台输出**：查看构建日志
- **构建产物**：查看构建生成的文件
- **测试报告**：查看测试结果

### 4.3 管理节点
- **新建节点**：系统管理 → 节点管理 → 新建节点
- **配置节点**：设置节点名称、描述、执行器数量、标签等
- **连接节点**：配置节点连接方式（SSH、JNLP 等）

## 5. 安全配置

### 5.1 用户管理
- **创建用户**：系统管理 → 管理用户 → 新建用户
- **用户权限**：系统管理 → 全局安全配置 → 授权策略

### 5.2 权限管理
Jenkins 支持多种授权策略：
- 任何人可以做任何事（不推荐）
- 登录用户可以做任何事
- 项目矩阵授权策略
- 基于角色的矩阵授权策略

### 5.3 认证方式
Jenkins 支持多种认证方式：
- Jenkins 内置用户数据库
- LDAP
- Active Directory
- GitHub OAuth
- OpenID Connect

## 6. 常见插件

### 6.1 核心插件
- **Git**：Git 源码管理
- **Pipeline**：流水线支持
- **GitHub Integration**：GitHub 集成
- **Docker**：Docker 支持
- **Kubernetes**：Kubernetes 集成
- **Maven Integration**：Maven 构建支持
- **JUnit**：测试报告支持
- **Email Extension**：邮件通知扩展
- **Credentials Binding**：凭证管理
- **SSH Agent**：SSH 代理

### 6.2 推荐插件
- **Blue Ocean**：现代化的流水线可视化界面
- **GitLab**：GitLab 集成
- **SonarQube Scanner**：代码质量检查
- **Ansible**：Ansible 集成
- **Terraform**：Terraform 支持
- **Slack Notification**：Slack 通知

## 7. 最佳实践

### 7.1 项目结构
- 为每个项目创建独立的 Jenkins 任务
- 使用文件夹（Folder）组织相关任务
- 为不同环境（开发、测试、生产）创建独立任务

### 7.2 流水线设计
- 使用声明式流水线（Declarative Pipeline）
- 分离构建、测试、部署阶段
- 使用变量和参数化构建
- 添加充分的日志记录
- 实现构建失败自动通知

### 7.3 性能优化
- 使用分布式构建，将任务分配到多个节点
- 合理设置执行器数量
- 清理旧的构建历史
- 使用缓存机制加速构建

### 7.4 安全最佳实践
- 定期更新 Jenkins 和插件
- 启用 HTTPS
- 限制 Jenkins 访问权限
- 定期备份 Jenkins 数据
- 使用凭证管理插件存储敏感信息

## 8. 常见问题

### 8.1 构建失败
- 检查构建日志，定位错误原因
- 验证源码管理配置
- 检查构建步骤和脚本
- 验证依赖环境

### 8.2 节点连接失败
- 检查网络连接
- 验证 SSH 配置或 JNLP 连接
- 检查节点上的 Jenkins Agent 状态
- 查看节点日志

### 8.3 插件安装失败
- 检查网络连接
- 验证 Jenkins 版本与插件版本兼容性
- 手动下载插件并上传安装
- 清理插件缓存

## 9. 总结

Jenkins 是一个强大的自动化构建、测试和部署工具，通过 Jenkins 可以实现持续集成和持续交付，提高软件开发的效率和质量。

通过学习 Jenkins 的基础概念、安装配置和基本使用方法，可以快速上手 Jenkins，并逐步构建复杂的自动化流水线。

Jenkins 的核心优势在于其丰富的插件生态和灵活的配置能力，可以与多种开发工具和技术栈集成，满足不同项目的需求。