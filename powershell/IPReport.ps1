get-ciminstance win32_networkadapterconfiguration | Where-Object ipenabled | Format-List Description, Index, IPAddress, IPSubnet, DNSDomain, DNSHostName, DNSServerSearchOrder