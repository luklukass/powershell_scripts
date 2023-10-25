# Set the directory path
$directory = "C:\yourpath"

# Get the list of files in the directory
$files = Get-ChildItem -Path $directory | Where-Object { $_.Extension -match ".jpg|.png|.jpeg" }

# Set the initial number for renaming
$counter = 1

# Iterate through each file and rename it
foreach ($file in $files) {
    $newName = "$counter" + $file.Extension
    $newPath = Join-Path -Path $directory -ChildPath $newName
    Rename-Item -Path $file.FullName -NewName $newPath -Force
    $counter++
}

# Display completion message
Write-Host "Renaming completed."