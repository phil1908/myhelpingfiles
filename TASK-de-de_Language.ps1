$source = "https://intuneblobthephilip.blob.core.windows.net/openuri/de-de_Language.ps1"
$destination = "c:\windows\temp\de-de_Language.ps1"

if (!(Test-Path -Path $destination)) {
  Invoke-WebRequest -Uri $source -OutFile $destination
    
} else {
  Write-Output "Destination file already exists"
}

$Principal = New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -RunLevel Highest
$Actions = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument '-Windowstyle Hidden -ExecutionPolicy Bypass -File c:\windows\temp\de-de_Language.ps1'
$Trigger = New-ScheduledTaskTrigger -AtStartup
$Settings = New-ScheduledTaskSettingsSet -RunOnlyIfNetworkAvailable -Hidden -StartWhenAvailable
$Task = New-ScheduledTask -Principal $Principal -Action $Actions -Trigger $Trigger -Settings $Settings
$taskName = "Betriebssystemsprache Deutsch"
$registerTask = Register-ScheduledTask -TaskName $taskName -InputObject $Task
