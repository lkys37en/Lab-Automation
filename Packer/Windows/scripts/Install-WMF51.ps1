$WMF5Url="http://download.microsoft.com/download/6/F/5/6F5FF66C-6775-42B0-86C4-47D41F2DA187/Win8.1AndW2K12R2-KB3191564-x64.msu"
$WMF5Dst="C:\windows\temp\Win8.1AndW2K12R2-KB3191564-x64.msu"

Write-Host "Downloading .NET WMF5.1 installer from $WMF5Url and saving it to $WMF5Dst"

(New-Object System.Net.WebClient).DownloadFile($WMF5Url, $WMF5Dst)

Write-Host "Installing VMF5.1"
Start-process -Wait -FilePath wusa -ArgumentList 'C:\windows\temp\Win8.1AndW2K12R2-KB3191564-x64.msu /quiet /norestart' -PassThru -Verbose