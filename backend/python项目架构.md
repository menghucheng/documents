# Python 项目架构

## 1. 典型 Python 项目结构

### 1.1 基础项目结构

```
my_project/
├── src/                      # 源代码目录
│   └── my_package/           # 主包目录
│       ├── __init__.py      # 包初始化文件
│       ├── module1.py       # 模块1
│       ├── module2.py       # 模块2
│       └── utils/           # 工具子包
│           ├── __init__.py
│           └── helpers.py
├── tests/                    # 测试目录
│   ├── __init__.py
│   ├── test_module1.py
│   └── test_module2.py
├── docs/                     # 文档目录
├── examples/                 # 示例代码目录
├── scripts/                  # 脚本目录
├── .gitignore                # Git 忽略文件
├── README.md                 # 项目说明文件
├── LICENSE                   # 许可证文件
├── pyproject.toml            # 项目配置文件（PEP 621）
├── setup.py                  # 安装脚本（传统方式）
├── requirements.txt          # 依赖列表
├── requirements-dev.txt      # 开发依赖列表
└── .env                      # 环境变量配置文件
```

### 1.2 各目录用途说明

| 目录/文件 | 用途 |
|-----------|------|
| `src/` | 源代码目录，包含所有 Python 模块和包 |
| `tests/` | 测试代码目录，包含单元测试、集成测试等 |
| `docs/` | 项目文档，如 API 文档、用户手册等 |
| `examples/` | 示例代码，展示如何使用项目 |
| `scripts/` | 辅助脚本，如部署脚本、数据处理脚本等 |
| `.gitignore` | 指定 Git 忽略的文件和目录 |
| `README.md` | 项目说明，包含项目介绍、安装、使用等信息 |
| `LICENSE` | 项目许可证 |
| `pyproject.toml` | 现代 Python 项目配置文件，包含构建、依赖等配置 |
| `setup.py` | 传统的项目安装脚本 |
| `requirements.txt` | 生产环境依赖列表 |
| `requirements-dev.txt` | 开发环境依赖列表 |
| `.env` | 环境变量配置文件，包含敏感信息 |

## 2. pyproject.toml 文件

### 2.1 什么是 pyproject.toml

`pyproject.toml` 是 PEP 621 中定义的现代 Python 项目配置文件，用于替代传统的 `setup.py`、`setup.cfg` 等配置文件。它使用 TOML 格式，包含项目的元数据、构建配置、依赖等信息。

### 2.2 pyproject.toml 基本结构

```toml
[build-system]
requires = ["setuptools>=61.0"]
build-backend = "setuptools.build_meta"

[project]
name = "my-package"
version = "0.1.0"
authors = [
  { name = "Author Name", email = "author@example.com" },
]
description = "A short description of the package"
readme = "README.md"
requires-python = ">=3.8"
classifiers = [
  "Programming Language :: Python :: 3",
  "License :: OSI Approved :: MIT License",
  "Operating System :: OS Independent",
]

[project.dependencies]
pandas = ">=1.3.0"
requests = "^2.28.0"

[project.dev-dependencies]
pytest = ">=7.0.0"
black = "^22.0.0"
flake8 = "^4.0.0"

[project.scripts]
my-script = "my_package.module1:main"

[tool.black]
line-length = 88
target-version = ['py38']

[tool.flake8]
extend-ignore = ["E203", "W503"]
```

### 2.3 主要配置段说明

#### 2.3.1 `[build-system]`
- 定义构建系统的要求
- `requires`: 构建项目所需的工具和版本
- `build-backend`: 构建后端，如 `setuptools.build_meta`、`poetry.core.masonry.api` 等

#### 2.3.2 `[project]`
- 项目元数据，如名称、版本、作者、描述等
- `name`: 项目名称
- `version`: 项目版本
- `authors`: 作者信息
- `description`: 项目简短描述
- `readme`: 项目说明文件
- `requires-python`: 项目所需的 Python 版本
- `classifiers`: 项目分类标签

#### 2.3.3 `[project.dependencies]`
- 项目生产依赖
- 支持多种版本约束格式：
  - `>=`: 大于等于指定版本
  - `<=`: 小于等于指定版本
  - `==`: 等于指定版本
  - `^`: 兼容版本（如 ^2.28.0 表示 2.28.0 <= version < 3.0.0）
  - `~`: 近似版本（如 ~2.28.0 表示 2.28.0 <= version < 2.29.0）

