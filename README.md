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
