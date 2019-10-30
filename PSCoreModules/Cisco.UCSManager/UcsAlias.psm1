Set-Alias Compare-UcsMo Compare-UcsManagedObject
Set-Alias Get-UcsMo Get-UcsManagedObject
Set-Alias Remove-UcsMo Remove-UcsManagedObject
Set-Alias Add-UcsMo Add-UcsManagedObject
Set-Alias Set-UcsMo Set-UcsManagedObject
Set-Alias Sync-UcsMo Sync-UcsManagedObject
Set-Alias Unregister-UcsCentral Remove-UcsPolicyControlEp
Set-Alias Get-UcsCentral Get-UcsPolicyControlEp
Set-Alias Associate-UcsServiceProfile Connect-UcsServiceProfile
Set-Alias Disassociate-UcsServiceProfile Disconnect-UcsServiceProfile
Set-Alias Acknowledge-UcsFault Confirm-UcsFault
##############################################################################
#.SYNOPSIS
# Remove a Blade
#
#.DESCRIPTION
# Remove a Blade
#
##############################################################################
function FnRemoveUcsBlade([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsBlade -Lc remove -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsBlade -Lc remove -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsBlade -Lc remove -Force
	}
	else
	{
		$input | Set-UcsBlade -Lc remove 
	}
}
Set-Alias Remove-UcsBlade FnRemoveUcsBlade
##############################################################################
#.SYNOPSIS
# Decommission a Blade
#
#.DESCRIPTION
# Decommission a Blade
#
##############################################################################
function FnDecommissionUcsBlade([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsBlade -Lc decommission -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsBlade -Lc decommission -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsBlade -Lc decommission -Force
	}
	else
	{
		$input | Set-UcsBlade -Lc decommission 
	}
}
Set-Alias Decommission-UcsBlade FnDecommissionUcsBlade
##############################################################################
#.SYNOPSIS
# Recommission a Blade
#
#.DESCRIPTION
# Recommission a Blade
#
##############################################################################
function FnRecommissionUcsBlade([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsFabricComputePhEp -AdminState enabled -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsFabricComputePhEp -AdminState enabled -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsFabricComputePhEp -AdminState enabled -Force
	}
	else
	{
		$input | Set-UcsFabricComputePhEp -AdminState enabled 
	}
}
Set-Alias Recommission-UcsBlade FnRecommissionUcsBlade
##############################################################################
#.SYNOPSIS
# Acknowledge a Blade
#
#.DESCRIPTION
# Acknowledge a Blade
#
##############################################################################
function FnAcknowledgeUcsBlade([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsBlade -Lc rediscover -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsBlade -Lc rediscover -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsBlade -Lc rediscover -Force
	}
	else
	{
		$input | Set-UcsBlade -Lc rediscover 
	}
}
Set-Alias Acknowledge-UcsBlade FnAcknowledgeUcsBlade
##############################################################################
#.SYNOPSIS
# Remove a Chassis
#
#.DESCRIPTION
# Remove a Chassis
#
##############################################################################
function FnRemoveUcsChassis([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsChassis -AdminState remove -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsChassis -AdminState remove -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsChassis -AdminState remove -Force
	}
	else
	{
		$input | Set-UcsChassis -AdminState remove 
	}
}
Set-Alias Remove-UcsChassis FnRemoveUcsChassis
##############################################################################
#.SYNOPSIS
# Decommission a Chassis
#
#.DESCRIPTION
# Decommission a Chassis
#
##############################################################################
function FnDecommissionUcsChassis([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsChassis -AdminState decommission -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsChassis -AdminState decommission -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsChassis -AdminState decommission -Force
	}
	else
	{
		$input | Set-UcsChassis -AdminState decommission 
	}
}
Set-Alias Decommission-UcsChassis FnDecommissionUcsChassis
##############################################################################
#.SYNOPSIS
# Recommission a Chassis
#
#.DESCRIPTION
# Recommission a Chassis
#
##############################################################################
function FnRecommissionUcsChassis([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsFabricSwChPhEp -AdminState enabled -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsFabricSwChPhEp -AdminState enabled -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsFabricSwChPhEp -AdminState enabled -Force
	}
	else
	{
		$input | Set-UcsFabricSwChPhEp -AdminState enabled 
	}
}
Set-Alias Recommission-UcsChassis FnRecommissionUcsChassis
##############################################################################
#.SYNOPSIS
# Acknowledge a Chassis
#
#.DESCRIPTION
# Acknowledge a Chassis
#
##############################################################################
function FnAcknowledgeUcsChassis([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsChassis -AdminState re-acknowledge -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsChassis -AdminState re-acknowledge -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsChassis -AdminState re-acknowledge -Force
	}
	else
	{
		$input | Set-UcsChassis -AdminState re-acknowledge 
	}
}
Set-Alias Acknowledge-UcsChassis FnAcknowledgeUcsChassis
##############################################################################
#.SYNOPSIS
# Remove a Fex
#
#.DESCRIPTION
# Remove a Fex
#
##############################################################################
function FnRemoveUcsFex([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsFex -AdminState remove -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsFex -AdminState remove -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsFex -AdminState remove -Force
	}
	else
	{
		$input | Set-UcsFex -AdminState remove 
	}
}
Set-Alias Remove-UcsFex FnRemoveUcsFex
##############################################################################
#.SYNOPSIS
# Decommission a Fex
#
#.DESCRIPTION
# Decommission a Fex
#
##############################################################################
function FnDecommissionUcsFex([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsFex -AdminState decommission -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsFex -AdminState decommission -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsFex -AdminState decommission -Force
	}
	else
	{
		$input | Set-UcsFex -AdminState decommission 
	}
}
Set-Alias Decommission-UcsFex FnDecommissionUcsFex
##############################################################################
#.SYNOPSIS
# Recommission a Fex
#
#.DESCRIPTION
# Recommission a Fex
#
##############################################################################
function FnRecommissionUcsFex([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsFabricSwChPhEp -AdminState enabled -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsFabricSwChPhEp -AdminState enabled -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsFabricSwChPhEp -AdminState enabled -Force
	}
	else
	{
		$input | Set-UcsFabricSwChPhEp -AdminState enabled 
	}
}
Set-Alias Recommission-UcsFex FnRecommissionUcsFex
##############################################################################
#.SYNOPSIS
# Acknowledge a Fex
#
#.DESCRIPTION
# Acknowledge a Fex
#
##############################################################################
function FnAcknowledgeUcsFex([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsFex -AdminState re-acknowledge -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsFex -AdminState re-acknowledge -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsFex -AdminState re-acknowledge -Force
	}
	else
	{
		$input | Set-UcsFex -AdminState re-acknowledge 
	}
}
Set-Alias Acknowledge-UcsFex FnAcknowledgeUcsFex
##############################################################################
#.SYNOPSIS
# Acknowledge a Slot
#
#.DESCRIPTION
# Acknowledge a Slot
#
##############################################################################
function FnAcknowledgeUcsSlot([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsFabricComputeSlotEp -AdminState reacknowledge -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsFabricComputeSlotEp -AdminState reacknowledge -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsFabricComputeSlotEp -AdminState reacknowledge -Force
	}
	else
	{
		$input | Set-UcsFabricComputeSlotEp -AdminState reacknowledge 
	}
}
Set-Alias Acknowledge-UcsSlot FnAcknowledgeUcsSlot
##############################################################################
#.SYNOPSIS
# Remove a RackUnit
#
#.DESCRIPTION
# Remove a RackUnit
#
##############################################################################
function FnRemoveUcsRackUnit([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsRackUnit -Lc remove -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsRackUnit -Lc remove -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsRackUnit -Lc remove -Force
	}
	else
	{
		$input | Set-UcsRackUnit -Lc remove 
	}
}
Set-Alias Remove-UcsRackUnit FnRemoveUcsRackUnit
##############################################################################
#.SYNOPSIS
# Decommission a RackUnit
#
#.DESCRIPTION
# Decommission a RackUnit
#
##############################################################################
function FnDecommissionUcsRackUnit([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsRackUnit -Lc decommission -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsRackUnit -Lc decommission -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsRackUnit -Lc decommission -Force
	}
	else
	{
		$input | Set-UcsRackUnit -Lc decommission 
	}
}
Set-Alias Decommission-UcsRackUnit FnDecommissionUcsRackUnit
##############################################################################
#.SYNOPSIS
# Recommission a RackUnit
#
#.DESCRIPTION
# Recommission a RackUnit
#
##############################################################################
function FnRecommissionUcsRackUnit([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsFabricComputePhEp -AdminState enabled -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsFabricComputePhEp -AdminState enabled -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsFabricComputePhEp -AdminState enabled -Force
	}
	else
	{
		$input | Set-UcsFabricComputePhEp -AdminState enabled 
	}
}
Set-Alias Recommission-UcsRackUnit FnRecommissionUcsRackUnit
##############################################################################
#.SYNOPSIS
# Acknowledge a RackUnit
#
#.DESCRIPTION
# Acknowledge a RackUnit
#
##############################################################################
function FnAcknowledgeUcsRackUnit([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsRackUnit -Lc rediscover -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsRackUnit -Lc rediscover -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsRackUnit -Lc rediscover -Force
	}
	else
	{
		$input | Set-UcsRackUnit -Lc rediscover 
	}
}
Set-Alias Acknowledge-UcsRackUnit FnAcknowledgeUcsRackUnit
##############################################################################
#.SYNOPSIS
# Remove a ServerUnit
#
#.DESCRIPTION
# Remove a ServerUnit
#
##############################################################################
function FnRemoveUcsCartridge([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsCartridge -Lc remove -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsCartridge -Lc remove -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsCartridge -Lc remove -Force
	}
	else
	{
		$input | Set-UcsCartridge -Lc remove 
	}
}
Set-Alias Remove-UcsCartridge FnRemoveUcsCartridge
##############################################################################
#.SYNOPSIS
# Decommission a ServerUnit
#
#.DESCRIPTION
# Decommission a ServerUnit
#
##############################################################################
function FnDecommissionUcsServerUnit([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsServerUnit -Lc decommission -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsServerUnit -Lc decommission -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsServerUnit -Lc decommission -Force
	}
	else
	{
		$input | Set-UcsServerUnit -Lc decommission 
	}
}
Set-Alias Decommission-UcsServerUnit FnDecommissionUcsServerUnit
##############################################################################
#.SYNOPSIS
# Recommission a ServerUnit
#
#.DESCRIPTION
# Recommission a ServerUnit
#
##############################################################################
function FnRecommissionUcsServerUnit([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsFabricComputeMSlotEp  -SlotAdminState reacknowledge -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsFabricComputeMSlotEp  -SlotAdminState reacknowledge -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsFabricComputeMSlotEp  -SlotAdminState reacknowledge -Force
	}
	else
	{
		$input | Set-UcsFabricComputeMSlotEp  -SlotAdminState reacknowledge 
	}
}
Set-Alias Recommission-UcsServerUnit FnRecommissionUcsServerUnit
##############################################################################
#.SYNOPSIS
# Acknowledge a ServerUnit
#
#.DESCRIPTION
# Acknowledge a ServerUnit
#
##############################################################################
function FnAcknowledgeUcsServerUnit([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsServerUnit -Lc rediscover -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsServerUnit -Lc rediscover -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsServerUnit -Lc rediscover -Force
	}
	else
	{
		$input | Set-UcsServerUnit -Lc rediscover 
	}
}
Set-Alias Acknowledge-UcsServerUnit FnAcknowledgeUcsServerUnit
##############################################################################
#.SYNOPSIS
# Reset IO Module
#
#.DESCRIPTION
# Reset IO Module
#
##############################################################################
function FnResetUcsIoModule([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsIom -AdminPowerState cycle-immediate -AdminState acknowledged -AdminPeerPowerState policy -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsIom -AdminPowerState cycle-immediate -AdminState acknowledged -AdminPeerPowerState policy -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsIom -AdminPowerState cycle-immediate -AdminState acknowledged -AdminPeerPowerState policy -Force
	}
	else
	{
		$input | Set-UcsIom -AdminPowerState cycle-immediate -AdminState acknowledged -AdminPeerPowerState policy 
	}
}
Set-Alias Reset-UcsIoModule FnResetUcsIoModule
##############################################################################
#.SYNOPSIS
# Reset Peer IO Module
#
#.DESCRIPTION
# Reset Peer IO Module
#
##############################################################################
function FnResetUcsPeerIoModule([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsIom -AdminPowerState policy -AdminState acknowledged -AdminPeerPowerState cycle-immediate -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsIom -AdminPowerState policy -AdminState acknowledged -AdminPeerPowerState cycle-immediate -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsIom -AdminPowerState policy -AdminState acknowledged -AdminPeerPowerState cycle-immediate -Force
	}
	else
	{
		$input | Set-UcsIom -AdminPowerState policy -AdminState acknowledged -AdminPeerPowerState cycle-immediate 
	}
}
Set-Alias Reset-UcsPeerIoModule FnResetUcsPeerIoModule
##############################################################################
#.SYNOPSIS
# Turn On Disk Locator LED
#
#.DESCRIPTION
# Turn On Disk Locator LED
#
##############################################################################
function FnEnableUcsDiskLocatorLed([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsStorageLocalDisk -AdminActionTrigger triggered -AdminAction led-on -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsStorageLocalDisk -AdminActionTrigger triggered -AdminAction led-on -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsStorageLocalDisk -AdminActionTrigger triggered -AdminAction led-on -Force
	}
	else
	{
		$input | Set-UcsStorageLocalDisk -AdminActionTrigger triggered -AdminAction led-on 
	}
}
Set-Alias Enable-UcsDiskLocatorLed FnEnableUcsDiskLocatorLed
##############################################################################
#.SYNOPSIS
# Turn Off Disk Locator LED
#
#.DESCRIPTION
# Turn Off Disk Locator LED
#
##############################################################################
function FnDisableUcsDiskLocatorLed([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsStorageLocalDisk -AdminActionTrigger triggered -AdminAction led-off -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsStorageLocalDisk -AdminActionTrigger triggered -AdminAction led-off -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsStorageLocalDisk -AdminActionTrigger triggered -AdminAction led-off -Force
	}
	else
	{
		$input | Set-UcsStorageLocalDisk -AdminActionTrigger triggered -AdminAction led-off 
	}
}
Set-Alias Disable-UcsDiskLocatorLed FnDisableUcsDiskLocatorLed
Export-ModuleMember -Function * -Alias *

