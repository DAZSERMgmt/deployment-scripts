# START http://boxstarter.org/package/nr/url?

# Windows Stuff
	Disable-BingSearch
	Update-ExecutionPolicy RemoteSigned

	tzutil /s "Eastern Standard Time"

	# Set computer name
	If (!(Test-Path C:\computerNamed)) {
		$name = Read-Host "What is your computer name?"
		Rename-Computer -NewName $name
		echo $null >> C:\computerNamed
		if (Test-PendingReboot) { Invoke-Reboot }
	}

# Updates & Backend
	choco install chocolatey -y
	choco install powershell -y

# Tools
	choco install emet -y
	choco install btsync -y
	choco install followmee -y
	choco install networx -y

# Applications
	choco install libreoffice -y
	choco install skype -y
	choco install slack -y
	choco install zoom -y

# Browsers
	choco install googlechrome -y
	# Copy master_preferences to Chrome profile
	Copy-Item master_preferences $env:PROGRAMFILES(x86)+"\Google\Chrome\Application\"
	Copy-Item initialbookmarks.html $env:PROGRAMFILES(x86)+"\Google\Chrome\Application\"

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
$App.Save()

$Mail = $Shell.CreateShortcut($env:USERPROFILE + "\Desktop\Web Mail.url")
$Mail.TargetPath = "https://mail.dazser.com"
$Mail.Save()

Remove-Item C:\computerNamed

# Windows Stuff
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
