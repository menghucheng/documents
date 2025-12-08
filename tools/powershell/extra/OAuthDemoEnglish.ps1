# Simple OAuth 2.0 API Demo for PowerShell

# Clear screen
Clear-Host
Write-Host "=== PowerShell OAuth 2.0 Demo ==="
Write-Host ""

# Configure API parameters
$tokenUrl = "https://reqres.in/api/login"
$apiUrl = "https://reqres.in/api/users?page=2"

# 1. Get Access Token
Write-Host "1. Getting access token..."
$loginData = @{email="eve.holt@reqres.in"; password="cityslicka"}

try {
    $tokenResponse = Invoke-RestMethod -Uri $tokenUrl -Method Post -ContentType "application/json" -Body (ConvertTo-Json $loginData)
    $token = $tokenResponse.token
    Write-Host "Token obtained successfully: $token"
} catch {
    Write-Host "Failed to get token: $($_.Exception.Message)"
    pause
    exit 1
}

Write-Host ""

# 2. Use Token to Access API
Write-Host "2. Using Bearer token to access API..."
$headers = @{Authorization="Bearer $token"}

try {
    $apiResult = Invoke-RestMethod -Uri $apiUrl -Method Get -Headers $headers -ContentType "application/json"
    Write-Host "API access successful!"
} catch {
    Write-Host "API access failed: $($_.Exception.Message)"
    pause
    exit 1
}

Write-Host ""

# 3. Parse JSON Response
Write-Host "3. Parsing JSON response..."
Write-Host "Total users: $($apiResult.total)"
Write-Host "Current page: $($apiResult.page)"
Write-Host ""
Write-Host "User list:"
Write-Host "-------------------------------"

# Loop through user data
foreach ($user in $apiResult.data) {
    Write-Host "ID: $($user.id), Name: $($user.first_name) $($user.last_name), Email: $($user.email)"
}

Write-Host ""
Write-Host "=== Demo Complete ==="
pause