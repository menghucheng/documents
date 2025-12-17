# PowerShell UTF-8 Encoding - Fix Chinese Display Issues
$OutputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

# Clear screen
Clear-Host

# Display welcome message in Chinese (with UTF-8 fix)
Write-Host "PowerShell OAuth 2.0 真实API演示"
Write-Host "==================================="
Write-Host ""
Write-Host "使用真实的GitHub API进行测试，无需注册新账号"
Write-Host "此脚本使用GitHub个人访问令牌进行OAuth 2.0认证"
Write-Host ""

# Step 1: Introduction to GitHub API
Write-Host "1. GitHub API简介"
Write-Host "   - GitHub提供了丰富的REST API用于访问其功能"
Write-Host "   - 可以使用个人访问令牌进行OAuth 2.0认证"
Write-Host "   - 公共仓库不需要认证，但认证可以提高API限制"
Write-Host ""

# Step 2: Testing GitHub API without authentication
Write-Host "2. 测试无需认证的GitHub API"
$githubPublicUrl = "https://api.github.com/users/github"

Write-Host "   调用GitHub公共API: $githubPublicUrl"

try {
    $githubResponse = Invoke-RestMethod -Uri $githubPublicUrl -Method Get
    Write-Host "   ✓ 请求成功！"
    Write-Host "   GitHub官方账号信息:"
    Write-Host "     - 用户名: $($githubResponse.login)"
    Write-Host "     - 名称: $($githubResponse.name)"
    Write-Host "     - 仓库数量: $($githubResponse.public_repos)"
    Write-Host "     - 关注者: $($githubResponse.followers)"
    Write-Host ""
} catch {
    Write-Host "   ✗ 请求失败: $($_.Exception.Message)"
    if ($_.ErrorDetails.Message) {
        Write-Host "   API错误信息: $($_.ErrorDetails.Message)"
    }
    Read-Host "按Enter键退出"
    exit 1
}

# Step 3: Using Personal Access Token (PAT) for authentication
Write-Host "3. 使用个人访问令牌(PAT)进行认证"
Write-Host "   如何获取GitHub个人访问令牌:"
Write-Host "   1. 登录GitHub账号"
Write-Host "   2. 进入Settings > Developer settings > Personal access tokens"
Write-Host "   3. 点击Generate new token"
Write-Host "   4. 选择需要的权限，点击Generate token"
Write-Host "   5. 保存好令牌，不要泄露给他人"
Write-Host ""

# Step 4: Example with PAT (commented out - user needs to add their own)
Write-Host "4. 使用PAT访问GitHub API示例"
Write-Host "   以下是如何使用PAT的代码示例:"
Write-Host ""
Write-Host "   # 替换为您的个人访问令牌"
Write-Host "   $personalAccessToken = 'your_github_pat_123456789'"
Write-Host ""
Write-Host "   # 设置请求头"
Write-Host "   $headers = @{"
Write-Host "       'Authorization' = 'Bearer ' + $personalAccessToken"
Write-Host "       'Accept' = 'application/vnd.github.v3+json'"
Write-Host "   }"
Write-Host ""
Write-Host "   # 访问需要认证的API（例如当前用户信息）"
Write-Host "   $userInfo = Invoke-RestMethod -Uri 'https://api.github.com/user' -Headers $headers"
Write-Host "   Write-Host '当前用户: ' $userInfo.login"
Write-Host ""

# Step 5: Testing with httpbin.org as alternative
Write-Host "5. 使用httpbin.org测试Bearer Token机制"
$httpbinUrl = "https://httpbin.org/bearer"
$testToken = "test-token-12345"

$testHeaders = @{
    'Authorization' = "Bearer $testToken"
}

try {
    $httpbinResponse = Invoke-RestMethod -Uri $httpbinUrl -Headers $testHeaders -Method Get
    Write-Host "   ✓ Bearer Token测试成功！"
    Write-Host "   httpbin.org收到的令牌: $($httpbinResponse.authenticated) - $($httpbinResponse.token)"
    Write-Host ""
} catch {
    Write-Host "   ✗ Bearer Token测试失败: $($_.Exception.Message)"
    Write-Host ""
}

# Step 6: Chinese encoding fix explanation
Write-Host "6. 中文显示问题解决方法"
Write-Host "   PowerShell支持中文，但需要正确的编码设置:"
Write-Host ""
Write-Host "   # 设置PowerShell使用UTF-8编码"
Write-Host "   $OutputEncoding = [System.Text.UTF8Encoding]::new()"
Write-Host "   [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()"
Write-Host ""
Write-Host "   # 在Windows Terminal中设置UTF-8"
Write-Host "   1. 打开Windows Terminal设置"
Write-Host "   2. 选择PowerShell配置文件"
Write-Host "   3. 设置'编码'为'UTF-8'"
Write-Host ""

# Step 7: Complete OAuth 2.0 Flow
Write-Host "7. 完整的OAuth 2.0流程示例"
Write-Host "   以下是完整的OAuth 2.0客户端凭证流程:"
Write-Host ""
Write-Host "   # 1. 配置API参数"
Write-Host "   $config = @{"
Write-Host "       TokenUrl = 'https://api.example.com/oauth/token'"
Write-Host "       ApiUrl = 'https://api.example.com/data'"
Write-Host "       ClientId = 'your_client_id'"
Write-Host "       ClientSecret = 'your_client_secret'"
Write-Host "   }"
Write-Host ""
Write-Host "   # 2. 获取访问令牌"
Write-Host "   $tokenBody = @{"
Write-Host "       grant_type = 'client_credentials'"
Write-Host "       client_id = $config.ClientId"
Write-Host "       client_secret = $config.ClientSecret"
Write-Host "   }"
Write-Host ""
Write-Host "   $tokenResponse = Invoke-RestMethod -Uri $config.TokenUrl -Method Post -Body $tokenBody"
Write-Host "   $accessToken = $tokenResponse.access_token"
Write-Host ""
Write-Host "   # 3. 使用令牌访问API"
Write-Host "   $apiHeaders = @{Authorization = 'Bearer ' + $accessToken}"
Write-Host "   $apiData = Invoke-RestMethod -Uri $config.ApiUrl -Headers $apiHeaders"
Write-Host ""

# Summary
Write-Host "==================================="
Write-Host "演示完成！"
Write-Host "==================================="
Write-Host ""
Write-Host "您学到了:"
Write-Host "1. PowerShell中文显示问题的解决方法"
Write-Host "2. 真实GitHub API的使用（无需认证）"
Write-Host "3. GitHub个人访问令牌的获取和使用"
Write-Host "4. Bearer Token认证机制的测试"
Write-Host "5. 完整的OAuth 2.0客户端凭证流程"
Write-Host ""
Write-Host "要使用真实的OAuth 2.0认证，请按照步骤3获取GitHub个人访问令牌"
Write-Host "然后将令牌添加到脚本中的相应位置"
Write-Host ""

# Wait for user input
Read-Host "按Enter键退出"