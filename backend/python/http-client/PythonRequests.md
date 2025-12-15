# Python Requests 库

## 1. 概述

### 1.1 什么是 Requests
Requests 是 Python 中最流行的 HTTP 客户端库，用于发送 HTTP 请求和处理响应。它提供了简单易用的 API，能够处理各种 HTTP 方法、参数、 headers、cookies 和会话等。

### 1.2 Requests 的优势
- **简单易用**：API 设计简洁明了，学习曲线平缓
- **功能全面**：支持所有 HTTP 方法、会话管理、Cookie 处理等
- **自动处理编码**：自动处理 URL 编码和解码
- **自动处理 JSON**：内置 JSON 解析功能
- **支持文件上传和下载**：简单易用的文件上传和下载功能
- **支持会话管理**：支持持久会话，自动处理 Cookie
- **支持 HTTPS**：内置 SSL 证书验证

### 1.3 常见应用场景
- **Web API 调用**：与各种 RESTful API 交互
- **网页数据爬取**：抓取网页内容
- **自动化测试**：测试 Web 服务
- **文件上传和下载**：与文件服务器交互
- **OAuth 认证**：处理各种认证机制

## 2. 安装

### 2.1 基本安装
```bash
pip install requests
```

### 2.2 安装特定版本
```bash
pip install requests==2.32.3  # 安装特定版本
```

### 2.3 升级 Requests
```bash
pip install --upgrade requests
```

## 3. 核心概念

### 3.1 HTTP 方法
- **GET**：请求资源
- **POST**：提交数据，创建资源
- **PUT**：更新资源
- **PATCH**：部分更新资源
- **DELETE**：删除资源
- **HEAD**：只获取响应头
- **OPTIONS**：获取服务器支持的 HTTP 方法

### 3.2 请求组件
- **URL**：请求的资源地址
- **Headers**：请求头，包含客户端信息、认证信息等
- **Params**：URL 查询参数
- **Data**：表单数据
- **JSON**：JSON 数据
- **Files**：文件数据
- **Cookies**：Cookie 信息
- **Auth**：认证信息

### 3.3 响应组件
- **Status Code**：HTTP 状态码
- **Headers**：响应头
- **Content**：响应内容
- **Encoding**：响应内容编码
- **URL**：实际请求的 URL
- **History**：重定向历史

## 4. 基本使用

### 4.1 发送 GET 请求

#### 4.1.1 基本 GET 请求
```python
import requests

# 发送 GET 请求
response = requests.get('https://api.github.com')

# 查看响应状态码
print(f'状态码：{response.status_code}')

# 查看响应内容（字符串形式）
print(f'响应内容：{response.text}')

# 查看响应内容（二进制形式）
print(f'响应内容（二进制）：{response.content}')

# 查看响应头
print(f'响应头：{response.headers}')

# 查看编码
print(f'编码：{response.encoding}')

# 查看实际请求的 URL
print(f'实际 URL：{response.url}')

# 查看重定向历史
print(f'重定向历史：{response.history}')
```

#### 4.1.2 带参数的 GET 请求
```python
# 方式 1：直接在 URL 中添加参数
response = requests.get('https://api.github.com/search/repositories?q=python&sort=stars&order=desc')

# 方式 2：使用 params 参数
params = {
    'q': 'python',
    'sort': 'stars',
    'order': 'desc'
}
response = requests.get('https://api.github.com/search/repositories', params=params)

# 查看完整 URL
print(f'完整 URL：{response.url}')
```

#### 4.1.3 带 Headers 的 GET 请求
```python
headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
    'Accept': 'application/vnd.github.v3+json'
}

response = requests.get('https://api.github.com', headers=headers)
```

### 4.2 发送 POST 请求

#### 4.2.1 发送表单数据
```python
# 发送表单数据
payload = {
    'username': 'user123',
    'password': 'password123'
}

response = requests.post('https://httpbin.org/post', data=payload)
print(response.text)
```

#### 4.2.2 发送 JSON 数据
```python
# 方式 1：使用 json 参数（推荐）
payload = {
    'name': '张三',
    'age': 25,
    'email': 'zhangsan@example.com'
}

response = requests.post('https://httpbin.org/post', json=payload)
print(response.text)

# 方式 2：手动编码 JSON
import json
payload_json = json.dumps(payload)
response = requests.post('https://httpbin.org/post', data=payload_json, headers={'Content-Type': 'application/json'})
print(response.text)
```

