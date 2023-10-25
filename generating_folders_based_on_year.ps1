$rootPath = "C:\"
$year = "2023"

# Specify Czech culture
$czechCulture = [System.Globalization.CultureInfo]::GetCultureInfo("cs-CZ")

# Create year folder
New-Item -ItemType Directory -Force -Path "$rootPath\$year"

# Loop through months
for ($month = 1; $month -le 12; $month++) {
    $monthName = $czechCulture.DateTimeFormat.GetMonthName($month)
    $monthFolder = New-Item -ItemType Directory -Force -Path "$rootPath\$year\$monthName"
    
    # Loop through days
    $daysInMonth = [System.DateTime]::DaysInMonth($year, $month)
    for ($day = 1; $day -le $daysInMonth; $day++) {
        $dayFolder = New-Item -ItemType Directory -Force -Path "$rootPath\$year\$monthName\$day"
    }
}
