# Nginx 文档

## 1. 基础概念

### 1.1 什么是 Nginx？

Nginx 是一个高性能的 HTTP 和反向代理服务器，同时也是一个 IMAP/POP3/SMTP 代理服务器。它以高性能、稳定性、丰富的功能集、简单的配置和低资源消耗而闻名。

### 1.2 Nginx 的特点

- **高性能**：采用事件驱动的异步非阻塞处理机制，能够处理大量并发连接
- **稳定性**：设计简洁，核心代码精简，运行稳定
- **丰富的功能**：支持 HTTP、HTTPS、反向代理、负载均衡、缓存、限流等
- **低资源消耗**：占用内存少，CPU 使用率低
- **模块化设计**：支持多种模块扩展
- **跨平台**：支持 Linux、Windows、macOS 等多种操作系统

### 1.3 Nginx 的应用场景

- **Web 服务器**：直接提供静态资源服务
- **反向代理**：将客户端请求转发到后端服务器
- **负载均衡**：将流量分配到多个后端服务器，提高系统可用性和性能
- **API 网关**：管理和路由 API 请求
- **静态资源缓存**：加速静态资源访问
- **SSL/TLS 终止**：处理 HTTPS 加密和解密
- **限流和访问控制**：保护后端服务，防止过载

## 2. 安装

### 2.1 Linux 系统安装

#### 2.1.1 Ubuntu/Debian

```bash
# 更新包列表
sudo apt update

# 安装 Nginx
sudo apt install nginx

# 检查 Nginx 状态
sudo systemctl status nginx

# 启动 Nginx
sudo systemctl start nginx

# 设置开机自启
sudo systemctl enable nginx
```

#### 2.1.2 CentOS/RHEL

```bash
# 安装 EPEL 仓库
sudo yum install epel-release

# 更新包列表
sudo yum update

# 安装 Nginx
sudo yum install nginx

# 检查 Nginx 状态
sudo systemctl status nginx

# 启动 Nginx
sudo systemctl start nginx

# 设置开机自启
sudo systemctl enable nginx
```

### 2.2 Windows 系统安装

