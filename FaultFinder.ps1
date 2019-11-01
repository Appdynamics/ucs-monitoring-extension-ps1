############## Logging initializations: change log dir as you deem fit ##############
$CompleteSetupIndicator = ".\appd.setup.complete.indicator.txt"
if (!(Test-Path $CompleteSetupIndicator)) {
  Write-Host "You must complete the setup before you continue. Please run the Setup.ps1 script" -ForegroundColor RED
  break
}

$LogDir = "..\..\logs"
$ilogFile = "UCSMonitor.log"

$LogPath = $LogDir + '\' + $iLogFile

#Load Logger Function - relative path

. ".\Logger.ps1"

#Checking for existence of logfolders and files if not create them.
if (!(Test-Path $LogDir)) {
  New-Item -Path $LogDir -ItemType directory
  New-Item -Path $LogDir -Name $iLogFile -ItemType File
}
else {
  Write-Log INFO "$LogDir exists" $LogPath

}


##############END of Log Init######################
$UCSEncryptedPasswordFile = ".\SecureFolder\UCSEncryptedPassword.xml"
$SNOWEncryptedPasswordFile = ".\SecureFolder\SNOWEnryptedPassword.txt"
$confFile = ".\config.json"
$FaultJson = ".\fault.json"
$PSUStatsJSON = ".\PSUStats.json"
$ServerTempJSON = ".\ServerTempStats.json"

#43800 
$queryInterVal = 100 #minimum of 1 minute. Ideal 5 minutes. 

$dateTime = Get-Date
$timeNow = $dateTime.ToString("yyyy/MM/dd HH:mm")
$timeAgo = $dateTime.Addminutes(- $queryInterVal).ToString("yyyy/MM/dd HH:mm")

##############Load Conf.json #####################
$confFileContent = (Get-Content $confFile -Raw) | ConvertFrom-Json

$UCSPasswordEncyptionKey = $confFileContent.ConfigItems | Where-Object { $_.Name -eq "UCSPasswordEncyptionKey" } `
   | Select-Object -ExpandProperty Value

$tier_id = $confFileContent.ConfigItems | Where-Object { $_.Name -eq "tierID" } `
   | Select-Object -ExpandProperty Value
if ([string]::IsNullOrEmpty($tier_id)) {
  $metric_prefix = "Custom Metrics|Cisco UCS"
} else {
  $metric_prefix = "name=Server|Component:$tier_id|Custom Metrics|Cisco UCS"
}

$failed = "value=1"
$success = "value=0"

############## Connect to UCS ##############

function DynamicModuleImporter {
  $edition = $PSVersionTable.PSEdition
  switch ($edition)
  {
    Core
    {
      Write-Host = "Importing Powershell Core " -ForegroundColor Yellow
      . .\PSCoreModules\LoadModule.ps1
    }
    Desktop
    {
      Write-Host = "Importing Powershell Windows " -ForegroundColor Yellow
      Import-Module Cisco.UCSManager
    }
  }
}


DynamicModuleImporter

Connect-Ucs -Path $UCSEncryptedPasswordFile -Key $(ConvertTo-SecureString -Force -AsPlainText "$UCSPasswordEncyptionKey")

#check connnection 
if ($DefaultUcs -eq $null) {
  $msg = "Error connecting to UCS. Please ensure you have created the encrypted password, you have connectivity to UCS and your Key is correct"
  Write-Host $msg -ForegroundColor RED
  Write-Log FATAL $msg $LogPath
  Write-Host "$metric_prefix|UCS|Connectivity,$failed"
  break
}
Write-Log DEBUG "Connected to UCS" $LogPath
Write-Host "$metric_prefix|UCS|Connectivity,$success"
$filterString = $ExecutionContext.InvokeCommand.ExpandString('Created -cbw "$timeAgo","$timeNow"')

Write-Log DEBUG "Filter String $filterString" $LogPath

############## Get UCS Faults  ##############
$faults = Get-UcsFault -Filter $filterString `
   | Where-Object { $_.Severity -match "^(major|minor|critical|warning)$" -and $_.Ack -ne "yes" } `
   | Select-Object Ack,Cause,Code,Created,Descr,Severity,PrevSeverity,OrigSeverity,`
   HighestSeverity,LastTransition,Occur,Rule,Tags,Get-Content,Ucs,Rn,Dn,Status

############## Power Supply Unit Stats  ##############
$PSUStats = Get-UcsPsuStats | Sort-Object -Property Dn `
   | Select-Object Dn,AmbientTemp,AmbientTempAvg,Input210v,Input210vAvg,Output12v,Output12vAvg,`
   OutputCurrentAvg,OutputPowerAvg,Suspect

############## Server Temperature stats  ##############
$ServerTemp = Get-UcsComputeMbTempStats | Sort-Object -Property Dn | Select-Object Dn,FmTempSenIo,FmTempSenIoAvg,FmTempSenIoMax,`
   FmTempSenRear,FmTempSenRearAvg,FmTempSenRearMax,Suspect

############## Close UCS Connection  ##############
Write-Log DEBUG "Disconnecting from UCS" $LogPath
Disconnect-Ucs

#Fetch Params from conf.json 
$confFileContent = (Get-Content $confFile -Raw) | ConvertFrom-Json

