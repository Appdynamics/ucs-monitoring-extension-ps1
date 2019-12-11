@echo off
REM For use in Windows Powershell Core only 
REM Replace rub.bat with run-core.bat in the monitor.xml file  
pwsh -ExecutionPolicy remotesigned -File FaultFinder.ps1
