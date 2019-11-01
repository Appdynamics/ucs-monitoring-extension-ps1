# Cisco UCS Monitoring Extension
**With in-built ServiceNow Integration**

# Introduction
Cisco Unified Computing System (UCS) is a system of servers, network, storage and storage network in a single platform.  Cisco UCS is used for creating a more cost-effective, efficient and centrally managed data center architecture by integrating computing, networking, virtualization and data storage components and resources.

This AppDynamics Cisco UCS monitoring extension covers UCS health monitoring from both proactive and reactive perspectives:

1. **Proactive** – This solution periodically collects Chassis blade server temperature and power supply statistics from UCS into the AppDynamics BiQ platform. The BiQ platform applies ML/AI on the aggregated data to learn the normal PSU and temperature stats to alert when a server is getting too hot and/or if there&#39;s an outlier in the Power supply stats. This will enable AppDynamics customers to proactively monitor UCS PSU and temperature health - before UCS flags it as a fault, and perform remediation actions before it impacts customers.

1. **UCS faults** - This solution periodically polls the UCS fault engine and aggregates UCS faults in AppDynamics by critical UCS functional areas – such as Disk Health, Fan Module health, Fabric Interconnect health, Blade servers Health, Rack Units Health, Chassis PSU Health vNICS health etc. All faults in UCS manager are monitored by the extension irrespective of the affected UCS component. Only faults that have not been acknowledged in UCS are pulled into AppDynamics. Also, the solution report on only Critical, Major, Minor and Warning faults. In other words, Info, Condition and Cleared Severities are all ignored and not reported in AppDynamics.

1. **ServiceNow Integration** – This UCS monitoring extension has an optional ServiceNow integration built-in, if enabled, the extension creates a ServiceNow incident with a detailed description of UCS faults. The incident is auto-assigned to a pre-defined group. By default, it creates P3 incident for Critical faults.

In summary, as this monitoring extension leverages the power of the BiQ platform, Cisco UCS customers can slice and dice UCS faults in numerous dimensions for reporting and trend analysis purposes.

For example, this query returns all UCS _critical_ faults in the _last 7_ days that was caused by a _power-supply_ failure and affected server and network components.

_SELECT \* FROM ucs\_faults WHERE cause = &quot;power-supply&quot; AND Severity = &quot;critical&quot; AND Type in (&quot;network&quot;, &quot;server&quot;) SINCE 7 days_

In the same vein, the ADQL below uses a regular expression to return the average Rear Temperature (FmTempSenIo) for the Chassis-1/blad-1 server in the last 10 minutes.

_SELECT avg(toFloat(FmTempSenIo)) FROM ucs\_server\_temperature WHERE Dn REGEXP &quot;sys/chassis-1/blade-1.\*&quot; SINCE 10 minutes_

Better still, save the ADQL as a metric so it can be executed every minute to plot a time-series graph.

# Prerequisite
The following requirments must be met: 

1. BiQ/Analytics License
2. Before the extension is installed, the prerequisites mentioned [here](https://community.appdynamics.com/t5/Knowledge-Base/Extensions-Prerequisites-Guide/ta-p/35213) need to be met. Please do not proceed with the extension installation if the specified prerequisites are not met.
3. Windows PowerShell 5.0 or later, or PowerShell Core running on Windows, Linux or macOS.

# Installation

1. Download and unzip the UCSMonitoringExtension.zip to the <MachineAgent_Dir>/monitors directory

2. Edit only the Value property in the config.json file located at <MachineAgent_Dir>/monitors/UCSMonitoringExtension

 The table below contains a description of some of the configuration properties.

| **Config Property Name** | **Description** |
| --- | --- |
| UCSPasswordEncyptionKey  | Any string of your choice. This key is used to encrypt and decrypt UCS connection details. |
| UCSURL  | Specify the IP Address or domain name of UCS manager. Please do not include the http/s bit |
| analyticsEndpoint  | This is the analytics endpoint of your controller. This differs depending on the location of your controller. Please refer to this [doc](https://docs.appdynamics.com/display/PAA/SaaS+Domains+and+IP+Ranges). |
| X-Events-API-AccountName  | You can get the global account name to use from the [License page](https://docs.appdynamics.com/display/latest/License+Management)  |
| X-Events-API-Key  | Create the analytics API Key by following the instruction in this[doc](https://docs.appdynamics.com/display/latest/Managing+API+Keys).  Grant Manage, Query and Publish permissions to Custom Analytics Events. |
| EnableServiceNow  | Set to &#39;yes&#39; or &#39;no&#39;. Other ServiceNOW properties are required if set to yes, else, ignore them. |
| tierID  | This is required to monitor the health of the UCS monitoring extension i.e connectivity to AppDynamics, UCS and SNOW.Follow the instructions in this [doc](https://community.appdynamics.com/t5/Knowledge-Base/How-do-I-troubleshoot-missing-custom-metrics-or-extensions/ta-p/28695#Configuring%20an%20Extension) to acquire the component (or tier) ID. |

3. Launch PowerShell as an Administrator and run the ./Setup.ps1 script. The Setup.ps1 script performs a one-time   configuration of the following items:

   - Acquires a UCS session and exports the session details into an
   encrypted file in the SecureFolder.
 
   - If enabled, it acquires a    ServiceNow session and stores it an
   encrypted file in the    SecureFolder using AES encryption algorithm.
   
   - Creates AppDynamics Analytics Schemas – for UCS faults, Power Supply 
   Stats and Chassis temperature.
   
   - Installs ServiceNow and UCS PowerShell module from Microsoft PSGallary. If your server is behind a firewall and it is blocked from accessing https://www.powershellgallery.com, you&#39;d need to manually download and install the PowerShell modules – refer to the Setup.ps1 script for the module names.
    - Creates a file named _appd.setup.complete.indicator.txt_ - to indicate that the setup has been successfully created, if and only if the setup was successful.
4. Login to AppDynamics Controller and navigate to Analytics – Searches – Add  - &#39;Drag and Drop Search&#39;. Click on the Schema drop-down and ensure all 3 UCS schemas are present.
5. Run FaultFinder.ps1 script manually and ensure there are no errors
6. Restart Machine Agent
7. Repeat step 4 after 4 minutes, but this time select the PSU schema. You&#39;re expected to see some data.