$EnableServiceNow = $confFileContent.ConfigItems | Where-Object { $_.Name -eq "EnableServiceNow" } `
   | Select-Object -ExpandProperty Value


$ServiceNowURL = $confFileContent.ConfigItems | Where-Object { $_.Name -eq "ServiceNowURL" } `
   | Select-Object -ExpandProperty Value


$SerivceNowUsername = $confFileContent.ConfigItems | Where-Object { $_.Name -eq "SerivceNowUsername" } `
   | Select-Object -ExpandProperty Value

$analyticsEndpoint = $confFileContent.ConfigItems | Where-Object { $_.Name -eq "analyticsEndpoint" } `
   | Select-Object -ExpandProperty Value

$X_Events_API_AccountName = $confFileContent.ConfigItems | Where-Object { $_.Name -eq "X-Events-API-AccountName" } `
   | Select-Object -ExpandProperty Value

$X_Events_API_Key = $confFileContent.ConfigItems | Where-Object { $_.Name -eq "X-Events-API-Key" } `
   | Select-Object -ExpandProperty Value

$UCS_Faults_Schema = $confFileContent.ConfigItems | Where-Object { $_.Name -eq "UCS-Faults-Schema" } `
   | Select-Object -ExpandProperty Value

$PSU_Stats_Schema = $confFileContent.ConfigItems | Where-Object { $_.Name -eq "PSU-Stats-Schema" } `
   | Select-Object -ExpandProperty Value


$Server_Temperature_Schema = $confFileContent.ConfigItems | Where-Object { $_.Name -eq "UCS-Server-Temperature-Schema" } `
   | Select-Object -ExpandProperty Value

############## Begin Data Normalisation ##############
$totalFaults = 0

if ([string]::IsNullOrEmpty($faults)) {
  $totalFaults = 0
} else {
  $totalFaults = ($faults | Measure-Object).Count
}

if ($totalFaults -lt 1) {
  $msg = "No faults found since $timeAgo. Nothing much to do, just going to collect Powersupply and temperature stats for baselining purposes."
  Write-Log INFO $msg $LogPath
  Write-Host $msg
  # to create the SNOW node for HR
  Write-Host "$metric_prefix|SNOW|Connectivity,$success"
} else {

  $msg = "Number of faults found at $timeNow is $totalFaults"
  Write-Host $msg
  Write-Log INFO $msg $LogPath

  #The TAG array JSON element must be converted into comma-seperated strings array
  # Otherwise request to AppD API fails 
  #$content = Get-Content $FaultJson -Raw 
  #(ConvertFrom-Json -InputObject $content) `
  #   | ForEach-Object { $_.Tags = ($_.Tags -join ","); $_ } `
  #   | ConvertTo-Json `
  #  | Out-File -FilePath $FaultJson

  $faults = $faults | Sort-Object -Property @{ Expression = { $_.Severity }; Ascending = $true },LastTransition -Descending | ForEach-Object { $_.Tags = ($_.Tags -join ","); $_ }

  #sort my last severit transition time then convert to json.  By default, Out-File overwrites existing files.
  #$faults | Convertto-Json | Out-File $FaultJson
  #$FaultsRequestBody = Get-Content $FaultJson -Raw

  $FaultsRequestBody = $faults | ConvertTo-Json #No need to create the file in prod release. It's only needed for debug purpose in dev
  #Send Faults Analytics Events   
  & "$PSScriptRoot\CreateAnalyticsEvents.ps1" -requestBody $FaultsRequestBody -Schema $UCS_Faults_Schema

  if ($EnableServiceNow -eq "yes") {
    Write-Host ="Integration with ServiceNow is set to yes, creating incident...." -ForegroundColor Yellow
    #Create SNOW Ticket  
    & "$PSScriptRoot\SNOWIncidentCreator.ps1"
  } else {
    Write-Host "Skipping ServiceNow incident creation as it's not enabled... " -ForegroundColor RED
  }

}

Write-Host "PSU Stas" -ForegroundColor Yellow
#Create SNOW Ticket  
Write-Host $PSUStats | ConvertTo-Json

#send PSU stats 
if (![string]::IsNullOrEmpty($PSUStats)) {
  Write-Host "Sending PSU data" -ForegroundColor Yellow
  #convert to JSON objects 
  #$PSUStats | Convertto-Json | Out-File $PSUStatsJSON

  $PSURequestBody = $PSUStats | ConvertTo-Json # Get-Content $PSUStatsJSON -Raw
  & "$PSScriptRoot\CreateAnalyticsEvents.ps1" -requestBody $PSURequestBody -Schema $PSU_Stats_Schema

}

Write-Host "ServerTemp Stas" -ForegroundColor Yellow
#Create SNOW Ticket  
Write-Host $ServerTemp | ConvertTo-Json

#send Server Temperature stats 
if (![string]::IsNullOrEmpty($ServerTemp)) {
  Write-Host "Sending Sever data" -ForegroundColor Yellow
  #convert to JSON objects 
  #$ServerTemp | Convertto-Json #| Out-File $ServerTempJSON

  $STempRequestBody = $ServerTemp | ConvertTo-Json #Get-Content $ServerTempJSON -Raw
  & "$PSScriptRoot\CreateAnalyticsEvents.ps1" -requestBody $STempRequestBody -Schema $Server_Temperature_Schema

}


