# Simple PowerShell OAuth 2.0 Demo with httpbin.org

# Clear screen
Clear-Host

# Display welcome message
Write-Host "PowerShell OAuth 2.0 Demo"
Write-Host "==========================="
Write-Host ""
Write-Host "Testing with httpbin.org API - this will always work!"
Write-Host ""

# 1. Test basic API connectivity
Write-Host "1. Testing API connectivity..."
$testUrl = "https://httpbin.org/get"

try {
    $testResponse = Invoke-RestMethod -Uri $testUrl -Method Get
    Write-Host "   Success! Connected to httpbin.org"
    Write-Host "   Your IP address: $($testResponse.origin)"
    Write-Host ""
} catch {
    Write-Host "   Failed to connect: $($_.Exception.Message)"
    Read-Host "Press Enter to exit"
    exit 1
}

# 2. Simulate OAuth 2.0 token acquisition
Write-Host "2. Simulating OAuth 2.0 token acquisition..."
$tokenEndpoint = "https://httpbin.org/post"
$clientData = @{
    client_id = "demo_client"
    client_secret = "demo_secret"
    grant_type = "client_credentials"
    scope = "read:data"
}

try {
    $tokenResponse = Invoke-RestMethod -Uri $tokenEndpoint -Method Post -Body $clientData
    $accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"
    
    Write-Host "   Token acquired successfully!"
    Write-Host "   Access Token: $accessToken"
    Write-Host ""
} catch {
    Write-Host "   Failed to get token: $($_.Exception.Message)"
    Read-Host "Press Enter to exit"
    exit 1
}

# 3. Use token for authenticated API request
Write-Host "3. Using Bearer token for API request..."
$apiEndpoint = "https://httpbin.org/headers"
$headers = @{
    "Authorization" = "Bearer $accessToken"
    "Accept" = "application/json"
    "User-Agent" = "PowerShell OAuth Demo"
}

try {
    $apiResponse = Invoke-RestMethod -Uri $apiEndpoint -Method Get -Headers $headers
    
    Write-Host "   API request successful with Bearer token!"
    Write-Host "   Server received these headers:"
    Write-Host "   -------------------------------"
    
    foreach ($header in $apiResponse.headers.GetEnumerator()) {
        Write-Host "   $($header.Key): $($header.Value)"
    }
    
    Write-Host ""
} catch {
    Write-Host "   API request failed: $($_.Exception.Message)"
    Read-Host "Press Enter to exit"
    exit 1
}

# 4. Parse JSON response
Write-Host "4. Parsing JSON response..."
Write-Host "   Converting response to PowerShell object..."
Write-Host ""

# Convert to JSON and back to demonstrate parsing
$jsonString = $apiResponse | ConvertTo-Json
$parsedObject = $jsonString | ConvertFrom-Json

Write-Host "   JSON string length: $($jsonString.Length) characters"
Write-Host "   Parsed object type: $($parsedObject.GetType().FullName)"
Write-Host "   Has headers property: $($parsedObject.PSObject.Properties.Name -contains 'headers')"
Write-Host ""

# 5. Error handling example
Write-Host "5. Error handling example code:"
Write-Host "   -----------------------------"
Write-Host "   try {"
Write-Host "       $response = Invoke-RestMethod -Uri 'https://httpbin.org/get' -Headers $headers"
Write-Host "       Write-Host 'Request successful'"
Write-Host "   } catch {"
Write-Host "       Write-Host 'Error occurred: ' $_.Exception.Message"
Write-Host "   }"
Write-Host ""

# Summary
Write-Host "==========================="
Write-Host "Demo Complete!"
Write-Host "==========================="
Write-Host ""
Write-Host "You learned:"
Write-Host "- Basic API connectivity testing with httpbin.org"
Write-Host "- OAuth 2.0 token acquisition workflow"
Write-Host "- Using Bearer tokens in API requests"
Write-Host "- JSON response parsing in PowerShell"
Write-Host "- Basic error handling techniques"
Write-Host ""
Write-Host "This script demonstrates real API testing that always works!"
Write-Host ""

# Wait for user input
Read-Host "Press Enter to exit"