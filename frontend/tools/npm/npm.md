# npm 文档

## 1. 基础概念

### 1.1 什么是 npm？

npm（Node Package Manager）是 Node.js 的包管理器，用于安装、共享和管理 JavaScript 代码包。它是 JavaScript 生态系统中最常用的包管理工具，允许开发者轻松地安装、更新和卸载依赖包。

### 1.2 npm 的组成

npm 由三个主要部分组成：

1. **npm 网站**：https://www.npmjs.com/ - 包的在线存储库，开发者可以在这里搜索和发布包
2. **npm 命令行工具 (CLI)**：用于在终端中执行 npm 命令
3. **npm 注册表**：一个大型数据库，存储了所有已发布的 npm 包的元数据和代码

### 1.3 核心术语

- **包（Package）**：包含 JavaScript 代码的模块，可以被其他项目使用
- **依赖（Dependency）**：项目所依赖的其他包
- **package.json**：项目的配置文件，包含项目信息、依赖列表等
- **node_modules**：存放项目依赖包的目录
- **registry**：包的存储服务器
- **scope**：包的命名空间，用于组织包（如 @babel/core）

## 2. 安装

### 2.1 安装 Node.js 和 npm

npm 随 Node.js 一起安装，因此你只需要安装 Node.js 即可：

