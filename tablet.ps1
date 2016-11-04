# START http://boxstarter.org/package/url?

# Windows Stuff
	Disable-BingSearch
	
	$policy = Get-ExecutionPolicy
	if (!($policy -eq "RemoteSigned")) {
		Update-ExecutionPolicy RemoteSigned
	}
	
	# Update the timezone and time
	tzutil /s "Eastern Standard Time"
	w32tm /resync /force

	# Set computer name
	If (!(Test-Path C:\computerNamed)) {
		$name = Read-Host "What is your computer name?"
		Rename-Computer -NewName $name
		echo $name >> C:\computerNamed
		if (Test-PendingReboot) { Invoke-Reboot }
	}

# Updates & Backend
	choco install chocolatey --source=chocolatey -y
	choco install powershell --source=chocolatey -y
	choco install javaruntime -y

# Tools
	#choco install emet -y
	# Configure EMET
	#Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Sparticuz/boxstarter-scripts/master/EMET-Settings.xml" -OutFile ${Env:ProgramFiles(x86)}"\EMET 5.5\MyEMETSettings.xml"
	#$path = ${Env:ProgramFiles(x86)}+"\EMET 5.5"
	#& $path\EMET_Conf.exe --import $path\MyEMETSettings.xml

	choco install btsync -y
	# BTSync starts after install, so kill it.
	Stop-Process -ProcessName btsync
	# Next, run btsync.ps1 to generate btsync.conf
	# Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Sparticuz/boxstarter-scripts/master/btsync.ps1" -UseBasicParsing | Invoke-Expression
	# Run btsync
	# $env:appdata+"\Bittorrent Sync\btsync.exe /config btsync.conf"

	#choco install followmee -y
	# Get FollowMee settings & Start the service
	#Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Sparticuz/boxstarter-scripts/master/FollowMee-Settings.xml" -OutFile ${Env:ProgramFiles(x86)}"\FollowMee\Settings.xml"
	#Start-Service FMEEService

	choco install networx -y
	Stop-Process -ProcessName networx
	# Now get the OpenSSL files
	$file = "C:\openssl.zip"
	Invoke-WebRequest -Uri "https://indy.fulgan.com/SSL/openssl-1.0.2j-x64_86-win64.zip" -OutFile $file
	# Unzip the file to specified location
	$shell_app = New-Object -Com Shell.Application 
	$zip_file = $shell_app.namespace($file)
	$path = $Env:ProgramFiles+"\Networx\"
	$destination = $shell_app.namespace($path) 
	$destination.Copyhere($zip_file.items())
	Remove-Item $file
	# Now get the settings database file
	Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Sparticuz/boxstarter-scripts/master/networx.db" -OutFile $Env:ProgramFiles"\NetWorx\NetWorx.db"

# Applications
	choco install libreoffice -y
	choco install skype -y
	choco install slack -y
	choco install zoom -y

# Browsers
	choco install googlechrome -y
	# Copy master_preferences to Chrome profile
	Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Sparticuz/boxstarter-scripts/master/master_preferences" -OutFile ${Env:ProgramFiles(x86)}"\Google\Chrome\Application\master_preferences"
	Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Sparticuz/boxstarter-scripts/master/initialbookmarks.html" -OutFile ${Env:ProgramFiles(x86)}"\Google\Chrome\Application\initialbookmarks.html"

#	# Create Shortcuts
#	$TargetFile = "$env:SystemRoot\System32\notepad.exe"
#	$ShortcutFile = "$env:Public\Desktop\Notepad.lnk"
#	$WScriptShell = New-Object -ComObject WScript.Shell
#	$Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
#	$Shortcut.TargetPath = $TargetFile
#	$Shortcut.Save()

#Install-ChocolateyShortcut `
 # -ShortcutFilePath "C:\notepad.lnk" `
  #-TargetPath "C:\Windows\System32\notepad.exe" `
#  -WorkDirectory "C:\" `
 # -Arguments "C:\test.txt" `
  #-IconLocation "C:\test.ico" `
#  -Description "This is the description"

$Shell = New-Object -ComObject ("WScript.Shell")

$App = $Shell.CreateShortcut($env:USERPROFILE + "\Desktop\DAZSER Web App.url")
$App.TargetPath = "https://www.dazser.net"
$App.IconLocation = "$env:windir\System32\shell32.dll, 13"
$App.Save()

$Mail = $Shell.CreateShortcut($env:USERPROFILE + "\Desktop\Web Mail.url")
$Mail.TargetPath = "https://mail.dazser.com"
$Mail.IconLocation = "$env:windir\System32\shell32.dll, 42"
$Mail.Save()

# Windows Stuff
	#Show Powershell on Win+X instead of Command Prompt #kill explorer
	Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name DontUsePowerShellOnWinX -Value 0
	#File Explorer preferences
	Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1
	Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1
	Enable-MicrosoftUpdate
	Install-WindowsUpdate -acceptEula

Remove-Item C:\computerNamed