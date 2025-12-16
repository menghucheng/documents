# Docker 文档

## 1. 基础概念

### 1.1 什么是 Docker？

Docker 是一个开源的容器化平台，允许开发者将应用程序及其依赖项打包到一个轻量级、可移植的容器中，然后发布到任何流行的 Linux 机器上，也可以在 Windows 和 macOS 上运行。Docker 容器与虚拟机不同，它们共享主机的内核，因此更加轻量级和高效。

### 1.2 Docker 的核心特性

- **轻量级**：容器共享主机内核，启动时间毫秒级，占用资源少
- **可移植性**：在开发、测试和生产环境中运行一致
- **隔离性**：容器之间相互隔离，互不影响
- **可扩展性**：支持快速扩展和缩减容器数量
- **版本控制**：支持镜像版本管理
- **自动化**：支持 CI/CD 集成，自动化构建和部署
- **生态系统**：拥有丰富的镜像仓库和工具

### 1.3 Docker 的核心概念

- **镜像 (Image)**：包含应用程序及其所有依赖项的只读模板
- **容器 (Container)**：镜像的运行实例，可读写
- **仓库 (Registry)**：存储和分发镜像的服务，如 Docker Hub、阿里云镜像仓库等
- **Dockerfile**：用于构建 Docker 镜像的文本文件，包含一系列指令
- **Docker Compose**：用于定义和运行多容器 Docker 应用的工具
- **Docker Swarm**：Docker 原生的集群管理和编排工具
- **网络 (Network)**：用于容器之间通信的网络配置
- **卷 (Volume)**：用于持久化存储容器数据的机制

### 1.4 Docker 的应用场景

- **应用打包和分发**：将应用程序及其依赖项打包到容器中，确保一致的运行环境
- **微服务架构**：将大型应用拆分为多个微服务，每个微服务运行在独立的容器中
- **持续集成/持续部署 (CI/CD)**：自动化构建、测试和部署应用
- **环境一致性**：确保开发、测试和生产环境一致，减少"在我的机器上可以运行"的问题
- **资源隔离**：将不同的应用或服务隔离在不同的容器中
- **快速扩展**：根据需求快速扩展或缩减容器数量
- **DevOps 实践**：促进开发和运维团队的协作

## 2. 安装

### 2.1 Linux 系统安装

#### 2.1.1 Ubuntu/Debian

```bash
# 更新包列表
sudo apt update

# 安装依赖包
sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release

# 添加 Docker 官方 GPG 密钥
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# 添加 Docker 仓库
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 更新包列表
sudo apt update

# 安装 Docker Engine、Docker CLI 和 Containerd
sudo apt install -y docker-ce docker-ce-cli containerd.io

# 验证安装
sudo docker run hello-world

# 允许当前用户使用 Docker（可选，需要重新登录）
sudo usermod -aG docker $USER
```

#### 2.1.2 CentOS/RHEL

```bash
# 安装依赖包
sudo yum install -y yum-utils

# 添加 Docker 仓库
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# 安装 Docker Engine、Docker CLI 和 Containerd
sudo yum install -y docker-ce docker-ce-cli containerd.io

# 启动 Docker
sudo systemctl start docker

# 设置开机自启
sudo systemctl enable docker

# 验证安装
sudo docker run hello-world

# 允许当前用户使用 Docker（可选，需要重新登录）
sudo usermod -aG docker $USER
```

### 2.2 Windows 系统安装

#### 2.2.1 Windows 10/11 专业版/企业版/教育版

1. 确保已启用 WSL 2（Windows Subsystem for Linux）
   - 打开 PowerShell 作为管理员
   - 运行：`wsl --install`
   - 重启计算机

