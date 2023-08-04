system\_wlan
===========

Configure your Wifi/WLAN using this role.

Requirements
------------

You need to have one and only one Wifi device in your desktop/laptop.
The role supports only the most simple wps-psk, usual at home.

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
         - { role: redhat_cop.fedora_desktop.system_wlan,
             system_wlans_list: { name: MySSID, key: mysecretkey } }

License
-------

MIT

Author Information
------------------

Eric Lavarde, Automation Principal Architect at Red Hat Consulting,
with the Automation Community of Practice (CoP) from Red Hat
