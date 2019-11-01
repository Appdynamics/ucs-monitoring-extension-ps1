param([string]$Schema,[string]$requestBody)

. ".\Logger.ps1"

$endpoint_create_event = "/events/publish/$Schema"

$url = $analyticsEndpoint + $endpoint_create_event

$msg = "Sending analytics metrics to: $url"
Write-Host $msg
Write-Log DEBUG $msg $LogPath


#Write-Host "$requestBody"

$header = @{
  "Accept" = 'application/json'
  "Content-Type" = 'application/vnd.appd.events+json;v=2'
  "X-Events-API-Key" = $X_Events_API_Key
  "X-Events-API-AccountName" = $X_Events_API_AccountName
}

$params = @{
  Uri = $url
  Headers = $header
  Method = 'POST'
  Body = $requestBody
}


# taking this out of try/catch for now. The exception handling mechanism for invoke-restmethod in PWS 5.1 is pretty useless. 
Invoke-RestMethod @params -ErrorAction Stop

[hashtable]$Private:return = @{}
$Private:return.status = 0
## attempt rest call, catch errors
try {

  #$response =  Invoke-RestMethod @params 
}
catch {
  $msg = "CreateEvents catch block"
  Write-Host $msg
  $Private:return.exception = $_.exception
  $Private:return.eMsg = $_.ErrorDetails.Message
  $Private:return.status = 1
}
## get HTTP status description

$desc = $Private:return.exception.response.statusdescription
$status = $Private:return.exception.response.statuscode
$statuscode = [int]$Private:return.exception.response.statuscode
$eMsg = $Private:return.eMsg

$msg = " $statuscode : $desc `n $eMsg"

$statuscode = [int]$Private:return.exception.response.statuscode

#Write-Log FATAL "$statusCode $msg" $LogPath

#Write-Host $statusCode $msg
