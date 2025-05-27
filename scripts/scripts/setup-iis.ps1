# This script installs IIS on a Windows Server VM and sets a custom HTML homepage

# Install the IIS Web-Server role
Install-WindowsFeature -name Web-Server -IncludeManagementTools

# Set the path to the default IIS start page
$path = "C:\inetpub\wwwroot\iisstart.htm"

# Replace content with custom homepage HTML (example message for Canada WebServer 1)
$html = @"
<!DOCTYPE html>
<html>
<head>
    <title>Canada Web Server 1 🇨🇦</title>
    <style>
        body { background-color: #0072C6; color: white; text-align: center; font-family: Arial; }
        h1 { margin-top: 20%; font-size: 3em; }
    </style>
</head>
<body>
    <h1>Welcome to Canada Web Server 1 🇨🇦</h1>
    <p>Load Balanced by Azure App Gateway</p>
</body>
</html>
"@

# Write the HTML content to the file
$html | Set-Content -Path $path -Encoding UTF8

# Restart IIS to make sure changes apply
iisreset
