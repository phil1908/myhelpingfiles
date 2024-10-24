######################################

$source = "https://cestgaleriespro01.blob.core.windows.net/container-avd-01/DE-region.xml"
$destination = "c:\windows\temp\DE-region.xml"

if (!(Test-Path -Path $destination)) {
  #Copy-Item -Path $source -Destination $destination
  Invoke-WebRequest -Uri $source -OutFile $destination
    
} else {
  Write-Output "Destination file already exists"
}

# Set Locale, language etc. 
& $env:SystemRoot\System32\control.exe "intl.cpl,,/f:`"$destination`""

# Set languages/culture. Not needed perse.
Set-WinSystemLocale de-DE
Set-WinUserLanguageList -LanguageList de-DE -Force
Set-Culture -CultureInfo de-DE
Set-WinHomeLocation -GeoId 94
Set-TimeZone -Id "W. Europe Standard Time"

# restart virtual machine to apply regional settings to current user. You could also do a logoff and login.
Start-sleep -Seconds 40
# Restart-Computer