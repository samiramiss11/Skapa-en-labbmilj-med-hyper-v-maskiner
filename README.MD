



To install and run the script:

1.install lability with get lability.ps1

2.Download the modules required with DownloadResources.ps1(this is optional)

3.run test-conf.ps1, do not forget to delete comments for Start-LabHostConfiguration, and change the path strings to where you have the files

4. C: Labs Configurations conf.p1 conf -Outputpath C: Labs Configurations -ConfigurationData.confpsd1 is used to create the mof and meta mof files, run it if needed

5.run Start-LabConfiguration -ConfigurationData C: Labs Configurations conf.psd1 # with path to conf.psd1

(optional) create a CSV file on the form Lastname, Firstname and run GenerateLabConfig to automatically generate userconfig for lability this is already done with users.csv
