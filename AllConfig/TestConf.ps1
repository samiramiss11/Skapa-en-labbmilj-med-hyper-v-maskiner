

#Test-LabHostConfiguration -Verbose
	
#Start-LabHostConfiguration -Verbose
#2016_x64_Standard_EN_Eval
Invoke-LabResourceDownload -MediaId 2012R2_x64_Standard_EN_V5_1_Eval
Start-LabHostConfiguration
Test-LabHostConfiguration -Verbose
Invoke-LabResourceDownload -ConfigurationData C:\Lability\Configurations\conf.psd1 -DSCResources

Find-DscResource xSmbShare
Install-Module -Name xSmbShare
Install-Module -Name xComputerManagement
Install-Module -Name xNetworking
Install-Module -Name xActiveDirectory
Install-Module -Name xDnsServer
. C:\Lability\Configurations\conf.ps1

. C:\Lability\Configurations\conf.ps1
conf -Outputpath C:\Lability\Configurations -ConfigurationData .\conf.psd1

Start-LabConfiguration -ConfigurationData C:\Lability\Configurations\conf.psd1
