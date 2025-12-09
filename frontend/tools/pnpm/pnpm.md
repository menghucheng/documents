# pnpm 文档

## 1. 基础概念

### 1.1 什么是 pnpm？

pnpm（Performant npm）是一个快速的、节省磁盘空间的 JavaScript 包管理器，由 Zoltan Kochan 开发。它使用硬链接和符号链接来共享依赖，从而减少磁盘使用并提高安装速度。pnpm 兼容 npm 的 package.json 格式，并且支持大多数 npm 命令。

### 1.2 核心特性

- **快速安装**：比 npm 和 yarn 更快的依赖安装速度
- **节省磁盘空间**：通过共享依赖包，减少重复安装
- **严格的依赖隔离**：每个项目只能访问自己声明的依赖
- **兼容 npm**：支持 npm 的 package.json 格式和大多数命令
- **Monorepo 支持**：内置工作区功能，适合管理多个相关项目
- **安全可靠**：严格的依赖管理，减少依赖劫持风险
- **支持 Node.js 项目**：适用于任何 Node.js 项目，包括 React、Vue、Next.js 等

### 1.3 与 npm/yarn 的比较

| 特性 | pnpm | npm | Yarn |
|------|------|-----|------|
| 安装速度 | 最快 | 较慢 | 快 |
| 磁盘空间 | 最节省 | 最占用 | 较节省 |
| 依赖隔离 | 严格 | 宽松 | 较严格 |
| Monorepo 支持 | 内置 | 需要配置 | 内置 |
| 兼容性 | 兼容 npm | 原生 | 兼容 npm |
| 安全性 | 高 | 中 | 高 |
| 缓存机制 | 共享全局缓存 | 本地缓存 | 共享全局缓存 |

### 1.4 工作原理

pnpm 的核心创新在于其依赖管理方式：

1. **全局存储**：所有依赖包都存储在一个全局目录中（默认：`~/.pnpm-store`）
2. **硬链接**：从全局存储向项目的 node_modules 创建硬链接
3. **符号链接**：使用符号链接构建依赖树，确保每个包只能访问其声明的依赖
4. **无重复安装**：相同版本的包只安装一次，不同项目共享同一个包

这种方式不仅节省了磁盘空间，还提高了安装速度，因为不需要重复下载和安装相同的包。

## 2. 安装

### 2.1 使用 npm 安装

```bash
npm install -g pnpm
```

### 2.2 使用安装脚本

```bash
# Windows
iwr https://get.pnpm.io/install.ps1 -useb | iex

# macOS/Linux
curl -fsSL https://get.pnpm.io/install.sh | sh -
```

### 2.3 使用 Homebrew（macOS）

```bash
brew install pnpm
```

### 2.4 使用 Scoop（Windows）

```bash
scoop install pnpm
```

### 2.5 验证安装

```bash
pnpm -v  # 显示 pnpm 版本
```

## 3. 常用命令

### 3.1 项目初始化

```bash
pnpm init  # 交互式创建 package.json
pnpm init -y  # 快速创建默认的 package.json
```

### 3.2 安装依赖

#### 3.2.1 安装生产依赖

```bash
pnpm add <package-name>  # 安装单个依赖
pnpm add <pkg1> <pkg2> <pkg3>  # 安装多个依赖
pnpm add <package-name>@<version>  # 安装特定版本
pnpm add <package-name>@latest  # 安装最新版本
```

#### 3.2.2 安装开发依赖

```bash
pnpm add -D <package-name>  # 安装开发依赖
pnpm add --save-dev <package-name>  # 同上
```

#### 3.2.3 安装全局依赖

```bash
pnpm add -g <package-name>  # 安装全局依赖
pnpm add --global <package-name>  # 同上
```

#### 3.2.4 安装所有依赖

从 package.json 安装所有依赖：

```bash
pnpm install
pnpm i  # 简写
```

### 3.3 卸载依赖

```bash
pnpm remove <package-name>  # 卸载生产依赖
pnpm rm <package-name>  # 简写
pnpm remove -D <package-name>  # 卸载开发依赖
pnpm remove -g <package-name>  # 卸载全局依赖
```

### 3.4 更新依赖

