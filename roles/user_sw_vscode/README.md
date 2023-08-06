user\_sw\_vscode
==============

A brief description of the role goes here.

Requirements
------------

Microsoft VS Code has been installed previously, e.g. with the `system_sw_vscode` role from the same collection.

Role Variables
--------------

cf. [defaults/main.yml](defaults/main.yml) for all details.

Dependencies
------------

None.

Example Playbook
----------------

You could install VS Code as root, and add extensions to it as normal user:

    - hosts: fedoras
      become: true
      roles:
        - role: redhat_cop.fedora_desktop.system_sw_vscode
    - hosts: fedoras
      become: false
      roles:
        - role: redhat_cop.fedora_desktop.user_sw_vscode
          user_sw_vscode_extensions:
            - redhat.ansible
            - vscodevim.vim

License
-------

MIT

Author Information
------------------

Eric Lavarde, Automation Principal Architect at Red Hat Consulting,
with the Automation Community of Practice (CoP) from Red Hat
