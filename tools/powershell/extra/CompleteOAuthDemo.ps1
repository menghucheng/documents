# Complete PowerShell OAuth 2.0 Demo with Mock Data

# Clear screen
Clear-Host
Write-Host "=== PowerShell OAuth 2.0 Complete Demo ==="
Write-Host ""
Write-Host "This demo shows the complete OAuth 2.0 flow using mock data"
Write-Host "No actual API calls are made, so it will always work!"
Write-Host ""

# Step 1: Configuration
Write-Host "1. Configuration"
$config = @{
    TokenEndpoint = "https://api.example.com/token"
    ApiEndpoint = "https://api.example.com/users"
    ClientId = "your-client-id"
    ClientSecret = "your-client-secret"
    Scope = "read:users"
}

Write-Host "   Token Endpoint: $($config.TokenEndpoint)"
Write-Host "   API Endpoint: $($config.ApiEndpoint)"
Write-Host "   Client ID: $($config.ClientId)"
Write-Host ""

# Step 2: Getting Access Token
Write-Host "2. Getting Access Token"
Write-Host "   Sending client credentials to token endpoint..."

# Mock token response
$mockTokenResponse = @{
    access_token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"
    token_type = "Bearer"
    expires_in = 3600
    scope = "read:users"
}

Write-Host "   Token obtained successfully!"
Write-Host "   Access Token: $($mockTokenResponse.access_token)"
Write-Host "   Token Type: $($mockTokenResponse.token_type)"
Write-Host "   Expires In: $($mockTokenResponse.expires_in) seconds"
Write-Host ""

# Step 3: Using Access Token
Write-Host "3. Using Access Token"
$headers = @{
    "Authorization" = "$($mockTokenResponse.token_type) $($mockTokenResponse.access_token)"
    "Content-Type" = "application/json"
}

Write-Host "   Authorization Header:"
Write-Host "   Bearer $($mockTokenResponse.access_token.Substring(0, 20))..."
Write-Host ""

# Step 4: API Response (Mock)
Write-Host "4. API Response (Mock Data)"
$mockApiResponse = @{
    "page" = 1
    "per_page" = 6
    "total" = 12
    "total_pages" = 2
    "data" = @(
        @{
            "id" = 1
            "email" = "george.bluth@reqres.in"
            "first_name" = "George"
            "last_name" = "Bluth"
            "avatar" = "https://reqres.in/img/faces/1-image.jpg"
        },
        @{
            "id" = 2
            "email" = "janet.weaver@reqres.in"
            "first_name" = "Janet"
            "last_name" = "Weaver"
            "avatar" = "https://reqres.in/img/faces/2-image.jpg"
        },
        @{
            "id" = 3
            "email" = "emma.wong@reqres.in"
            "first_name" = "Emma"
            "last_name" = "Wong"
            "avatar" = "https://reqres.in/img/faces/3-image.jpg"
        }
    )
}

Write-Host "   Total Users: $($mockApiResponse.total)"
Write-Host "   Current Page: $($mockApiResponse.page)"
Write-Host "   Users on Page: $($mockApiResponse.data.Count)"
Write-Host ""

# Step 5: Parsing JSON Response
Write-Host "5. Parsing JSON Response"
Write-Host "   User List:"
Write-Host "   ID | Email | First Name | Last Name"
Write-Host "   -------------------------------------"

foreach ($user in $mockApiResponse.data) {
    Write-Host "   $($user.id) | $($user.email) | $($user.first_name) | $($user.last_name)"
}

Write-Host ""

# Step 6: Complete JSON Output
Write-Host "6. Complete JSON Output (first 500 chars)"
$jsonOutput = $mockApiResponse | ConvertTo-Json -Depth 3
Write-Host "   $($jsonOutput.Substring(0, [Math]::Min(500, $jsonOutput.Length)))..."
Write-Host ""

# Step 7: Error Handling Example
Write-Host "7. Error Handling Example"
Write-Host "   Here's how to handle errors in real API calls:"
Write-Host ""
Write-Host "   try {
       $response = Invoke-RestMethod -Uri $apiUrl -Headers $headers
   } catch {
       Write-Host 'Error: ' $_.Exception.Message
       if ($_.ErrorDetails.Message) {
           Write-Host 'API Error: ' $_.ErrorDetails.Message
       }
   }"
Write-Host ""

# Summary
Write-Host "=== Demo Complete ==="
Write-Host ""
Write-Host "What you learned:"
Write-Host "1. OAuth 2.0 configuration"
Write-Host "2. Getting access tokens"
Write-Host "3. Using Bearer tokens in API calls"
Write-Host "4. Parsing JSON responses"
Write-Host "5. Error handling techniques"
Write-Host ""

# Wait for user input
Write-Host "Press Enter to exit..."
Read-Host