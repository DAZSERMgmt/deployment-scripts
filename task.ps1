# Set up recurring powershell script
#  mofcomp C:\Windows\System32\wbem\SchedProv.mof
#  $chocoCmd = Get-Command -Name "choco" -ErrorAction SilentlyContinue -WarningAction SilentlyContinue | Select-Object -ExpandProperty Source

  # Settings for the scheduled task
#  $taskAction = New-ScheduledTaskAction –Execute $chocoCmd -Argument "upgrade all -y"
#  $taskTrigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Sunday -At 12pm
#  $taskUserPrincipal = New-ScheduledTaskPrincipal -UserId "SYSTEM"
#  $taskSettings = New-ScheduledTaskSettingsSet -Compatibility Win8

  # Set up the task, and register it
#  $task = New-ScheduledTask -Action $taskAction -Principal $taskUserPrincipal -Trigger $taskTrigger -Settings $taskSettings
#  Register-ScheduledTask -TaskName "ChocoUpgrade" -InputObject $task -Force

 # Finally, set the desktop wallpaper
#  Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Sparticuz/boxstarter-scripts/master/bg.jpg" -OutFile $env:USERPROFILE"\Documents\bg.jpg"
#  Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\" -Name Wallpaper -Value $env:USERPROFILE"\Documents\bg.jpg"
  #rundll32.exe user32.dll, UpdatePerUserSystemParameters