# SIG # Begin signature block
# MIIYygYJKoZIhvcNAQcCoIIYuzCCGLcCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDtdoqOPMCJ8ZRu
# CdKNH0RB2JXNlR4hMjgTc2n7rC4t1KCCEx0wggQVMIIC/aADAgECAgsEAAAAAAEx
# icZQBDANBgkqhkiG9w0BAQsFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3Qg
# Q0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMKR2xvYmFsU2ln
# bjAeFw0xMTA4MDIxMDAwMDBaFw0yOTAzMjkxMDAwMDBaMFsxCzAJBgNVBAYTAkJF
# MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWdu
# IFRpbWVzdGFtcGluZyBDQSAtIFNIQTI1NiAtIEcyMIIBIjANBgkqhkiG9w0BAQEF
# AAOCAQ8AMIIBCgKCAQEAqpuOw6sRUSUBtpaU4k/YwQj2RiPZRcWVl1urGr/SbFfJ
# MwYfoA/GPH5TSHq/nYeer+7DjEfhQuzj46FKbAwXxKbBuc1b8R5EiY7+C94hWBPu
# TcjFZwscsrPxNHaRossHbTfFoEcmAhWkkJGpeZ7X61edK3wi2BTX8QceeCI2a3d5
# r6/5f45O4bUIMf3q7UtxYowj8QM5j0R5tnYDV56tLwhG3NKMvPSOdM7IaGlRdhGL
# D10kWxlUPSbMQI2CJxtZIH1Z9pOAjvgqOP1roEBlH1d2zFuOBE8sqNuEUBNPxtyL
# ufjdaUyI65x7MCb8eli7WbwUcpKBV7d2ydiACoBuCQIDAQABo4HoMIHlMA4GA1Ud
# DwEB/wQEAwIBBjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdDgQWBBSSIadKlV1k
# sJu0HuYAN0fmnUErTDBHBgNVHSAEQDA+MDwGBFUdIAAwNDAyBggrBgEFBQcCARYm
# aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wNgYDVR0fBC8w
# LTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLm5ldC9yb290LXIzLmNybDAf
# BgNVHSMEGDAWgBSP8Et/qC5FJK5NUPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOC
# AQEABFaCSnzQzsm/NmbRvjWek2yX6AbOMRhZ+WxBX4AuwEIluBjH/NSxN8RooM8o
# agN0S2OXhXdhO9cv4/W9M6KSfREfnops7yyw9GKNNnPRFjbxvF7stICYePzSdnno
# 4SGU4B/EouGqZ9uznHPlQCLPOc7b5neVp7uyy/YZhp2fyNSYBbJxb051rvE9ZGo7
# Xk5GpipdCJLxo/MddL9iDSOMXCo4ldLA1c3PiNofKLW6gWlkKrWmotVzr9xG2wSu
# kdduxZi61EfEVnSAR3hYjL7vK/3sbL/RlPe/UOB74JD9IBh4GCJdCC6MHKCX8x2Z
# faOdkdMGRE4EbnocIOM28LZQuTCCBMYwggOuoAMCAQICDCRUuH8eFFOtN/qheDAN
# BgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2ln
# biBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBUaW1lc3RhbXBpbmcgQ0EgLSBT
# SEEyNTYgLSBHMjAeFw0xODAyMTkwMDAwMDBaFw0yOTAzMTgxMDAwMDBaMDsxOTA3
# BgNVBAMMMEdsb2JhbFNpZ24gVFNBIGZvciBNUyBBdXRoZW50aWNvZGUgYWR2YW5j
# ZWQgLSBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANl4YaGWrhL/
# o/8n9kRge2pWLWfjX58xkipI7fkFhA5tTiJWytiZl45pyp97DwjIKito0ShhK5/k
# Ju66uPew7F5qG+JYtbS9HQntzeg91Gb/viIibTYmzxF4l+lVACjD6TdOvRnlF4RI
# shwhrexz0vOop+lf6DXOhROnIpusgun+8V/EElqx9wxA5tKg4E1o0O0MDBAdjwVf
# ZFX5uyhHBgzYBj83wyY2JYx7DyeIXDgxpQH2XmTeg8AUXODn0l7MjeojgBkqs2Iu
# YMeqZ9azQO5Sf1YM79kF15UgXYUVQM9ekZVRnkYaF5G+wcAHdbJL9za6xVRsX4ob
# +w0oYciJ8BUCAwEAAaOCAagwggGkMA4GA1UdDwEB/wQEAwIHgDBMBgNVHSAERTBD
# MEEGCSsGAQQBoDIBHjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxz
# aWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMBYGA1UdJQEB/wQMMAoGCCsG
# AQUFBwMIMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5j
# b20vZ3MvZ3N0aW1lc3RhbXBpbmdzaGEyZzIuY3JsMIGYBggrBgEFBQcBAQSBizCB
# iDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNl
# cnQvZ3N0aW1lc3RhbXBpbmdzaGEyZzIuY3J0MDwGCCsGAQUFBzABhjBodHRwOi8v
# b2NzcDIuZ2xvYmFsc2lnbi5jb20vZ3N0aW1lc3RhbXBpbmdzaGEyZzIwHQYDVR0O
# BBYEFNSHuI3m5UA8nVoGY8ZFhNnduxzDMB8GA1UdIwQYMBaAFJIhp0qVXWSwm7Qe
# 5gA3R+adQStMMA0GCSqGSIb3DQEBCwUAA4IBAQAkclClDLxACabB9NWCak5BX87H
# iDnT5Hz5Imw4eLj0uvdr4STrnXzNSKyL7LV2TI/cgmkIlue64We28Ka/GAhC4evN
# GVg5pRFhI9YZ1wDpu9L5X0H7BD7+iiBgDNFPI1oZGhjv2Mbe1l9UoXqT4bZ3hcD7
# sUbECa4vU/uVnI4m4krkxOY8Ne+6xtm5xc3NB5tjuz0PYbxVfCMQtYyKo9JoRbFA
# uqDdPBsVQLhJeG/llMBtVks89hIq1IXzSBMF4bswRQpBt3ySbr5OkmCCyltk5lXT
# 0gfenV+boQHtm/DDXbsZ8BgMmqAc6WoICz3pZpendR4PvyjXCSMN4hb6uvM0MIIE
# 2TCCA8GgAwIBAgIQIHWDPrOEReitUG9yJSUhQDANBgkqhkiG9w0BAQsFADB/MQsw
# CQYDVQQGEwJVUzEdMBsGA1UEChMUU3ltYW50ZWMgQ29ycG9yYXRpb24xHzAdBgNV
# BAsTFlN5bWFudGVjIFRydXN0IE5ldHdvcmsxMDAuBgNVBAMTJ1N5bWFudGVjIENs
# YXNzIDMgU0hBMjU2IENvZGUgU2lnbmluZyBDQTAeFw0xNjExMDkwMDAwMDBaFw0x
# OTExMjYyMzU5NTlaMHExCzAJBgNVBAYTAlVTMRMwEQYDVQQIDApDYWxpZm9ybmlh
# MREwDwYDVQQHDAhTYW4gSm9zZTEcMBoGA1UECgwTQ2lzY28gU3lzdGVtcywgSW5j
# LjEcMBoGA1UEAwwTQ2lzY28gU3lzdGVtcywgSW5jLjCCASIwDQYJKoZIhvcNAQEB
# BQADggEPADCCAQoCggEBALLlVI4b5lGZi0ZHbXjIMlPDLvF6C7xjHJXtpR5zTvax
# nQNvjs+574jAE57yRjFxwmKqWqoyHKoSNO3YnlxjUk/buDk43m/QI1qtrs+14i4K
# ip3lmM2IOJeFsdLxpsPWSDdakvFqyz+H1W1266X42E5LtUk9KLqt/CP19tbA4kby
# EsSRjJfQ+ZvugUyk2NYTZ8GairJPr3ld9xls7GOI4JtCMfqv2elhUR50vM9Yec66
# il4GNgS4Af33Sz2O2XA3Ocz02km7XdS5sTIrHZSjpApQEmuugJBm2wYQ0lwOldNb
# MW61VA/vMsOR8Y0pAXb2hor9et2edDvY21GYQCo3kwUCAwEAAaOCAV0wggFZMAkG
# A1UdEwQCMAAwDgYDVR0PAQH/BAQDAgeAMCsGA1UdHwQkMCIwIKAeoByGGmh0dHA6
# Ly9zdi5zeW1jYi5jb20vc3YuY3JsMGEGA1UdIARaMFgwVgYGZ4EMAQQBMEwwIwYI
# KwYBBQUHAgEWF2h0dHBzOi8vZC5zeW1jYi5jb20vY3BzMCUGCCsGAQUFBwICMBkM
# F2h0dHBzOi8vZC5zeW1jYi5jb20vcnBhMBMGA1UdJQQMMAoGCCsGAQUFBwMDMFcG
# CCsGAQUFBwEBBEswSTAfBggrBgEFBQcwAYYTaHR0cDovL3N2LnN5bWNkLmNvbTAm
# BggrBgEFBQcwAoYaaHR0cDovL3N2LnN5bWNiLmNvbS9zdi5jcnQwHwYDVR0jBBgw
# FoAUljtT8Hkzl699g+8uK8zKt4YecmYwHQYDVR0OBBYEFMJofs4grwKJnUFm8/jC
# hhSUyVqAMA0GCSqGSIb3DQEBCwUAA4IBAQAoAoTeg6dizssRJJ92t06YFEdI+Ozj
# v12Rw8Y1Q/SJ7emwiFqFypQ9Y/lPS9LkgXxzIFWBXmCxFsPPpGQh0SG+56om+2oZ
# kj26E2pou2382mBSRW/GbbRPoGGDPQ4H2uf5Hk4ru4Aq/RGakJYk3B10u0vMZAYK
# oo5qHPDIDdTPTaYOlPzyh+7THSJWCOqlCvSQsd4bAAwarJO/db7QvIDVEt3tAsll
# /zOAWTQVFu8rNjoaXWHFo8J2JuFrvcAgzoAz9Nsl8f/X/ZonY4O1FVeA+TYIdfpI
# PJlkR1tsJi1tJJ74usKT5V4Z0dX8JVgJ4gnTtjCn8YC9xWihUPDapcjQMIIFWTCC
# BEGgAwIBAgIQPXjX+XZJYLJhffTwHsqGKjANBgkqhkiG9w0BAQsFADCByjELMAkG
# A1UEBhMCVVMxFzAVBgNVBAoTDlZlcmlTaWduLCBJbmMuMR8wHQYDVQQLExZWZXJp
# U2lnbiBUcnVzdCBOZXR3b3JrMTowOAYDVQQLEzEoYykgMjAwNiBWZXJpU2lnbiwg
# SW5jLiAtIEZvciBhdXRob3JpemVkIHVzZSBvbmx5MUUwQwYDVQQDEzxWZXJpU2ln
# biBDbGFzcyAzIFB1YmxpYyBQcmltYXJ5IENlcnRpZmljYXRpb24gQXV0aG9yaXR5
# IC0gRzUwHhcNMTMxMjEwMDAwMDAwWhcNMjMxMjA5MjM1OTU5WjB/MQswCQYDVQQG
# EwJVUzEdMBsGA1UEChMUU3ltYW50ZWMgQ29ycG9yYXRpb24xHzAdBgNVBAsTFlN5
# bWFudGVjIFRydXN0IE5ldHdvcmsxMDAuBgNVBAMTJ1N5bWFudGVjIENsYXNzIDMg
# U0hBMjU2IENvZGUgU2lnbmluZyBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
# AQoCggEBAJeDHgAWryyx0gjE12iTUWAecfbiR7TbWE0jYmq0v1obUfejDRh3aLvY
# NqsvIVDanvPnXydOC8KXyAlwk6naXA1OpA2RoLTsFM6RclQuzqPbROlSGz9BPMpK
# 5KrA6DmrU8wh0MzPf5vmwsxYaoIV7j02zxzFlwckjvF7vjEtPW7ctZlCn0thlV8c
# cO4XfduL5WGJeMdoG68ReBqYrsRVR1PZszLWoQ5GQMWXkorRU6eZW4U1V9Pqk2Jh
# IArHMHckEU1ig7a6e2iCMe5lyt/51Y2yNdyMK29qclxghJzyDJRewFZSAEjM0/il
# fd4v1xPkOKiE1Ua4E4bCG53qWjjdm9sCAwEAAaOCAYMwggF/MC8GCCsGAQUFBwEB
# BCMwITAfBggrBgEFBQcwAYYTaHR0cDovL3MyLnN5bWNiLmNvbTASBgNVHRMBAf8E
# CDAGAQH/AgEAMGwGA1UdIARlMGMwYQYLYIZIAYb4RQEHFwMwUjAmBggrBgEFBQcC
# ARYaaHR0cDovL3d3dy5zeW1hdXRoLmNvbS9jcHMwKAYIKwYBBQUHAgIwHBoaaHR0
# cDovL3d3dy5zeW1hdXRoLmNvbS9ycGEwMAYDVR0fBCkwJzAloCOgIYYfaHR0cDov
# L3MxLnN5bWNiLmNvbS9wY2EzLWc1LmNybDAdBgNVHSUEFjAUBggrBgEFBQcDAgYI
# KwYBBQUHAwMwDgYDVR0PAQH/BAQDAgEGMCkGA1UdEQQiMCCkHjAcMRowGAYDVQQD
# ExFTeW1hbnRlY1BLSS0xLTU2NzAdBgNVHQ4EFgQUljtT8Hkzl699g+8uK8zKt4Ye
# cmYwHwYDVR0jBBgwFoAUf9Nlp8Ld7LvwMAnzQzn6Aq8zMTMwDQYJKoZIhvcNAQEL
# BQADggEBABOFGh5pqTf3oL2kr34dYVP+nYxeDKZ1HngXI9397BoDVTn7cZXHZVqn
# jjDSRFph23Bv2iEFwi5zuknx0ZP+XcnNXgPgiZ4/dB7X9ziLqdbPuzUvM1ioklbR
# yE07guZ5hBb8KLCxR/Mdoj7uh9mmf6RWpT+thC4p3ny8qKqjPQQB6rqTog5QIikX
# TIfkOhFf1qQliZsFay+0yQFMJ3sLrBkFIqBgFT/ayftNTI/7cmd3/SeUx7o1DohJ
# /o39KK9KEr0Ns5cF3kQMFfo2KwPcwVAB8aERXRTl4r0nS1S+K4ReD6bDdAUK75fD
# iSKxH3fzvc1D1PFMqT+1i4SvZPLQFCExggUDMIIE/wIBATCBkzB/MQswCQYDVQQG
# EwJVUzEdMBsGA1UEChMUU3ltYW50ZWMgQ29ycG9yYXRpb24xHzAdBgNVBAsTFlN5
# bWFudGVjIFRydXN0IE5ldHdvcmsxMDAuBgNVBAMTJ1N5bWFudGVjIENsYXNzIDMg
# U0hBMjU2IENvZGUgU2lnbmluZyBDQQIQIHWDPrOEReitUG9yJSUhQDANBglghkgB
# ZQMEAgEFAKCBhDAYBgorBgEEAYI3AgEMMQowCKACgAChAoAAMBkGCSqGSIb3DQEJ
# AzEMBgorBgEEAYI3AgEEMBwGCisGAQQBgjcCAQsxDjAMBgorBgEEAYI3AgEVMC8G
# CSqGSIb3DQEJBDEiBCCH0eOkuPqQrTkK4DBpGSDJfp064EtWErgnVrf3X+m7MjAN
# BgkqhkiG9w0BAQEFAASCAQCVmTcSOHRdDbK5wa7yAp6wCdsGX1pDNHDL3jth0G1V
# jJkvl7m7YXpRRFpbZ+yyUldVlxyR74N9WZwzg8LeqMcuU/v/oh/5JOQ7s1d2Vul4
# PJnsC9/xGq1/nN8aCtUeJ8YssqWWDnW0MBkLo47cJHQZ2C1ftlNx37xj+PebXbA3
# 05Hc701WLoUGchDGIs8Ssd0qRoJeLrrnouxQAqG8+CzT49CKwSHhDvM600vqFgJn
# GbvCOs53cSb9Tax3tyvD4bRwNRKI8KJTzwxhV/QB14LPg8Ohpj48AB1WzKYk/lpU
# xcNM84Pp3YIsv/dl9k4tz8TfEgkY2wzKzsgzO7j2VGt5oYICuTCCArUGCSqGSIb3
# DQEJBjGCAqYwggKiAgEBMGswWzELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2Jh
# bFNpZ24gbnYtc2ExMTAvBgNVBAMTKEdsb2JhbFNpZ24gVGltZXN0YW1waW5nIENB
# IC0gU0hBMjU2IC0gRzICDCRUuH8eFFOtN/qheDANBglghkgBZQMEAgEFAKCCAQww
# GAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgwNjE1
# MTUwNTQ4WjAvBgkqhkiG9w0BCQQxIgQg6yEFKp+aBEnseG9TBKhlvnD1oI3Jjdii
# Du2NCd71tPMwgaAGCyqGSIb3DQEJEAIMMYGQMIGNMIGKMIGHBBQ+x2bV1NRy4hsf
# IUNSHDG3kNlLaDBvMF+kXTBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFs
# U2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBUaW1lc3RhbXBpbmcgQ0Eg
# LSBTSEEyNTYgLSBHMgIMJFS4fx4UU603+qF4MA0GCSqGSIb3DQEBAQUABIIBAFmD
# 554MlaQrIrT12B6hEYxveXU4RYlXevhPjMcLrlUwFDWkrZ9q9aLVfAfXu1gRrBYy
# 4Eah4rR5XEHERUzYemyNiHAAY96kDzUGoGMAqkoNTgs0KvRcyLh6C3AMIodt3HTs
# mFovtUnptQGD5iVzNzpXduNm3zj9HiLNxCk+DzTEh5OGiwzKtsUIBKrLSi4YcrhG
# nQjJsIAIbqA+TjDi3uyG+8WlAA4Cq3DwpBnqme/iSXadRo/BmeP0W3qQkHDPjF0n
# DuwuRROIg8ZqBG6703KiVk0ehe6p1rZR3duiQGxH9e6cyewdCVPTsMaf/ZnxTsFW
# J5pMcj/HhAoznipaMxA=
# SIG # End signature block
