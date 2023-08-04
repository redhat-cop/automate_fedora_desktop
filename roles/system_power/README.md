system\_power
============

Setup power saving on Fedora desktops.

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

    - hosts: fedoras
      roles:
         - role: redhat_cop.fedora_desktop.system_power
           system_power_calibrate: true

License
-------

MIT

Author Information
------------------

Eric Lavarde, Automation Principal Architect at Red Hat Consulting,
with the Automation Community of Practice (CoP) from Red Hat
