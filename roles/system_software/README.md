system\_software
===============

Install mandatory and optional software under Fedora, enable optionally RPMFusion according to license wishes.

Requirements
------------

Assumes (of course) the presence of dnf.

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
         - { role: redhat_cop.fedora_desktop.system_software,
             system_software_additional: [firefox, ansible, myrepos] }

License
-------

MIT

Author Information
------------------

Eric Lavarde, Automation Principal Architect at Red Hat Consulting,
with the Automation Community of Practice (CoP) from Red Hat