#### 2.3.4 `[project.dev-dependencies]`
- 项目开发依赖，如测试工具、代码格式化工具等

#### 2.3.5 `[project.scripts]`
- 定义命令行脚本
- 格式：`脚本名称 = "模块路径:函数名"`

#### 2.3.6 `[tool.*]`
- 第三方工具的配置，如 `black`、`flake8`、`pytest` 等

### 2.4 使用 pyproject.toml 的优势

- 统一的项目配置文件，替代多个配置文件
- 支持现代 Python 构建工具（如 pip、build、setuptools）
- 清晰的配置结构
- 支持环境隔离和依赖管理
- 符合 PEP 标准，具有良好的兼容性

## 3. .env 文件与环境变量

### 3.1 什么是 .env 文件

`.env` 文件是一个简单的文本文件，用于存储项目的环境变量。它通常包含敏感信息，如数据库连接字符串、API 密钥等，不应提交到版本控制系统。

### 3.2 .env 文件格式

```env
# 数据库配置
DATABASE_URL="postgresql://user:password@localhost:5432/mydb"

# API 配置
API_KEY="your_api_key_here"
API_URL="https://api.example.com/v1"

# 应用配置
DEBUG=True
SECRET_KEY="your_secret_key_here"
PORT=8000
```

### 3.3 如何使用 .env 文件

#### 3.3.1 使用 python-dotenv 库

`python-dotenv` 是一个流行的库，用于从 `.env` 文件加载环境变量。

**安装：**
```bash
pip install python-dotenv
```

**使用：**

```python
# 在项目入口文件中加载
from dotenv import load_dotenv
import os

# 加载 .env 文件
load_dotenv()

# 访问环境变量
database_url = os.getenv("DATABASE_URL")
api_key = os.getenv("API_KEY")
debug = os.getenv("DEBUG", "False").lower() == "true"
port = int(os.getenv("PORT", 8000))
```

#### 3.3.2 使用 pydantic-settings

`pydantic-settings` 是 Pydantic 的扩展库，用于管理应用程序设置，支持从环境变量和配置文件加载。

**安装：**
```bash
pip install pydantic-settings
```

**使用：**

```python
from pydantic_settings import BaseSettings
from typing import Optional

class Settings(BaseSettings):
    # 数据库配置
    database_url: str
    
    # API 配置
    api_key: str
    api_url: str = "https://api.example.com/v1"
    
    # 应用配置
    debug: bool = False
    secret_key: str
    port: int = 8000
    
    class Config:
        env_file = ".env"
        env_file_encoding = "utf-8"

# 创建设置实例
settings = Settings()

# 使用设置
print(settings.database_url)
print(settings.debug)
print(settings.port)
```

### 3.4 .env 文件最佳实践

1. **不要将 .env 文件提交到版本控制系统**：
   - 在 `.gitignore` 中添加 `.env`
   - 提供 `.env.example` 模板文件

2. **使用不同的 .env 文件用于不同环境**：
   - `.env.development`：开发环境
   - `.env.test`：测试环境
   - `.env.production`：生产环境

3. **使用类型安全的方式访问环境变量**：
   - 使用 `pydantic-settings` 或类似库进行类型验证
   - 避免直接使用 `os.environ`

4. **为所有环境变量设置合理的默认值**：
   - 非敏感配置可以设置默认值
   - 敏感配置必须在环境中提供

## 4. 配置读取方法

### 4.1 基于文件的配置

#### 4.1.1 使用 JSON 配置文件

```python
import json
import os

def load_config():
    config_path = os.path.join(os.path.dirname(__file__), "config.json")
    with open(config_path, "r", encoding="utf-8") as f:
        return json.load(f)

config = load_config()
print(config["database"]["host"])
```

**config.json 示例：**
```json
{
  "database": {
    "host": "localhost",
    "port": 5432,
    "name": "mydb",
    "user": "user",
    "password": "password"
  },
  "api": {
    "key": "api_key",
    "url": "https://api.example.com/v1"
  }
}
```

