$NETurl = "https://download.microsoft.com/download/6/E/4/6E48E8AB-DC00-419E-9704-06DD46E5F81D/NDP472-KB4054530-x86-x64-AllOS-ENU.exe"
$NETdst = "C:\windows\temp\NDP472-KB4054530-x86-x64-AllOS-ENU.exe"

Write-Host "Downloading .NET 4.7.2 web installer from $NETurl and saving it to $NETdst"

(New-Object System.Net.WebClient).DownloadFile($NETurl, $NETdst)


Write-Host "Installing .NET 4.7.2"
Start-Process -Wait -FilePath $NETdst -ArgumentList '/passive /norestart' -PassThru -Verbose