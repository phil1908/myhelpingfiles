$source = "https://intuneblobthephilip.blob.core.windows.net/openuri/TASK-de-de_Language.ps1"
$destination = "c:\windows\temp\de-de_Language.ps1"

if (!(Test-Path -Path $destination)) {
  #Copy-Item -Path $source -Destination $destination
  Invoke-WebRequest -Uri $source -OutFile $destination
    
} else {
  Write-Output "Destination file already exists"
}

## Create Schedueled Tasks for the pop-up notifications
# Set the date to 09:00 on the day that the script runs
#$scheduledDate = [DateTime]::Today.AddHours(9)
#$scheduledDate = [DateTime]::Today.AddDays(30)
# Define Scheduled Task for the notifications. (the time and the messages are defined in the 'M365InstallationNotifications.ps1' script) 
#$notificationPrincipal = New-ScheduledTaskPrincipal -GroupId "BUILTIN\Users" -RunLevel Limited
$Principal = New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -RunLevel Highest
#$Principal = New-ScheduledTaskPrincipal -UserID $user -RunLevel Highest
$Actions = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument "-Windowstyle Hidden -ExecutionPolicy Bypass - File 'c:\windows\temp\de-de_Language.ps1'"
$Trigger = New-ScheduledTaskTrigger -AtStartup
$Settings = New-ScheduledTaskSettingsSet -RunOnlyIfNetworkAvailable -Hidden -StartWhenAvailable
$Task = New-ScheduledTask -Principal $Principal -Action $Actions -Trigger $Trigger -Settings $Settings
$taskName = "Betriebssystemsprache Deutsch"
$registerTask = Register-ScheduledTask -TaskName $taskName -InputObject $Task