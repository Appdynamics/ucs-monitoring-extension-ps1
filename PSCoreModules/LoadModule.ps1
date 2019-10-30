Import-Module ".\PSCoreModules\Cisco.UCS.Core"
Import-Module ".\PSCoreModules\Cisco.UCSManager"

$version = Get-UcsPowerToolConfiguration
write-host " Using Cisco UCS PowerTool Core Suite $($version.Version) Beta"
