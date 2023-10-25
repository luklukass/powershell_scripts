

#Otevreni dialogu pro vyber souboru

$openFileDialog = New-Object System.Windows.Forms.OpenFileDialog
$openFileDialog.Filter = "CSV files (*.csv)|*.csv"
$openFileDialog.Title = "Select input CSV file"
$openFileDialog.ShowDialog() | Out-Null
$csvFile = $openFileDialog.FileName

#Kontrola zda byl vybran soubor
if($csvFile) {
   
    $csv = Import-Csv $csvFile -Delimiter ","
}
else {
    Write-Host "Chyba: Nevybrán soubor"
    exit
}

#Otevreni dialogu pro ulozeni souboru

$saveFileDialog = New-Object System.Windows.Forms.SaveFileDialog
$saveFileDialog.Filter = "CSV files (*.csv)|*.csv"
$saveFileDialog.Title = "Select output CSV file"
$saveFileDialog.ShowDialog() | Out-Null
$outputFile = $saveFileDialog.FileName


#Kontrola zda byl vybran soubor
if($outputfile) {
    
    $csv | Export-Csv $outputFile -NoTypeInformation -Delimiter ","
}
else {
    Write-Host "Chyba: Nevybrán soubor"
    exit
}

# cteni csv souboru
$csv = Import-Csv $csvFile -Delimiter "," 

# dotaz pro kazdpou IP na ipinfo.io
foreach ($row in $csv) {
    $ip = $row.IP
    $ipInfo = Invoke-RestMethod -Uri "https://ipinfo.io/$ip/json"
    $row | Add-Member -MemberType NoteProperty -Name "Country" -Value $ipInfo.Country
    $row | Add-Member -MemberType NoteProperty -Name "City" -Value $ipInfo.City
    $row | Add-Member -MemberType NoteProperty -Name "ISP" -Value $ipInfo.org
}


# vypis do souboru
$csv | Export-Csv $outputFile -NoTypeInformation 
