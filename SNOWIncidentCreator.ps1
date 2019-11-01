#param([string]$snowFaults, [int]$totalFaults, [string]$LogPath)

#Load Logger Function - relative path

. ".\Logger.ps1"

#encrypt SNOW password 
#https://www.altaro.com/msp-dojo/encrypt-password-powershell/
#Module
#https://github.com/Sam-Martin/servicenow-powershell

Write-Log DEBUG "In SNOW Path is: $SNOWEncryptedPasswordFile " $LogPath

[Byte[]]$key = (1..16)

$password = Get-Content $SNOWEncryptedPasswordFile | ConvertTo-SecureString -Key $key

if ([string]::IsNullOrEmpty($password)) {
  Write-Host "$metric_prefix|SNOW|Connectivity,$failed"
  $msg = "Failed to descrypt SNOW password. Please contact support."
  Write-Host $msg
  Write-Log FATAL $msg $LogPath
} else {

  $credential = New-Object System.Management.Automation.PsCredential ($SerivceNowUsername,$password)
  Write-Log DEBUG "SercieNowUsername is $SerivceNowUsername" $LogPath

  Import-Module ServiceNow
  $connected = Set-ServiceNowAuth -url $ServiceNowURL -Credentials $credential

  Write-Log DEBUG "connected to ServiceNow = $connected" $LogPath

  if (!$connected) {
    $msg = "Connection to $url failed."
    Write-Host $msg -ForegroundColor Red
    Write-Log FATAL $msg $LogPath
    Write-Host "$metric_prefix|SNOW|Connectivity,$failed"
    break
  }

  Write-Host "$metric_prefix|SNOW|Connectivity,$success"

  Write-Host $totalFaults

  #first elements of faults goes in the shortdescription - as it's the highest priority

  $firstCause = $faults | Select-Object -First 1 | Select-Object Cause | Select-Object -ExpandProperty Cause
  #$firstCause = $firstCause -replace ':','' 
  $firstCause = $firstCause.Trim()

  $firstSeverity = $faults | Select-Object -First 1 | Select-Object Severity | Select-Object -ExpandProperty Severity
  $firstSeverity = $firstSeverity.Trim()

  $firstType = $faults | Select-Object -First 1 | Select-Object Type | Select-Object -ExpandProperty Type
  $firstType = $firstType.Trim()

  $firstDn = $faults | Select-Object -First 1 | Select-Object Dn | Select-Object -ExpandProperty Dn
  $firstDn = $firstDn.Trim()
  #Yank out the last bit containg fault code.for. eg org-root/org-HXMGMTCL001/ls-rack-unit-4/fault-F0331
  $yankedDn = $firstDn -replace "\/fault-F[0-9]+$",""

  #Write-Host "Dn before splitting $firstDn.  Aftering splitting $splitDn[0], $splitDn[1] $splitDn[2] $splitDn[3]"

  [int]$minusOne = $totalFaults - 1
  $lessOne = ""
  if ($minusOne -ge 1) { $lessOne = "Including $minusOne other faults" }

  $summary = "AppDynamics detected a $firstSeverity $firstCause fault with $yankedDn affecting $firstType. $lessOne "

  #get the first 3 issues 

  #$Descfaults = $faults | Select-Object -First 5 | Select-Object Created, Severity, Cause, Descr, Dn | Sort-Object Severity | Format-Table -View Severity | Out-File .\tf.txt


  $descr = $faults | Select-Object | ConvertTo-Html -Property Created,LastTransition,Severity,Cause,Occcur,Rn,Type,Tags,Dn,Descr -Fragment

  $totalCritical = ($faults | Where-Object { $_.Severity -eq "critical" } | Measure-Object).Count

  $totalMajor = ($faults | Where-Object { $_.Severity -eq "major" } | Measure-Object).Count

  $totalMinor = ($faults | Where-Object { $_.Severity -eq "minor" } | Measure-Object).Count

  $totalWarning = ($faults | Where-Object { $_.Severity -eq "warning" } | Measure-Object).Count

  $faultsCalc = "<b> Faults Summary </b> <br> Critical : $totalCritical <br> Major : $totalMajor <br> Minor : $totalMinor <br> Warning: $totalWarning <br> "

  Write-Host $faultsCalc
  Write-Log INFO $faultsCalc $LogPath

  #$comment = $faults | Select-Object -First 10 | ConvertTo-HTML -Property Dn, Rn, Type, Tags, Rule, Ack  -Fragment 

  Write-Host $summary

  $IncidentParams = @{ 
    Caller = "$SerivceNowUsername"
    ShortDescription = "$summary"
    Description = "$faultsCalc $descr"
    AssignmentGroup = "$SerivceNowAssignmentGroup"
    Comment = "This is an automated incident created by AppDynamics"

    CustomFields = @{
      u_service = "MyService"
      u_record_type = "incident"
      impact = "2"
      urgency = "2"
      u_system = "Cisco Unity PROD system"

    }
  }

  $snow = New-ServiceNowIncident @IncidentParams
  $icnum = $snow.number
  Write-Log INFO "Incident number $icnum " $LogPath
  Write-Log INFO "summary=>  $summary " $LogPath
  Write-Log INFO "Assignment Group=> $SerivceNowAssignmentGroup " $LogPath
  
  Write-Host "Incident number- $icnum"

}
