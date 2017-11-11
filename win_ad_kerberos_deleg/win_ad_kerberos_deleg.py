#!/usr/bin/python
# -*- coding: utf-8 -*-

# (c) 2017, David Baumann <me@davidbaumann.at>
# GNU GENERAL PUBLIC LICENSE v3

ANSIBLE_METADATA = {'status': ['preview'],
                    'supported_by': 'core',
                    'version': '1.0'}

DOCUMENTATION = '''
---
module: win_ad_kerberos_deleg
version_added: "2.4"
short_description: Manage Active Directory Kerberos Delegation
description:
     - Manage Kerberos Delegation Settings for Computer or User
requirements:
    - Windows Server 2012 Active Directory with Powershell Management Utiliys or newer
options:
  computer:
    description:
      - Name of the Computer Object to Manage
    required: no

  trust_kerb_only:
    description:
      - yes or now if trust only Kerberos or Trust all Auth Protocols, Usaly you need to Trust all Auth protocols for Web Applications
    required: no
    default: false
    type: bool

  spnlist:
    description:
      - List of SPN Records to the Computer should Delegate
    required: no
    default: []

author: David Baumann(@daBONDi)
'''

EXAMPLES = '''
# Playbook example
# Add Delegation Trust to a Computer Account
---

'''
- win_ad_kerberos_deleg:
    computer: "mycomputer"
    spnlist:
      - "http/www.mysite.com"
      - "host/mycomputer"


RETURN = '''

'''
