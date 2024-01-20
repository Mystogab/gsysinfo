cls
echo "G-Script System Info by Gabriel Desimone"
echo ""
echo "Reading system... (please wait)"

# Get cpu info
$cpu = (Get-WMIObject win32_Processor).Name

# Get RAM info
$ramAmount = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).sum /1gb
$ramSpeed = ((Get-WmiObject Win32_PhysicalMemory | Select-Object Speed)[0]).Speed

# Get GPU info
$gpus = ""
(Get-WmiObject Win32_VideoController | Select-Object Name) | ForEach-Object { $gpus += "GPU: " + $_.Name + "`n" }

# Get Free Disk Info
$drives = ""
(Get-WmiObject -Class Win32_LogicalDisk) | ForEach-Object {
	$letter = $_.DeviceID
	$freeSpace = [math]::Round($_.FreeSpace / 1GB, 0) 
	$drives += "DISK $letter $freeSpace GB" + "`n"
}

cls
echo "G-Script System Info by Gabriel Desimone"
echo ""
echo "CPU: $cpu"
echo "RAM: $ramAmount GB @ $ramSpeed Mhz"
echo ""
$gpus
$drives

echo ""
[void](Read-Host 'Presione una tecla para salir')
exit
