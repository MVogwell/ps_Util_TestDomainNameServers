<#

.SYNOPSIS
Test DNS resolution for a hostname from multiple DNS servers.

.DESCRIPTION
Full description here


.PARAMETER host
    Required. This must be a valid dns name

.PARAMETER dns_servers
    String array specifying the DNS servers to use for the test. Default is google's public DNS servers

.EXAMPLE

.\ps_Util_DNSTest.ps1

.EXAMPLE

.\ps_Util_DNSTest.ps1 -hostname www.bbc.co.uk

.EXAMPLE

$Servers = @("server1.domain.com","server2.domain.com")
.\ps_Util_DNSTest.ps1 -dns_servers $Servers

.NOTES
MVogwell - 05-11-19

.LINK

#>

[CmdLetBinding()]
param (
    [Parameter(Mandatory=$true)][string]$hostname,
    [Parameter(Mandatory=$false)][string[]]$dns_servers = @("8.8.8.8","8.8.4.4")
)

$ErrorActionPreference = "Stop"
$arrResults = @()
$arrFailedDNSServers = @()

Foreach ($dns_server in $dns_servers) {
    Try {
        $objResult = Resolve-DNSName $hostname -Server $dns_server
        $objResult | Add-Member -MemberType NoteProperty -Name "DomainNameServer" -Value $dns_server
    }
    Catch {
        $sErrMsg = ($Error[0].Exception.Message).replace("`r"," ").replace("`n"," ")

        $objResult = New-Object -Type PSCustomObject

        $objResult | Add-Member -MemberType NoteProperty -Name "Name" -Value $sErrMsg
        $objResult | Add-Member -MemberType NoteProperty -Name "Type" -Value "Failed"
        $objResult | Add-Member -MemberType NoteProperty -Name "TTL" -Value "n/a"
        $objResult | Add-Member -MemberType NoteProperty -Name "Section" -Value "Answer"
        $objResult | Add-Member -MemberType NoteProperty -Name "IPAddress" -Value "n/a"
        $objResult | Add-Member -MemberType NoteProperty -Name "DomainNameServer" -Value $dns_server

    }

    $arrResults += $objResult
}

$arrResults | Select Name, Type, TTL, Section, IPAddress, DomainNameServer | ft -Auto
