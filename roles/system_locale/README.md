system\_locale
=============

Set the extended locales for keymap and keep only useful dictionaries.

Requirements
------------

The `localectl` utility is required but that should be a given on Fedora.

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
         - role: redhat_cop.fedora_desktop.system_locale
           system_locale_keep_dicts_langs: [en_US, en_UK]

License
-------

MIT

Author Information
------------------

Eric Lavarde, Automation Principal Architect at Red Hat Consulting,
with the Automation Community of Practice (CoP) from Red Hat
