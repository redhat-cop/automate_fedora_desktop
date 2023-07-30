inventory\_create
================

A role to create a basic inventory and add one or more hosts to it.
Each host's host\_vars is pre-populated by variable files created out of the `defaults/main.yml` of all roles making out the collection.

Requirements
------------

n/a

Role Variables
--------------

cf. defaults/main.yml

Dependencies
------------

n/a

Example Playbook
----------------

Calling the following playbook with `-i host1,host2,` will create an inventory locally for both hosts listed in the inline inventory:

    - hosts: all
      roles:
         - role: redhat_cop.fedora_desktop.inventory_create,
           ansible_host: localhost

License
-------

BSD

Author Information
------------------

Eric Lavarde, Automation Principal Architect at Red Hat Consulting
