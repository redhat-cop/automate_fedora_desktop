kickstart\_serve
===============

Use the Python module http.server to serve the created kickstart files for automated Fedora installation.
Beware that this approach is highly insecure, even though very simple, and probably ok in a safe environment.

Requirements
------------

In order to open the firewall, root access is required.

Role Variables
--------------

cf. [defaults/main.yml](defaults/main.yml) for all details.

Dependencies
------------

The role depends somewhat on the 'kickstart\_create' role, but any directory can actually be served by this role.

Example Playbook
----------------

    - hosts: all
      roles:
         - kickstart_create
         - kickstart_serve

License
-------

MIT

Author Information
------------------

Eric Lavarde, Automation Principal Architect at Red Hat Consulting,
with the Automation Community of Practice (CoP) from Red Hat
