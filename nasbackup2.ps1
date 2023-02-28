$limit = (Get-Date).AddDays(-60)
$sourcePath = "C:/"
$destinationPath = "https://<sitio de SharePoint>/<biblioteca de documentos>/"
$files = Get-ChildItem -Path $sourcePath -Recurse | Where-Object { $_.LastWriteTime -lt $limit}

foreach ($file in $files) {
    $destination = $destinationPath + $file.Name
    Write-Host "Moving $($file.FullName) to $destination"
    Move-PnPFile -Path $file.FullName -Destination $destination -Force
}