$WMFUrl = "https://lkylabsfs.lkys37en.com/3wLyZu0TkfB1WSuTEST0/WMF51/Win7AndW2K8R2-KB3191566-x64.msu"
$WMFDst = "C:\windows\temp\Win7AndW2K8R2-KB3191566-x64.msu"

Write-Host "Downloading WMF 5.1 from $WMFUrl and saving it to $WMFUrl"

(New-Object System.Net.WebClient).DownloadFile($WMFUrl, $WMFDst)

Write-Host "Installing VMF5.1"
Start-Process -FilePath C:\windows\temp\Win7AndW2K8R2-KB3191566-x64.msu -ArgumentList '/quiet /norestart' -Wait -PassThru