#### 4.1.2 使用 YAML 配置文件

**安装：**
```bash
pip install pyyaml
```

**使用：**
```python
import yaml
import os

def load_config():
    config_path = os.path.join(os.path.dirname(__file__), "config.yaml")
    with open(config_path, "r", encoding="utf-8") as f:
        return yaml.safe_load(f)

config = load_config()
print(config["database"]["host"])
```

**config.yaml 示例：**
```yaml
database:
  host: localhost
  port: 5432
  name: mydb
  user: user
  password: password

api:
  key: api_key
  url: https://api.example.com/v1
```

### 4.2 基于环境变量的配置

#### 4.2.1 使用 os 模块

```python
import os

class Config:
    # 数据库配置
    DATABASE_HOST = os.getenv("DATABASE_HOST", "localhost")
    DATABASE_PORT = int(os.getenv("DATABASE_PORT", "5432"))
    DATABASE_NAME = os.getenv("DATABASE_NAME", "mydb")
    DATABASE_USER = os.getenv("DATABASE_USER", "user")
    DATABASE_PASSWORD = os.getenv("DATABASE_PASSWORD", "")
    
    # API 配置
    API_KEY = os.getenv("API_KEY", "")
    API_URL = os.getenv("API_URL", "https://api.example.com/v1")
    
    # 应用配置
    DEBUG = os.getenv("DEBUG", "False").lower() == "true"
    SECRET_KEY = os.getenv("SECRET_KEY", "")
    PORT = int(os.getenv("PORT", "8000"))

config = Config()
```

#### 4.2.2 使用 pydantic-settings

如 3.3.2 节所示，`pydantic-settings` 提供了强大的环境变量管理功能。

### 4.3 基于配置中心的配置

对于大型项目，可以使用配置中心来管理配置，如 Consul、Etcd、Spring Cloud Config 等。

**使用 python-consul 示例：**

```bash
pip install python-consul
```

```python
import consul

class ConfigCenter:
    def __init__(self, host="localhost", port=8500):
        self.consul = consul.Consul(host=host, port=port)
    
    def get_config(self, key):
        index, data = self.consul.kv.get(key)
        if data:
            return data["Value"].decode("utf-8")
        return None

config_center = ConfigCenter()
database_url = config_center.get_config("my_project/database/url")
```

## 5. VSCode 配置文件

### 5.1 settings.json

`settings.json` 是 VSCode 的配置文件，用于自定义编辑器行为。

#### 5.1.1 全局设置 vs 工作区设置

- **全局设置**：对所有项目生效，位于 `~/.config/Code/User/settings.json`（Linux/macOS）或 `%APPDATA%\Code\User\settings.json`（Windows）
- **工作区设置**：仅对当前工作区生效，位于 `.vscode/settings.json`

#### 5.1.2 常用 Python 相关配置

```json
{
    "python.pythonPath": "${workspaceFolder}/.venv/bin/python",
    "python.venvPath": "${workspaceFolder}/.venv",
    "python.analysis.extraPaths": ["${workspaceFolder}/src"],
    "python.linting.enabled": true,
    "python.linting.pylintEnabled": false,
    "python.linting.flake8Enabled": true,
    "python.linting.mypyEnabled": true,
    "python.formatting.provider": "black",
    "python.formatting.blackPath": "${workspaceFolder}/.venv/bin/black",
    "python.formatting.blackArgs": ["--line-length", "88"],
    "python.testing.pytestEnabled": true,
    "python.testing.unittestEnabled": false,
    "python.testing.pytestPath": "${workspaceFolder}/.venv/bin/pytest",
    "python.testing.pytestArgs": ["tests/"],
    "files.exclude": {
        "**/.venv": true,
        "**/__pycache__": true,
        "**/*.pyc": true,
        "**/*.pyo": true,
        "**/*.pyd": true,
        "**/.pytest_cache": true,
        "**/.mypy_cache": true,
        "**/.black": true
    },
    "files.watcherExclude": {
        "**/.venv/**": true,
        "**/__pycache__/**": true
    }
}
```

### 5.2 launch.json

`launch.json` 是 VSCode 的调试配置文件，用于配置调试器。

