# Caddy 文档

## 1. 基础概念

### 1.1 什么是 Caddy？

Caddy 是一个现代化的开源 Web 服务器，以自动 HTTPS 为主要特点，同时提供反向代理、负载均衡、静态文件服务等功能。它以简单易用的配置、自动 TLS 证书管理、高性能和安全性而闻名。

### 1.2 Caddy 的特点

- **自动 HTTPS**：默认启用 HTTPS，自动获取和续订 Let's Encrypt 证书
- **简单配置**：使用简洁的 Caddyfile 配置语法，易于学习和维护
- **高性能**：基于 Go 语言开发，采用事件驱动的异步架构
- **安全默认**：默认启用多种安全特性，如 HSTS、OCSP 装订等
- **跨平台**：支持 Linux、Windows、macOS、FreeBSD 等多种操作系统
- **可扩展**：支持多种插件扩展功能
- **现代化支持**：支持 HTTP/2、HTTP/3（QUIC）、WebSocket 等

### 1.3 Caddy 的应用场景

- **Web 服务器**：直接提供静态资源服务
- **反向代理**：将客户端请求转发到后端服务器
- **负载均衡**：将流量分配到多个后端服务器
- **API 网关**：管理和路由 API 请求
- **静态资源缓存**：加速静态资源访问
- **SSL/TLS 终止**：处理 HTTPS 加密和解密
- **WebSocket 代理**：支持 WebSocket 应用

## 2. 安装

### 2.1 Linux 系统安装

#### 2.1.1 Ubuntu/Debian

```bash
# 添加 Caddy 官方仓库
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list

# 更新包列表并安装 Caddy
sudo apt update
sudo apt install caddy

# 检查 Caddy 状态
sudo systemctl status caddy

# 启动 Caddy
sudo systemctl start caddy

# 设置开机自启
sudo systemctl enable caddy
```

#### 2.1.2 CentOS/RHEL

```bash
# 添加 Caddy 官方仓库
sudo dnf install -y 'dnf-command(copr)'
sudo dnf copr enable @caddy/caddy

# 安装 Caddy
sudo dnf install caddy

# 检查 Caddy 状态
sudo systemctl status caddy

# 启动 Caddy
sudo systemctl start caddy

# 设置开机自启
sudo systemctl enable caddy
```

### 2.2 Windows 系统安装

#### 2.2.1 使用安装程序

