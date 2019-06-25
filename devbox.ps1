# START http://boxstarter.org/package/nr/url?

$Boxstarter.RebootOk=$true
$Boxstarter.NoPassword=$false
$Boxstarter.AutoLogin=$true

# Windows Stuff
	Update-ExecutionPolicy RemoteSigned	
	Disable-UAC
	Disable-BingSearch
	Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -DisableOpenFileExplorerToQuickAccess -EnableShowFileExtensions -EnableShowFullPathInTitleBar -EnableShowRecentFilesInQuickAccess -EnableShowFrequentFoldersInQuickAccess -EnableExpandToOpenFolder

	tzutil /s "Eastern Standard Time"

	if ((Test-Path D:) -and ((Get-Volume -DriveLetter D | Select-Object -ExpandProperty DriveType) -eq "Fixed")) {
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
	choco install vcredist2017 -y

# Tools & Utilities
	choco install 7zip -y
	choco install baretail -y
	choco install checksum -y
	#choco install crashplan -y
	choco install dellcommandupdate -y
	#choco install emet -y
	choco install git -y
	choco install github -y
	choco install glasswire -y
	choco install heidisql -y
	choco install Microsoft-Hyper-V-Tools-All -source WindowsFeatures -y
	#Install WSL
	choco install Microsoft-Windows-Subsystem-Linux -source windowsfeatures -y
	choco install mysql.workbench -y
	choco install nssm -y
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
	#choco install atom -y
	choco install adobe-creative-cloud -y
	choco install authy-desktop -y
	choco install calibre -y
	#choco install ccleaner -y	#rebooted?
	choco install ccenhancer -y
	choco install deluge -y
	choco install discord -y
	#  choco install dropbox -y
	choco install eac -y
	choco install greenshot -y
	#choco install googledrive -y
	choco install handbrake -y
	choco install itunes -y
	choco install joplin -y
	choco install lastpass -y
	choco install libreoffice -y
	choco install makemkv -y
	choco install malwarebytes -y
	choco install mkvtoolnix -y
	choco install mp3tag -y
	choco install odrive -y
	#choco install skype -y
	#choco install slack -y Domain Installed
	#choco install spotify -y
	choco install sublimetext3 -y
	#choco install sublimetext3.packagecontrol -y
	choco install sumatrapdf -y
	choco install treesizefree -y
	choco install vscode -y
	choco install vlc -y
	choco install zoom -y

# Browsers
	choco install firefox -y
	choco install googlechrome.canary -y
	choco install googlechrome.dev -y

	Install-ChocolateyPinnedTaskBarItem "$env:windir\explorer.exe"
	Install-ChocolateyPinnedTaskBarItem "$env:SystemRoot\system32\WindowsPowerShell\v1.0\powershell.exe"

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
	# Windows Phone Companion
	Get-AppxPackage Microsoft.WindowsPhone | Remove-AppxPackage

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
	# Change it back to "Quick Access" (Windows 10 default)
	#Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Type DWord -Value 2

	# Privacy: Let apps use my advertising ID: Disable
	If (-Not (Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo")) {
		New-Item -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo | Out-Null
	}
	Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo -Name Enabled -Type DWord -Value 0

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