#### 5.2.1 常用 Python 调试配置

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: Flask",
            "type": "python",
            "request": "launch",
            "module": "flask",
            "env": {
                "FLASK_APP": "src/my_package/app.py",
                "FLASK_ENV": "development"
            },
            "args": [
                "run",
                "--no-debugger",
                "--no-reload"
            ],
            "jinja": true,
            "justMyCode": true
        },
        {
            "name": "Python: Django",
            "type": "python",
            "request": "launch",
            "program": "${workspaceFolder}/manage.py",
            "args": [
                "runserver",
                "--noreload"
            ],
            "django": true,
            "justMyCode": true
        },
        {
            "name": "Python: Module",
            "type": "python",
            "request": "launch",
            "module": "my_package.module1",
            "justMyCode": true
        },
        {
            "name": "Python: Current File",
            "type": "python",
            "request": "launch",
            "program": "${file}",
            "console": "integratedTerminal",
            "justMyCode": true
        },
        {
            "name": "Python: pytest",
            "type": "python",
            "request": "launch",
            "module": "pytest",
            "args": [
                "${file}",
                "-v"
            ],
            "console": "integratedTerminal",
            "justMyCode": true
        }
    ]
}
```

### 5.3 tasks.json

`tasks.json` 是 VSCode 的任务配置文件，用于定义自动化任务。

#### 5.3.1 常用 Python 任务配置

```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "install-deps",
            "type": "shell",
            "command": "pip install -r requirements.txt -r requirements-dev.txt",
            "group": {
                "kind": "build",
                "isDefault": true
            },
            "presentation": {
                "reveal": "always",
                "panel": "new"
            },
            "problemMatcher": []
        },
        {
            "label": "run-tests",
            "type": "shell",
            "command": "pytest tests/ -v",
            "group": {
                "kind": "test",
                "isDefault": true
            },
            "presentation": {
                "reveal": "always",
                "panel": "new"
            },
            "problemMatcher": []
        },
        {
            "label": "format-code",
            "type": "shell",
            "command": "black src/ tests/",
            "group": {
                "kind": "format",
                "isDefault": true
            },
            "presentation": {
                "reveal": "always",
                "panel": "new"
            },
            "problemMatcher": []
        },
        {
            "label": "lint-code",
            "type": "shell",
            "command": "flake8 src/ tests/",
            "group": {
                "kind": "test"
            },
            "presentation": {
                "reveal": "always",
                "panel": "new"
            },
            "problemMatcher": [
                {
                    "owner": "python",
                    "fileLocation": ["relative", "${workspaceFolder}"],
                    "pattern": {
                        "regexp": "^(.*):(\d+):(\d+):\\s*([A-Z]\\d+)\\s*(.*)$",
                        "file": 1,
                        "line": 2,
                        "column": 3,
                        "code": 4,
                        "message": 5
                    }
                }
            ]
        },
        {
            "label": "type-check",
            "type": "shell",
            "command": "mypy src/",
            "group": {
                "kind": "test"
            },
            "presentation": {
                "reveal": "always",
                "panel": "new"
            },
            "problemMatcher": []
        }
    ]
}
```

### 5.4 VSCode 配置最佳实践

1. **使用工作区配置**：
   - 将配置文件放在 `.vscode/` 目录下
   - 提交到版本控制系统，确保团队成员使用相同的配置

2. **使用变量**：
   - 使用 `${workspaceFolder}` 表示工作区根目录
   - 使用 `${file}` 表示当前文件
   - 使用 `${relativeFile}` 表示当前文件相对于工作区的路径

3. **配置调试器**：
   - 为不同的运行场景配置不同的调试配置
   - 使用环境变量配置不同环境

4. **配置任务**：
   - 为常用操作配置任务，如安装依赖、运行测试、格式化代码等
   - 使用 `group` 字段组织任务

5. **使用扩展配置**：
   - 为 Python、Django、Flask 等扩展配置特定选项
   - 使用 `python.analysis.extraPaths` 添加源代码路径

## 5. Python 项目测试

### 5.1 测试框架

#### 5.1.1 pytest

pytest 是目前 Python 生态中最流行的测试框架，具有简洁的语法和强大的功能。

**安装：**
```bash
pip install pytest pytest-cov pytest-mock
```

**基本测试示例：**
```python
# tests/test_module1.py

