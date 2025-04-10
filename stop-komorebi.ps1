# stop-elevated-komorebi.ps1

# Stop the bar process first
$barProcess = Get-Process -Name "komorebi-bar" -ErrorAction SilentlyContinue
if ($barProcess) {
    Stop-Process -Name "komorebi-bar" -Force
}

# Stop whkd process
$whkdProcess = Get-Process -Name "whkd" -ErrorAction SilentlyContinue
if ($whkdProcess) {
    Stop-Process -Name "whkd" -Force
}

# Use elevated privileges to stop komorebi
Start-Process powershell -WindowStyle Hidden -Verb RunAs -ArgumentList "komorebic stop" -Wait

# Double check for any remaining komorebi processes
$komorebiProcess = Get-Process -Name "komorebi" -ErrorAction SilentlyContinue
if ($komorebiProcess) {
    Stop-Process -Name "komorebi" -Force
}

Write-Host "Komorebi and related processes have been stopped."