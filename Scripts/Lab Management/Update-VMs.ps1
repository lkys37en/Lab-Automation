Function Update-VMs {
    <#
    .Synopsis
    This script was written by lkys37en with the intent of automating VM management with PowerCLI.
    
    .Description
    Removes and or creates new snapshots on VM's using PowerCLI
    
    .Example
    Only removes snapshot(s)
    Update-VMs -Username administrator@vsphere.local -Password Welcome1! -ServerName vcenter.lab.local -VMName P3* -RemoveSnapshotName NoConfig,test
    
    .Example
    Removes snapshots and creates a new one
    Update-VMs -Username administrator@vsphere.local -Password Welcome1! -ServerName vcenter.lab.local -VMName P3* -RemoveSnapshotName NoConfig,test -NewSnapshotName Final

    .Example
    Only create a new snapshot 
    Update-VMs -Username administrator@vsphere.local -Password Welcome1! -ServerName vcenter.lab.local -VMName P3* -NewSnapshotName Final
    #>
    [CmdletBinding()]
    param (
        [parameter(HelpMessage = "Enter vCenter username in administrator@vsphere.local format ")]
        [String]$Username,
       
        [parameter(HelpMessage = "Enter vCenter password")]
        [String]$Password,

        [parameter(HelpMessage = "Enter vCenter servername ")]
        [String]$ServerName,

        [parameter(HelpMessage = "Enter list of VM's to manage.")]
        [String]$VMName,

        [parameter(HelpMessage = "Enter list of snapshots to remove")]
        [String[]]$RemoveSnapshotName,

        [parameter(HelpMessage = "Enter new snapshot name to configure")]
        [String]$NewSnapshotName
    )
       
    try {
        Write-Host -ForegroundColor Green "[+] Creating Credential Object" 
        $SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force
        $Credential = New-Object System.Management.Automation.PSCredential $UserName, $SecurePassword
            
        Write-Host -ForegroundColor Green "[+] Connecting to vCenter server"
        Connect-VIServer -Server $ServerName -Credential $Credential -ErrorAction Stop | Out-Null
    }
    catch {
        Write-Host -ForegroundColor Red "[*] Could not connect to $ServerName due to incorrect username or password"
        break
    }
    
    $VM = (Get-VM -Name $VMName).Name 
    ForEach ($ShutdownVM in $VM) {
        try {
            Write-Host -ForegroundColor Green "[+] Shuting down $ShutdownVM"
            Get-VM -Name $ShutdownVM | Stop-VMGuest -Confirm:$false -ErrorAction Stop
        }
        catch [VMware.VimAutomation.Sdk.Types.V1.ErrorHandling.VimException.VimException] {
            if ($_.Exception.Message -like "*failed for VM*") {
                Write-Host -ForegroundColor Cyan "[*] $ShutdownVM is currently turned off moving on"
                continue
            }
            catch {
                Write-Error -Message "$($_.Exception.Message)"
            }
        }
    }

    if ($RemoveSnapshotName) {
        Foreach ($Snapshot in $RemoveSnapshotName) {
            foreach ($VMs in $VM) {
                try {
                    Write-Host -ForegroundColor Green "[+] Deleting snapshot $Snapshot on $VMs"
                    Get-VM -Name $VMs | Get-Snapshot -Name $Snapshot -ErrorAction Stop | Remove-Snapshot -Confirm:$false 
                }
                catch [VMware.VimAutomation.Sdk.Types.V1.ErrorHandling.VimException.VimException] {
                    if ($_.Exception.Message -like "*was not found*") {
                        Write-Host -ForegroundColor Cyan "[*] $Snapshot doesn't exist on $VMs moving on"
                        continue               
                    }
                }
                catch {
                    Write-Error -Message "$($_.Exception.Message)"
                }
            }
        }
    }
}
    
if ($NewSnapshotName) {
    foreach ($VMs in $VM) {
        try {
            Write-Host -ForegroundColor Green "[+] Creating snapshot $NewSnapshotName on $VMs"
            Get-VM -Name $VMs | New-Snapshot -Name $NewSnapshotName -Confirm:$false | Out-Null
        }
        catch {
            Write-Host -ForegroundColor Red "$($_.Exception.Message)"
        }
    }
}