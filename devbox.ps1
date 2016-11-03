# START http://boxstarter.org/package/nr/url?

$Boxstarter.RebootOk=$true
$Boxstarter.NoPassword=$false
$Boxstarter.AutoLogin=$true

# Windows Stuff
	Disable-UAC
	Disable-BingSearch
	Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -DisableOpenFileExplorerToQuickAccess -EnableShowFileExtensions -EnableShowFullPathInTitleBar -EnableShowRecentFilesInQuickAccess -EnableShowFrequentFoldersInQuickAccess -EnableExpandToOpenFolder
	Update-ExecutionPolicy RemoteSigned

	tzutil /s "Eastern Standard Time"

	if ((Test-Path D:) -and ((Get-Volume -DriveLetter D | Select -ExpandProperty DriveType) -eq "Fixed")) {
		Move-LibraryDirectory "My Pictures" "D:\Pictures"
		Move-LibraryDirectory "My Video" "D:\Videos"
		Move-LibraryDirectory "My Music" "D:\Music"
		Move-LibraryDirectory "Downloads" "D:\Downloads"
		Move-LibraryDirectory "Personal" "D:\Documents"
		Move-LibraryDirectory "Desktop" "D:\Desktop"
	}

# Updates & Backend
	choco install chocolatey -y
	choco install powershell -y

	# Dot Net 2/3
	choco install NetFx3 -source windowsfeatures -y
	# Dot Net 4
	choco install NetFx4-AdvSrvs -source windowsfeatures -y
	choco install vcredist2005 -y
	choco install vcredist2008 -y
	choco install vcredist2010 -y
	choco install vcredist2012 -y
	choco install vcredist2013 -y
	choco install vcredist2015 -y

# Tools & Utilities
	choco install 7zip -y
	choco install baretail -y
	choco install crashplan -y
	choco install emet -y
	choco install git -y
	choco install github -y
	choco install glasswire -y
	choco install heidisql -y
	# choco install Microsoft-Hyper-V-Tools-All -source windowsfeatures -y /enablefeature /all #failed
	choco install mysql.workbench -y
	choco install putty.install -y
	choco install rdcman -y
	choco install rdmfree -y
	choco install setpoint -y
	choco install ussf -y
	choco install wget -y

# Fonts
	#choco install sourcecodepro -y	#failed
	choco install inconsolata -y
	#choco install robotofonts -y	#failed
	choco install opensans -y

# Applications
	choco install atom -y
	choco install calibre -y
	choco install ccleaner -y	#rebooted?
	choco install ccenhancer -y
	choco install deluge -y
	choco install dropbox -y
	choco install greenshot -y
	choco install googledrive -y
	choco install handbrake -y
	choco install itunes -y
	choco install lastpass -y
	choco install libreoffice -y
	choco install malwarebytes -y
	choco install markdownpad2 -y
	choco install mp3tag -y
	choco install skype -y
	choco install slack -y
	choco install spotify -y
	#choco install sublimetext3 -y
	#choco install sublimetext3.packagecontrol -y
	choco install sumatrapdf -y
	choco install treesizefree -y
	choco install visualstudiocode -y
	choco install vlc -y

# Browsers
	choco install firefox -y
	choco install googlechrome.canary -y
	choco install googlechrome.dev -y

	Install-ChocolateyPinnedTaskBarItem "$env:windir\explorer.exe"
	Install-ChocolateyPinnedTaskBarItem "$env:SystemRoot\system32\WindowsPowerShell\v1.0\powershell.exe"

# Windows Stuff
	#Show Powershell on Win+X instead of Command Prompt #kill explorer
	Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name DontUsePowerShellOnWinX -Value 0
	#File Explorer preferences
	Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1
	Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1
	Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1
    Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2
    #taskbar preferences

	#Install WSL
	choco install Microsoft-Windows-Subsystem-Linux -source windowsfeatures -y

	

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