1. 访问 [Node.js 官方网站](https://nodejs.org/)
2. 下载适合你操作系统的安装包（推荐使用 LTS 版本）
3. 运行安装程序，按照提示完成安装
4. 验证安装：

```bash
node -v  # 显示 Node.js 版本
npm -v   # 显示 npm 版本
```

### 2.2 更新 npm

要更新 npm 到最新版本，可以使用以下命令：

```bash
npm install -g npm@latest
```

### 2.3 安装特定版本的 npm

如果你需要使用特定版本的 npm，可以使用以下命令：

```bash
npm install -g npm@<version>
```

例如，安装 npm 8.0.0：

```bash
npm install -g npm@8.0.0
```

## 3. 常用命令

### 3.1 项目初始化

创建一个新的 npm 项目：

```bash
npm init  # 交互式创建 package.json
npm init -y  # 快速创建默认的 package.json
```

### 3.2 安装依赖

#### 3.2.1 安装生产依赖

```bash
npm install <package-name>  # 安装单个依赖
npm install <pkg1> <pkg2> <pkg3>  # 安装多个依赖
npm install <package-name>@<version>  # 安装特定版本
npm install <package-name>@latest  # 安装最新版本
```

#### 3.2.2 安装开发依赖

```bash
npm install <package-name> --save-dev  # 简写: -D
```

#### 3.2.3 安装全局依赖

```bash
npm install -g <package-name>  # 简写: -g
```

#### 3.2.4 安装所有依赖

从 package.json 安装所有依赖：

```bash
npm install
```

### 3.3 卸载依赖

```bash
npm uninstall <package-name>  # 卸载生产依赖
npm uninstall <package-name> --save-dev  # 卸载开发依赖
npm uninstall -g <package-name>  # 卸载全局依赖
```

### 3.4 更新依赖

```bash
npm update  # 更新所有依赖到兼容版本
npm update <package-name>  # 更新单个依赖
npm outdated  # 检查过时的依赖
```

### 3.5 查看依赖

```bash
npm list  # 查看所有依赖（树形结构）
npm list --depth=0  # 只查看直接依赖
npm view <package-name>  # 查看包的详细信息
npm view <package-name> versions  # 查看包的所有版本
```

### 3.6 运行脚本

package.json 中定义的脚本可以通过以下命令运行：

```bash
npm run <script-name>
```

常用的内置脚本可以直接运行：

```bash
npm start  # 运行 start 脚本
npm test  # 运行 test 脚本
npm run build  # 运行 build 脚本
```

### 3.7 发布包

```bash
npm login  # 登录到 npm
npm publish  # 发布包
npm publish --access public  # 发布公开包（适用于 scoped 包）
npm unpublish <package-name> --force  # 卸载已发布的包
```

### 3.8 其他常用命令

```bash
npm cache clean --force  # 清理 npm 缓存
npm audit  # 检查依赖中的安全漏洞
npm audit fix  # 自动修复安全漏洞
npm config list  # 查看 npm 配置
npm config set <key> <value>  # 设置 npm 配置
npm root  # 查看本地依赖目录
npm root -g  # 查看全局依赖目录
```

## 4. package.json 配置

### 4.1 基本结构

package.json 是 npm 项目的核心配置文件，包含了项目的基本信息和依赖列表。以下是一个典型的 package.json 结构：

```json
{
  "name": "my-project",
  "version": "1.0.0",
  "description": "A sample npm project",
  "main": "index.js",
  "scripts": {
    "start": "node index.js",
    "test": "jest",
    "build": "webpack"
  },
  "keywords": ["sample", "project"],
  "author": "Your Name <your.email@example.com>",
  "license": "MIT",
  "dependencies": {
    "express": "^4.18.2"
  },
  "devDependencies": {
    "jest": "^29.7.0",
    "webpack": "^5.89.0"
  },
  "engines": {
    "node": ">=16.0.0"
  },
  "repository": {
    "type": "git",
    "url": "git+https://github.com/yourusername/my-project.git"
  },
  "bugs": {
    "url": "https://github.com/yourusername/my-project/issues"
  },
  "homepage": "https://github.com/yourusername/my-project#readme"
}
```

### 4.2 核心字段

#### 4.2.1 基本信息

- **name**：项目名称，必须唯一
- **version**：项目版本，遵循 [语义化版本规范](https://semver.org/)
- **description**：项目描述
- **main**：项目的入口文件
- **scripts**：定义可运行的脚本命令
- **keywords**：项目的关键词，用于 npm 搜索
- **author**：项目作者信息
- **license**：项目许可证

#### 4.2.2 依赖管理

- **dependencies**：生产环境依赖
- **devDependencies**：开发环境依赖
- **peerDependencies**：对等依赖，需要用户手动安装
- **optionalDependencies**：可选依赖，安装失败不会导致整个安装过程失败
- **bundledDependencies**：打包依赖，发布时会包含这些依赖

#### 4.2.3 其他字段

- **engines**：指定项目运行所需的 Node.js 和 npm 版本
- **repository**：项目的代码仓库信息
- **bugs**：项目的 issue 跟踪地址
- **homepage**：项目的主页地址
- **private**：如果设置为 true，项目将无法发布到 npm
- **workspaces**：用于 monorepo 项目，指定工作区目录

## 5. 依赖版本管理

### 5.1 语义化版本规范

npm 使用语义化版本规范（Semantic Versioning，简称 SemVer）来管理依赖版本。版本号格式为：**MAJOR.MINOR.PATCH**

- **MAJOR**：不兼容的 API 变更
- **MINOR**：向下兼容的功能性新增
- **PATCH**：向下兼容的问题修正

### 5.2 版本范围表示法

npm 支持多种版本范围表示法：

| 表示法 | 描述 | 示例 |
|-------|------|------|
| ^ | 兼容更新（不改变 MAJOR 版本） | ^1.2.3 表示 >=1.2.3 <2.0.0 |
| ~ | 补丁更新（不改变 MAJOR.MINOR 版本） | ~1.2.3 表示 >=1.2.3 <1.3.0 |
| > | 大于指定版本 | >1.2.3 |
| >= | 大于或等于指定版本 | >=1.2.3 |
| < | 小于指定版本 | <1.2.3 |
| <= | 小于或等于指定版本 | <=1.2.3 |
| = | 等于指定版本 | =1.2.3 |
| * | 任意版本 | * |
| x | 通配符 | 1.x 表示 1.0.0 到 1.999.999 |

### 5.3 package-lock.json

package-lock.json 是 npm 自动生成的文件，用于锁定依赖的精确版本，确保在不同环境中安装的依赖版本一致。它包含了：

- 所有依赖的精确版本
- 依赖的依赖关系
- 包的哈希值，用于验证包的完整性

### 5.4 npm-shrinkwrap.json

npm-shrinkwrap.json 与 package-lock.json 类似，但它用于发布包时锁定依赖版本。当你发布一个包时，如果存在 npm-shrinkwrap.json，npm 会使用它来安装依赖。

## 6. 高级功能

### 6.1 工作区（Workspaces）

工作区是 npm 7+ 引入的功能，用于管理 monorepo 项目，允许在一个仓库中管理多个相关的包。

#### 6.1.1 配置工作区

在 package.json 中添加 workspaces 字段：

```json
{
  "name": "my-monorepo",
  "private": true,
  "workspaces": [
    "packages/*",
    "apps/*"
  ]
}
```

#### 6.1.2 工作区常用命令

```bash
npm install  # 安装所有工作区的依赖
npm run build -w <workspace>  # 在特定工作区运行脚本
npm run build -ws  # 在所有工作区运行脚本
npm run build -ws --if-present  # 只在有该脚本的工作区运行
```

### 6.2 配置 npm

#### 6.2.1 查看配置

```bash
npm config list  # 查看所有配置
npm config list -l  # 查看所有默认配置
npm config get <key>  # 查看特定配置项
```

#### 6.2.2 设置配置

```bash
npm config set <key> <value>  # 设置全局配置
npm config set <key> <value> --global  # 同上
npm config set <key> <value> --user  # 设置用户级配置
```

#### 6.2.3 常用配置项

- **registry**：设置 npm 注册表地址
- **prefix**：设置全局安装目录
- **cache**：设置缓存目录
- **proxy**：设置代理
- **https-proxy**：设置 HTTPS 代理
- **strict-ssl**：是否严格验证 SSL 证书

### 6.3 使用不同的注册表

#### 6.3.1 临时使用其他注册表

```bash
npm install <package> --registry=https://registry.npmmirror.com
```

#### 6.3.2 永久设置注册表

```bash
npm config set registry https://registry.npmmirror.com
```

#### 6.3.3 使用 nrm 管理注册表

nrm 是一个 npm 注册表管理工具，可以方便地切换不同的注册表：

```bash
npm install -g nrm
nrm ls  # 列出可用的注册表
nrm use <registry-name>  # 切换到指定注册表
nrm add <name> <url>  # 添加自定义注册表
nrm del <name>  # 删除注册表
nrm test <name>  # 测试注册表速度
```

## 7. 最佳实践

### 7.1 项目结构

```
my-project/
├── node_modules/          # 依赖包目录
├── src/                   # 源代码目录
│   └── index.js          # 主入口文件
├── package.json          # 项目配置文件
├── package-lock.json     # 依赖锁定文件
└── README.md             # 项目说明文档
```

### 7.2 依赖管理

- **生产依赖 vs 开发依赖**：只将运行时必需的包放在 dependencies 中，开发工具和测试框架放在 devDependencies 中
- **使用精确版本**：对于生产环境，考虑使用精确版本号或锁定文件，确保依赖的一致性
- **定期更新依赖**：使用 `npm outdated` 检查过时的依赖，并及时更新以获取安全修复和新功能
- **清理不需要的依赖**：定期清理不再使用的依赖，减少项目体积

### 7.3 脚本管理

- **合理命名脚本**：使用清晰、一致的脚本名称（如 start, build, test, lint 等）
- **使用钩子脚本**：利用 npm 的钩子脚本（如 preinstall, postinstall 等）自动化流程
- **保持脚本简洁**：复杂的脚本可以拆分为单独的脚本文件

### 7.4 安全性

- **定期运行安全审计**：使用 `npm audit` 检查依赖中的安全漏洞
- **修复安全漏洞**：使用 `npm audit fix` 自动修复安全漏洞，或手动更新受影响的依赖
- **使用可信的包**：优先使用下载量高、维护活跃的包
- **检查包的依赖树**：使用 `npm list` 检查包的依赖树，避免不必要的深层依赖

### 7.5 性能优化

- **使用 npm ci**：在 CI/CD 环境中，使用 `npm ci` 替代 `npm install`，可以更快、更可靠地安装依赖
- **清理缓存**：定期使用 `npm cache clean --force` 清理缓存，释放磁盘空间
- **使用 --no-optional**：安装依赖时使用 `--no-optional` 可以跳过可选依赖，减少安装时间
- **使用 --only=prod**：在生产环境中，使用 `npm install --only=prod` 只安装生产依赖

## 8. 常见问题

### 8.1 安装依赖失败

可能的原因及解决方案：

- **网络问题**：检查网络连接，或切换到其他注册表
- **权限问题**：使用管理员权限运行命令，或修改 npm 配置中的 prefix 目录
- **Node.js 版本不兼容**：升级或降级 Node.js 版本，确保与项目要求的版本兼容
- **包损坏**：清理 npm 缓存 `npm cache clean --force`，然后重新安装

### 8.2 全局安装权限问题

在 macOS 或 Linux 上，全局安装可能会遇到权限问题。解决方案：

1. **修改 npm 全局安装目录**：
   ```bash
   mkdir ~/.npm-global
   npm config set prefix '~/.npm-global'
   export PATH=~/.npm-global/bin:$PATH
   source ~/.profile
   ```

2. **使用 sudo（不推荐）**：
   ```bash
   sudo npm install -g <package>
   ```

### 8.3 包版本冲突

当不同的依赖需要同一个包的不同版本时，可能会发生版本冲突。解决方案：

- 使用 `npm ls <package>` 查看冲突的包
- 尝试更新冲突的依赖到兼容版本
- 使用 `npm dedupe` 优化依赖树，减少重复依赖
- 考虑使用 yarn 或 pnpm，它们在依赖管理方面有更好的处理机制

### 8.4 npm 运行缓慢

可能的原因及解决方案：

- **网络问题**：切换到更快的注册表
- **磁盘空间不足**：清理磁盘空间
- **依赖过多**：清理不必要的依赖
- **Node.js 版本过旧**：升级到最新的 LTS 版本
- **使用 npm ci**：在 CI/CD 环境中使用 `npm ci` 替代 `npm install`

## 9. 资源

- **官方文档**：https://docs.npmjs.com/
- **npm 网站**：https://www.npmjs.com/
- **Node.js 官方网站**：https://nodejs.org/
- **语义化版本规范**：https://semver.org/
- **npm 命令速查表**：https://www.npmjs.com.cn/cli/
- **nrm 工具**：https://github.com/Pana/nrm

## 10. 总结

npm 是 JavaScript 生态系统中不可或缺的工具，它简化了依赖管理和项目构建流程。通过掌握 npm 的基本概念、常用命令和最佳实践，你可以更高效地开发和管理 JavaScript 项目。

随着 npm 的不断发展，它引入了许多新功能，如工作区、更强大的脚本系统和改进的依赖管理。定期学习和掌握这些新功能，可以帮助你更好地利用 npm 的强大能力，提高开发效率。