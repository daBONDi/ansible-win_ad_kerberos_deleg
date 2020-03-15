# ansible-win_ad_kerberos_deleg

Ansible Module for managing Kerberos Delegation in a Windows Active Directory Environment

## Installation

Copy the win_ad_kerberos_deleg into you libary folder

## Example

```yaml
- win_ad_kerberos_deleg:
    computer: "mycomputer"
    spnlist:
      - "http/www.mysite.com"
      - "host/mycomputer"
```

> Maybe check also my other Module to set the TrustedToAuthForDelegation for the AD Object [https://github.com/daBONDi/ansible-win_ad_kerberos_trust_delegation](https://github.com/daBONDi/ansible-win_ad_kerberos_trust_delegation)
