Write-Host "Enabling CredSSP"
Enable-WSManCredSSP -Role Server -Force
Enable-WSManCredSSP -Role Client -DelegateComputer * -Force
set-item wsman:localhost\client\trustedhosts -value * -Force
Set-Item -Path "wsman:\localhost\service\auth\credSSP" -Value $True -Force

New-Item -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation -Name AllowFreshCredentialsWhenNTLMOnly -Force
New-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation\AllowFreshCredentialsWhenNTLMOnly -Name 1 -Value * -PropertyType String

Write-host "Verify CredSSP is enabled"
Get-WSManCredSSP