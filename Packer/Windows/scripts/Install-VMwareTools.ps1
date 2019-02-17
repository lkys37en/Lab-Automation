$VMTools = ((Invoke-WebRequest –Uri ‘https://packages.vmware.com/tools/releases/latest/windows/x64/’ -UseBasicParsing).Links | Where-Object outerHTML -like “*VMware-tools*”).href
$DownloadUrl = "https://packages.vmware.com/tools/releases/latest/windows/x64/$VMTools"
$DownloadPath = "C:\Windows\Temp\$VMTools"


Write-host "Downloading vmware tools from $DOwnloadUrl and saving to $DownloadPath"

(New-Object System.Net.WebClient).DownloadFile($DownloadUrl, $DownloadPath)

Write-host "Installing VMware Tools"

if (([Environment]::OSVersion.Version.Build) -match "7601") {
    Write-Host "Windows 7 was detected"
    cmd /c $DownloadPath /S /V "/qn REBOOT=ReallySuppress"
}

else {
    Write-Host "Windows 7 wasn't detected"
    Start-Process -Wait $DownloadPath -ArgumentList '/S /V "/qn REBOOT=ReallySuppress"' -PassThru
}

Write-Host "Waiting for vmware tools to complete"
Start-Sleep -Seconds 30 

if (Get-Process -Name VMwareToolsUpgrader) {
    Write-Host "Killing VMwareToolsUpgrader Process" 
    Stop-Process -Name VMWareToolsUpgrader -Force -PassThru -Verbose
}

exit 0


