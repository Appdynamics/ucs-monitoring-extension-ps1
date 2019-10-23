# ucs-monitoring-extension-ps
 
Highlevel setup instruction for those who can't wait for a proper documetation 

1. Add your controller and ServiceNow creds to config.json 
2. Run the Setup.ps1 manually as an Admin. The Setup script:
    * Installs the Cisco.UCSManager Powershell Module -https://www.powershellgallery.com/packages/Cisco.UCSManager/2.4.1.3
    * Installs ServiceNow Powershell module - https://www.powershellgallery.com/packages/ServiceNow/1.8.0
    * Encrypts UCS and ServiceNow creds using AES encryption algo.
    * Automatically creates the analytics schemas 
    * Creates a appd.setup.complete.indicator.txt file to indicate that the setup has been completed. 
3. Run the FaultFinder.ps1 mannally to ensure it all works 
4. Bundle into MA monitors folder and restart MA 




## Analytics Queries

"queryName" : "UCS_Adaptor_vNICs_Health"
"adqlQueryString" : SELECT count(*) FROM ucs_faults WHERE Dn REGEXP "sys/chassis-[1-9]/blade-[1-5]/adaptor-.*"
  
"queryName" : "UCS_Blade_Server_Health",
"adqlQueryString" : SELECT count(*) FROM ucs_faults WHERE Dn REGEXP "sys/chassis-[1-9]/blade-[1-9]/fault-F.*"
  
"queryName" : "UCS_Chassis_IOM_Health",
"adqlQueryString" : SELECT count(*) FROM ucs_faults WHERE Dn REGEXP "sys/chassis-[1-9]/slot-.*"
  
"queryName" : "UCS_Chassis_PSU_Health",
"adqlQueryString" : SELECT count(*) FROM ucs_faults WHERE Dn REGEXP "sys/chassis-[1-9]/psu-.*"
  
 "queryName" : "UCS_Critical_Faults_Count",
 "adqlQueryString" : "SELECT count(*) FROM ucs_faults WHERE Severity = "critical"
 
"queryName" : "UCS_Fabric_Interconnect_Health",
"adqlQueryString" : "SELECT count(*) FROM ucs_faults WHERE Dn REGEXP "sys/switch-.*"
  
 "queryName" : "UCS_FanModule_Health",
  "adqlQueryString" : SELECT count(*) FROM ucs_faults WHERE Dn REGEXP "sys/chassis-[1-9]/fan-module.*
  
 "queryName" : "UCS_FmTempSenIo_Chassis-1-Blade-1",
 "adqlQueryString" : SELECT avg(toFloat(FmTempSenIo)) FROM ucs_server_temperature WHERE Dn REGEXP 

 "queryName" : "UCS_FmTempSenIo_Chassis-2-Blade-2",
  "adqlQueryString" : "SELECT avg(toFloat(FmTempSenIo)) FROM ucs_server_temperature WHERE Dn REGEXP "sys/chassis-2/blade-2.*"

 "queryName" : "UCS_Major_Faults_Count",
 "adqlQueryString" : "SELECT count(*) FROM ucs_faults WHERE Severity = "major"

  "queryName" : "UCS_Minor_Faults_Count",
  "adqlQueryString" : "SELECT count(*) FROM ucs_faults WHERE Severity = "minor"
  
  "queryName" : "UCS_NumberOfFaults",
  "adqlQueryString" : "SELECT count(*) FROM ucs_faults WHERE Severity is not NULL",
  
 "queryName" : "UCS_PSU_Input201v-Chassis-1-psu-1",
 "adqlQueryString" : "SELECT avg(toFloat(Input210v)) FROM ucs_psu_stats WHERE Dn = "sys/chassis-1/psu-1/stats"

  "queryName" : "UCS_RackUnit_CPU_Health",
  "adqlQueryString" : SELECT count(*) FROM ucs_faults WHERE Dn REGEXP "sys/rack-unit-[1-9]/board/cpu-.*"
  
  "queryName" : "UCS_RackUnit_PSU_Health",
    "adqlQueryString" : SELECT count(*) FROM ucs_faults WHERE Dn REGEXP "sys/rack-unit-[1-9]/psu-.*"
  
  "queryName" : "UCS_StorageDisk_Health",
  "adqlQueryString" : SELECT count(*) FROM ucs_faults WHERE Dn REGEXP "sys/rack-unit-[1-9]/board/storage.*",
 

  "queryName" : "UCS_Temp_Chassis-1_Blade-1",
  "queryDescription" : "Learning temperature",
    "adqlQueryString" : SELECT avg(toFloat(FmTempSenIo)) FROM ucs_server_temperature WHERE Dn REGEXP "sys/chassis-1/blade-1.*"    

  "queryName" : "UCS_Warning_Faults_Count",
  "adqlQueryString" : SELECT count(*) FROM ucs_faults WHERE Severity = "warning"
