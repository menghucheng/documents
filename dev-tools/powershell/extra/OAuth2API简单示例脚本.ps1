<#
.SYNOPSIS
简单的PowerShell OAuth 2.0 API访问示例脚本
.DESCRIPTION
本脚本演示OAuth 2.0 API访问流程，使用公开测试API
#>

# 清除控制台
Clear-Host
Write-Host "==============================================="
Write-Host "PowerShell OAuth 2.0 API示例脚本"
Write-Host "==============================================="
Write-Host "使用公开测试API，无需真实凭据"
Write-Host "==============================================="
Write-Host ""

# 1. 配置参数
$config = @{
    TokenEndpoint = "https://reqres.in/api/login"
    ApiEndpoint = "https://reqres.in/api/users?page=2"
    Username = "eve.holt@reqres.in"
    Password = "cityslicka"
}

# 2. 获取访问令牌
try {
    Write-Host "[1] 获取访问令牌..."
    
    $tokenBody = @{
        email = $config.Username
        password = $config.Password
    }
    
    $tokenResponse = Invoke-RestMethod -Uri $config.TokenEndpoint `
                                      -Method Post `
                                      -ContentType "application/json" `
                                      -Body ($tokenBody | ConvertTo-Json)
    
    $accessToken = $tokenResponse.token
    Write-Host "✅ 成功获取令牌: $accessToken"
    Write-Host ""
    
} catch {
    Write-Host "❌ 获取令牌失败: $($_.Exception.Message)"
    if ($_.ErrorDetails.Message) {
        Write-Host "API错误: $($_.ErrorDetails.Message)"
    }
    Read-Host "按Enter退出"
    exit 1
}

# 3. 使用令牌访问API
try {
    Write-Host "[2] 使用令牌访问API..."
    
    $headers = @{
        "Authorization" = "Bearer $accessToken"
        "Content-Type" = "application/json"
    }
    
    $apiResponse = Invoke-RestMethod -Uri $config.ApiEndpoint `
                                   -Method Get `
                                   -Headers $headers
    
    Write-Host "✅ API访问成功！"
    Write-Host ""
    
} catch {
    Write-Host "❌ API访问失败: $($_.Exception.Message)"
    if ($_.ErrorDetails.Message) {
        Write-Host "API错误: $($_.ErrorDetails.Message)"
    }
    Read-Host "按Enter退出"
    exit 1
}

# 4. 解析响应
Write-Host "[3] 解析API响应..."
Write-Host ""

Write-Host "📋 基本信息:"
Write-Host "总页数: $($apiResponse.total_pages)"
Write-Host "总用户数: $($apiResponse.total)"
Write-Host "当前页: $($apiResponse.page)"
Write-Host ""

Write-Host "👥 用户列表:"
Write-Host "-----------------------------------------------"
Write-Host "ID | 邮箱 | 姓名 | 头像"
Write-Host "-----------------------------------------------"

foreach ($user in $apiResponse.data) {
    Write-Host "$($user.id) | $($user.email) | $($user.first_name) $($user.last_name) | $($user.avatar)"
}

Write-Host "-----------------------------------------------"
Write-Host ""

# 5. 显示完整响应选项
$showFull = Read-Host "显示完整JSON响应？(Y/N)"
if ($showFull -eq "Y" -or $showFull -eq "y") {
    Write-Host ""
    Write-Host "📄 完整JSON响应:"
    $apiResponse | ConvertTo-Json -Depth 10
}

# 总结
Write-Host "==============================================="
Write-Host "脚本执行完成！"
Write-Host "==============================================="
Write-Host "您已完成："
Write-Host "1. 获取OAuth 2.0令牌"
Write-Host "2. 使用Bearer令牌访问API"
Write-Host "3. 解析JSON响应"
Write-Host ""

Read-Host "按Enter退出"