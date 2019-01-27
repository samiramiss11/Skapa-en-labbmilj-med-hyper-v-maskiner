


Configuration conf {
<#
    Requires the following custom DSC resources:
        xComputerManagement: https://github.com/PowerShell/xComputerManagement
        xNetworking:         https://github.com/PowerShell/xNetworking
        xActiveDirectory:    https://github.com/PowerShell/xActiveDirectory
        xSmbShare:           https://github.com/PowerShell/xSmbShare
        xDhcpServer:         https://github.com/PowerShell/xDhcpServer
        xDnsServer:          https://github.com/PowerShell/xDnsServer
#>
    param (
        [Parameter()] [ValidateNotNull()] [PSCredential] $Credential = (Get-Credential -Credential 'Administrator')
    )
    Import-DscResource -Module xComputerManagement, xNetworking, xActiveDirectory;
    Import-DscResource -Module xSmbShare, PSDesiredStateConfiguration;
    Import-DscResource -Module xDnsServer;
	#$password = ConvertTo-SecureString "Linux4Ever" -AsPlainText -Force
	#$Credential = (New-Object System.Management.Automation.PSCredential ("Administrator",$password))
    node $AllNodes.Where({$true}).NodeName {

        LocalConfigurationManager {

            RebootNodeIfNeeded   = $true;
            AllowModuleOverwrite = $true;
            ConfigurationMode    = 'ApplyOnly';
            CertificateID        = $node.Thumbprint;
        }

        if (-not [System.String]::IsNullOrEmpty($node.IPAddress)) {

            xIPAddress 'PrimaryIPAddress' {

                IPAddress      = $node.IPAddress;
                InterfaceAlias = $node.InterfaceAlias;
                #PrefixLength   = $node.PrefixLength;
                AddressFamily  = $node.AddressFamily;
            }

            if (-not [System.String]::IsNullOrEmpty($node.DefaultGateway)) {

                xDefaultGatewayAddress 'PrimaryDefaultGateway' {

                    InterfaceAlias = $node.InterfaceAlias;
                    Address        = $node.DefaultGateway;
                    AddressFamily  = $node.AddressFamily;
                }
            }

            if (-not [System.String]::IsNullOrEmpty($node.DnsServerAddress)) {

                xDnsServerAddress 'PrimaryDNSClient' {

                    Address        = $node.DnsServerAddress;
                    InterfaceAlias = $node.InterfaceAlias;
                    AddressFamily  = $node.AddressFamily;
                }
            }

            if (-not [System.String]::IsNullOrEmpty($node.DnsConnectionSuffix)) {

                xDnsConnectionSuffix 'PrimaryConnectionSuffix' {

                    InterfaceAlias           = $node.InterfaceAlias;
                    ConnectionSpecificSuffix = $node.DnsConnectionSuffix;
                }
            }

        } #end if IPAddress

    } #end nodes ALL

    node $AllNodes.Where({$_.Role -in 'DC'}).NodeName {

        ## Flip credential into username@domain.com
        $domainCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ("$($Credential.UserName)@$($node.DomainName)", $Credential.Password);

        xComputer 'Hostname' {

            Name = $node.NodeName;
        }

        ## Hack to fix DependsOn with hypens "bug" :(
        foreach ($feature in @(
                'AD-Domain-Services',
                'GPMC',
                'RSAT-AD-Tools'
            )) {
            WindowsFeature $feature.Replace('-','') {

                Ensure               = 'Present';
                Name                 = $feature;
                IncludeAllSubFeature = $true;
            }
        }

        xADDomain 'ADDomain' {

            DomainName                    = $node.DomainName;
            SafemodeAdministratorPassword = $Credential;
            DomainAdministratorCredential = $Credential;
            DependsOn                     = '[WindowsFeature]ADDomainServices';
        }

        xADUser User1 {

            DomainName  = $node.DomainName;
            UserName    = 'User1';
            Description = 'Lability Test Lab user';
            Password    = $Credential;
            Ensure      = 'Present';
            DependsOn   = '[xADDomain]ADDomain';
        }

        xADGroup DomainAdmins {

            GroupName        = 'Domain Admins';
            MembersToInclude = 'User1';
            DependsOn        = '[xADUser]User1';
        }

        xADGroup EnterpriseAdmins {

            GroupName        = 'Enterprise Admins';
            GroupScope       = 'Universal';
            MembersToInclude = 'User1';
            DependsOn        = '[xADUser]User1';
        }
		xADUser EleCha {

            DomainName  = $node.DomainName;
            UserName    = 'EleCha';
            Description = 'Lability Test Lab user';
            Password    = $Credential;
            Ensure      = 'Present';
            DependsOn   = '[xADDomain]ADDomain';
        }
            xADUser SamAli {

            DomainName  = $node.DomainName;
            UserName    = 'SamAli';
            Description = 'Lability Test Lab user';
            Password    = $Credential;
            Ensure      = 'Present';
            DependsOn   = '[xADDomain]ADDomain';
        }
            xADUser GunAnd {

            DomainName  = $node.DomainName;
            UserName    = 'GunAnd';
            Description = 'Lability Test Lab user';
            Password    = $Credential;
            Ensure      = 'Present';
            DependsOn   = '[xADDomain]ADDomain';
        }
            xADUser YelBet{

            DomainName  = $node.DomainName;
            UserName    = 'YelBet';
            Description = 'Lability Test Lab user';
            Password    = $Credential;
            Ensure      = 'Present';
            DependsOn   = '[xADDomain]ADDomain';
        }
            xADUser ElhAtl {

            DomainName  = $node.DomainName;
            UserName    = 'ElhAtl';
            Description = 'Lability Test Lab user';
            Password    = $Credential;
            Ensure      = 'Present';
            DependsOn   = '[xADDomain]ADDomain';
        }
            xADUser SimPar {

            DomainName  = $node.DomainName;
            UserName    = 'SimPar';
            Description = 'Lability Test Lab user';
            Password    = $Credential;
            Ensure      = 'Present';
            DependsOn   = '[xADDomain]ADDomain';
        }
            xADUser BenJer {

            DomainName  = $node.DomainName;
            UserName    = 'BenJer';
            Description = 'Lability Test Lab user';
            Password    = $Credential;
            Ensure      = 'Present';
            DependsOn   = '[xADDomain]ADDomain';
        }
            xADUser SarMoa {

            DomainName  = $node.DomainName;
            UserName    = 'SarMoa';
            Description = 'Lability Test Lab user';
            Password    = $Credential;
            Ensure      = 'Present';
            DependsOn   = '[xADDomain]ADDomain';
        }
            xADUser LubBet {

            DomainName  = $node.DomainName;
            UserName    = 'LubBet';
            Description = 'Lability Test Lab user';
            Password    = $Credential;
            Ensure      = 'Present';
            DependsOn   = '[xADDomain]ADDomain';
        }
            xADUser GayKri {

            DomainName  = $node.DomainName;
            UserName    = 'GayKri';
            Description = 'Lability Test Lab user';
            Password    = $Credential;
            Ensure      = 'Present';
            DependsOn   = '[xADDomain]ADDomain';
        }
            xADUser AliLun {

            DomainName  = $node.DomainName;
            UserName    = 'AliLun';
            Description = 'Lability Test Lab user';
            Password    = $Credential;
            Ensure      = 'Present';
            DependsOn   = '[xADDomain]ADDomain';
        }
            xADUser DanMaz {

            DomainName  = $node.DomainName;
            UserName    = 'DanMaz';
            Description = 'Lability Test Lab user';
            Password    = $Credential;
            Ensure      = 'Present';
            DependsOn   = '[xADDomain]ADDomain';
        }
            xADUser TonPal {

            DomainName  = $node.DomainName;
            UserName    = 'TonPal';
            Description = 'Lability Test Lab user';
            Password    = $Credential;
            Ensure      = 'Present';
            DependsOn   = '[xADDomain]ADDomain';
        }
            xADUser EriGon {

            DomainName  = $node.DomainName;
            UserName    = 'EriGon';
            Description = 'Lability Test Lab user';
            Password    = $Credential;
            Ensure      = 'Present';
            DependsOn   = '[xADDomain]ADDomain';
        }
            xADUser JacBri {

            DomainName  = $node.DomainName;
            UserName    = 'JacBri';
            Description = 'Lability Test Lab user';
            Password    = $Credential;
            Ensure      = 'Present';
            DependsOn   = '[xADDomain]ADDomain';
        }
            xADUser KriMaz {

            DomainName  = $node.DomainName;
            UserName    = 'KriMaz';
            Description = 'Lability Test Lab user';
            Password    = $Credential;
            Ensure      = 'Present';
            DependsOn   = '[xADDomain]ADDomain';
        }
            xADUser SasJen {

            DomainName  = $node.DomainName;
            UserName    = 'SasJen';
            Description = 'Lability Test Lab user';
            Password    = $Credential;
            Ensure      = 'Present';
            DependsOn   = '[xADDomain]ADDomain';
        }
            xADUser MorMaz {

            DomainName  = $node.DomainName;
            UserName    = 'MorMaz';
            Description = 'Lability Test Lab user';
            Password    = $Credential;
            Ensure      = 'Present';
            DependsOn   = '[xADDomain]ADDomain';
        }
            xADUser PelRos {

            DomainName  = $node.DomainName;
            UserName    = 'PelRos';
            Description = 'Lability Test Lab user';
            Password    = $Credential;
            Ensure      = 'Present';
            DependsOn   = '[xADDomain]ADDomain';
        }
            xADUser EliJah {

            DomainName  = $node.DomainName;
            UserName    = 'EliJah';
            Description = 'Lability Test Lab user';
            Password    = $Credential;
            Ensure      = 'Present';
            DependsOn   = '[xADDomain]ADDomain';
        }


    } #end nodes DC

    ## INET1 is on the 'Internet' subnet and not domain-joined
    node $AllNodes.Where({$_.Role -in 'CLIENT','APP','EDGE'}).NodeName {

        ## Flip credential into username@domain.com
        $upn = '{0}@{1}' -f $Credential.UserName, $node.DomainName;
        $domainCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ($upn, $Credential.Password);

        xComputer 'DomainMembership' {

            Name       = $node.NodeName;
            DomainName = $node.DomainName;
            Credential = $domainCredential;
        }
    } #end nodes DomainJoined

    node $AllNodes.Where({$_.Role -in 'APP'}).NodeName {

        ## Flip credential into username@domain.com
        $upn = '{0}@{1}' -f $Credential.UserName, $node.DomainName;
        $domainCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ($upn, $Credential.Password);

        foreach ($feature in @(
                'Web-Default-Doc',
                'Web-Dir-Browsing',
                'Web-Http-Errors',
                'Web-Static-Content',
                'Web-Http-Logging',
                'Web-Stat-Compression',
                'Web-Filtering',
                'Web-Mgmt-Tools',
                'Web-Mgmt-Console')) {
            WindowsFeature $feature.Replace('-','') {

                Ensure               = 'Present';
                Name                 = $feature;
                IncludeAllSubFeature = $true;
                DependsOn            = '[xComputer]DomainMembership';
            }
        }

        


    } #end nodes APP
	node $AllNodes.Where({$_.Role -in 'APP','DC'}).NodeName {
		    
		File 'Resurser' {

			DestinationPath = 'C:\Resurser';
			Type            = 'Directory';
		}
        xSmbShare 'Resurser' {

            Name         = 'Resurser';
            Path         = 'C:\Resurser';
            ChangeAccess = 'samira\Everyone';
            DependsOn    = '[File]Resurser';
            Ensure       = 'Present';
        }
		File 'Gemensam' {

			DestinationPath = 'C:\Gemensam';
			Type            = 'Directory';
		}
        xSmbShare 'FilesShare' {

            Name         = 'Gemensam';
            Path         = 'C:\Gemensam';
            ChangeAccess = 'samira\Everyone';
            DependsOn    = '[File]Gemensam';
            Ensure       = 'Present';
        }
			
			
		File 'EleCha' {
			DestinationPath = 'C:\EleCha';
			Type            = 'Directory';
		}
        xSmbShare 'EleCha$' {

            Name         = 'EleCha$';
            Path         = 'C:\EleCha';
            ChangeAccess = 'samira\EleCha';
            DependsOn    = '[File]EleCha';
            Ensure       = 'Present';
        }
        File 'SamAli' {

			DestinationPath = 'C:\SamAli';
			Type            = 'Directory';
		}
        xSmbShare 'SamAli$' {

            Name         = 'SamAli$';
            Path         = 'C:\SamAli';
            ChangeAccess = 'samira\SamAli';
            DependsOn    = '[File]SamAli';
            Ensure       = 'Present';
        }
        File 'GunAnd' {

			DestinationPath = 'C:\GunAnd';
			Type            = 'Directory';
		}
        xSmbShare 'GunAnd$' {

            Name         = 'GunAnd$';
            Path         = 'C:\GunAnd';
            ChangeAccess = 'samira\GunAnd';
            DependsOn    = '[File]GunAnd';
            Ensure       = 'Present';
        }
        File 'YelBet' {

			DestinationPath = 'C:\YelBet';
			Type            = 'Directory';
		}
        xSmbShare 'YelBet$' {

            Name         = 'YelBet$';
            Path         = 'C:\YelBet';
            ChangeAccess = 'samira\YelBet';
            DependsOn    = '[File]YelBet';
            Ensure       = 'Present';
        }
        File 'ElhAtl' {

			DestinationPath = 'C:\ElhAtl';
			Type            = 'Directory';
		}
        xSmbShare 'ElhAtl$' {

            Name         = 'ElhAtl$';
            Path         = 'C:\ElhAtl';
            ChangeAccess = 'samira\ElhAtl';
            DependsOn    = '[File]ElhAtl';
            Ensure       = 'Present';
        }
        File 'SimPar' {

			DestinationPath = 'C:\SimPar';
			Type            = 'Directory';
		}
        xSmbShare 'SimPar$' {

            Name         = 'SimPar$';
            Path         = 'C:\SimPar';
            ChangeAccess = 'samira\SimPar';
            DependsOn    = '[File]SimPar';
            Ensure       = 'Present';
        }
        File 'BenJer' {

			DestinationPath = 'C:\BenJer';
			Type            = 'Directory';
		}
        xSmbShare 'BenJer$' {

            Name         = 'BenJer$';
            Path         = 'C:\BenJer';
            ChangeAccess = 'samira\BenJer';
            DependsOn    = '[File]BenJer';
            Ensure       = 'Present';
        }
        File 'SarMoa' {

			DestinationPath = 'C:\SarMoa';
			Type            = 'Directory';
		}
        xSmbShare 'SarMoa$' {

            Name         = 'SarMoa$';
            Path         = 'C:\SarMoa';
            ChangeAccess = 'samira\SarMoa';
            DependsOn    = '[File]SarMoa';
            Ensure       = 'Present';
        }
        File 'LubBet' {

			DestinationPath = 'C:\LubBet';
			Type            = 'Directory';
		}
        xSmbShare 'LubBet$' {

            Name         = 'LubBet$';
            Path         = 'C:\LubBet';
            ChangeAccess = 'samira\LubBet';
            DependsOn    = '[File]LubBet';
            Ensure       = 'Present';
        }
        File 'GayKri' {

			DestinationPath = 'C:\GayKri';
			Type            = 'Directory';
		}
        xSmbShare 'GayKri$' {

            Name         = 'GayKri$';
            Path         = 'C:\GayKri';
            ChangeAccess = 'samira\GayKri';
            DependsOn    = '[File]GayKri';
            Ensure       = 'Present';
        }
        File 'AliLun' {

			DestinationPath = 'C:\AliLun';
			Type            = 'Directory';
		}
        xSmbShare 'AliLun$' {

            Name         = 'AliLun$';
            Path         = 'C:\AliLun';
            ChangeAccess = 'samira\AliLun';
            DependsOn    = '[File]AliLun';
            Ensure       = 'Present';
        }
        File 'DanMaz' {

			DestinationPath = 'C:\DanMaz';
			Type            = 'Directory';
		}
        xSmbShare 'DanMaz$' {

            Name         = 'DanMaz$';
            Path         = 'C:\DanMaz';
            ChangeAccess = 'samira\DanMaz';
            DependsOn    = '[File]DanMaz';
            Ensure       = 'Present';
        }
        File 'TonPal' {

			DestinationPath = 'C:\TonPal';
			Type            = 'Directory';
		}
        xSmbShare 'TonPal$' {

            Name         = 'TonPal$';
            Path         = 'C:\TonPal';
            ChangeAccess = 'samira\TonPal';
            DependsOn    = '[File]TonPal';
            Ensure       = 'Present';
        }
        File 'EriGon' {

			DestinationPath = 'C:\EriGon';
			Type            = 'Directory';
		}
        xSmbShare 'EriGon$' {

            Name         = 'EriGon$';
            Path         = 'C:\EriGon';
            ChangeAccess = 'samira\EriGon';
            DependsOn    = '[File]EriGon';
            Ensure       = 'Present';
        }
        File 'JacBri' {

			DestinationPath = 'C:\JacBri';
			Type            = 'Directory';
		}
        xSmbShare 'JacBri$' {

            Name         = 'JacBri$';
            Path         = 'C:\JacBri';
            ChangeAccess = 'samira\JacBri';
            DependsOn    = '[File]JacBri';
            Ensure       = 'Present';
        }
        File 'KriMaz' {

			DestinationPath = 'C:\KriMaz';
			Type            = 'Directory';
		}
        xSmbShare 'KriMaz$' {

            Name         = 'KriMaz$';
            Path         = 'C:\KriMaz';
            ChangeAccess = 'samira\KriMaz';
            DependsOn    = '[File]KriMaz';
            Ensure       = 'Present';
        }
        File 'SasJen' {

			DestinationPath = 'C:\SasJen';
			Type            = 'Directory';
		}
        xSmbShare 'SasJen$' {

            Name         = 'SasJen$';
            Path         = 'C:\SasJen';
            ChangeAccess = 'samira\SasJen';
            DependsOn    = '[File]SasJen';
            Ensure       = 'Present';
        }
        File 'MorMaz' {

			DestinationPath = 'C:\MorMaz';
			Type            = 'Directory';
		}
        xSmbShare 'MorMaz$' {

            Name         = 'MorMaz$';
            Path         = 'C:\MorMaz';
            ChangeAccess = 'samira\MorMaz';
            DependsOn    = '[File]MorMaz';
            Ensure       = 'Present';
        }
        File 'PelRos' {

			DestinationPath = 'C:\PelRos';
			Type            = 'Directory';
		}
        xSmbShare 'PelRos$' {

            Name         = 'PelRos$';
            Path         = 'C:\PelRos';
            ChangeAccess = 'samira\PelRos';
            DependsOn    = '[File]PelRos';
            Ensure       = 'Present';
        }
        File 'EliJah' {

			DestinationPath = 'C:\EliJah';
			Type            = 'Directory';
		}
        xSmbShare 'EliJah$' {

            Name         = 'EliJah$';
            Path         = 'C:\EliJah';
            ChangeAccess = 'samira\EliJah';
            DependsOn    = '[File]EliJah';
            Ensure       = 'Present';
        }

		#create file shares
	}
} #end
