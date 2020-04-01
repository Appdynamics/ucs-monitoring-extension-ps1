#Set-ExecutionPolicy RemoteSigned 
$CompleteSetupIndicator = ".\appd.setup.complete.indicator.txt"

if (Test-Path $CompleteSetupIndicator) {
  Write-Host "The Setup has been executed. `n Delete $CompleteSetupIndicator if you want to re-run the setup process"
  break
}

$UCSEncryptedPasswordFile = ".\SecureFolder\UCSEncryptedPassword.xml"
$SNOWEncryptedPasswordFile = ".\SecureFolder\SNOWEnryptedPassword.txt"
$PSUJsonTemplate = ".\jsonTemplates\CreatPSUStatsSchema.json"
$TemperatureJsonTemplate = ".\jsonTemplates\CreateServerTempSchema.json"
$FaultJsonTemplate = ".\jsonTemplates\CreateFaultsSchema.json"

$sleeptime = 3

$confFile = ".\config.json"

if (!(Test-Path $confFile)) {
  Write-Host "$confFile does not exist. It must be present."
  break
}

$confFileContent = (Get-Content $confFile -Raw) | ConvertFrom-Json

$UCSPasswordEncryptionKey = $confFileContent.ConfigItems | Where-Object { $_.Name -eq "UCSPasswordEncryptionKey" } `
   | Select-Object -ExpandProperty Value

$UCSURL = $confFileContent.ConfigItems | Where-Object { $_.Name -eq "UCSURL" } `
   | Select-Object -ExpandProperty Value

$ServiceNowUsername = $confFileContent.ConfigItems | Where-Object { $_.Name -eq "ServiceNowUsername" } `
   | Select-Object -ExpandProperty Value

$ServiceNowURL = $confFileContent.ConfigItems | Where-Object { $_.Name -eq "ServiceNowURL" } `
   | Select-Object -ExpandProperty Value

$EnableServiceNow = $confFileContent.ConfigItems | Where-Object { $_.Name -eq "EnableServiceNow" } `
   | Select-Object -ExpandProperty Value


$analyticsEndpoint = $confFileContent.ConfigItems | Where-Object { $_.Name -eq "analyticsEndpoint" } `
   | Select-Object -ExpandProperty Value

$PSU_Stats_Schema = $confFileContent.ConfigItems | Where-Object { $_.Name -eq "PSU-Stats-Schema" } `
   | Select-Object -ExpandProperty Value

$Server_Temperature_Schema = $confFileContent.ConfigItems | Where-Object { $_.Name -eq "UCS-Server-Temperature-Schema" } `
   | Select-Object -ExpandProperty Value

$UCS_Faults_Schema = $confFileContent.ConfigItems | Where-Object { $_.Name -eq "UCS-Faults-Schema" } `
   | Select-Object -ExpandProperty Value

$X_Events_API_AccountName = $confFileContent.ConfigItems | Where-Object { $_.Name -eq "X-Events-API-AccountName" } `
   | Select-Object -ExpandProperty Value

