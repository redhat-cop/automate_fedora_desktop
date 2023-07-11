Role Name
=========

A role to keep Fedora up-to-date also across major revisions.

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------

By default, the role only does a `dnf update` and outputs the current version of Fedora.
If the variable `fedora_target_release` is defined (e.g. to 30) then the role will upgrade
the host to this release, assumed the current release `ansible_distribution_major_version`
is defined (generally by gathering facts) and lower than the target revision.

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
