#Logging initializations: change as you deem fit
#$LogDir = "C:\AppDynamics\UCSMonitor"
#$ilogFile = "UCSMonitor.log"

#$LogPath = $LogDir + '\' + $iLogFile

# Function to Write into Log file
Function Write-Log {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $False)]
        [ValidateSet("INFO", "WARN", "ERROR", "FATAL", "DEBUG")]
        [String]
        $Level = "INFO",

        [Parameter(Mandatory = $True)]
        [string]
        $Message,

        [Parameter(Mandatory = $False)]
        [string]
        $logfile
    )

    $Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
    $Line = "$Stamp $Level $Message"
    if ($logfile) {
        Add-Content $logfile -Value $Line
    }
    else {
        Write-Output $Line
    }
}