$X_Events_API_Key = $confFileContent.ConfigItems | Where-Object { $_.Name -eq "X-Events-API-Key" } `
   | Select-Object -ExpandProperty Value


function ProgressBar {
  for ($i = 1; $i -le 6; $i++)
  {
    Write-Progress -Activity "Please wait........" -Status "$i% Complete:" -PercentComplete $i;
    Start-Sleep 1
  }
}

Write-Host = "Encryption Key read from JSON is $UCSPasswordEncryptionKey"

$edition = $PSVersionTable.PSEdition

switch ($edition)
{
  Core
  {
    Write-Host = "Found Powershell Core " -ForegroundColor Green
    & "$PSScriptRoot\PSCoreModules\LoadModule.ps1"

  }
  Desktop
  {
    # Install-Module -Name Cisco.UCSManager
    Write-Host = "Found Windows Powershell "
    Write-Host = "Checking if Cisco.UCSManager Module is installed "

    if (-not (Get-InstalledModule Cisco.UCSManager -ErrorAction silentlycontinue)) {
      Write-Host = "Cisco.UCSManager module is not installed. Installing it now..."
      # Set-PSRepository PSGallery -InstallationPolicy Trusted
      Install-Module -Name Cisco.UCSManager -Confirm:$False -Force #Powershell will prompt for user acceptance without the -Force flag

      Write-Host "Module should now be installed.... wait while we fetch details "
      Get-InstalledModule Cisco.UCSManager

      Write-Host "Importing UCSManager module "
      Import-Module Cisco.UCSManager -Force

    } else {

      Get-InstalledModule Cisco.UCSManager
      Write-Host "Cisco.UCSManager module found.. skipping"

      Write-Host "Importing UCSManager module "
      Import-Module Cisco.UCSManager -Force
    }

  }
  default {
    Write-Host "Unsuported Powershell Edition ($edition), the script only supports Powershell on Windows and Powershell Core"

  }

}

Write-Host = "Checking if ServiceNow Module is installed "
if (-not (Get-InstalledModule ServiceNow -ErrorAction silentlycontinue)) {
  Write-Host = "SerivceNow module is not installed. Installing it now..."
  #Set-PSRepository PSGallery -InstallationPolicy Trusted
  Install-Module -Name ServiceNow -Confirm:$False -Force #Powershell will prompt for user acceptance without the -Force flag

  Write-Host "Module should now be installed.... wait while we fetch details "
  Get-InstalledModule ServiceNow

} else {
  Get-InstalledModule ServiceNow
  Write-Host "ServiceNow module found.. skipping "

}

function AcquireUCSSession {
  Write-Host "########### Step 1. Connecting to UCS on $UCSURL. You will be prompted for creds" -ForegroundColor Yellow

  Connect-Ucs $UCSURL

  if ($DefaultUcs -eq $null) {
    Write-Error = "Error connecting to UCS on $UCSURL, ensure your URL and Creds are correct. You must fix this issue to use this monitoring extension" -ForegroundColor Red
    break
  }

  Write-Host "Connection to UCS is succesful. Dumping your encrypted Creds to $UCSEncryptedPasswordFile"

  Export-UcsPSSession -LiteralPath $UCSEncryptedPasswordFile -Key $(ConvertTo-SecureString -Force -AsPlainText "$UCSPasswordEncryptionKey")

  Write-Host = "Disconnecting from UCS"

  Disconnect-Ucs
}

if (Test-Path $UCSEncryptedPasswordFile) {
  #ProgressBar
  Write-Host "It looks like you already have a UCS encrypted passsword at $UCSEncryptedPasswordFile " -ForegroundColor Yellow
  $response = Read-Host -Prompt "Do you want to overwrite $UCSEncryptedPasswordFile? Y/N"
  Write-Host "You reponse is $response" -ForegroundColor Green
  if (($response -eq "Y") -or ($response -eq "y")) {
    AcquireUCSSession
  } elseif (($response -eq "N") -or ($response -eq "n")) {
    Write-Host "No problem, we are not going to update your UCS Password. " -ForegroundColor Yellow
    Start-Sleep $sleeptime
  } else {
    Write-Host "Unknown response, you need to enter either y/n or Y/N to proceed. Run the script again to proceed" -ForegroundColor RED
    return
  }
} else {
  AcquireUCSSession
}


Write-Host "########### Setting up AppDynamics Analytics Custom Event Schemas###########"
Start-Sleep $sleeptime

$psu_schema_endpoint = "$analyticsEndpoint/events/schema/$PSU_Stats_Schema"
Write-Host "PSU Schema is Endpoint $psu_schema_endpoint `n" -ForegroundColor Yellow

$temperature_schema_endpoint = "$analyticsEndpoint/events/schema/$Server_Temperature_Schema"
Write-Host "Temperature Schema $temperature_schema_endpoint" -ForegroundColor Yellow

$faults_schema_endpoint = "$analyticsEndpoint/events/schema/$UCS_Faults_Schema"
Write-Host "Faults Schema $faults_schema_endpoint " -ForegroundColor Yellow

$psuRequestBody = Get-Content $PSUJsonTemplate -Raw
$temperatureRequestBody = Get-Content $TemperatureJsonTemplate -Raw
$faultsRequestBody = Get-Content $FaultJsonTemplate -Raw

$header = @{

  "Content-Type" = 'application/vnd.appd.events+json;v=2'
  "X-Events-API-Key" = $X_Events_API_Key
  "X-Events-API-AccountName" = $X_Events_API_AccountName
}

$PostParams = @{
  #Uri     = $url
  Headers = $header
  Method = 'POST'
  #Body =  $requestBody
}

$GetParams = @{
  #Uri     = $url
  Headers = $header
  Method = 'GET'
  #Body =  $requestBody
}

