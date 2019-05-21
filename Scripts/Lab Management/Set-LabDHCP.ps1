Function Add-DHCPScope {
    <#
    .Synopsis
    This script was written by lkys37en with the intent of automating lab building with vagrant.
    
    .Description
    Add DHCP scopes for lab subnets
    
    .Example
    
    #>
    [CmdletBinding()]
    param (
        [Parameter(HelpMessage = "Enter Location of Excel file")]
        [string]$ExcelPath,
        
        [Parameter(HelpMessage = "Enter Name of Excel Worksheet")]
        [string]$ExcelWorkSheet    
    )

    Import-Module PSExcel
    Import-XLSX -Path $ExcelPath -Sheet $ExcelWorkSheet -Text | Where-Object {
        if ($_.Name) {
            try {
                Write-Host -ForegroundColor Green "[+] Adding DHCP Scope $($_.Name)"
                Add-DhcpServerv4Scope -Name $_.Name -StartRange $_.StartRange -EndRange $_.EndRange -SubnetMask $_.SubnetMask -ErrorAction Stop
            }

            catch {
                Write-Host -ForegroundColor Red "[-] $($_.Exception.Message)"
            }
        }

        if ($_.ExcludeStartRange -and $_.ExcludeEndRange -ne '') {
            try {
                Write-Host -ForegroundColor Green "[+] Adding exclusion range to $($_.Name)"
                Add-Dhcpserverv4ExclusionRange -ScopeId $_.ScopeId -StartRange $_.ExcludeStartRange -EndRange $_.ExcludeEndRange -ErrorAction Stop
            }
            catch {
                Write-Host -ForegroundColor Red "[-] $($_.Exception.Message)"
            }

        }
        if ($_.ExcludeStartRange -and $_.ExcludeEndRange -ne '') {
            try {
                Write-Host -ForegroundColor Green "[+] Adding DHCP options to $($_.Name)"
                Set-DhcpServerv4OptionValue -ScopeId $_.ScopeId -DnsServer $_.DnsServer -DnsDomain $_.DnsDomain -Router $_.Router -Force -ErrorAction Stop
            }
            catch {
                Write-Host -ForegroundColor Red "[-] $($_.Exception.Message)"
            }

        }
        
    }
}


Function Add-DHCPReservations {
    <#
    .Synopsis
    This script was written by lkys37en with the intent of automating lab building with vagrant.
    
    .Description
    Add DHCP scopes for lab subnets
    #>
    [CmdletBinding()]
    param (
        [Parameter(HelpMessage = "Enter Location of Excel file")]
        [string]$ExcelPath,
        
        [Parameter(HelpMessage = "Enter Name of Excel Worksheet")]
        [string[]]$ExcelWorkSheet    
    )

    Import-Module PSExcel
    foreach ($WkSheet in $ExcelWorkSheet) {
        Import-XLSX -Path $ExcelPath -Sheet $WkSheet -Text | Where-Object {
            if ($_.ScopeId -and $_.IPAddress -and $_.ClientId -ne '') {
                try {
                $Mac= $_.mac -replace ":"
                    Write-Host -ForegroundColor Green "[+] Adding DHCP reservation for $($_.HostName)"
                    Add-DhcpServerv4Reservation -ScopeId $_.ScopeId -IPAddress $_.IPAddress -ClientId $Mac -Name $_.Hostname -Description $_.Description -ErrorAction Stop
                }
                catch {
                    Write-Host -ForegroundColor Red "[-] $($_.Exception.Message)"
                }
            }

        }
    }
}