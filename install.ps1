# Set execution policy
$policy = Get-ExecutionPolicy
if (!($policy -eq "RemoteSigned")) {
    Write-Output "Policy is set to $policy, setting to RemoteSigned"
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
}

Write-Output "Pulling tablet.ps1"
Invoke-WebRequest https://raw.githubusercontent.com/DAZSERMgmt/boxstarter-scripts/master/tablet.ps1 -OutFile $env:temp\tablet.ps1 
Write-Output  "Executing tablet.ps1"
Start-Process powershell -ArgumentList "-noprofile", "-file ${env:temp}\tablet.ps1" -Verb RunAs -Wait

# Cleanup after Process done
Remove-Item $env:appdata\Microsoft\Windows\Start Menu\Programs\Startup\post-restart.bat
Remove-Item $env:temp\tablet.ps1
