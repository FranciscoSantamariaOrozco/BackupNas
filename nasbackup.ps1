$limit = (Get-Date).AddDays(-60)
$files = Get-ChildItem -Path "C:/" -Recurse | Where-Object { $_.LastWriteTime -lt $limit }

# Import the SharePointPnPPowerShellOnline module
Import-Module SharePointPnPPowerShellOnline

# Connect to SharePoint Online
Connect-PnPOnline -Url "https://<tenant>.sharepoint.com/sites/<sitename>" -Credentials (Get-Credential)

# Loop through the old files and move them to SharePoint Online
foreach ($file in $files)
{
    # Specify the target folder in SharePoint Online
    $targetFolder = "/sites/<sitename>/Shared Documents/Old Files"

    # Upload the file to SharePoint Online
    Add-PnPFile -Path $file.FullName -Folder $targetFolder

    # Output status message
    Write-Host "Moved file $($file.FullName) to $targetFolder"
}