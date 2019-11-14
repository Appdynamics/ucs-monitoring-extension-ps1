
<p><img align="right" width="100" height="60" src="https://user-images.githubusercontent.com/2548160/68075860-ba631e80-fda5-11e9-8457-07859944ae08.png"> </p><strong> Cisco UCS Monitoring Extension</strong>

# Create Analytics Metrics 

Copy the queries from  <a href="https://gist.github.com/iogbole/961a3ab20503a1c90b9ac9896822e6a7#file-queries-txt" target="_blank" > this Gist </a> and create analytics metrics from them. Your metric names should match the values in the gist. 

Refer to the <a href="https://docs.appdynamics.com/display/latest/Create+Analytics+Metrics+From+Scheduled+Queries"> Create Analytics Metrics From Scheduled Queries</a> documentation for details on how to do this. 

# Create Analytics Health Rules 

Create health rules from the scheduled queries in the previous section. You may use the AppDynamcis Config Exporter* tool to import the health rules from <a href="https://gist.github.com/iogbole/961a3ab20503a1c90b9ac9896822e6a7#file-analytics-health-rules-json" target= "_blank">this Gist</a> into your controller. Config Exporter has limited functionalities in Controller version 4.5.12, and may be completely depreciated in version 4.5.16 - so your mileage may differ depending on your controller version. 

The other alternative is to manaully create the health rules. Again,the names should be exactly thesame otherwise, you will be required to update the dashboard JSON file. 

                  "name" : "UCS_StorageDisk_Health",
                  "name" : "UCS_Blade_Server_Health",
                  "name" : "UCS_RackUnit_CPU_Health",
                  "name" : "UCS_NumberOfFaults",
                  "name" : "UCS_RackUnit_PSU_Health",
                  "name" : "UCS_Chassis_PSU_Health",
                  "name" : "UCS_FanModule_Health",
                  "name" : "UCS_Adaptor_vNICs_Health",
                  "name" : "UCS_Chassis_IOM_Health",
                  "name" : "UCS_Fabric_Interconnect_Health",
                  "name" : "UCS_RackUnit_PSU_Health"

A full list of the health rule names, including UCS servers' power supply and temperature telemetry baselining can be found in <a href="https://gist.github.com/iogbole/961a3ab20503a1c90b9ac9896822e6a7#file-health-rule-names-json" target="_blank">this Gist</a>. 

Using *UCS_StorageDisk_Health* as an example:  

![Screenshot 2019-11-14 at 12 44 57](https://user-images.githubusercontent.com/2548160/68859861-2582ee00-06e0-11ea-9993-d6e9574bdfc0.png)

Condition

![Screenshot 2019-11-14 at 12 45 07](https://user-images.githubusercontent.com/2548160/68859874-2a47a200-06e0-11ea-8201-a48c6f4459b3.png)

# Monitoring the monitor 

UCS Monitoring extension performs a health check on itself, ServiceNow connectivity (if in use) and connectivity to UCS Manager. 

Navigate to the application that contains the tier ID you provided in the config.json file and the create the following health rules using exact name: 

**SNOW Connectivity Health**

 *Health Rule Name:  SNOW Connectivity Health*

 ![SNOW](https://user-images.githubusercontent.com/2548160/68711065-c793c080-0590-11ea-8b9a-30914ac72380.png)

  *Condition* 
  - No warning condition 
  - A metric value of 1 indicates failure 
  
 ![condition](https://user-images.githubusercontent.com/2548160/68712168-0cb8f200-0593-11ea-9494-1cda611080b7.jpg)

**UCS Connectivity Health**

 *Health Rule Name: UCS Connectivity Health*
 
  ![UCS](https://user-images.githubusercontent.com/2548160/68712728-3c1c2e80-0594-11ea-9226-33ac014273d9.png)
 
 *Condition* 
  - No warning condition 
  - A metric value of 1 indicates failure 
  
  ![UCS1](https://user-images.githubusercontent.com/2548160/68712882-8d2c2280-0594-11ea-9e9d-b9c11e4d9e86.png)

**UCS Machine Availability Health**

 *Health Rule Name: UCS Machine Availability Health*
 
 ![Screenshot 2019-11-12 at 21 42 03](https://user-images.githubusercontent.com/2548160/68713370-95d12880-0595-11ea-9f38-658b8feb935e.png)
 
*Condition* 
  - No warning condition 
  - A metric value of 1 indicates success 
![112](https://user-images.githubusercontent.com/2548160/68713582-198b1500-0596-11ea-88ef-78717f7d908c.jpg)

# Upload the dashboard 
1. Download the dashboard JSON file from <a href="https://gist.github.com/iogbole/961a3ab20503a1c90b9ac9896822e6a7#file-ucs_dashboard-json" taget="_blank">this Gist</a>. 
2. Get your analytics applicationName from the controller. Navigate to  Analytics - Alert & Response - Health Rules. Select any health rule and note down the value under "Policy Executed On" coulmn as indicated in the screenshot below
 
![Health Rules - AppDynamics 2019-11-14 13-53-40](https://user-images.githubusercontent.com/2548160/68862911-38002600-06e6-11ea-8b2d-24eb8ac98b25.jpg)

3. Open the UCS_Dashoard.JSON file in your favourite text editor and find and replace all instances of "AppDynamics Analytics-249" with the value from step 2. 

4. Upload the dashboard 

5. Update any missing health status manually  - including the UCS extension health check status 

6. Make it your own 

# Role Based Access Control 
If you'd like to restrict access to the UCS dashboard, you'd need to create a UCS Dashboard viewer role. Note that this role need to be able to query the faults, psu and temperature schemas respectively. Follow the screenshots: 

Navigate to the Administrator's page and Add a role: 

Under Applications, select Analytics and the application that contains the tierID you provided in the config.json file 

![1](https://user-images.githubusercontent.com/2548160/68866002-a8f60c80-06eb-11ea-8c57-c521310fae57.jpg)

Under Analytics, Events, Select Custom Analytics Events 

![2](https://user-images.githubusercontent.com/2548160/68866008-abf0fd00-06eb-11ea-8ad6-6aa34f9e594b.jpg)

Then add all 3 ucs schemas 

![3](https://user-images.githubusercontent.com/2548160/68866014-aeebed80-06eb-11ea-9b6e-d963fc317d46.jpg)

Finally, assign the role to a user or group - depending on your need. 
![4](https://user-images.githubusercontent.com/2548160/68866017-b0b5b100-06eb-11ea-9103-d2004eb9f3bb.jpg)
 

*Config Exporter - Ask your AppDynamics representative to give you the Config Exporter tool if you don't already have it. Config exporter be used to migrate configuration between controllers or applications. The configuration can be imported directly into another controller/application or it can be download as a file. 