1. 从 [Caddy 官网](https://caddyserver.com/download) 下载 Windows 安装程序
2. 运行安装程序，按照提示完成安装
3. 安装完成后，Caddy 将作为服务自动启动

#### 2.2.2 使用 Chocolatey

```bash
# 使用 Chocolatey 安装 Caddy
choco install caddy
```

### 2.3 macOS 系统安装

#### 2.3.1 使用 Homebrew

```bash
# 使用 Homebrew 安装 Caddy
brew install caddy

# 启动 Caddy 服务
brew services start caddy

# 停止 Caddy 服务
brew services stop caddy

# 重启 Caddy 服务
brew services restart caddy
```

### 2.4 二进制文件安装

从 [Caddy 官网](https://caddyserver.com/download) 下载适用于您系统的二进制文件，然后解压并使用：

```bash
# 下载 Caddy
curl -O -L https://caddyserver.com/api/download?os=linux&arch=amd64

# 解压
mkdir -p caddy
mv download* caddy/caddy.tar.gz
cd caddy
tar -xzf caddy.tar.gz

# 赋予执行权限
chmod +x caddy

# 移动到系统路径
sudo mv caddy /usr/local/bin/

# 验证安装
caddy version
```

## 3. 基本配置

### 3.1 配置文件

Caddy 支持两种配置方式：

1. **Caddyfile**：简单易用的文本配置文件，适合大多数场景
2. **JSON**：结构化配置，适合复杂场景和自动化配置

### 3.2 Caddyfile 基础语法

Caddyfile 是 Caddy 的默认配置文件，使用简洁的语法：

```caddy
# 注释以 # 开头

# 站点配置
example.com {
    # 配置指令
    root * /var/www/example.com
    file_server
}
```

### 3.3 Caddyfile 结构

一个典型的 Caddyfile 包含以下部分：

1. **全局选项**：配置 Caddy 服务器的全局设置
2. **站点块**：配置一个或多个站点
3. **指令**：定义站点的具体行为

### 3.4 核心指令

#### 3.4.1 基础指令

- **root**：设置站点的根目录
  ```caddy
  root * /var/www/example.com
  ```

- **file_server**：启用静态文件服务
  ```caddy
  file_server
  ```

- **reverse_proxy**：启用反向代理
  ```caddy
  reverse_proxy localhost:3000
  ```

- **encode**：启用响应压缩
  ```caddy
  encode gzip zstd
  ```

- **log**：配置日志
  ```caddy
  log {
      output file /var/log/caddy/example.com.log
      format json
  }
  ```

- **tls**：配置 TLS 证书
  ```caddy
  tls admin@example.com
  ```

### 3.5 基本配置示例

#### 3.5.1 静态网站配置

```caddy
# 简单的静态网站配置
example.com {
    root * /var/www/example.com
    file_server
    encode gzip zstd
}
```

#### 3.5.2 HTTPS 配置（自动）

```caddy
# Caddy 会自动获取和续订 Let's Encrypt 证书
secure.example.com {
    root * /var/www/secure.example.com
    file_server
    encode gzip zstd
    # 自动使用 Let's Encrypt 证书
    tls admin@example.com
}
```

#### 3.5.3 HTTP 重定向到 HTTPS

```caddy
# HTTP 重定向到 HTTPS
http://example.com {
    redir https://{host}{uri} permanent
}

https://example.com {
    root * /var/www/example.com
    file_server
}
```

## 4. 高级配置

### 4.1 反向代理

#### 4.1.1 基本反向代理

```caddy
# 反向代理到单个后端服务器
proxy.example.com {
    reverse_proxy localhost:3000
}
```

#### 4.1.2 反向代理高级配置

```caddy
proxy.example.com {
    reverse_proxy {
        to localhost:3000 localhost:3001
        # 负载均衡算法：random, least_conn, round_robin（默认）
        lb_policy least_conn
        # 健康检查
        health_uri /health
        health_interval 30s
        health_timeout 5s
        # 代理头设置
        header_up Host {host}
        header_up X-Real-IP {remote_host}
        header_up X-Forwarded-For {remote_host}
        header_up X-Forwarded-Proto {scheme}
    }
}
```

### 4.2 负载均衡

```caddy
# 负载均衡配置
loadbalance.example.com {
    reverse_proxy {
        # 后端服务器组
        to backend1:8080 backend2:8080 backend3:8080
        # 负载均衡算法
        lb_policy round_robin
        # 粘性会话
        sticky_cookie {
            name mycookie
            expires 24h
            http_only
            secure
        }
    }
}
```

### 4.3 静态资源缓存

```caddy
# 静态资源缓存配置
cache.example.com {
    root * /var/www/cache.example.com
    
    # 缓存静态资源
    handle_path /*.{css,js,png,jpg,jpeg,gif,ico,svg,woff,woff2,ttf,eot} {
        file_server
        # 浏览器缓存 7 天
        header Cache-Control "public, max-age=604800"
    }
    
    # 其他资源
    handle {
        file_server
    }
}
```

### 4.4 限流配置

```caddy
# 限流配置
limit.example.com {
    # 按 IP 限流：每秒 10 个请求
    rate_limit {remote_host} 10r/s
    
    reverse_proxy localhost:3000
}
```

### 4.5 访问控制

```caddy
# 访问控制配置
restrict.example.com {
    # 允许特定 IP 访问
    @internal {
        remote_ip 192.168.1.0/24 10.0.0.1
    }
    
    # 拒绝其他 IP 访问 /admin 路径
    @admin {
        path /admin/*
        not remote_ip 192.168.1.0/24 10.0.0.1
    }
    
    handle @admin {
        respond "Access denied" 403
    }
    
    # 其他请求正常处理
    handle {
        reverse_proxy localhost:3000
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
   echo "<h1>Hello, Caddy!</h1>" | sudo tee /var/www/mywebsite/index.html
   ```

3. **创建 Caddyfile**：
   ```caddy
   # /etc/caddy/Caddyfile
   mywebsite.example.com {
       root * /var/www/mywebsite
       file_server
       encode gzip zstd
       log {
           output file /var/log/caddy/mywebsite.log
           format json
       }
   }
   ```

4. **测试配置**：
   ```bash
   sudo caddy validate
   ```

5. **重新加载配置**：
   ```bash
   sudo systemctl reload caddy
   ```

6. **访问网站**：
   在浏览器中输入 `https://mywebsite.example.com`（Caddy 会自动配置 HTTPS）

### 5.2 反向代理 Node.js 应用

```caddy
# /etc/caddy/Caddyfile
nodeapp.example.com {
    reverse_proxy localhost:3000 {
        header_up Host {host}
        header_up X-Real-IP {remote_host}
        header_up X-Forwarded-For {remote_host}
        header_up X-Forwarded-Proto {scheme}
    }
    encode gzip zstd
    log {
        output file /var/log/caddy/nodeapp.log
        format json
    }
}
```

### 5.3 反向代理 PHP 应用

```caddy
# /etc/caddy/Caddyfile
phpapp.example.com {
    root * /var/www/phpapp
    php_fastcgi unix//run/php/php8.1-fpm.sock
    file_server
    encode gzip zstd
    log {
        output file /var/log/caddy/phpapp.log
        format json
    }
}
```

### 5.4 WebSocket 代理

```caddy
# /etc/caddy/Caddyfile
websocket.example.com {
    reverse_proxy localhost:8080 {
        # WebSocket 支持（默认启用）
        transport http {
            keepalive_interval 2m
            keepalive_idle_timeout 2h
        }
    }
    encode gzip zstd
}
```

## 6. 常用命令

```bash
# 查看 Caddy 版本
caddy version

# 验证配置文件
caddy validate --config /etc/caddy/Caddyfile

# 启动 Caddy（前台运行）
caddy run --config /etc/caddy/Caddyfile

# 启动 Caddy（后台运行）
caddy start --config /etc/caddy/Caddyfile

# 停止 Caddy
caddy stop

# 重新加载配置
caddy reload --config /etc/caddy/Caddyfile

# 查看 Caddy 状态
caddy status

# 查看 Caddy 进程
ps aux | grep caddy

# 查看 Caddy 监听端口
netstat -tuln | grep caddy
# 或
ss -tuln | grep caddy
```

## 7. 日志管理

### 7.1 日志配置

在 Caddyfile 中配置日志：

```caddy
# 简单日志配置
example.com {
    log {
        output file /var/log/caddy/example.com.log
        format json
    }
    
    root * /var/www/example.com
    file_server
}

# 高级日志配置
example.com {
    log {
        # 日志输出位置：file, stdout, stderr, syslog
        output file /var/log/caddy/example.com.log {
            # 日志轮转配置
            roll_size 100mb
            roll_keep 10
            roll_keep_for 720h  # 30 天
        }
        
        # 日志格式：json, console, single_field
        format json {
            time_format iso8601
        }
        
        # 日志级别：debug, info, warn, error
        level info
        
        # 过滤日志
        filter {
            status >= 400
        }
    }
    
    root * /var/www/example.com
    file_server
}
```

### 7.2 查看日志

```bash
# 查看日志
tail -f /var/log/caddy/example.com.log

# 查看 JSON 日志（使用 jq 工具格式化）
tail -f /var/log/caddy/example.com.log | jq

# 查看错误日志
grep -i error /var/log/caddy/example.com.log
```

## 8. 最佳实践

### 8.1 性能优化

1. **启用压缩**：
   ```caddy
   encode gzip zstd
   ```

2. **启用浏览器缓存**：
   ```caddy
   @static {
       file
       path *.css *.js *.png *.jpg *.jpeg *.gif *.ico *.svg *.woff *.woff2 *.ttf *.eot
   }
   header @static Cache-Control "public, max-age=604800"
   ```

3. **使用 HTTP/3**：
   ```caddy
   # 全局启用 HTTP/3
   {
       servers {
           protocol {
               experimental_http3
           }
       }
   }
   ```

4. **优化 TLS 配置**：
   ```caddy
   tls {
       protocols tls1.2 tls1.3
       ciphers TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
       curves X25519 P-256
       alpn h2 http/1.1
   }
   ```

### 8.2 安全建议

1. **使用强密码保护管理界面**：
   ```caddy
   admin {
       address localhost:2019
       auth admin {
           password_hash $2a$10$G4Q4vjA7R9C8B8D7E6F5A4B3C2D1E0F9A8B7C6D5E4F3A2B1C0D9E8F7G6H5I4J3K2L1M0N9O8P7Q6R5S4T3U2V1W0X9Y8Z7
       }
   }
   ```

2. **启用 HSTS**：
   ```caddy
   header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload"
   ```

3. **防止点击劫持**：
   ```caddy
   header X-Frame-Options SAMEORIGIN
   ```

4. **防止 XSS 攻击**：
   ```caddy
   header X-XSS-Protection "1; mode=block"
   ```

5. **防止 MIME 类型嗅探**：
   ```caddy
   header X-Content-Type-Options nosniff
   ```

### 8.3 配置管理

1. **使用版本控制**：将 Caddyfile 纳入版本控制系统（如 Git）

2. **分离配置文件**：将不同站点的配置分离到不同文件，便于管理
   ```bash
   # 使用 include 指令包含其他配置文件
   include /etc/caddy/conf.d/*.caddy
   ```

3. **定期备份配置文件**：
   ```bash
   sudo cp /etc/caddy/Caddyfile /etc/caddy/Caddyfile.bak.$(date +%Y%m%d)
   ```

4. **使用环境变量**：在 Caddyfile 中使用环境变量，便于不同环境的配置管理
   ```caddy
   example.com {
       root * {$WEBROOT}
       file_server
   }
   ```

## 9. 常见问题

### 9.1 Caddy 无法启动

- **检查配置文件语法**：
  ```bash
  sudo caddy validate
  ```

- **查看 Caddy 日志**：
  ```bash
  sudo journalctl -u caddy
  ```

- **检查端口是否被占用**：
  ```bash
  sudo netstat -tuln | grep 80
  sudo netstat -tuln | grep 443
  ```

### 9.2 自动 HTTPS 失败

- **检查域名解析**：确保域名已正确解析到服务器 IP
  ```bash
  nslookup example.com
  ```

- **检查服务器防火墙**：确保端口 80 和 443 已开放
  ```bash
  sudo ufw status
  ```

- **检查 Let's Encrypt 速率限制**：Let's Encrypt 对每个域名有速率限制

- **查看 Caddy 日志**：
  ```bash
  sudo journalctl -u caddy | grep -i letsencrypt
  ```

### 9.3 反向代理返回 502 Bad Gateway

- **检查后端服务器是否运行**：
  ```bash
  curl http://localhost:3000
  ```

- **检查后端服务器日志**

- **检查 Caddy 配置中的后端地址是否正确**

## 10. 资源

- **官方网站**：https://caddyserver.com/
- **官方文档**：https://caddyserver.com/docs/
- **Caddyfile 指令文档**：https://caddyserver.com/docs/caddyfile/directives
- **Let's Encrypt**：https://letsencrypt.org/ （免费 SSL 证书）
- **Caddy 社区**：https://caddy.community/ （论坛和讨论）
- **Caddy 插件**：https://caddyserver.com/docs/json/apps/http/servers/routes/handlers/ （官方插件列表）

## 11. 总结

Caddy 是一个现代化、易用、安全的 Web 服务器，以自动 HTTPS 为主要特点。通过简洁的 Caddyfile 配置，可以轻松实现静态网站服务、反向代理、负载均衡等功能。

本文档介绍了 Caddy 的基础概念、安装方法、配置示例、常用命令和最佳实践，希望能帮助你快速上手 Caddy，并在实际项目中灵活应用。

Caddy 的自动 HTTPS 功能和简单配置使其成为现代 Web 开发的理想选择，特别适合需要快速部署安全网站的场景。随着对 Caddy 的深入学习和实践，你会发现它的更多强大功能和便捷特性。