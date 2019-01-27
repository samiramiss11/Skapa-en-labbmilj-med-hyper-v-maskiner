<# Create an environment consisting of:
- 2pcs Windows 2019 server in the domain controller role.
- 2pcs Windows 2016 servers in the role of member servers.
Create 20 users, use eg. "test data creates the page" http://www.databasetestdata.com/, to create basic data.

Create users with the name standard, three first letters from the first name and then the first three letters of the last name.
Create file sharing areas (Shares folders) on all servers:
- Common
- Resources
- Private for each user

All users should have access to Common and resources .
Private should be created as hidden with username as "Share folder name".
IP, network etc. are created based on own discretion.#>

#region USER INPUT #
Write-Host "Enter VM admin credentials"
$credentials = Get-Credential
#endregion

#region HOST/VM-NAMES #
#$VMS = @("Lab-DC01", "Lab-DC02", "Lab-SRV01", "Lab-SRV02")
$VMs = [ordered]@{
    "Lab-DC01"  = "10.0.0.10"
    "Lab-DC02"  = "10.0.0.11"
    "Lab-SRV01" = "10.0.0.12"
    "Lab-SRV02" = "10.0.0.13"
}
#endregion

#region LOCATIONS #
$root_path = "E:\Hyper-V\VMLAB\"
$template_vhd = "E:\Hyper-V\VMLAB\LAB-TEMPLATE\Virtual Hard Disks\LAB-TEMPLATE.vhdx"
#endregion

#region VM CONFIG VARIABLES #
$gen = 2
$memory = 4GB
$vm_switch = "Lab-Switch"
#endregion

foreach ($vm in $VMS.Keys) {
    $vm_path = $root_path + $vm
    $vhd_path = $vm_path + "\Virtual Hard Disks\"
    $vhd_file = $vm + ".vhdx"
    #region COPY TEMPLATE VHDX and CREATE PATH
    New-Item -ItemType Directory -Force -Path $vhd_path
    Copy-Item "$template_vhd" -Destination "$vhd_path$vhd_file"
    #endregion
   
    New-VM -Name $vm -Path $root_path -MemoryStartupBytes $memory -VHDPath $vhd_path$vhd_file -Generation $gen -SwitchName $vm_switch
}

<# foreach ($vm in $VMS.Keys) {
    $ip = $VMS.Item($vm)
    Invoke-Command -ComputerName $vm -ScriptBlock { 
        New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress $Using:ip -AddressFamily "IPv4" -DefaultGateway $Using:gw -PrefixLength 24 -WhatIf
    } -credential $credentials
} #>


<#
cmd's visual studio code
* formatera kod = shift + alt  f
* kopiera en rad = Shift + ALT NER
* multi-line editing = CTRL + ALT UPP/NER. ESC två gånger = CANCEL
* block comment = markera skit och shift + alt  a
    samma för att avkommentera
#>

#region IP ADDRESSES 
#$ip1 = "10.0.0.10"
#$ip2 = "10.0.0.11"
#$ip3 = "10.0.0.12"
#$ip4 = "10.0.0.13"
#$gw = "10.0.0.1"
#$subnet = "255.255.255.0"
#$dns1 = "10.0.0.1" #temp
#$dns2 = "172.29.90.11"
#endregion 

<#
IPAddress         : 172.29.90.150
InterfaceIndex    : 6
InterfaceAlias    : Ethernet
AddressFamily     : IPv4
Type              : Unicast
PrefixLength      : 28
PrefixOrigin      : Dhcp
SuffixOrigin      : Dhcp
AddressState      : Preferred
ValidLifetime     : 23:59:11
PreferredLifetime : 23:59:11
SkipAsSource      : False
PolicyStore       : ActiveStore
#>
