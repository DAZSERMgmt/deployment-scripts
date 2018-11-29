# Start a new Tablet

function Test-PendingReboot {
  If (Test-Path C:\rebootNeeded) {
    Remove-Item C:\rebootNeeded
    return $true
  }
  return $false
}

function Invoke-Reboot {
  #Need to create startup to call install.ps1 again
  Write-Output "Writing Restart file"
  $startup = "C:\Users\User\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
  Invoke-WebRequest https://raw.githubusercontent.com/Sparticuz/boxstarter-scripts/master/install.ps1 -OutFile C:\Users\User\Desktop\install.ps1
  $restartScript = 'powershell.exe -File "C:\Users\User\Desktop\install.ps1"'
  New-Item "$startup\post-restart.bat" -type file -force -value $restartScript | Out-Null
  Restart-Computer -Force
}

# Windows Stuff
  # Update the timezone and time
  $time = tzutil /g
  if (!($time -eq "Eastern Standard Time")) {
    Write-Output "Setting Time Zone to EST"
    tzutil /s "Eastern Standard Time"
  }

  Write-Output "Setting Local Policy to RemoteSigned"
  Set-ExecutionPolicy RemoteSigned -Scope LocalMachine

# Install K9 in the foreground while the script continues in the background
# Don't reboot after install
  If (!(Test-Path "C:\Program Files\Blue Coat K9 Web Protection")){
    Write-Output "Installing K9 Web Filter"
    Write-Output "Don't reboot after install"
    Invoke-WebRequest https://raw.githubusercontent.com/DAZSERMgmt/boxstarter-scripts/master/FilterCodes.html -UseBasicParsing -OutFile C:\Users\User\Desktop\FilterCodes.html
    Invoke-WebRequest http://download.k9webprotection.com/k9-webprotection.exe -UseBasicParsing -OutFile $env:TEMP\k9.exe
    Start-Process -FilePath "$env:TEMP\k9.exe"
    Invoke-Item C:\Users\User\Desktop\FilterCodes.html
  }

# Install chocolatey
  Invoke-WebRequest https://chocolatey.org/install.ps1 -UseBasicParsing | Invoke-Expression

  RefreshEnv

# Updates & Backend
  choco install powershell -y
  
# Applications
  choco install libreoffice-fresh -y
  choco install skype -y
  choco install slack -y
  choco install zoom -y
  choco install google-drive-file-stream --ignore-checksum -y

# Browsers
  choco install googlechrome -y
  # Copy master_preferences to Chrome profile
  Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Sparticuz/boxstarter-scripts/master/master_preferences" -OutFile ${Env:ProgramFiles(x86)}"\Google\Chrome\Application\master_preferences"
  Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Sparticuz/boxstarter-scripts/master/initialbookmarks.html" -OutFile ${Env:ProgramFiles(x86)}"\Google\Chrome\Application\initialbookmarks.html"

  $Shell = New-Object -ComObject ("WScript.Shell")

  $App = $Shell.CreateShortcut("C:\Users\User\Desktop\DAZSER Web App.url")
  $App.TargetPath = "https://www.dazser.net"
  #$App.IconLocation = "$env:windir\System32\shell32.dll, 13"
  $App.Save()

  $Mail = $Shell.CreateShortcut("C:\Users\User\Desktop\E-Mail.url")
  $Mail.TargetPath = "https://mail.google.com/a/dazser.com"
  #$Mail.IconLocation = "$env:windir\System32\shell32.dll, 42"
  $Mail.Save()

# Windows Stuff
  #Show Powershell on Win+X instead of Command Prompt #kill explorer
  Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name DontUsePowerShellOnWinX -Value 0
  #File Explorer preferences
  Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1
  Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1

  Invoke-WebRequest "https://raw.githubusercontent.com/Sparticuz/boxstarter-scripts/master/task.ps1" -UseBasicParsing | Invoke-Expression

  Invoke-WebRequest https://raw.githubusercontent.com/Sparticuz/boxstarter-scripts/master/bg.jpg -OutFile "C:\Users\User\Pictures\bg.jpg"
  Set-ItemProperty -Path "HKCU:Control Panel\Desktop" -Name WallPaper -Value C:\Users\User\Pictures\bg.jpg

  #Remove-Item C:\Users\User\Desktop\Resilio.exe
  Remove-Item "C:\Users\User\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\post-restart.bat"
  Remove-Item C:\computerNamed
