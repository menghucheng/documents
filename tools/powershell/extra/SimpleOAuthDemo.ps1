# 简单的OAuth 2.0 API示例

# 清除屏幕
Clear-Host
Write-Host "=== PowerShell OAuth 2.0 示例 ==="
Write-Host ""

# 配置API参数
$tokenUrl = "https://reqres.in/api/login"
$apiUrl = "https://reqres.in/api/users?page=2"

# 1. 获取令牌
Write-Host "1. 获取访问令牌..."
$loginData = @{email="eve.holt@reqres.in"; password="cityslicka"}

# 发送请求获取令牌
try {
    $tokenResponse = Invoke-RestMethod -Uri $tokenUrl -Method Post -ContentType "application/json" -Body (ConvertTo-Json $loginData)
    $token = $tokenResponse.token
    Write-Host "成功获取令牌: $token"
} catch {
    Write-Host "获取令牌失败: $_.Exception.Message"
    pause
    exit 1
}

Write-Host ""

# 2. 使用令牌访问API
Write-Host "2. 使用Bearer令牌访问API..."
$headers = @{Authorization="Bearer $token"}

# 发送API请求
try {
    $apiResult = Invoke-RestMethod -Uri $apiUrl -Method Get -Headers $headers -ContentType "application/json"
    Write-Host "API访问成功！"
} catch {
    Write-Host "API访问失败: $_.Exception.Message"
    pause
    exit 1
}

Write-Host ""

# 3. 解析JSON响应
Write-Host "3. 解析JSON响应..."
Write-Host "总用户数: $($apiResult.total)"
Write-Host "当前页: $($apiResult.page)"
Write-Host ""
Write-Host "用户列表:"
Write-Host "-------------------------------"

# 遍历用户数据
foreach ($user in $apiResult.data) {
    Write-Host "ID: $($user.id), 姓名: $($user.first_name) $($user.last_name), 邮箱: $($user.email)"
}

Write-Host ""
Write-Host "=== 示例完成 ==="
pause