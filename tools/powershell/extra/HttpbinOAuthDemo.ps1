# PowerShell OAuth 2.0 Demo using httpbin.org

# Clear screen
Clear-Host
Write-Host "=== PowerShell OAuth 2.0 Demo with httpbin.org ==="
Write-Host ""
Write-Host "This demo uses httpbin.org for reliable API testing"
Write-Host "No authentication required - perfect for learning!"
Write-Host ""

# Step 1: Understanding OAuth 2.0 Flow
Write-Host "1. OAuth 2.0 Flow Overview"
Write-Host "   - Client sends credentials to Token Endpoint"
Write-Host "   - Server returns Access Token"
Write-Host "   - Client uses Access Token for API calls"
Write-Host "   - Server verifies Token and returns data"
Write-Host ""

# Step 2: Testing with httpbin.org
Write-Host "2. Testing HTTP Requests with httpbin.org"
$httpbinUrl = "https://httpbin.org/get"

Write-Host "   Testing basic GET request..."

try {
    $response = Invoke-RestMethod -Uri $httpbinUrl -Method Get
    Write-Host "   ✓ Request successful!"
    Write-Host ""
} catch {
    Write-Host "   ✗ Request failed: $($_.Exception.Message)"
    Read-Host "Press Enter to exit..."
    exit 1
}

# Step 3: Simulating OAuth 2.0 Token Flow
Write-Host "3. Simulating OAuth 2.0 Token Acquisition"
Write-Host "   Using httpbin.org/post to simulate token endpoint..."

$tokenEndpoint = "https://httpbin.org/post"
$clientCredentials = @{
    client_id = "demo-client-id"
    client_secret = "demo-client-secret"
    grant_type = "client_credentials"
    scope = "read write"
}

try {
    $tokenResponse = Invoke-RestMethod -Uri $tokenEndpoint -Method Post -Body $clientCredentials
    
    # Extract token from response (simulated)
    $mockToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9..."
    
    Write-Host "   ✓ Token acquisition simulated successfully"
    Write-Host "   ✓ Access Token: $mockToken"
    Write-Host ""
} catch {
    Write-Host "   ✗ Token simulation failed: $($_.Exception.Message)"
    Read-Host "Press Enter to exit..."
    exit 1
}

# Step 4: Using Token in API Calls
Write-Host "4. Using Bearer Token in API Requests"
Write-Host "   Testing token authentication with httpbin.org..."

$apiEndpoint = "https://httpbin.org/get"
$headers = @{
    "Authorization" = "Bearer $mockToken"
    "Accept" = "application/json"
}

try {
    $apiResponse = Invoke-RestMethod -Uri $apiEndpoint -Method Get -Headers $headers
    
    Write-Host "   ✓ API request with Bearer token successful!"
    Write-Host "   ✓ Server received headers:"
    Write-Host "     - Authorization: $($apiResponse.headers.Authorization)"
    Write-Host "     - Accept: $($apiResponse.headers.Accept)"
    Write-Host ""
} catch {
    Write-Host "   ✗ API request failed: $($_.Exception.Message)"
    Read-Host "Press Enter to exit..."
    exit 1
}

# Step 5: Parsing JSON Responses
Write-Host "5. Parsing JSON Responses"
Write-Host "   Example of parsing JSON data:"
Write-Host ""

# Create sample JSON response
$sampleJson = @{
    "status" = "success"
    "data" = @(
        @{
            "id" = 1
            "name" = "Item 1"
            "value" = 100
        },
        @{
            "id" = 2
            "name" = "Item 2"
            "value" = 200
        }
    )
}

# Convert to JSON and back
$jsonString = $sampleJson | ConvertTo-Json
$parsedJson = $jsonString | ConvertFrom-Json

Write-Host "   JSON String:"
Write-Host "   $jsonString"
Write-Host ""
Write-Host "   Parsed Data:"
foreach ($item in $parsedJson.data) {
    Write-Host "     - Item $($item.id): $($item.name) ($($item.value))"
}
Write-Host ""

# Step 6: Real-world Error Handling
Write-Host "6. Error Handling Techniques"
Write-Host "   Comprehensive error handling for API calls:"
Write-Host ""
Write-Host "   try {"
Write-Host "       $response = Invoke-RestMethod -Uri $apiEndpoint -Headers $headers"
Write-Host "       Write-Host '✓ Success!'"
Write-Host "   } catch [System.Net.WebException] {"
Write-Host "       $errorResponse = $_.Exception.Response"
Write-Host "       $errorStream = $errorResponse.GetResponseStream()"
Write-Host "       $reader = New-Object System.IO.StreamReader($errorStream)"
Write-Host "       $errorText = $reader.ReadToEnd()"
Write-Host "       Write-Host '✗ Web Error: ' $errorText"
Write-Host "   } catch {"
Write-Host "       Write-Host '✗ General Error: ' $_.Exception.Message"
Write-Host "   }"
Write-Host ""

# Step 7: Complete OAuth 2.0 Flow Example
Write-Host "7. Complete OAuth 2.0 Flow Example"
Write-Host "   Putting it all together for a real API:"
Write-Host ""
Write-Host "   # 1. Configure API settings"
Write-Host "   $apiSettings = @{"
Write-Host "       TokenUrl = 'https://api.example.com/token'"
Write-Host "       ApiUrl = 'https://api.example.com/data'"
Write-Host "       ClientId = 'your-client-id'"
Write-Host "       ClientSecret = 'your-client-secret'"
Write-Host "   }"
Write-Host ""
Write-Host "   # 2. Get access token"
Write-Host "   $tokenBody = @{"
Write-Host "       client_id = $apiSettings.ClientId"
Write-Host "       client_secret = $apiSettings.ClientSecret"
Write-Host "       grant_type = 'client_credentials'"
Write-Host "   }"
Write-Host "   $tokenResponse = Invoke-RestMethod -Uri $apiSettings.TokenUrl -Method Post -Body $tokenBody"
Write-Host ""
Write-Host "   # 3. Use token for API calls"
Write-Host "   $authHeaders = @{Authorization = 'Bearer ' + $tokenResponse.access_token}"
Write-Host "   $apiData = Invoke-RestMethod -Uri $apiSettings.ApiUrl -Headers $authHeaders"
Write-Host ""
Write-Host "   # 4. Process results"
Write-Host "   foreach ($item in $apiData.items) {"
Write-Host "       Write-Host 'Item: ' $item.name"
Write-Host "   }"
Write-Host ""

# Summary
Write-Host "=== Demo Complete ==="
Write-Host ""
Write-Host "What you learned:"
Write-Host "1. OAuth 2.0 flow and concepts"
Write-Host "2. Using httpbin.org for API testing"
Write-Host "3. Working with Bearer tokens"
Write-Host "4. Parsing JSON responses"
Write-Host "5. Error handling best practices"
Write-Host ""
Write-Host "This script demonstrates the complete OAuth 2.0 workflow"
Write-Host "using reliable public APIs - it will always work!"
Write-Host ""

# Wait for user input
Write-Host "Press Enter to exit..."
Read-Host