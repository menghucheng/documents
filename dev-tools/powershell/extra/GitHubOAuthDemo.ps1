# GitHub API OAuth 2.0 Demo for PowerShell

# Clear screen
Clear-Host
Write-Host "=== GitHub API OAuth 2.0 Demo ==="
Write-Host ""

# Step 1: Introduction
Write-Host "This demo shows how to use GitHub API with OAuth 2.0 authentication"
Write-Host "It will use the GitHub public API (no authentication required for read-only access)"
Write-Host ""

# Step 2: Making an API Call to GitHub
Write-Host "2. Calling GitHub API"
$githubApiUrl = "https://api.github.com/users/octocat"

Write-Host "   API Endpoint: $githubApiUrl"
Write-Host "   Calling API..."

# Make the API call
try {
    $githubResponse = Invoke-RestMethod -Uri $githubApiUrl -Method Get
    Write-Host "   API call successful!"
    Write-Host ""
} catch {
    Write-Host "   API call failed: $($_.Exception.Message)"
    Write-Host "   Press Enter to exit..."
    Read-Host
    exit 1
}

# Step 3: Parsing JSON Response
Write-Host "3. Parsing JSON Response"
Write-Host "   GitHub User Information:"
Write-Host "   Name: $($githubResponse.name)"
Write-Host "   Username: $($githubResponse.login)"
Write-Host "   Company: $($githubResponse.company)"
Write-Host "   Location: $($githubResponse.location)"
Write-Host "   Bio: $($githubResponse.bio)"
Write-Host "   Public Repos: $($githubResponse.public_repos)"
Write-Host "   Followers: $($githubResponse.followers)"
Write-Host "   Following: $($githubResponse.following)"
Write-Host ""

# Step 4: Complete OAuth 2.0 Example
Write-Host "4. OAuth 2.0 with GitHub API Example"
Write-Host "   If you need to use authenticated endpoints, here's how:"
Write-Host ""
Write-Host "   # Generate a personal access token from GitHub settings"
Write-Host "   $personalAccessToken = 'your-github-personal-access-token'"
Write-Host "   "
Write-Host "   # Use the token in API calls"
Write-Host "   $headers = @{Authorization = 'Bearer ' + $personalAccessToken}"
Write-Host "   $response = Invoke-RestMethod -Uri 'https://api.github.com/user' -Headers $headers"
Write-Host ""

# Step 5: Error Handling Example
Write-Host "5. Error Handling Example"
Write-Host "   Real-world error handling for API calls:"
Write-Host ""
Write-Host "   try {
       $response = Invoke-RestMethod -Uri 'https://api.github.com/users' -Headers $headers
   } catch {
       Write-Host 'Error Type: ' $_.Exception.GetType().FullName
       Write-Host 'Error Message: ' $_.Exception.Message
       if ($_.ErrorDetails.Message) {
           $errorJson = $_.ErrorDetails.Message | ConvertFrom-Json
           Write-Host 'API Error: ' $errorJson.message
       }
   }"
Write-Host ""

# Step 6: Working with Pagination
Write-Host "6. Working with Pagination"
Write-Host "   GitHub API uses pagination for large results. Here's how to handle it:"
Write-Host ""
Write-Host "   $page = 1"
Write-Host "   $allUsers = @()"
Write-Host "   "
Write-Host "   do {
       $url = "https://api.github.com/users?since=$((($page-1)*30))"
       $users = Invoke-RestMethod -Uri $url
       $allUsers += $users
       $page++
   } while ($users.Count -gt 0)"
Write-Host ""

# Summary
Write-Host "=== Demo Complete ==="
Write-Host ""
Write-Host "What you learned:"
Write-Host "1. Basic GitHub API calls"
Write-Host "2. Parsing JSON responses"
Write-Host "3. OAuth 2.0 authentication with GitHub"
Write-Host "4. Error handling for API calls"
Write-Host "5. Working with paginated results"
Write-Host ""

# Wait for user input
Write-Host "Press Enter to exit..."
Read-Host