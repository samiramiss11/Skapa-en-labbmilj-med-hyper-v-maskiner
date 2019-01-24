





New-NATSwitch
{
  [CmdletBinding(
    SupportsShouldProcess = $true)]
  [OutputType([String])]
  Param
  ( 
    [Parameter(Mandatory = $true)]
    [string]$Name,
        
    [Parameter(Mandatory = $false)]
    [string]$IPAddress = '172.16.10.1',
        
    [Parameter(Mandatory = $false)]
    [int]$PrefixLength = 24,
        
    [Parameter(Mandatory = $false)]
    [string]$NATName = 'LabNAT'
  )

  Begin
  {
  }
  Process
  {
        
    New-VMSwitch -SwitchName $Name -SwitchType Internal

    $NetAdapter = Get-NetAdapter -Name "vEthernet ($Name)"
    $InterfaceIndex = $NetAdapter.ifIndex
          
    New-NetIPAddress -IPAddress $IPAddress -PrefixLength $PrefixLength -InterfaceIndex $InterfaceIndex
          
    $ip2 = $IPAddress.Split('.')
    $ip2[-1] = "0/$PrefixLength"
    $InternalIPInterfaceAddressPrefix = $ip2 -join '.'

    New-NetNat -Name $NATName -InternalIPInterfaceAddressPrefix $InternalIPInterfaceAddressPrefix 
                  
  }
  End
  {
  }
}
