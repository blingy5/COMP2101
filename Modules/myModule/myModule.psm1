function welcome {
	write-output "Welcome to $env:computername user $env:username" 
	$date = get-date -format 'HH:MM tt on dddd' 
	write-output "Current time is: $date" 
}

welcome 

function get-cpuinfo {
	Get-CimInstance cim_processor | Select-Object -Property Name, MaxClockSpeed, Manufacturer
}

get-cpuinfo

function get-mydisks {
	get-disk | Select-Object Manufacturer, Model, SerialNumber, FirmwareRevision, Size
}