1. 从 [Nginx 官网](http://nginx.org/en/download.html) 下载 Windows 版本
2. 解压到指定目录（如 `C:\nginx`）
3. 打开命令提示符，进入 Nginx 目录
4. 运行以下命令：

```bash
# 启动 Nginx
start nginx

# 停止 Nginx
nginx -s stop

# 重新加载配置
nginx -s reload

# 查看版本
nginx -v
```

### 2.3 macOS 系统安装

```bash
# 使用 Homebrew 安装
brew install nginx

# 启动 Nginx
brew services start nginx

# 停止 Nginx
brew services stop nginx

# 重启 Nginx
brew services restart nginx
```

## 3. 基本配置

### 3.1 配置文件结构

Nginx 的主配置文件通常位于：
- Linux：`/etc/nginx/nginx.conf`
- Windows：`conf/nginx.conf`
- macOS：`/usr/local/etc/nginx/nginx.conf`

配置文件结构：

```nginx
# 全局配置
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

# 事件配置
events {
    worker_connections 1024;
}

# HTTP 模块配置
http {
    include /etc/nginx/mime.types;
    default_type application/octet-stream;
    
    # 日志格式
    log_format main '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';
    
    access_log /var/log/nginx/access.log main;
    
    # 基本设置
    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;
    types_hash_max_size 2048;
    
    # 包含虚拟主机配置
    include /etc/nginx/conf.d/*.conf;
}
```

### 3.2 虚拟主机配置

虚拟主机允许在一台服务器上托管多个网站。配置文件通常位于 `/etc/nginx/conf.d/` 目录下，以 `.conf` 结尾。

#### 3.2.1 静态网站配置

```nginx
# /etc/nginx/conf.d/example.com.conf
server {
    listen 80;
    server_name example.com www.example.com;
    
    root /var/www/example.com;
    index index.html index.htm;
    
    location / {
        try_files $uri $uri/ =404;
    }
    
    # 日志配置
    access_log /var/log/nginx/example.com.access.log main;
    error_log /var/log/nginx/example.com.error.log;
}
```

#### 3.2.2 反向代理配置

```nginx
# /etc/nginx/conf.d/proxy.conf
server {
    listen 80;
    server_name proxy.example.com;
    
    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

#### 3.2.3 HTTPS 配置

```nginx
# /etc/nginx/conf.d/ssl.example.com.conf
server {
    listen 443 ssl http2;
    server_name ssl.example.com;
    
    # SSL 证书配置
    ssl_certificate /path/to/fullchain.pem;
    ssl_certificate_key /path/to/privkey.pem;
    
    # SSL 优化配置
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers off;
    ssl_session_cache shared:SSL:10m;
    ssl_session_timeout 10m;
    
    root /var/www/ssl.example.com;
    index index.html;
    
    location / {
        try_files $uri $uri/ =404;
    }
}

# HTTP 重定向到 HTTPS
server {
    listen 80;
    server_name ssl.example.com;
    return 301 https://$host$request_uri;
}
```

## 4. 高级配置

### 4.1 负载均衡

Nginx 支持多种负载均衡算法，常用的有：

- **轮询**：默认算法，按顺序分配请求
- **weight**：权重分配，权重越高，分配的请求越多
- **ip_hash**：根据客户端 IP 地址分配，同一 IP 始终分配到同一服务器
- **least_conn**：优先分配到连接数最少的服务器
- **fair**：根据服务器响应时间分配，响应时间短的优先

#### 4.1.1 负载均衡配置示例

```nginx
# 定义上游服务器组
upstream backend {
    # 轮询
    server backend1.example.com:8080;
    server backend2.example.com:8080;
    server backend3.example.com:8080;
    
    # 带权重
    # server backend1.example.com:8080 weight=3;
    # server backend2.example.com:8080 weight=2;
    # server backend3.example.com:8080 weight=1;
    
    # ip_hash
    # ip_hash;
    
    # least_conn
    # least_conn;
}

# 负载均衡服务器配置
server {
    listen 80;
    server_name loadbalance.example.com;
    
    location / {
        proxy_pass http://backend;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

### 4.2 静态资源缓存

```nginx
server {
    listen 80;
    server_name cache.example.com;
    
    root /var/www/cache.example.com;
    
    # 静态资源缓存配置
    location ~* \.(jpg|jpeg|png|gif|ico|css|js|woff|woff2|ttf|eot)$ {
        expires 7d;  # 缓存 7 天
        add_header Cache-Control "public, no-transform";
    }
    
    location / {
        try_files $uri $uri/ =404;
    }
}
```

### 4.3 限流配置

```nginx
# 定义限流策略
limit_req_zone $binary_remote_addr zone=mylimit:10m rate=10r/s;

server {
    listen 80;
    server_name limit.example.com;
    
    # 应用限流
    location / {
        limit_req zone=mylimit burst=20 nodelay;
        proxy_pass http://localhost:3000;
    }
}
```

### 4.4 访问控制

```nginx
server {
    listen 80;
    server_name restrict.example.com;
    
    # 允许特定 IP 访问
    location /admin {
        allow 192.168.1.0/24;
        allow 10.0.0.1;
        deny all;
        root /var/www/restrict.example.com/admin;
        index index.html;
    }
    
    location / {
        root /var/www/restrict.example.com;
        index index.html;
    }
}
```

## 5. 使用示例

### 5.1 部署静态网站

1. **创建网站目录**：
   ```bash
   sudo mkdir -p /var/www/mywebsite
   ```

2. **创建测试页面**：
   ```bash
   echo "<h1>Hello, Nginx!</h1>" | sudo tee /var/www/mywebsite/index.html
   ```

3. **创建 Nginx 配置文件**：
   ```nginx
   # /etc/nginx/conf.d/mywebsite.conf
   server {
       listen 80;
       server_name mywebsite.example.com;
       
       root /var/www/mywebsite;
       index index.html;
       
       location / {
           try_files $uri $uri/ =404;
       }
   }
   ```

4. **测试配置文件**：
   ```bash
   sudo nginx -t
   ```

5. **重新加载配置**：
   ```bash
   sudo systemctl reload nginx
   ```

6. **访问网站**：
   在浏览器中输入 `http://mywebsite.example.com` 或 `http://your-server-ip`

### 5.2 反向代理 Node.js 应用

1. **假设你有一个运行在 3000 端口的 Node.js 应用**

2. **创建反向代理配置**：
   ```nginx
   # /etc/nginx/conf.d/nodejs.conf
   server {
       listen 80;
       server_name nodejs.example.com;
       
       location / {
           proxy_pass http://localhost:3000;
           proxy_set_header Host $host;
           proxy_set_header X-Real-IP $remote_addr;
           proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
           proxy_set_header X-Forwarded-Proto $scheme;
       }
   }
   ```

3. **测试并重新加载配置**：
   ```bash
   sudo nginx -t
   sudo systemctl reload nginx
   ```

4. **访问应用**：
   在浏览器中输入 `http://nodejs.example.com`

## 6. 常用命令

```bash
# 检查配置文件语法
sudo nginx -t

# 重新加载配置
sudo nginx -s reload

# 停止 Nginx
sudo nginx -s stop

# 快速关闭 Nginx
sudo nginx -s quit

# 查看 Nginx 版本
sudo nginx -v

# 查看 Nginx 详细版本信息
sudo nginx -V

# 查看 Nginx 进程
sudo ps aux | grep nginx

# 查看 Nginx 监听端口
sudo netstat -tuln | grep nginx
# 或
sudo ss -tuln | grep nginx
```

## 7. 日志管理

### 7.1 日志位置

- **访问日志**：通常位于 `/var/log/nginx/access.log`
- **错误日志**：通常位于 `/var/log/nginx/error.log`

### 7.2 查看日志

```bash
# 查看访问日志
tail -f /var/log/nginx/access.log

# 查看错误日志
tail -f /var/log/nginx/error.log

# 查看特定网站的日志
tail -f /var/log/nginx/example.com.access.log
```

### 7.3 日志轮转

Nginx 日志会不断增长，需要定期轮转。在 Linux 系统中，可以使用 `logrotate` 工具来管理日志轮转。

默认的 logrotate 配置文件通常位于 `/etc/logrotate.d/nginx`：

```bash
/var/log/nginx/*.log {
    daily
    missingok
    rotate 52
    compress
    delaycompress
    notifempty
    create 0640 nginx adm
    sharedscripts
    postrotate
        if [ -f /var/run/nginx.pid ]; then
            kill -USR1 $(cat /var/run/nginx.pid)
        fi
    endscript
}
```

## 8. 最佳实践

### 8.1 性能优化

1. **调整 worker_processes**：设置为 CPU 核心数
   ```nginx
   worker_processes auto;
   ```

2. **调整 worker_connections**：根据系统资源调整，建议 1024-4096
   ```nginx
   events {
       worker_connections 2048;
   }
   ```

3. **启用 gzip 压缩**：
   ```nginx
   gzip on;
   gzip_types text/plain text/css application/json application/javascript text/xml application/xml text/javascript;
   gzip_min_length 1024;
   ```

4. **启用 sendfile**：
   ```nginx
   sendfile on;
   ```

5. **优化 TCP 连接**：
   ```nginx
   tcp_nopush on;
   tcp_nodelay on;
   ```

### 8.2 安全建议

1. **隐藏 Nginx 版本信息**：
   ```nginx
   server_tokens off;
   ```

2. **限制请求方法**：
   ```nginx
   if ($request_method !~ ^(GET|POST|HEAD)$) {
       return 405;
   }
   ```

3. **防止点击劫持**：
   ```nginx
   add_header X-Frame-Options SAMEORIGIN;
   ```

4. **防止 XSS 攻击**：
   ```nginx
   add_header X-XSS-Protection "1; mode=block";
   ```

5. **启用 HTTPS**：使用 Let's Encrypt 等免费证书

6. **定期更新 Nginx**：修复安全漏洞

7. **使用防火墙限制访问**：只允许必要的端口和 IP 访问

### 8.3 配置管理

1. **使用单独的配置文件**：为每个网站创建单独的配置文件，放在 `/etc/nginx/conf.d/` 目录下

2. **使用 include 指令**：将通用配置提取到单独的文件中，使用 include 引入

3. **备份配置文件**：定期备份 Nginx 配置文件

4. **使用版本控制**：将配置文件纳入版本控制系统（如 Git）

5. **测试配置文件**：在重新加载配置前，始终使用 `nginx -t` 测试配置文件语法

## 9. 常见问题

### 9.1 Nginx 无法启动

- **检查端口是否被占用**：
  ```bash
  sudo netstat -tuln | grep 80
  ```

- **检查配置文件语法**：
  ```bash
  sudo nginx -t
  ```

- **查看错误日志**：
  ```bash
  tail -f /var/log/nginx/error.log
  ```

### 9.2 403 Forbidden 错误

- **检查文件权限**：确保 Nginx 用户（通常是 nginx）有访问网站文件的权限
  ```bash
  sudo chown -R nginx:nginx /var/www/mywebsite
  sudo chmod -R 755 /var/www/mywebsite
  ```

- **检查 SELinux 设置**：如果 SELinux 处于 enforcing 模式，可能会限制 Nginx 访问文件
  ```bash
  sudo getenforce
  # 如果输出是 Enforcing，可以临时设置为 Permissive 测试
  sudo setenforce 0
  ```

### 9.3 502 Bad Gateway 错误

- **检查后端服务器是否运行**：
  ```bash
  curl http://localhost:3000
  ```

- **检查后端服务器日志**

- **检查 Nginx 配置中的 proxy_pass 地址是否正确**

## 10. 资源

- **官方网站**：http://nginx.org/
- **官方文档**：http://nginx.org/en/docs/
- **Nginx 中文文档**：http://www.nginx.cn/doc/
- **Let's Encrypt**：https://letsencrypt.org/ （免费 SSL 证书）
- **Nginx 配置生成器**：https://www.digitalocean.com/community/tools/nginx （在线生成 Nginx 配置）

## 11. 总结

Nginx 是一个功能强大、高性能的 Web 服务器和反向代理服务器，广泛应用于现代 Web 架构中。通过合理配置 Nginx，可以实现静态资源服务、反向代理、负载均衡、缓存、限流等多种功能。

本文档介绍了 Nginx 的基础概念、安装方法、配置示例、常用命令和最佳实践，希望能帮助你快速上手 Nginx，并在实际项目中灵活应用。

随着对 Nginx 深入学习和实践，你会发现它的更多强大功能和优化技巧，从而构建出高性能、高可用的 Web 服务架构。