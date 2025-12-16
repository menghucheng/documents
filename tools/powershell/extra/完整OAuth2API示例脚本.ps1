<#
.SYNOPSIS
完整的PowerShell OAuth 2.0 API访问示例脚本
.DESCRIPTION
本脚本演示了如何使用PowerShell实现OAuth 2.0 Client Credentials Grant流程，
包括获取访问令牌、使用令牌访问API以及解析JSON响应。
此版本使用公开测试API，无需真实凭据即可测试。
.AUTHOR
PowerShell学习文档
.VERSION
1.0
#>

# 清除控制台
Clear-Host
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "PowerShell OAuth 2.0 API访问完整示例脚本" -ForegroundColor Cyan
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "此脚本使用公开测试API，无需真实凭据即可运行"
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host ""

# 1. 配置参数 - 这里使用ReqRes.in的公开测试API
# ReqRes.in提供免费的测试API，无需注册
$config = @{
    # 模拟的OAuth 2.0令牌端点（ReqRes.in提供的测试端点）
    TokenEndpoint = "https://reqres.in/api/login"
    
    # 模拟的受保护API端点（获取用户列表）
    ApiEndpoint = "https://reqres.in/api/users?page=2"
    
    # 测试用的凭据（ReqRes.in的测试账户）
    TestUsername = "eve.holt@reqres.in"
    TestPassword = "cityslicka"
}

# 2. 获取访问令牌（使用ReqRes.in的登录端点模拟）
try {
    Write-Host "[步骤1] 正在获取访问令牌..." -ForegroundColor Cyan
    
    # 构建请求体 - 根据API要求调整字段名
    $tokenRequestBody = @{
        email = $config.TestUsername
        password = $config.TestPassword
    }
    
    # 发送请求获取令牌
    $tokenResponse = Invoke-RestMethod -Uri $config.TokenEndpoint `
                                      -Method Post `
                                      -ContentType "application/json" `
                                      -Body ($tokenRequestBody | ConvertTo-Json) `
                                      -ErrorAction Stop
    
    # 提取访问令牌
    $accessToken = $tokenResponse.token
    
    Write-Host "✅ 成功获取访问令牌！" -ForegroundColor Green
    Write-Host "令牌: $accessToken" -ForegroundColor Yellow
    Write-Host ""
    
} catch {
    Write-Host "❌ 获取访问令牌失败: $($_.Exception.Message)" -ForegroundColor Red
    if ($_.ErrorDetails.Message) {
        Write-Host "API错误详情: $($_.ErrorDetails.Message)" -ForegroundColor Red
    }
    Write-Host "按任意键退出..." -ForegroundColor Yellow
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

# 3. 使用访问令牌访问API
try {
    Write-Host "[步骤2] 正在使用令牌访问API..." -ForegroundColor Cyan
    
    # 构建请求头
    $apiHeaders = @{
        "Authorization" = "Bearer $accessToken"  # 添加Bearer令牌
        "Content-Type" = "application/json"
    }
    
    # 发送请求到API
    $apiResponse = Invoke-RestMethod -Uri $config.ApiEndpoint `
                                   -Method Get `
                                   -Headers $apiHeaders `
                                   -ErrorAction Stop
    
    Write-Host "✅ API访问成功！" -ForegroundColor Green
    Write-Host ""
    
} catch {
    Write-Host "❌ API访问失败: $($_.Exception.Message)" -ForegroundColor Red
    if ($_.ErrorDetails.Message) {
        Write-Host "API错误详情: $($_.ErrorDetails.Message)" -ForegroundColor Red
    }
    Write-Host "按任意键退出..." -ForegroundColor Yellow
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

# 4. 解析和显示API响应
Write-Host "[步骤3] 解析API响应..." -ForegroundColor Cyan
Write-Host ""

# 显示响应的基本信息
Write-Host "📋 响应基本信息:" -ForegroundColor Yellow
Write-Host "- 响应类型: $($apiResponse.GetType().Name)"
Write-Host "- 总页数: $($apiResponse.total_pages)"
Write-Host "- 总用户数: $($apiResponse.total)"
Write-Host "- 当前页: $($apiResponse.page)"
Write-Host "- 当前页用户数: $($apiResponse.per_page)"
Write-Host ""

# 显示用户列表
Write-Host "👥 用户列表:" -ForegroundColor Yellow
Write-Host "-----------------------------------------------"
Write-Host "ID | 邮箱 | 姓名 | 头像"
Write-Host "-----------------------------------------------"

foreach ($user in $apiResponse.data) {
    Write-Host "$($user.id) | $($user.email) | $($user.first_name) $($user.last_name) | $($user.avatar)"
}

Write-Host "-----------------------------------------------"
Write-Host ""

# 显示完整的JSON响应（可选）
$showFullResponse = Read-Host "是否显示完整的JSON响应？(Y/N)"
if ($showFullResponse -eq "Y" -or $showFullResponse -eq "y") {
    Write-Host ""
    Write-Host "📄 完整JSON响应:" -ForegroundColor Yellow
    $apiResponse | ConvertTo-Json -Depth 10
    Write-Host ""
}

# 5. 总结
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "脚本执行完成！" -ForegroundColor Green
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "您已成功完成："
Write-Host "1. 获取OAuth 2.0访问令牌"
Write-Host "2. 使用Bearer令牌访问受保护API"
Write-Host "3. 解析和处理JSON响应"
Write-Host ""
Write-Host "💡 学习提示："
Write-Host "- 查看脚本注释了解每个步骤"
Write-Host "- 修改$config中的参数以适应其他API"
Write-Host "- 尝试添加更多的错误处理和功能"
Write-Host "===============================================" -ForegroundColor Cyan

# 等待用户按键退出
Write-Host "按任意键退出..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")