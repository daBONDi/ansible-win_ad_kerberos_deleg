# win_ad_kerberos_deleg

Module for managing Kerberos Delegation in a Windows Active Directory Environment

Check Github Repository https://github.com/daBONDi/ansible-win_ad_kerberos_deleg for updates

## Example
```yaml
- win_ad_kerberos_deleg:
    computer: "mycomputer"
    spnlist:
      - "http/www.mysite.com"
      - "host/mycomputer"
```