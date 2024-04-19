system\_tuxedo
=============

Installs software and drivers provided by Tuxedo Computers for their hardware.

[Tuxedo computers](https://tuxedocomputers.com) are a small German company offering computers cut for Linux.
This role is based on the instructions provided to [add package sources](https://www.tuxedocomputers.com/en/Infos/Help-and-Support/Instructions/Add-TUXEDO-Computers-software-package-sources.tuxedo).
The source code for the packages is available on [GitLab](https://gitlab.com/tuxedocomputers/development).

Requirements
------------

A computer, mostly laptop, from Tuxedo Computers obviously.

Role Variables
--------------

cf. [defaults/main.yml](defaults/main.yml) for all details.

Dependencies
------------

n/a

Example Playbook
----------------


    - hosts: localhost
      become: true
      roles:
         - role: redhat_cop.fedora_desktop.system_tuxedo
           system_tuxedo_state: present

License
-------

MIT

Author Information
------------------

Eric Lavarde, Automation Principal Architect at Red Hat Consulting,
with the Automation Community of Practice (CoP) from Red Hat
