
Write-Output "Computer Information:" 
Get-WmiObject win32_computersystem | Format-List Name, 
                                                 Manufacturer, 
                                                 Domain, 
                                                 Model, 
                                                 TotalPhysicalMemory, 
                                                 PrimaryOwnerName


Write-Output "Network Configuration:"
get-ciminstance win32_networkadapterconfiguration | Where-Object ipenabled | Format-List Description,
                                                                                         Index, 
                                                                                         IPAddress, 
                                                                                         IPSubnet, 
                                                                                         DNSDomain, 
                                                                                         DNSHostName, 
                                                                                         DNSServerSearchOrder

Write-Output "Memory Information:" 
Get-WmiObject win32_physicalmemory | Format-Table Manufacturer,
                                                  Description, 
                                                  Capacity,
                                                  Banklabel,
                                                  Devicelocator



Write-Output "Processor Information:" 
Get-CimInstance -class CIM_Processor | Format-list name,
                                                   numberofcores, 
                                                   currentclockspeed, 
                                                   maxclockspeed, 
                                                   @{ n = "L1cachesize"; e = {switch ($_.L1CacheSize) { $null { $output = "Not Found"} Default { $output = $_.L1CacheSize } }; $output } },
                                                   @{ n = "L2cachesize"; e = {switch ($_.L2CacheSize) { $null { $output = "Not Found"} Default { $output = $_.L2CacheSize } }; $output } },
                                                   @{ n = "L3cachesize"; e = {switch ($_.L3CacheSize) { $null { $output = "Not Found"} Default { $output = $_.L3CacheSize } }; $output } }



Write-Output "Disk Drive Summary:" 

  $diskdrives = Get-CIMInstance CIM_diskdrive

  $mydrives = foreach ($disk in $diskdrives) {
      $partitions = $disk|get-cimassociatedinstance -resultclassname CIM_diskpartition
      foreach ($partition in $partitions) {
            $logicaldisks = $partition | get-cimassociatedinstance -resultclassname CIM_logicaldisk
            foreach ($logicaldisk in $logicaldisks) {
                     new-object -typename psobject -property @{Manufacturer=$disk.Manufacturer
                                                               Model=$disk.model
                                                               "Size of Drive (GB)"=$disk.Size / 1gb -as [int]
                                                               "Drive Name"=$logicaldisk.DeviceID
                                                               "Size(GB)"=$logicaldisk.size / 1gb -as [int]
                                                               "Free(GB)"=$logicaldisk.FreeSpace / 1gb -as [int] 
                                                               "Percentfree"=$logicaldisk.freespace * 100 / $logicaldisk.size -as [int]
                                                               Location=$partition.deviceid
                                                               
                                                               
                                                               }
           }
      }
  }
  $mydrives | Format-Table Manufacturer, location, model, "Size of Drive (GB)", "Drive Name", "Size(GB)", "Free(GB)", "Percentfree"


  Write-Output "Graphics Information:" 

  
  $cards = Get-WmiObject win32_videocontroller
  $cards = New-Object -TypeName psobject -Property @{
  name = $cards.name
  description = $cards.description 
  screenresolution = [string]($cards.CurrentHorizontalResolution) + 'px X ' + [string]($cards.CurrentVerticalResolution) + 'px' } |
  Format-List name, description, screenresolution
  $cards