def test_add():
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
    assert add(0, 0) == 0

def test_divide():
    assert divide(10, 2) == 5
    
    # 测试异常
    with pytest.raises(ZeroDivisionError):
        divide(10, 0)
```

**运行测试：**
```bash
# 运行所有测试
pytest

# 运行特定文件
pytest tests/test_module1.py

# 运行特定测试函数
pytest tests/test_module1.py::test_add

# 显示详细输出
pytest -v

# 显示测试覆盖率
pytest --cov=src

# 生成覆盖率报告
pytest --cov=src --cov-report=html
```

#### 5.1.2 unittest

unittest 是 Python 标准库中的测试框架，基于 Java 的 JUnit。

**基本测试示例：**
```python
# tests/test_module2.py
import unittest
from src.my_package.module2 import multiply

class TestMultiply(unittest.TestCase):
    def test_multiply(self):
        self.assertEqual(multiply(2, 3), 6)
        self.assertEqual(multiply(-1, 1), -1)
        self.assertEqual(multiply(0, 5), 0)
    
    def test_multiply_with_zero(self):
        self.assertEqual(multiply(0, 0), 0)
        self.assertEqual(multiply(5, 0), 0)

if __name__ == '__main__':
    unittest.main()
```

**运行测试：**
```bash
# 运行所有测试
python -m unittest

# 运行特定文件
python -m unittest tests/test_module2.py

# 运行特定测试类
python -m unittest tests/test_module2.py::TestMultiply

# 运行特定测试方法
python -m unittest tests/test_module2.py::TestMultiply::test_multiply
```

### 5.2 测试类型

#### 5.2.1 单元测试

单元测试是对软件中最小可测试单元进行的测试，通常是函数或方法。

**最佳实践：**
- 每个测试函数只测试一个功能
- 使用清晰的测试命名
- 测试应该是独立的，不依赖于其他测试
- 测试应该覆盖正常情况和边界情况

#### 5.2.2 集成测试

集成测试是测试多个组件之间的交互，验证它们能否正确协同工作。

**示例：**
```python
# tests/test_integration.py
import pytest
from src.my_package import Database, UserService

@pytest.fixture
def database():
    # 创建测试数据库
    db = Database("test.db")
    yield db
    # 清理测试数据
    db.cleanup()

def test_user_creation(database):
    # 测试用户创建流程
    user_service = UserService(database)
    user = user_service.create_user("test@example.com", "password123")
    
    assert user is not None
    assert user.email == "test@example.com"
    assert user_service.get_user(user.id) is not None
```

#### 5.2.3 端到端测试

端到端测试是测试整个应用流程，从用户输入到系统输出。

**常用工具：**
- **selenium**：用于 Web 应用的端到端测试
- **pytest-playwright**：用于现代 Web 应用的自动化测试
- **httpx**：用于 API 测试

**API 测试示例：**
```python
# tests/test_api.py
import httpx
from src.my_package.app import app

@pytest.fixture
def client():
    return httpx.AsyncClient(app=app, base_url="http://testserver")

async def test_create_user(client):
    response = await client.post("/users", json={
        "email": "test@example.com",
        "password": "password123"
    })
    
    assert response.status_code == 201
    data = response.json()
    assert data["email"] == "test@example.com"
    assert "id" in data
```

### 5.3 测试组织

#### 5.3.1 测试目录结构

```
tests/
├── __init__.py
├── conftest.py          # 共享 fixtures
├── unit/                # 单元测试
│   ├── __init__.py
│   ├── test_module1.py
│   └── test_module2.py
├── integration/         # 集成测试
│   ├── __init__.py
│   └── test_database.py
└── e2e/                 # 端到端测试
    ├── __init__.py
    └── test_api.py
```

#### 5.3.2 使用 fixtures

fixtures 是 pytest 中用于设置测试环境的函数。

**共享 fixtures（conftest.py）：**
```python
# tests/conftest.py
import pytest
from src.my_package import Database

@pytest.fixture(scope="session")
def database():
    """创建一个测试数据库实例，整个测试会话共享"""
    db = Database("test.db")
    db.init_schema()
    yield db
    db.drop_schema()
    db.close()

