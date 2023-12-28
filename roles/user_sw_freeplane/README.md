user\_sw\_freeplane
=================

Install [Freeplane](https://freeplane.org/) mind-mapping tool for one specific user

Requirements
------------

Java needs to be pre-installed, potentially using the role `redhat_cop.fedora_desktop.system_sw_freeplane` in the same collection.

Role Variables
--------------

cf. [defaults/main.yml](defaults/main.yml) for all details.

Dependencies
------------

n/a

Example Playbook
----------------

    - hosts: fedoras
      roles:
         - role: redhat_cop.fedora_desktop.user_sw_freeplane
           sw_freeplane_version: "1.11.6"

License
-------

MIT

Author Information
------------------

Eric Lavarde, Automation Principal Architect at Red Hat Consulting,
with the Automation Community of Practice (CoP) from Red Hat
