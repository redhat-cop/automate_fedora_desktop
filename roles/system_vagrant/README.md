system\_vagrant
==============

Configures vagrant on Fedora so that custom plugins can be installed, and optionally non-root can use it without password entry.
Experience shows that you shouldn't mix packaged and non-packaged Vagrant plugins, hence you need to remove all packaged ones, and install them as user with `vagrant plugin install`.

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
         - role: redhat_cop.fedora_desktop.system_vagrant
           system_vagrant_block_plugins: true

License
-------

MIT

Author Information
------------------

Eric Lavarde, Automation Principal Architect at Red Hat Consulting,
with the Automation Community of Practice (CoP) from Red Hat