@pytest.fixture
def clean_database(database):
    """每次测试前清理数据库"""
    database.clean_table("users")
    database.clean_table("products")
    yield database
```

### 5.4 测试最佳实践

#### 5.4.1 测试命名

- 测试函数名应该清晰描述测试内容
- 使用 `test_` 前缀
- 对于类测试，使用 `Test` 前缀

**示例：**
```python
def test_add_positive_numbers():
    pass

def test_add_negative_numbers():
    pass

def test_divide_by_zero():
    pass
```

#### 5.4.2 测试隔离

- 每个测试应该独立运行
- 测试之间不应该共享状态
- 使用 fixtures 管理测试环境

#### 5.4.3 测试覆盖率

- 目标覆盖率：80% 以上
- 关注核心业务逻辑
- 不要为了覆盖率而测试

**运行覆盖率报告：**
```bash
pytest --cov=src --cov-report=html
```

#### 5.4.4 测试数据管理

- 使用工厂模式创建测试数据
- 避免硬编码测试数据
- 使用 fixtures 管理测试数据

**示例：**
```python
# tests/factories.py
def create_user_data(email=None, password=None):
    return {
        "email": email or "test@example.com",
        "password": password or "password123"
    }

def create_product_data(name=None, price=None):
    return {
        "name": name or "Test Product",
        "price": price or 9.99
    }
```

#### 5.4.5 Mocking

Mocking 用于模拟外部依赖，如数据库、API 等。

**使用 pytest-mock 示例：**
```python
# tests/test_service.py
import pytest
from src.my_package import UserService

def test_user_service(mocker):
    # 模拟数据库连接
    mock_db = mocker.MagicMock()
    mock_db.get_user.return_value = {"id": 1, "email": "test@example.com"}
    
    # 创建服务实例
    user_service = UserService(mock_db)
    
    # 测试方法
    user = user_service.get_user(1)
    
    # 验证调用
    mock_db.get_user.assert_called_once_with(1)
    assert user["id"] == 1
```

## 6. 最佳实践总结

### 6.1 项目结构最佳实践

1. **使用 src 目录布局**：
   - 将源代码放在 `src/` 目录下
   - 避免直接在项目根目录放置 Python 模块

2. **遵循 PEP 8 命名规范**：
   - 包名使用小写字母和下划线
   - 模块名使用小写字母和下划线
   - 类名使用驼峰命名法
   - 函数名和变量名使用蛇形命名法

3. **使用虚拟环境**：
   - 为每个项目创建独立的虚拟环境
   - 在 `.gitignore` 中添加虚拟环境目录

### 6.2 配置管理最佳实践

1. **使用 pyproject.toml**：
   - 遵循 PEP 621 规范
   - 统一管理项目配置和依赖

2. **使用 .env 文件管理敏感配置**：
   - 不要将 `.env` 文件提交到版本控制系统
   - 使用类型安全的方式访问环境变量

3. **使用分层配置**：
   - 基础配置 -> 环境配置 -> 本地配置
   - 优先级：本地配置 > 环境配置 > 基础配置

### 6.3 开发工具最佳实践

1. **配置 VSCode 工作区**：
   - 配置 Python 路径和虚拟环境
   - 配置代码格式化和 linting
   - 配置测试框架

2. **使用 pre-commit 钩子**：
   - 安装 pre-commit：`pip install pre-commit`
   - 创建 `.pre-commit-config.yaml` 配置文件
   - 在提交前自动运行代码格式化、linting 等

3. **使用容器化开发环境**：
   - 使用 Docker 或 Podman 创建一致的开发环境
   - 使用 `docker-compose` 管理多服务应用

## 7. 总结

Python 项目架构设计是一个重要的环节，合理的架构可以提高代码的可维护性、可扩展性和可测试性。本文介绍了典型的 Python 项目结构、pyproject.toml 文件、.env 文件、配置读取方法以及 VSCode 配置文件。

通过遵循最佳实践，可以创建一个结构清晰、配置合理、易于开发和维护的 Python 项目。同时，使用现代化的工具和库，如 pydantic-settings、pyproject.toml 等，可以提高开发效率，减少配置错误。

在实际项目中，应根据项目规模和需求，选择合适的架构和工具，灵活调整配置方案。