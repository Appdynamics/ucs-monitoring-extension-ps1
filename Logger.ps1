#Logging initializations: change as you deem fit
#$LogDir = "C:\AppDynamics\UCSMonitor"
#$ilogFile = "UCSMonitor.log"

#$LogPath = $LogDir + '\' + $iLogFile

# Function to Write into Log file
function Write-Log {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $False)]
    [ValidateSet("INFO","WARN","ERROR","FATAL","DEBUG")]
    [string]
    $Level = "INFO",

    [Parameter(Mandatory = $True)]
    [string]
    $Message,

    [Parameter(Mandatory = $False)]
    [string]
    $logfile
  )

  $Stamp = (Get-Date).ToString("yyyy/MM/dd HH:mm:ss")
  $Line = "$Stamp $Level $Message"
  if ($logfile) {
    Add-Content $logfile -Value $Line
  }
  else {
    Write-Output $Line
  }
}
