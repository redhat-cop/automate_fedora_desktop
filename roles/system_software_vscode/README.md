system\_software\_vscode
======================

Setup the repository and install Microsoft VisualStudio Code on Fedora.

Requirements
------------

None.

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
        - role: redhat_cop.fedora_desktop.system_software_vscode
    - hosts: fedoras
      become: false
      roles:
        - role: redhat_cop.fedora_desktop.user_software_vscode
          software_vscode_extensions:
            - redhat.ansible
            - vscodevim.vim

License
-------

MIT

Author Information
------------------

Eric Lavarde, Automation Principal Architect at Red Hat Consulting,
with the Automation Community of Practice (CoP) from Red Hat