#### 4.2.3 上传文件
```python
# 上传单个文件
files = {
    'file': open('example.txt', 'rb')
}

response = requests.post('https://httpbin.org/post', files=files)
print(response.text)

# 上传多个文件
files = [
    ('file1', open('example1.txt', 'rb')),
    ('file2', open('example2.txt', 'rb'))
]

response = requests.post('https://httpbin.org/post', files=files)
print(response.text)

# 上传文件并附加表单数据
payload = {'username': 'user123'}
files = {'file': open('example.txt', 'rb')}

response = requests.post('https://httpbin.org/post', data=payload, files=files)
print(response.text)
```

### 4.3 其他 HTTP 方法
```python
# PUT 请求
response = requests.put('https://httpbin.org/put', json={'name': '张三'})
print(response.text)

# DELETE 请求
response = requests.delete('https://httpbin.org/delete')
print(response.text)

# PATCH 请求
response = requests.patch('https://httpbin.org/patch', json={'name': '李四'})
print(response.text)

# HEAD 请求（只获取响应头）
response = requests.head('https://httpbin.org/get')
print(response.headers)

# OPTIONS 请求（获取服务器支持的 HTTP 方法）
response = requests.options('https://httpbin.org/get')
print(response.headers['Allow'])
```

## 5. 响应处理

### 5.1 处理 JSON 响应
```python
response = requests.get('https://api.github.com/repos/psf/requests')

# 方式 1：使用 json() 方法（推荐）
data = response.json()
print(f'仓库名称：{data["name"]}')
print(f'星标数：{data["stargazers_count"]}')
print(f'描述：{data["description"]}')

# 方式 2：手动解析 JSON
import json
data = json.loads(response.text)
print(f'仓库名称：{data["name"]}')
```

### 5.2 处理二进制响应
```python
# 下载图片
response = requests.get('https://www.example.com/image.jpg')
with open('image.jpg', 'wb') as f:
    f.write(response.content)

# 下载音频
response = requests.get('https://www.example.com/audio.mp3')
with open('audio.mp3', 'wb') as f:
    f.write(response.content)
```

### 5.3 处理文本响应
```python
# 获取网页内容
response = requests.get('https://www.example.com')
response.encoding = 'utf-8'  # 设置编码
print(response.text)
```

### 5.4 处理状态码
```python
response = requests.get('https://api.github.com/repos/psf/requests')

# 检查状态码
if response.status_code == 200:
    print('请求成功')
elif response.status_code == 404:
    print('资源不存在')
elif response.status_code == 500:
    print('服务器错误')

# 使用内置的状态码常量
if response.status_code == requests.codes.ok:
    print('请求成功')

# 抛出异常（如果请求失败）
try:
    response.raise_for_status()  # 如果状态码不是 2xx，抛出 HTTPError
    print('请求成功')
except requests.exceptions.HTTPError as e:
    print(f'请求失败：{e}')
except requests.exceptions.ConnectionError:
    print('连接错误')
except requests.exceptions.Timeout:
    print('请求超时')
except requests.exceptions.RequestException as e:
    print(f'请求异常：{e}')
```

## 6. 高级功能

### 6.1 会话管理
会话管理用于在多个请求之间保持状态（如 Cookie）：

```python
# 创建会话
with requests.Session() as session:
    # 登录（自动保存 Cookie）
    session.post('https://httpbin.org/post', data={'username': 'user123', 'password': 'password123'})
    
    # 后续请求会自动携带 Cookie
    response = session.get('https://httpbin.org/get')
    print(response.text)

# 设置会话级别的 Headers
with requests.Session() as session:
    session.headers.update({
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        'Accept': 'application/json'
    })
    
    response = session.get('https://api.github.com')
    print(response.text)
```

### 6.2 Cookie 处理
```python
# 获取 Cookie
response = requests.get('https://httpbin.org/cookies/set?name=value')
print(f'Cookie：{response.cookies}')

# 发送 Cookie
cookies = {'name': 'value', 'session_id': '123456'}
response = requests.get('https://httpbin.org/cookies', cookies=cookies)
print(response.text)

# 使用 RequestsCookieJar 管理 Cookie
jar = requests.cookies.RequestsCookieJar()
jar.set('name', 'value', domain='httpbin.org', path='/cookies')
jar.set('session_id', '123456', domain='httpbin.org', path='/')

response = requests.get('https://httpbin.org/cookies', cookies=jar)
print(response.text)
```

