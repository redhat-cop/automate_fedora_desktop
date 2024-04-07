user\_firefox
============

Configure Firefox for a specific user through the user.js in its profile

Requirements
------------

Firefox has already been started at least once and the profile(s) do(es) exist.

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
         - role: redhat_cop.fedora_desktop.user_firefox
           user_firefox_user_prefs:
             - key: browser.download.lastDir.savePerSite
               value: true
             - key: signon.rememberSignons
               state: absent

License
-------

MIT

Author Information
------------------

Eric Lavarde, Automation Principal Architect at Red Hat Consulting,
with the Automation Community of Practice (CoP) from Red Hat
