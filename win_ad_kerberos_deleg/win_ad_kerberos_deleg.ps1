#!powershell
# (c) 2017, David Baumann <me@davidbaumann.at>
# GNU GENERAL PUBLIC LICENSE v3
#
# WANT_JSON
# POWERSHELL_COMMON

Set-StrictMode -Version 2;
$ErrorActionPreference = "Stop";

########################################################################################################################


# Setting and Reading Params from Ansible
$parsed_args = Parse-Args $args -supports_check_mode $true;
$check_mode = Get-AnsibleParam $parsed_args "_ansible_check_mode" -default $false;

$changed = $false;

$Attrib = @{
    computer = Get-AnsibleParam $parsed_args "computer"
    trust_kerb_only = Get-AnsibleParam $parsed_args "trust_kerb_only" $false
    spnlist = Get-AnsibleParam $parsed_args "spnlist" -default []
}

$spnlist_desired = $Attrib.spnlist
$comp = $Attrib.computer;
$delegationProperty = 'msDS-AllowedToDelegateTo'

# Processing Computer Account Delegation 
If($comp)
{

    if( (Get-ADComputer $comp -Properties msDS-AllowedToDelegateTo)[$delegationProperty])
    {
        # SPN Defined
        # Returns a string[]
        $spnlist_ad = Get-ADComputer $comp -Properties $delegationProperty | Select-Object -ExpandProperty $delegationProperty
        if( Compare-Object $spnlist_ad $spnlist_desired)
        {
            if(-not $check_mode){
                try{
                    if($spnlist_desired.length)
                    {
                        # We got a new list
                        Get-ADComputer $comp | Set-ADObject -Replace @{$delegationProperty=$spnlist_desired};
                        Get-AdComputer $comp | Set-ADAccountControl -TrustedToAuthForDelegation $true;
                    }else{
                        # We got an Empty spnlist_desired, so we need to remove all delegation
                        Get-ADComputer $comp | Set-ADObject -clear $delegationProperty;
                        Get-AdComputer $comp | Set-ADAccountControl -TrustedToAuthForDelegation $false;
                    }
                }catch{
                    Fail-Json $_.Exception.Message
                }
            }
            $changed = $true;
        }
    }else{
        # No Delegation Defined
        if($Attrib.spnlist.length)
        {
            # We need to define a Delegation
            if(-not $check_mode){
                try{
                    Get-ADComputer $comp | Set-ADObject -Add @{$delegationProperty=$spnlist_desired};
                    Get-AdComputer $comp | Set-ADAccountControl -TrustedToAuthForDelegation $true;
                }catch{
                    Fail-Json $_.Exception.Message
                }
            }
            $changed = $true
        }
    }
}

# Generate Return Object
$result = @{
    changed = $changed
}

Exit-Json -obj $result;