```bash
pnpm update  # 更新所有依赖到兼容版本
pnpm up  # 简写
pnpm update <package-name>  # 更新单个依赖
pnpm up <package-name>  # 简写
pnpm outdated  # 检查过时的依赖
```

### 3.5 运行脚本

```bash
pnpm run <script-name>  # 运行脚本
pnpm <script-name>  # 如果脚本名不是 pnpm 内置命令，可以省略 run
```

例如：

```bash
pnpm start  # 运行 start 脚本
pnpm test  # 运行 test 脚本
pnpm build  # 运行 build 脚本
```

### 3.6 查看依赖

```bash
pnpm list  # 查看所有依赖（树形结构）
pnpm ls  # 简写
pnpm list --depth=0  # 只查看直接依赖
pnpm view <package-name>  # 查看包的详细信息
pnpm view <package-name> versions  # 查看包的所有版本
```

### 3.7 发布包

```bash
pnpm publish  # 发布包
pnpm publish --access public  # 发布公开包（适用于 scoped 包）
pnpm unpublish <package-name> --force  # 卸载已发布的包
```

### 3.8 pnpm 特有命令

#### 3.8.1 列出全局存储中的包

```bash
pnpm store list  # 列出全局存储中的所有包
```

#### 3.8.2 清理全局存储

```bash
pnpm store prune  # 清理未使用的包
```

#### 3.8.3 导出依赖

```bash
pnpm export  # 导出依赖到 tarball
```

#### 3.8.4 导入依赖

```bash
pnpm import  # 从 package-lock.json 或 yarn.lock 导入依赖
```

#### 3.8.5 检查依赖关系

```bash
pnpm why <package-name>  # 查看为什么安装某个包
pnpm why -r <package-name>  # 在工作区中查看为什么安装某个包
```

#### 3.8.6 修复依赖

```bash
pnpm fix  # 修复损坏的依赖
```

## 4. 配置

### 4.1 配置文件

pnpm 支持多种配置方式：

1. **命令行参数**：如 `pnpm install --registry=https://registry.npmmirror.com`
2. **环境变量**：如 `PNPM_REGISTRY=https://registry.npmmirror.com pnpm install`
3. **配置文件**：
   - 项目级：`pnpm-workspace.yaml`（工作区配置）和 `.npmrc`（npm 兼容配置）
   - 用户级：`~/.pnpmrc`
   - 全局级：`/etc/pnpmrc`

### 4.2 常用配置项

#### 4.2.1 注册表配置

```ini
# .npmrc
registry=https://registry.npmmirror.com
```

#### 4.2.2 存储目录配置

```ini
# .npmrc
store-dir=~/.pnpm-store
```

#### 4.2.3 依赖隔离配置

```ini
# .npmrc
strict-peer-dependencies=true  # 严格检查 peer 依赖
```

#### 4.2.4 全局安装配置

```ini
# .npmrc
global-bin-dir=~/.local/bin  # 全局可执行文件目录
global-dir=~/.pnpm-global  # 全局安装目录
```

### 4.3 查看配置

```bash
pnpm config list  # 查看所有配置
pnpm config get <key>  # 查看特定配置项
pnpm config set <key> <value>  # 设置配置项
```

## 5. 工作区（Workspaces）

### 5.1 什么是工作区？

工作区是 pnpm 内置的 monorepo 支持，允许在一个仓库中管理多个相关的包。工作区中的包可以相互引用，共享依赖，从而简化开发和发布流程。

### 5.2 配置工作区

创建 `pnpm-workspace.yaml` 文件，定义工作区目录：

```yaml
# pnpm-workspace.yaml
packages:
  # 所有在 packages/ 目录下的包
  - 'packages/**'
  # 所有在 apps/ 目录下的应用
  - 'apps/**'
  # 排除特定目录
  - '!**/test/**'
```

### 5.3 工作区常用命令

```bash
pnpm install  # 安装所有工作区的依赖
pnpm add <package> -w  # 向根目录添加依赖
pnpm add <package> --filter <workspace>  # 向特定工作区添加依赖
pnpm add <package> --filter <workspace> -D  # 向特定工作区添加开发依赖
pnpm run build --filter <workspace>  # 在特定工作区运行脚本
pnpm run build -r  # 在所有工作区运行脚本
pnpm run build -r --if-present  # 只在有该脚本的工作区运行
pnpm publish -r  # 发布所有工作区的包
```

