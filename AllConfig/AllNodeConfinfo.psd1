
@{
    AllNodes = @(
        @{
            NodeName                    = '*';
            InterfaceAlias              = 'Ethernet';
            DefaultGateway              = '10.11.12.1';
            PrefixLength                = 24;
            AddressFamily               = 'IPv4';
            DnsServerAddress            = '10.11.12.1';
            DomainName                  = 'samira.local';
            PSDscAllowPlainTextPassword = $true;
            #CertificateFile             = "$env:AllUsersProfile\Labs\Certificates\LabClient.cer";
            #Thumbprint                  = 'AAC41ECDDB3B582B133527E4DE0D2F8FEB17AAB2';
            PSDscAllowDomainUser        = $true; # Removes 'It is not recommended to use domain credential for node X' messages
            Labs_SwitchName         = 'Corpnet';
            Labs_ProcessorCount     = 1;
            Labs_StartupMemory      = 2GB;
            Labs_Media              = '2012R2_x64_Datacenter_EN_V5_1_Eval';
        }
        @{
            NodeName                = 'DC1';
            IPAddress               = '10.11.12.44';
            DnsServerAddress        = '127.0.0.1';
            Role                    = 'DC';
            Labs_ProcessorCount = 1;
        }
		@{
            NodeName                = 'DC2';
            IPAddress               = '10.11.12.45';
            DnsServerAddress        = '127.0.0.1';
            Role                    = 'DC';
            Labs_ProcessorCount = 1;
        }
		@{
            NodeName  = 'SERV1';
            IPAddress = '10.11.12.46';
            Role      = 'APP';
			Labs_ProcessorCount = 1;
        }
		@{
            NodeName  = 'SERV2';
            IPAddress = '10.11.12.47';
            Role      = 'APP';
			Labs_ProcessorCount = 1;
        }
    );
    NonNodeData = @{
        Labs = @{
            EnvironmentPrefix = 'TLG-';
            Media = @();
            Network = @(
                @{ Name = 'Corpnet'; Type = 'Internal'; }
                @{ Name = 'Internet'; Type = 'Internal'; }
                # @{ Name = 'Corpnet'; Type = 'External'; NetAdapterName = 'Ethernet'; AllowManagementOS = $true; }
                <#
                    IPAddress: The desired IP address.
                    InterfaceAlias: Alias of the network interface for which the IP address should be set. <- Use NetAdapterName
                    DefaultGateway: Specifies the IP address of the default gateway for the host. <- Not needed for internal switch
                    Subnet: Local subnet CIDR (used for cloud routing).
                    AddressFamily: IP address family: { IPv4 | IPv6 }
                #>
            );

            <#
                If you are generating the .mof files on the host and/or you want Labilty to use the DSC
                resource versions/modules installed on the physical host, you should remove the 'DSCResource' key.
                Labs will then "just" copy all local DSC resources.
            #>
            DSCResource = @(
                ## Download published version from the PowerShell Gallery
                @{ Name = 'xComputerManagement'; RequiredVersion = '1.9.0.0'; Provider = 'PSGallery'; }
                ## If not specified, the provider defaults to the PSGallery.
                @{ Name = 'xSmbShare'; RequiredVersion = '2.0.0.0'; }
                @{ Name = 'xNetworking'; RequiredVersion = '3.2.0.0'; }
                @{ Name = 'xActiveDirectory'; RequiredVersion = '2.16.0.0'; }
                @{ Name = 'xDnsServer'; RequiredVersion = '1.7.0.0'; }
                @{ Name = 'xDhcpServer'; RequiredVersion = '1.5.0.0'; }
                ## The 'GitHub# provider can download modules directly from a GitHub repository, for example:
                ## @{ Name = 'Labs'; Provider = 'GitHub'; Owner = 'VirtualEngine'; Repository = 'Labs'; Branch = 'dev'; }
            );
        };
    };
};
