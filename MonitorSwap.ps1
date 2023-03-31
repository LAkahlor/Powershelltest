##Simple Script to Swap Left/Right monitors.
$Left = Get-WmiObject -Namespace root\wmi -Class WmiMonitorBasicDisplayParams -Property MaxHorizontalImageSize | Select-Object -ExpandProperty MaxHorizontalImageSize
$Right = Get-WmiObject -Namespace root\wmi -Class WmiMonitorBasicDisplayParams -Property MaxHorizontalImageSize | Select-Object -ExpandProperty MaxHorizontalImageSize
Set-CimInstance -Namespace root\wmi -ClassName WmiMonitorBasicDisplayParams -Arguments @{LeftPosition=$Right;RightPosition=$Left}


##$Left = Get-WmiObject -Namespace root\wmi -Class WmiMonitorBasicDisplayParams -Property MaxHorizontalImageSize -ComputerName <RemotePC> | Select-Object -ExpandProperty MaxHorizontalImageSize
##$Right = Get-WmiObject -Namespace root\wmi -Class WmiMonitorBasicDisplayParams -Property MaxHorizontalImageSize -ComputerName <RemotePC> | Select-Object -ExpandProperty MaxHorizontalImageSize
##Set-CimInstance -Namespace root\wmi -ClassName WmiMonitorBasicDisplayParams -Arguments @{LeftPosition=$Right;RightPosition=$Left} -ComputerName <RemotePC>