### 5.4 工作区示例结构

```
my-monorepo/
├── packages/
│   ├── package-a/  # 工作区包 A
│   │   ├── package.json
│   │   └── src/
│   └── package-b/  # 工作区包 B
│       ├── package.json
│       └── src/
├── apps/
│   └── app1/  # 应用 1
│       ├── package.json
│       └── src/
├── pnpm-workspace.yaml  # 工作区配置
├── package.json  # 根目录配置
└── pnpm-lock.yaml  # 依赖锁定文件
```

## 6. 高级特性

### 6.1 存储目录（Store Directory）

pnpm 使用全局存储目录来存储所有安装过的包，默认位置是：

- Windows：`%LOCALAPPDATA%\pnpm\store`
- macOS：`~/.pnpm-store`
- Linux：`~/.pnpm-store`

你可以通过 `store-dir` 配置项来修改存储目录位置。

### 6.2 依赖隔离

pnpm 实现了严格的依赖隔离，每个包只能访问其声明的依赖，从而避免了"依赖劫持"等安全问题。这种隔离是通过符号链接实现的，确保了依赖树的完整性和安全性。

### 6.3 硬链接和符号链接

pnpm 使用两种类型的链接：

1. **硬链接（Hard Links）**：从全局存储目录向项目的 node_modules 创建硬链接，使得多个项目可以共享同一个包文件，而不需要重复复制。
2. **符号链接（Symbolic Links）**：使用符号链接构建依赖树，确保每个包只能访问其声明的依赖。

### 6.4 pnpm-lock.yaml

pnpm-lock.yaml 是 pnpm 自动生成的依赖锁定文件，类似于 npm 的 package-lock.json。它包含了：

- 所有依赖的精确版本
- 依赖的依赖关系
- 包的哈希值，用于验证包的完整性
- 工作区配置（如果使用了工作区）

### 6.5 与 npm 命令的兼容性

pnpm 兼容大多数 npm 命令，下表列出了常用 npm 命令对应的 pnpm 命令：

| npm 命令 | pnpm 命令 | 说明 |
|----------|-----------|------|
npm install | pnpm install | 安装依赖 |
npm install <pkg> | pnpm add <pkg> | 安装单个依赖 |
npm uninstall <pkg> | pnpm remove <pkg> | 卸载依赖 |
npm update | pnpm update | 更新依赖 |
npm run <script> | pnpm run <script> | 运行脚本 |
npm init | pnpm init | 初始化项目 |
npm test | pnpm test | 运行测试 |
npm build | pnpm build | 构建项目 |
npm publish | pnpm publish | 发布包 |
npm cache clean | pnpm store prune | 清理缓存 |

## 7. 最佳实践

### 7.1 项目迁移

#### 7.1.1 从 npm 迁移到 pnpm

1. 安装 pnpm
2. 删除现有的 `node_modules` 目录和 `package-lock.json` 文件
3. 运行 `pnpm install` 安装依赖
4. 更新项目的 CI/CD 配置，使用 pnpm 替代 npm

#### 7.1.2 从 Yarn 迁移到 pnpm

1. 安装 pnpm
2. 删除现有的 `node_modules` 目录和 `yarn.lock` 文件
3. 运行 `pnpm install` 安装依赖
4. 或者使用 `pnpm import` 从 `yarn.lock` 导入依赖

### 7.2 在 CI/CD 中使用 pnpm

#### 7.2.1 GitHub Actions 示例

```yaml
# .github/workflows/ci.yml
name: CI
on: [push, pull_request]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: pnpm/action-setup@v2
        with:
          version: latest
      - uses: actions/setup-node@v3
        with:
          node-version: 16
          cache: 'pnpm'
      - run: pnpm install
      - run: pnpm test
      - run: pnpm build
```

#### 7.2.2 GitLab CI 示例

