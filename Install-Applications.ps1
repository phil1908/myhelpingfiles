# Software install Script
#
# Applications to install:
#
# PowerShell 7
# Google Chrome
# Notepad++
# 



#region Set logging 
$logFile = "c:\temp\" + (get-date -format 'yyyyMMdd') + '_softwareinstall.log'
function Write-Log {
    Param($message)
    Write-Output "$(get-date -format 'yyyyMMdd HH:mm:ss') $message" | Out-File -Encoding utf8 $logFile -Append
}
#endregion

#region PowerShell 7
try {
    Start-Process -filepath msiexec.exe -Wait -ErrorAction Stop -ArgumentList '/i', 'c:\temp\PowerShell-7.2.0-win-x64.msi', '/quiet'
    if (Test-Path "C:\Program Files\PowerShell\7\pwsh.exe") {
        Write-Log "PowerShell 7 has been installed"
    }
    else {
        write-log "Error locating the PowerShell 7 executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error installing PowerShell 7: $ErrorMessage"
}
#endregion

#region Notepad++
try {
    Start-Process -filepath 'c:\temp\npp.8.1.9.3.Installer.x64.exe' -Wait -ErrorAction Stop -ArgumentList '/S'
    if (Test-Path "C:\Program Files\Notepad++\notepad++.exe") {
        Write-Log "Notepad++ has been installed"
    }
    else {
        write-log "Error locating the Notepad++ executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error installing Notepad++: $ErrorMessage"
}
#endregion

#region Google Chrome
try {
    Start-Process -filepath msiexec.exe -Wait -ErrorAction Stop -ArgumentList '/i', "C:\temp\googlechromebetastandaloneenterprise64.msi", '/quiet'
    if (Test-Path "C:\Program Files\Google\Chrome\Application\chrome.exe") {
        Write-Log "Google Chrome has been installed"
    }
    else {
        write-log "Error locating the Google Chrome executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error installing Google Chrome: $ErrorMessage"
}
#endregion

#region VSCode
try {
    Start-Process -filepath 'C:\temp\VSCodeSetup-x64-1.63.0.exe' -Wait -ErrorAction Stop -ArgumentList '/VERYSILENT', '/mergetasks=!runcode'
    if (Test-Path "C:\Program Files\Microsoft VS Code\Code.exe") {
        Write-Log "VSCode has been installed"
    }
    else {
        write-log "Error locating the Google Chrome executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error installing CSCode: $ErrorMessage"
}
#endregion

#region Sysprep Fix
# Fix for first login delays due to Windows Module Installer
try {
    ((Get-Content -path C:\DeprovisioningScript.ps1 -Raw) -replace 'Sysprep.exe /oobe /generalize /quiet /quit', 'Sysprep.exe /oobe /generalize /quit /mode:vm' ) | Set-Content -Path C:\DeprovisioningScript.ps1
    write-log "Sysprep Mode:VM fix applied"
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error updating script: $ErrorMessage"
}
#endregion

#region Time Zone Redirection
$Name = "fEnableTimeZoneRedirection"
$value = "1"
# Add Registry value
try {
    New-ItemProperty -ErrorAction Stop -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" -Name $name -Value $value -PropertyType DWORD -Force
    if ((Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services").PSObject.Properties.Name -contains $name) {
        Write-log "Added time zone redirection registry key"
    }
    else {
        write-log "Error locating the Teams registry key"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error adding teams registry KEY: $ErrorMessage"
}
#endregion
