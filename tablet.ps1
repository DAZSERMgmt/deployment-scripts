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
  # Remove Windows Apps
	# 3D Builder
	Get-AppxPackage Microsoft.3DBuilder | Remove-AppxPackage
	# Autodesk
	Get-AppxPackage *Autodesk* | Remove-AppxPackage
	# BubbleWitch
	Get-AppxPackage *BubbleWitch* | Remove-AppxPackage
	# Candy Crush
	Get-AppxPackage king.com.CandyCrush* | Remove-AppxPackage
	# Get Started
	Get-AppxPackage Microsoft.Getstarted | Remove-AppxPackage
	# March of Empires
	Get-AppxPackage *MarchofEmpires* | Remove-AppxPackage
	# McAfee Security
	Get-AppxPackage *McAfee* | Remove-AppxPackage
	# Office Hub
	Get-AppxPackage Microsoft.MicrosoftOfficeHub | Remove-AppxPackage

	#Show Powershell on Win+X instead of Command Prompt 
	Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name DontUsePowerShellOnWinX -Value 0

	#File Explorer preferences
	Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1
	Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1
	Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2

	#Disallow Shake to Minimize
	Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name DisallowShaking -Value 1
		
	# Change Explorer home screen back to "This PC"
	Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Type DWord -Value 1

  Invoke-WebRequest https://raw.githubusercontent.com/Sparticuz/boxstarter-scripts/master/bg.jpg -OutFile "C:\Users\User\Pictures\bg.jpg"
  Set-ItemProperty -Path "HKCU:Control Panel\Desktop" -Name WallPaper -Value C:\Users\User\Pictures\bg.jpg

  Install-ChocolateyPinnedTaskBarItem "$env:windir\explorer.exe"

  Remove-Item "C:\Users\User\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\post-restart.bat"