### 6.3 认证

#### 6.3.1 基本认证
```python
# 方式 1：使用 auth 参数
response = requests.get('https://httpbin.org/basic-auth/user/passwd', auth=('user', 'passwd'))
print(response.text)

# 方式 2：使用 HTTPBasicAuth
from requests.auth import HTTPBasicAuth
response = requests.get('https://httpbin.org/basic-auth/user/passwd', auth=HTTPBasicAuth('user', 'passwd'))
print(response.text)
```

#### 6.3.2 摘要认证
```python
from requests.auth import HTTPDigestAuth
response = requests.get('https://httpbin.org/digest-auth/auth/user/passwd', auth=HTTPDigestAuth('user', 'passwd'))
print(response.text)
```

#### 6.3.3 OAuth 认证
```python
# OAuth 2.0 令牌认证
headers = {
    'Authorization': 'Bearer YOUR_ACCESS_TOKEN'
}
response = requests.get('https://api.example.com/resource', headers=headers)
print(response.text)

# OAuth 1.0 认证（需要安装 requests-oauthlib）
pip install requests-oauthlib

from requests_oauthlib import OAuth1Session

client_key = 'YOUR_CLIENT_KEY'
client_secret = 'YOUR_CLIENT_SECRET'
resource_owner_key = 'YOUR_RESOURCE_OWNER_KEY'
resource_owner_secret = 'YOUR_RESOURCE_OWNER_SECRET'

oauth = OAuth1Session(client_key, client_secret, resource_owner_key, resource_owner_secret)
response = oauth.get('https://api.twitter.com/1.1/account/verify_credentials.json')
print(response.text)
```

### 6.4 超时设置
```python
# 设置超时（秒）
try:
    response = requests.get('https://httpbin.org/delay/5', timeout=3)  # 3 秒超时
    print('请求成功')
except requests.exceptions.Timeout:
    print('请求超时')

# 分别设置连接超时和读取超时
try:
    response = requests.get('https://httpbin.org/delay/5', timeout=(1, 3))  # 连接超时 1 秒，读取超时 3 秒
    print('请求成功')
except requests.exceptions.Timeout:
    print('请求超时')
```

### 6.5 代理设置
```python
# HTTP 代理
proxies = {
    'http': 'http://10.10.1.10:3128',
    'https': 'http://10.10.1.10:1080'
}

response = requests.get('https://httpbin.org/ip', proxies=proxies)
print(response.text)

# SOCKS 代理（需要安装 pysocks）
pip install pysocks

proxies = {
    'http': 'socks5://user:pass@host:port',
    'https': 'socks5://user:pass@host:port'
}

response = requests.get('https://httpbin.org/ip', proxies=proxies)
print(response.text)
```

### 6.6 SSL 证书验证
```python
# 默认验证 SSL 证书
response = requests.get('https://api.github.com')
print(response.status_code)

# 禁用 SSL 证书验证（不推荐）
response = requests.get('https://api.github.com', verify=False)
print(response.status_code)

# 指定 CA 证书
response = requests.get('https://api.github.com', verify='/path/to/cert.pem')
print(response.status_code)
```

## 7. 实用技巧

### 7.1 下载大文件
```python
# 分块下载大文件
url = 'https://example.com/large_file.zip'
chunk_size = 1024 * 1024  # 1MB

with requests.get(url, stream=True) as response:
    response.raise_for_status()
    with open('large_file.zip', 'wb') as f:
        for chunk in response.iter_content(chunk_size=chunk_size):
            f.write(chunk)
            print(f'下载了 {f.tell() / (1024*1024):.2f} MB')

print('下载完成')
```