Write-Host "#############Setting up fault Schema#############"
ProgressBar
try{
$fresp = Invoke-RestMethod @GetParams -Uri $faults_schema_endpoint -ErrorAction Continue
}catch{}
$ftype = $fresp.eventType
if (![string]::IsNullOrEmpty($ftype) -and ($ftype -match "$UCS_Faults_Schema")) {
  $ftype
  Write-Host "$UCS_Faults_Schema already exist. Skipping" -ForegroundColor Yellow
} else {
  Write-Host ""
  Write-Host "Creating $UCS_Faults_Schema Schema" -ForegroundColor Yellow
  Invoke-RestMethod @PostParams -Uri $faults_schema_endpoint -Body $faultsRequestBody -ErrorAction Stop
}

Start-Sleep $sleeptime

Write-Host "#############Setting up Temperature Schema #############"
ProgressBar
try{
$tresp = Invoke-RestMethod @GetParams -Uri $temperature_schema_endpoint -ErrorAction Continue
}catch{}
$ttype = $tresp.eventType
if (![string]::IsNullOrEmpty($ttype) -and ($ttype -match "$Server_Temperature_Schema")) {
  $ttype
  Write-Host "$Server_Temperature_Schema already exist. Skipping" -ForegroundColor Yellow

} else {
  Write-Host ""
  Write-Host "Creating $Server_Temperature_Schema Schema" -ForegroundColor Yellow

  Invoke-RestMethod @PostParams -Uri $temperature_schema_endpoint -Body $temperatureRequestBody -ErrorAction Stop
}

Start-Sleep $sleeptime

Write-Host "#############Setting up PSU Schema #############"
ProgressBar
try{
$presp = Invoke-RestMethod @GetParams -Uri $psu_schema_endpoint -ErrorAction Continue
}catch{}
$ptype = $presp.eventType
if (![string]::IsNullOrEmpty($ptype) -and ($ptype -match "$PSU_Stats_Schema")) {
  $ptype
  Write-Host "$PSU_Stats_Schema already exist. Skipping" . -ForegroundColor Yellow
} else {
  Write-Host ""
  Write-Host "Creating $PSU_Stats_Schema Schema" -ForegroundColor Yellow
  Invoke-RestMethod @PostParams -Uri $psu_schema_endpoint -Body $psuRequestBody -ErrorAction Stop
}

Write-Host ""

Write-Host "########### Step 3. You now need to encrypt your ServiceNow creds ###########"

Start-Sleep $sleeptime
#Follow this instruction to hash the password and store in a file 
#https://www.altaro.com/msp-dojo/encrypt-password-powershell/

function AcquireSNOWSession {
  [Byte[]]$key = (1..16)
  (Get-Credential).password | ConvertFrom-SecureString -Key $key | Out-File $SNOWEncryptedPasswordFile

  if (!(Test-Path $SNOWEncryptedPasswordFile)) {
    Write-Host "The $SNOWEncryptedPasswordFile file must exist. It wasn't created "
    break
  }

  Write-Host "Testing connection to $ServiceNowURL with $ServiceNowUsername username "

  $password = Get-Content $SNOWEncryptedPasswordFile | ConvertTo-SecureString -Key $key
  $credential = New-Object System.Management.Automation.PsCredential ($ServiceNowUsername,$password)

  Import-Module ServiceNow -Force
  $connected = Set-ServiceNowAuth -url $ServiceNowURL -Credentials $credential
  if (!$connected) {
    Write-Host "Connection to $url failed."
    break
  } else {
    Write-Host "connected to ServiceNow = $connected"
  }

}

if ($EnableServiceNow -eq "yes") {
  Write-Host "ServiceNow is enabled " -ForegroundColor Yellow
  if ((Test-Path $SNOWEncryptedPasswordFile)) {
    Write-Host "It looks like you already have a SNOW encrypted passsword at $SNOWEncryptedPasswordFile " -ForegroundColor Yellow
    $response = Read-Host -Prompt "Do you want to overwrite $SNOWEncryptedPasswordFile? Y/N"
    Write-Host "Your reponse is [$response]" -ForegroundColor Green
    if (($response -eq "Y") -or ($response -eq "y")) {
      AcquireSNOWSession
    } elseif (($response -eq "N") -or ($response -eq "n")) {
      Write-Host "No problem, we are not going to update your SNOW Password. " -ForegroundColor Yellow
      Start-Sleep $sleeptime
    } else {
      Write-Host "Unknown response, you need to enter either y/n or Y/N to proceed. Run the script again to proceed" -ForegroundColor RED
      return
    }
  } else {
    AcquireSNOWSession
  }

} else {

  Write-Host "ServiceNow Integration is not enabled."
}

Write-Host "Setup completed successfully. Registring changes"
ProgressBar
New-Item -Path . -Name $CompleteSetupIndicator -ItemType "file" -Value "The presence of this file indicates that the setup is complete. Delete it to restart the setup" -Force
