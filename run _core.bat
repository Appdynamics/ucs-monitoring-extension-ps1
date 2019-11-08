@echo off
REM Modify monitor.xml file to use run_core.bat
REM If you're using Powershell Core on Windows 

pwsh -ExecutionPolicy remotesigned -File FaultFinder.ps1