### 7.2 并发请求
```python
# 使用线程池并发请求
import concurrent.futures

urls = [
    'https://api.github.com/repos/psf/requests',
    'https://api.github.com/repos/facebook/react',
    'https://api.github.com/repos/tensorflow/tensorflow',
    'https://api.github.com/repos/vuejs/vue',
    'https://api.github.com/repos/angular/angular'
]

def fetch_url(url):
    response = requests.get(url)
    response.raise_for_status()
    data = response.json()
    return {
        'name': data['name'],
        'stars': data['stargazers_count'],
        'language': data['language']
    }

with concurrent.futures.ThreadPoolExecutor(max_workers=5) as executor:
    results = list(executor.map(fetch_url, urls))

for result in results:
    print(f'{result["name"]:20} | 星标数: {result["stars"]:8} | 语言: {result["language"]}')

# 使用 asyncio 和 aiohttp 进行异步请求（更高效）
pip install aiohttp

import asyncio
import aiohttp

async def fetch_async(session, url):
    async with session.get(url) as response:
        data = await response.json()
        return {
            'name': data['name'],
            'stars': data['stargazers_count'],
            'language': data['language']
        }

async def main():
    async with aiohttp.ClientSession() as session:
        tasks = [fetch_async(session, url) for url in urls]
        results = await asyncio.gather(*tasks)
        return results

results = asyncio.run(main())
for result in results:
    print(f'{result["name"]:20} | 星标数: {result["stars"]:8} | 语言: {result["language"]}')
```

### 7.3 自定义请求
```python
# 使用 PreparedRequest 自定义请求
from requests import Request, Session

# 创建 Session
session = Session()

# 创建 Request 对象
req = Request('POST', 'https://httpbin.org/post',
              data={'username': 'user123'},
              headers={'User-Agent': 'Mozilla/5.0'})

# 准备请求（自动处理 URL 编码等）
prepped = session.prepare_request(req)

# 发送请求
response = session.send(prepped)
print(response.text)
```

## 8. 常见问题与解决方案

### 8.1 问题：请求超时
**解决方案**：
- 增加超时时间
- 检查网络连接
- 检查服务器状态
- 使用并发请求

### 8.2 问题：SSL 证书验证失败
**解决方案**：
- 确保证书有效
- 更新证书颁发机构列表
- 临时禁用验证（不推荐）

### 8.3 问题：编码错误
**解决方案**：
- 手动设置编码
- 使用 `response.encoding = 'utf-8'`

### 8.4 问题：403 Forbidden
**解决方案**：
- 检查认证信息
- 检查 User-Agent
- 检查 IP 是否被封禁

### 8.5 问题：404 Not Found
**解决方案**：
- 检查 URL 是否正确
- 检查资源是否存在

## 9. 最佳实践

### 9.1 代码规范
- 使用上下文管理器处理会话
- 处理异常
- 使用描述性变量名
- 添加注释
- 模块化设计

### 9.2 性能优化
- 使用会话管理
- 减少请求次数
- 使用并发请求
- 适当设置超时
- 避免不必要的数据传输

### 9.3 安全最佳实践
- 不要硬编码敏感信息
- 使用环境变量存储配置
- 验证 SSL 证书
- 使用安全的认证方式
- 限制请求速率

### 9.4 调试技巧
- 打印完整 URL
- 查看请求头和响应头
- 打印响应内容
- 使用 `logging` 模块记录请求信息

## 10. 相关资源

### 10.1 官方文档
- [Requests 官方文档](https://docs.python-requests.org/en/latest/)
- [Requests GitHub 仓库](https://github.com/psf/requests)

### 10.2 学习资源
- [Requests 快速入门](https://docs.python-requests.org/en/latest/user/quickstart/)
- [Requests 高级用法](https://docs.python-requests.org/en/latest/user/advanced/)
- [HTTP 权威指南](https://www.oreilly.com/library/view/http-the-definitive/1565925092/)

### 10.3 相关库
- **aiohttp**：异步 HTTP 客户端
- **httpx**：新一代 HTTP 客户端（支持同步和异步）
- **requests-oauthlib**：OAuth 认证支持
- **beautifulsoup4**：HTML 解析库
- **scrapy**：网页爬取框架

## 11. 总结

Requests 是 Python 中最流行的 HTTP 客户端库，提供了简单易用的 API，能够处理各种 HTTP 请求和响应。它支持所有 HTTP 方法、会话管理、Cookie 处理、文件上传和下载等功能，适用于各种 Web 开发和数据采集场景。

通过学习 Requests，你可以：
- 轻松调用各种 Web API
- 抓取网页内容
- 自动化测试 Web 服务
- 处理各种认证机制
- 高效处理并发请求

无论你是 Web 开发者、数据科学家还是自动化测试工程师，掌握 Requests 都将大大提高你的工作效率和开发能力。