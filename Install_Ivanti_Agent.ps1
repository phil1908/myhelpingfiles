# URL der Datei
$url = "https://cestgaleriespro01.blob.core.windows.net/container-ivantiagents-01/carexpert%20AVD%20Client%20Agent%20Group%202021.1%20SU3.exe"

# Installation direkt ausführen
Start-Process -FilePath "powershell" -ArgumentList "-Command", "& {Invoke-WebRequest -Uri $url -OutFile $env:TEMP\carexpert_AVD_Client_Agent_Group_2021.1_SU3.exe; Start-Process -FilePath $env:TEMP\carexpert_AVD_Client_Agent_Group_2021.1_SU3.exe -Wait}"
