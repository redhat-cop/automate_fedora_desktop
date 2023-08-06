user\_desktop
============

Configure your favourite desktop environment

Requirements
------------

Gnome and Xfce are supported for now (which might not be your favourite desktop)

Role Variables
--------------

cf. [defaults/main.yml](defaults/main.yml) for all details.

Dependencies
------------

None

Example Playbook
----------------

    - hosts: fedoras
      roles:
         - role: redhat_cop.fedora_desktop.user_desktop
           user_desktop_name: xfce

License
-------

MIT

Author Information
------------------

Eric Lavarde, Automation Principal Architect at Red Hat Consulting,
with the Automation Community of Practice (CoP) from Red Hat
