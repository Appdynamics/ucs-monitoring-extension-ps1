

<p><img align="right" width="100" height="60" src="https://user-images.githubusercontent.com/2548160/68075860-ba631e80-fda5-11e9-8457-07859944ae08.png"> </p><strong> Cisco UCS Monitoring Extension</strong>

# Introduction
Cisco Unified Computing System (UCS) is a system of servers, network, storage and storage network in a single platform.  Cisco UCS is used for creating a more cost-effective, efficient and centrally managed data center architecture by integrating computing, networking, virtualization and data storage components and resources.

This AppDynamics Cisco UCS monitoring extension covers UCS health monitoring from both proactive and reactive perspectives:

1. **Baselining Chassis Telemetry** – This solution periodically collects temperature and power supply values from UCS chassis blade-server into the AppDynamics BiQ platform. The BiQ platform applies ML/AI on the aggregated data to learn the normal power supply and temperature telemetries - so as to proactively alert when a server is getting too hot and/or if there&#39;s an outlier in the power supply volatage. This will enable AppDynamics customers to proactively monitor blade-server health (before UCS flags it as a fault), and perform remediation actions before customers are impacted.

1. **Monitoring UCS Faults** - The extension periodically polls the UCS fault engine and aggregates UCS faults in AppDynamics. These faults can be further categorised into critical UCS functional areas such as Disk Health, Fan Module health, Fabric Interconnect health, Blade server health, Rack Unit health, Chassis PSU health, vNICS health etc. All faults that are visible to the UCS manager are monitored by this extension irrespective of the affected component within UCS. Only faults that have not been acknowledged in UCS are monitored. In addition, the extension reports on only Critical, Major, Minor and Warning faults. In other words, Info, Condition and Cleared Severities are all ignored and not monitored by AppDynamics.

1. **ServiceNow Integration** – The UCS monitoring extension has an optional ServiceNow integration built-in; if enabled, the extension creates a ServiceNow incident with a detailed description of faults. The ServiceNow incident is auto-assigned to a pre-defined group. By default, it creates a P3 incident for Critical faults.

In summary, as this monitoring extension leverages the power of the AppDynamics BiQ platform, Cisco UCS customers can now slice and dice UCS faults in numerous dimensions for reporting and trend analysis purposes. For example, this query returns all UCS _critical_  faults that were caused by _power-supply_ failure, and had a direct (or a knock-on) effect on a _server_  or a _network components_ in the _last 7_ days.

> SELECT \* FROM ucs\_faults WHERE cause = &quot;power-supply&quot; AND
> Severity = &quot;critical&quot; AND Type in (&quot;network&quot;,
> &quot;server&quot;) SINCE 7 days

In the same vein, the ADQL below uses regular expression to calculate and return the average Rear Temperature of the first blade server in the first chassis. 

> SELECT avg(toFloat(FmTempSenIo)) FROM ucs\_server\_temperature WHERE
> Dn REGEXP &quot;sys/chassis-1/blade-1.\*&quot;

Better still, you can save the ADQL as a metric so it can be automatically executed every minute to plot a time-series graph.

# Prerequisites
The following requirements must be met: 

1) BiQ/Analytics License

2) Windows PowerShell 5.0 or later, or PowerShell Core running on Windows, Linux or macOS.
 - How to install PowerShell Core on [Linux
   Documentation](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-6)
 - How to install PowerShell Core on [macOS
   Documentation](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-macos?view=powershell-6)  
  - How to upgrade Windows PowerShell to 5.1 [Documentation](https://docs.microsoft.com/en-us/skypeforbusiness/set-up-your-computer-for-windows-powershell/download-and-install-windows-powershell-5-1)
 - How to install PowerShell Core on Windows (if you decide to use Powershell Core on Windows instead of upgrading to Windows PowerShell 5.1) [Documentation](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-windows?view=powershell-6)

3) Before the extension is installed, the generic AppDynamics extension prerequisites mentioned [here](https://community.appdynamics.com/t5/Knowledge-Base/Extensions-Prerequisites-Guide/ta-p/35213) need to be met. 

Please do not proceed with the extension installation if any of the aforementioned prerequisites are not met.


# Installation

1) Download and unzip the UCSMonitoringExtension.zip to the <MachineAgent_Dir>/monitors directory

2) Edit only the Value property in the `config.json` file located at <MachineAgent_Dir>/monitors/UCSMonitoringExtension

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


3) Launch PowerShell as an Administrator, change directory to the extensions folder and run the `.\Setup.ps1` script. The `Setup.ps1` script performs a one-time configuration of the following items:

   - Acquires a UCS session and exports the session details into an
   encrypted file in the SecureFolder.
 
   - If enabled, it acquires a    ServiceNow session and stores it an
   encrypted file in the    SecureFolder using AES encryption algorithm.
   
   - Creates AppDynamics Analytics Schemas – for UCS faults, Power Supply 
   Stats and Chassis temperature.
   
   - Installs ServiceNow and UCS PowerShell module from Microsoft PSGallary. If your server is behind a firewall and it is blocked from accessing https://www.powershellgallery.com, you&#39;d need to manually download and install the PowerShell modules – refer to the `Setup.ps1` script for the module names.
    - Creates a file named `appd.setup.complete.indicator.txt` - to indicate that the setup has been successfully created, if and only if the setup was successful.
    
  | ![Setup](https://user-images.githubusercontent.com/2548160/68075952-b4217200-fda6-11e9-98dd-a4562ccb3128.jpg) |       
  |:--:| 
 | *Fig. 1.0 Setup.ps1 Process* |
                              
4) Login to AppDynamics Controller and navigate to Analytics – Searches – Add  - &#39;Drag and Drop Search&#39;. Click on the Schema drop-down and ensure all 3 UCS schemas are present.

 | ![schemas](https://user-images.githubusercontent.com/2548160/68076034-b3d5a680-fda7-11e9-96a4-0767ef45dad0.jpg) |
 |:--:| 
| *Fig. 1.1 Analaytics Schema* |
 
5) Run the `FaultFinder.ps1` script manually and ensure there are no errors 

6) Restart Machine Agent 

7) Repeat step 4 after 4 minutes, but this time select the PSU schema. You&#39;re expected to see some data.  


 | ![verify_PSU_data](https://user-images.githubusercontent.com/2548160/68076433-36f8fb80-fdac-11e9-9652-fb62d9baf1c5.png)) | 
 |:--:| 
| *Fig. 1.3 Verify PSU Telemetry* |
                                 
<p align="middle" style="color:#4E3EB1;"> 
<strong>
 -------- End of UCS Monitoring Extension Setup -------- 
 </strong>
 
</p>

<p align="justify"><i><b>If you are interested in setting up a UCS dashboard similar to the one below, click <a href="https://appdynamics.github.io/ucs-monitoring-extension-docs/ucsdashboard.html">here</a> to continue reading </b></i></p>
<p align="middle"><i> (Pro-tip: Right click the dashboard and select open in new tab)</i>  </p>

<img width="1584" alt="Screenshot 2019-11-01 at 20 36 37" src="https://user-images.githubusercontent.com/2548160/68076387-c520b200-fdab-11e9-90bd-d40fd331f8eb.png">