```yaml
# .gitlab-ci.yml
image: node:16

stages:
  - install
  - test
  - build

install:
  stage: install
  script:
    - npm install -g pnpm
    - pnpm install
  cache:
    key: $CI_COMMIT_REF_SLUG
    paths:
      - node_modules/
      - .pnpm-store/

test:
  stage: test
  script:
    - pnpm test

build:
  stage: build
  script:
    - pnpm build
```

### 7.3 依赖管理最佳实践

1. **使用工作区管理 monorepo**：对于多包项目，使用 pnpm 工作区可以简化依赖管理和发布流程
2. **锁定依赖版本**：使用 `pnpm-lock.yaml` 锁定依赖版本，确保在不同环境中安装的依赖一致
3. **定期更新依赖**：使用 `pnpm outdated` 检查过时的依赖，并及时更新以获取安全修复和新功能
4. **使用精确版本**：对于生产环境，考虑使用精确版本号，确保依赖的一致性
5. **清理未使用的依赖**：定期清理不再使用的依赖，减少项目体积

### 7.4 性能优化

1. **使用缓存**：在 CI/CD 环境中缓存 `node_modules` 和 `.pnpm-store` 目录
2. **并行安装**：pnpm 默认使用并行安装，可以通过 `--parallel` 参数进一步优化
3. **使用 `--frozen-lockfile`**：在 CI/CD 环境中使用 `pnpm install --frozen-lockfile`，确保依赖不被意外修改
4. **使用 `--filter` 限制范围**：在工作区中，使用 `--filter` 参数只操作特定的包

## 8. 常见问题

### 8.1 依赖冲突

如果遇到依赖冲突问题，可以尝试以下解决方案：

- 使用 `pnpm why <package>` 查看依赖树
- 使用 `pnpm add <package>@latest` 更新冲突的依赖
- 考虑使用 `resolutions` 字段强制指定依赖版本：

```json
// package.json
{
  "resolutions": {
    "react": "^18.0.0"
  }
}
```

### 8.2 peer 依赖警告

pnpm 对 peer 依赖检查比较严格，如果遇到 peer 依赖警告，可以尝试以下解决方案：

- 安装缺失的 peer 依赖
- 在 `.npmrc` 中设置 `strict-peer-dependencies=false` 禁用严格检查
- 使用 `pnpm add -D <package>` 将 peer 依赖添加为开发依赖

### 8.3 全局安装权限问题

在 macOS 或 Linux 上，全局安装可能会遇到权限问题。解决方案：

1. **修改全局安装目录**：
   ```bash
   pnpm config set global-dir ~/.pnpm-global
   pnpm config set global-bin-dir ~/.local/bin
   export PATH=~/.local/bin:$PATH
   ```

2. **使用 sudo（不推荐）**：
   ```bash
   sudo pnpm add -g <package>
   ```

### 8.4 与某些工具不兼容

如果遇到与某些工具不兼容的问题，可以尝试以下解决方案：

- 确保工具支持 pnpm
- 使用 `pnpm dlx <package>` 临时安装并运行工具
- 考虑使用 `pnpm exec <command>` 执行命令

## 9. 资源

- **官方文档**：https://pnpm.io/
- **GitHub 仓库**：https://github.com/pnpm/pnpm
- **中文文档**：https://pnpm.io/zh/
- **pnpm 工作区**：https://pnpm.io/zh/workspaces
- **迁移指南**：https://pnpm.io/zh/migration

## 10. 总结

pnpm 是一个快速、节省磁盘空间的包管理器，它通过创新的依赖管理方式，解决了 npm 和 yarn 存在的一些问题。pnpm 兼容 npm 的 package.json 格式和大多数命令，同时提供了更好的性能和安全性。

pnpm 的核心优势在于：

1. **更快的安装速度**：比 npm 和 yarn 更快
2. **更少的磁盘使用**：相同版本的包只安装一次
3. **严格的依赖隔离**：提高了安全性，避免了依赖劫持
4. **内置的 monorepo 支持**：简化了多包项目的管理
5. **良好的兼容性**：与 npm 生态系统兼容

如果你正在寻找一个更高效、更安全的包管理器，pnpm 是一个值得考虑的选择。无论是小型项目还是大型 monorepo，pnpm 都能提供出色的性能和可靠性。