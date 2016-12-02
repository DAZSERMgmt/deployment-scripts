iwr https://download-cdn.resilio.com/stable/windows64/Resilio-Sync_x64.exe -OutFile C:\Users\User\Desktop\Resilio.exe

# Get JSON data
#$jsonFileData = Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Sparticuz/boxstarter-scripts/master/btsync.conf" -UseBasicParsing
#$jsonObject = $jsonFileData.Content | ConvertFrom-Json

# Set JSON settings
#$jsonObject.device_name = $env:ComputerName
#$jsonObject.storage_path = $env:UserProfile+"\Documents"
#$jsonObject.shared_folders[0].dir = $env:UserProfile+"\Documents\Forms"

# Write to Conf file
#$jsonFileDataToWrite = $jsonObject | ConvertTo-Json
#$jsonFileDataToWrite | Out-File $env:AppData"\Resilio Sync\btsync.conf" -Encoding ascii