2. 下载并安装 Docker Desktop for Windows
   - 从 [Docker 官网](https://www.docker.com/products/docker-desktop) 下载 Docker Desktop for Windows
   - 运行安装程序，按照提示完成安装
   - 启动 Docker Desktop

3. 验证安装
   - 打开 PowerShell 或 Command Prompt
   - 运行：`docker run hello-world`

#### 2.2.2 Windows 家庭版

1. 启用 Hyper-V（通过 PowerShell）
   - 打开 PowerShell 作为管理员
   - 运行：`Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All`
   - 重启计算机

2. 下载并安装 Docker Desktop for Windows
   - 从 [Docker 官网](https://www.docker.com/products/docker-desktop) 下载 Docker Desktop for Windows
   - 运行安装程序，按照提示完成安装
   - 启动 Docker Desktop

3. 验证安装
   - 打开 PowerShell 或 Command Prompt
   - 运行：`docker run hello-world`

### 2.3 macOS 系统安装

1. 下载 Docker Desktop for Mac
   - 从 [Docker 官网](https://www.docker.com/products/docker-desktop) 下载 Docker Desktop for Mac

2. 安装 Docker Desktop
   - 双击下载的 `.dmg` 文件
   - 将 Docker 图标拖放到 Applications 文件夹
   - 从 Applications 文件夹启动 Docker

3. 验证安装
   - 打开 Terminal
   - 运行：`docker run hello-world`

## 3. 基本配置

### 3.1 Docker 配置文件

Docker 的主要配置文件是 `/etc/docker/daemon.json`（Linux）或通过 Docker Desktop GUI 配置（Windows/macOS）。

#### 3.1.1 基本配置示例

```json
{
  "registry-mirrors": ["https://registry.docker-cn.com"],
  "insecure-registries": ["my-registry.example.com:5000"],
  "data-root": "/var/lib/docker",
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  },
  "storage-driver": "overlay2"
}
```

#### 3.1.2 重启 Docker 服务

```bash
# Linux
sudo systemctl restart docker

# Windows/macOS
# 通过 Docker Desktop GUI 重启
```

### 3.2 镜像管理

#### 3.2.1 拉取镜像

```bash
# 拉取最新版本的镜像
docker pull nginx

# 拉取指定版本的镜像
docker pull nginx:1.23.0

# 拉取私有镜像
docker pull my-registry.example.com/my-image:latest
```

#### 3.2.2 列出镜像

```bash
# 列出所有镜像
docker images

# 列出所有镜像 ID
docker images -q

# 列出镜像的详细信息
docker images --digests
```

#### 3.2.3 删除镜像

```bash
# 根据镜像 ID 或名称删除镜像
docker rmi nginx:latest

# 强制删除镜像
docker rmi -f nginx:latest

# 删除所有镜像
docker rmi $(docker images -q)
```

#### 3.2.4 镜像标签

```bash
# 为镜像添加标签
docker tag nginx:latest my-nginx:v1.0

# 推送镜像到仓库
docker push my-registry.example.com/my-nginx:v1.0
```

### 3.3 容器管理

#### 3.3.1 创建和运行容器

```bash
# 运行一个简单的容器
docker run hello-world

# 运行交互式容器
docker run -it ubuntu /bin/bash

# 运行后台容器
docker run -d --name my-nginx nginx:latest

# 映射端口
docker run -d -p 80:80 --name my-nginx nginx:latest

# 挂载卷
docker run -d -v /host/path:/container/path --name my-nginx nginx:latest

# 设置环境变量
docker run -d -e "ENV_VAR=value" --name my-nginx nginx:latest
```

#### 3.3.2 列出容器

```bash
# 列出运行中的容器
docker ps

# 列出所有容器（包括停止的）
docker ps -a

# 列出容器 ID
docker ps -q

# 列出容器的详细信息
docker ps --no-trunc
```

#### 3.3.3 管理容器

```bash
# 启动容器
docker start my-nginx

# 停止容器
docker stop my-nginx

# 重启容器
docker restart my-nginx

# 进入运行中的容器
docker exec -it my-nginx /bin/bash

# 查看容器日志
docker logs my-nginx

# 实时查看容器日志
docker logs -f my-nginx

# 查看容器资源使用情况
docker stats my-nginx

# 查看容器详细信息
docker inspect my-nginx
```

#### 3.3.4 删除容器

```bash
# 删除停止的容器
docker rm my-nginx

# 强制删除运行中的容器
docker rm -f my-nginx

# 删除所有停止的容器
docker rm $(docker ps -a -q)

# 删除所有容器
docker rm -f $(docker ps -a -q)
```

### 3.4 网络配置

#### 3.4.1 列出网络

```bash
# 列出所有网络
docker network ls
```

#### 3.4.2 创建网络

```bash
# 创建桥接网络
docker network create my-network

# 创建覆盖网络
docker network create -d overlay my-overlay-network
```

#### 3.4.3 连接容器到网络

```bash
# 运行容器时连接到网络
docker run -d --name my-container --network my-network nginx:latest

# 将现有容器连接到网络
docker network connect my-network my-container

# 断开容器与网络的连接
docker network disconnect my-network my-container
```

#### 3.4.4 查看网络详情

```bash
docker network inspect my-network
```

### 3.5 卷管理

#### 3.5.1 创建卷

```bash
# 创建卷
docker volume create my-volume
```

#### 3.5.2 列出卷

```bash
docker volume ls
```

#### 3.5.3 使用卷

```bash
# 运行容器时使用卷
docker run -d -v my-volume:/container/path --name my-container nginx:latest
```

#### 3.5.4 查看卷详情

```bash
docker volume inspect my-volume
```

#### 3.5.5 删除卷

```bash
# 删除未使用的卷
docker volume prune

# 删除指定卷
docker volume rm my-volume
```

## 4. 高级配置

### 4.1 Dockerfile

Dockerfile 是用于构建 Docker 镜像的文本文件，包含一系列指令和参数。

#### 4.1.1 基本 Dockerfile 示例

```dockerfile
# 使用官方 Node.js 镜像作为基础镜像
FROM node:16-alpine

# 设置工作目录
WORKDIR /app

# 复制 package.json 和 package-lock.json 到工作目录
COPY package*.json ./

# 安装依赖
RUN npm install

# 复制应用代码到工作目录
COPY . .

# 暴露端口
EXPOSE 3000

# 运行应用
CMD ["node", "server.js"]
```

#### 4.1.2 构建镜像

```bash
# 构建镜像
docker build -t my-node-app:latest .

# 使用指定的 Dockerfile 构建
docker build -f Dockerfile.dev -t my-node-app:dev .

# 构建时传递构建参数
docker build --build-arg NODE_ENV=production -t my-node-app:latest .
```

#### 4.1.3 多阶段构建示例

```dockerfile
# 第一阶段：构建阶段
FROM node:16-alpine as builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# 第二阶段：运行阶段
FROM nginx:1.23-alpine
# 复制构建产物到 Nginx 静态目录
COPY --from=builder /app/build /usr/share/nginx/html
# 暴露端口
EXPOSE 80
# 启动 Nginx
CMD ["nginx", "-g", "daemon off;"]
```

### 4.2 Docker Compose

Docker Compose 是用于定义和运行多容器 Docker 应用的工具，使用 YAML 文件配置应用的服务、网络和卷。

#### 4.2.1 安装 Docker Compose

```bash
# Linux
curl -L "https://github.com/docker/compose/releases/download/v2.15.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# 验证安装
docker-compose --version

# Windows/macOS
# Docker Desktop 已包含 Docker Compose
```

#### 4.2.2 基本 Docker Compose 文件示例

```yaml
# docker-compose.yml
version: '3.8'

services:
  web:
    build: .
    ports:
      - "80:80"
    depends_on:
      - db
    environment:
      - DATABASE_URL=postgresql://postgres:password@db:5432/mydb
  
  db:
    image: postgres:14-alpine
    volumes:
      - postgres-data:/var/lib/postgresql/data
    environment:
      - POSTGRES_PASSWORD=password
      - POSTGRES_DB=mydb

volumes:
  postgres-data:
```

#### 4.2.3 Docker Compose 常用命令

```bash
# 启动服务
docker-compose up

# 后台启动服务
docker-compose up -d

# 停止服务
docker-compose down

# 查看服务状态
docker-compose ps

# 查看服务日志
docker-compose logs

# 实时查看服务日志
docker-compose logs -f

# 构建服务
docker-compose build

# 重启服务
docker-compose restart

# 进入服务容器
docker-compose exec web bash
```

### 4.3 Docker Swarm

Docker Swarm 是 Docker 原生的集群管理和编排工具，用于管理多个 Docker 节点组成的集群。

#### 4.3.1 初始化 Swarm 集群

```bash
# 初始化 Swarm 管理器节点
docker swarm init

# 添加工作节点
docker swarm join --token <token> <manager-ip>:2377
```

#### 4.3.2 部署服务

```bash
# 部署服务
docker service create --name my-nginx --replicas 3 -p 80:80 nginx:latest

# 扩展服务
docker service scale my-nginx=5

# 更新服务
docker service update --image nginx:1.23.0 my-nginx

# 删除服务
docker service rm my-nginx
```

#### 4.3.3 查看服务状态

```bash
# 查看所有服务
docker service ls

# 查看服务详情
docker service inspect my-nginx

# 查看服务任务
docker service ps my-nginx
```

## 5. 使用示例

### 5.1 基本命令示例

```bash
# 拉取 Nginx 镜像
docker pull nginx

# 运行 Nginx 容器，映射端口 8080 到容器的 80 端口
docker run -d -p 8080:80 --name my-nginx nginx

# 查看容器日志
docker logs my-nginx

# 进入容器
docker exec -it my-nginx bash

# 停止容器
docker stop my-nginx

# 启动容器
docker start my-nginx

# 删除容器
docker rm my-nginx
```

### 5.2 Dockerfile 示例：Node.js 应用

```dockerfile
# 使用官方 Node.js 16 镜像作为基础
FROM node:16-alpine

# 设置工作目录
WORKDIR /app

# 复制 package.json 和 package-lock.json
COPY package*.json ./

# 安装依赖
RUN npm ci --only=production

# 复制应用代码
COPY . .

# 暴露端口
EXPOSE 3000

# 运行应用
CMD ["node", "server.js"]
```

### 5.3 Docker Compose 示例：WordPress 应用

```yaml
# docker-compose.yml
version: '3.8'

services:
  wordpress:
    image: wordpress:latest
    ports:
      - "80:80"
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: wordpress
      WORDPRESS_DB_NAME: wordpress
    volumes:
      - wordpress-data:/var/www/html
    depends_on:
      - db
  
  db:
    image: mysql:5.7
    volumes:
      - db-data:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: wordpress

volumes:
  wordpress-data:
  db-data:
```

### 5.4 构建和运行自定义镜像

```bash
# 进入应用目录
cd my-node-app

# 构建镜像
docker build -t my-node-app:latest .

# 运行容器
docker run -d -p 3000:3000 --name my-node-app my-node-app:latest

# 访问应用
curl http://localhost:3000
```

## 6. 最佳实践

### 6.1 镜像优化

1. **使用官方基础镜像**：官方镜像经过优化，安全可靠
2. **使用 Alpine 版本**：Alpine 镜像体积小，安全性高
3. **最小化镜像层数**：合并 RUN 指令，减少镜像层数
4. **使用 .dockerignore 文件**：排除不必要的文件和目录
5. **多阶段构建**：分离构建阶段和运行阶段，减少最终镜像体积
6. **安装最小依赖**：只安装必要的依赖包
7. **清理缓存**：在安装依赖后清理缓存
8. **使用固定版本标签**：避免使用 latest 标签，确保镜像版本一致

### 6.2 容器安全

1. **使用非 root 用户**：在 Dockerfile 中创建并使用非 root 用户
2. **最小化容器权限**：使用 --cap-drop=ALL 和 --read-only 等选项
3. **定期更新镜像**：及时更新基础镜像，修复安全漏洞
4. **扫描镜像漏洞**：使用 docker scan 或第三方工具扫描镜像
5. **限制容器资源**：使用 --cpus 和 --memory 限制容器资源
6. **使用私有镜像仓库**：对于敏感应用，使用私有镜像仓库
7. **启用 Docker 内容信任**：确保镜像的完整性和来源

### 6.3 性能优化

1. **使用 overlay2 存储驱动**：overlay2 是 Docker 的推荐存储驱动
2. **调整日志驱动**：使用 json-file 并设置适当的日志大小限制
3. **使用 volumes 而非 bind mounts**：volumes 性能更好，管理更方便
4. **优化网络配置**：使用桥接网络而非默认网络
5. **合理设置容器资源限制**：根据应用需求设置 CPU 和内存限制
6. **使用健康检查**：配置健康检查，及时发现和恢复故障容器

### 6.4 CI/CD 集成

1. **自动化构建**：在 CI 流程中自动构建镜像
2. **自动化测试**：在构建后运行测试
3. **自动化部署**：通过 CI/CD 流程自动部署到测试和生产环境
4. **镜像标签策略**：使用语义化版本号或 Git 提交哈希作为镜像标签
5. **使用 Docker Compose**：在 CI/CD 中使用 Docker Compose 测试多容器应用

### 6.5 监控和日志

1. **配置集中日志管理**：使用 ELK Stack、Fluentd 或 Loki 等工具集中管理日志
2. **监控容器资源**：使用 Prometheus + Grafana 监控容器资源使用情况
3. **配置健康检查**：为容器配置健康检查，便于监控和自动恢复
4. **使用 Docker 原生监控**：使用 docker stats 和 docker events 命令监控容器

## 7. 常见问题

### 7.1 权限问题

**问题**：无法运行 Docker 命令，提示权限不足

**解决方案**：将当前用户添加到 docker 组

```bash
sudo usermod -aG docker $USER
# 重新登录或运行以下命令立即生效
newgrp docker
```

### 7.2 端口占用

**问题**：运行容器时提示端口已被占用

**解决方案**：使用不同的端口映射，或停止占用端口的进程

```bash
# 使用不同的端口映射
docker run -d -p 8081:80 nginx

# 查找占用端口的进程
sudo lsof -i :80
# 停止占用端口的进程
sudo kill <pid>
```

### 7.3 镜像拉取缓慢

**问题**：拉取 Docker 镜像速度缓慢

**解决方案**：配置 Docker 镜像加速器

```json
# 修改 /etc/docker/daemon.json
{
  "registry-mirrors": ["https://registry.docker-cn.com"]
}
```

### 7.4 容器无法访问网络

**问题**：容器无法访问外部网络或其他容器

**解决方案**：检查网络配置，确保容器连接到正确的网络

```bash
# 查看容器的网络配置
docker inspect my-container | grep -A 10 Networks

# 连接容器到网络
docker network connect my-network my-container
```

### 7.5 容器数据丢失

**问题**：容器删除后数据丢失

**解决方案**：使用 volumes 或 bind mounts 持久化数据

```bash
# 使用 volume 持久化数据
docker run -d -v my-volume:/data my-container

# 使用 bind mount 持久化数据
docker run -d -v /host/path:/container/path my-container
```

### 7.6 Docker 磁盘空间不足

**问题**：Docker 占用过多磁盘空间

**解决方案**：清理未使用的资源

```bash
# 清理未使用的镜像、容器、卷和网络
docker system prune

# 清理所有未使用的资源（包括停止的容器）
docker system prune -a

# 清理未使用的卷
docker volume prune
```

## 8. 资源

- **官方网站**：https://www.docker.com/
- **官方文档**：https://docs.docker.com/
- **Docker Hub**：https://hub.docker.com/ （官方镜像仓库）
- **Docker Compose 文档**：https://docs.docker.com/compose/
- **Docker Swarm 文档**：https://docs.docker.com/engine/swarm/
- **Dockerfile 参考**：https://docs.docker.com/engine/reference/builder/
- **Docker 命令参考**：https://docs.docker.com/engine/reference/commandline/cli/
- **Docker 最佳实践**：https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
- **Docker 社区**：https://www.docker.com/community

## 9. 总结

Docker 是一个强大的容器化平台，允许开发者将应用程序及其依赖项打包到轻量级、可移植的容器中，实现快速部署和扩展。它的核心优势包括轻量级、可移植性、隔离性、可扩展性和生态系统丰富。

本文档介绍了 Docker 的基础概念、安装方法、配置示例、常用命令、高级功能、使用示例和最佳实践，希望能帮助你快速上手 Docker，并在实际项目中灵活应用。

通过学习 Docker，你可以实现应用的快速部署、环境一致性、资源隔离和高效扩展，促进 DevOps 实践，提高开发和运维效率。随着对 Docker 的深入学习和实践，你会发现它的更多强大功能和便捷特性，从而构建出更加高效、可靠的应用架构。