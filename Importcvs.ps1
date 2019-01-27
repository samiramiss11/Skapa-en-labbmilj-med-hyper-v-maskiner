
$users = Import-Csv -Path ".\users.csv"

ForEach ($user in $users) {
$fn = $user.FirstName.SubString(0,3)
$ln = $user.LastName.SubString(0,3)
$un = "$fn$ln";

$str = @"
            xADUser $un {
            DomainName  = `$node.DomainName;
            UserName    = '$un';
            Description = 'Lability Test Lab user';
            Password    = `$Credential;
            Ensure      = 'Present';
            DependsOn   = '[xADDomain]ADDomain';
        }
"@

echo $str >> ".\conf.txt"

$str2 = @"
        File '$un' {
			DestinationPath = 'C:\$un';
			Type            = 'Directory';
		}
        xSmbShare '$un`$' {
            Name         = '$un`$';
            Path         = 'C:\$un';
            ChangeAccess = 'samira\$un';
            DependsOn    = '[File]$un';
            Ensure       = 'Present';
        }
"@
echo $str2 >> ".\conf2.txt"
}
