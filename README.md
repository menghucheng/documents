# GitHub Pages 部署指南

## 部署成功的关键要点

1. **禁用Jekyll自动构建**
   - 在项目根目录创建 `.nojekyll` 文件
   - 这是解决 `Build with Jekyll` 失败的核心步骤
   - GitHub Pages 默认会尝试用 Jekyll 构建，但纯静态网站不需要

2. **入口文件要求**
   - 必须存在 `index.html` 作为首页
   - 必须位于部署源指定的目录（本项目为根目录）

3. **部署配置**
   - 在仓库 Settings → Pages 中设置源为 `master` 分支 `/ (root)`
   - 避免不必要的自定义工作流配置

4. **验证步骤**
   - 提交后等待 2-3 分钟让 GitHub 处理
   - 通过 `git ls-files` 确认关键文件已提交
   - 检查 GitHub Actions 日志确保无错误

> 💡 提示：对于纯静态网站，`.nojekyll` 是比配置 Jekyll 更简单、更稳定的部署方式