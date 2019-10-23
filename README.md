# ucs-monitoring-extension-ps
 
Highlevel setup instruction for those who can't wait for a proper documetation 

1. Add your controller and ServiceNow creds to config.json 
2. Run the Setup.ps1 manually as an Admin. The Setup script encrypts UCS and ServiceNow creds using AES encryption algo. It also automatically creates the analytics schemas for you. Finally, it creates a appd.setup.complete.indicator.txt file to indicate that the setup has been completed. 
3. Run the FaultFinder.ps1 mannally to ensure it all works 
4. Bundle into MA monitors folder and restart MA 
