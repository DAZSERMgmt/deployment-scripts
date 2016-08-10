# Get JSON data
$jsonFileData = Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Sparticuz/boxstarter-scripts/master/btsync.conf" -UseBasicParsing
$jsonObject = $jsonFileData.Content | ConvertFrom-Json

# Set JSON settings
$jsonObject.device_name = $env:ComputerName
$jsonObject.storage_path = $env:UserProfile+"\Documents"
$jsonObject.shared_folders.dir = $env:UserProfile+"\Documents\Forms"

# Write to Conf file
$jsonFileDataToWrite = $jsonObject | ConvertTo-Json
$jsonFileDataToWrite | Out-File $env:AppData"\Bittorrent Sync\btsync.conf"