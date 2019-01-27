



To install and run the script:

1.Go to labbmilj--med-hyper-v-maskiner/AllConfig/ConfigurationInfo.ps1 and install them.

2.Run labbmilj--med-hyper-v-maskiner/AllConfig/TestConf.ps1

3.run test-conf.ps1, you need to  to delete comments for Start-LabHostConfiguration, and change the path strings to where you have the files.

4.In folder DC or SERV you find All Configuration for create Your servers with different roles.
5.In folder UserScript you find All information and Configuration for create and configure users.
6.In folder AllConfig you find All Configuration for domains....
7.run Start-LabConfiguration -ConfigurationData    labbmilj--med-hyper-v-maskiner/AllConfig/Conff.ps1

8.(optional) create a CSV file on the form Lastname, Firstname and run GenerateLabConfig to automatically generate userconfig for lability this is already done with users.csv


** in folder labbmilj--med-hyper-v-maskiner/Create an environment/  you can find scripts from Github to create an environment for your lab first.
