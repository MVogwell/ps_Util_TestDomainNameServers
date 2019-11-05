# ps_Util_TestDomainNameServers

A simple powershell DNS utility to test a single hostname against multiple Domain Name Servers (DNS).

## Examples


### Example 1
.\ps_Util_TestDomainNameServers.ps1

This will request the hostname to test and then do a DNS lookup against google's public DNS servers

### Example 2
.\ps_Util_TestDomainNameServers.ps1 -hostname <domain-name>

This will test the domain name specified after the -hostname argument

### Example 3
$dns_servers_to_use = @("myDnsServer1.com","myDnsServer2.com")
.\ps_Util_TestDomainNameServers.ps1 -hostname <domain-name> -dns_servers $dns_servers_to_use

