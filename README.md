# Ansible Collection - redhat\_cop.automate\_fedora\_desktop

## Introduction

This collection offers a set of roles and other utilities to build and configure a Fedora Desktop in a fully automated and repeatable manner.

Even though the automation is mainly based on Ansible and is packaged as an Ansible collection, certain elements are not related to Ansible (mainly the scripts) to simplify the bootstrap if you don't have Ansible yet installed.

This documentation uses the following terminology:

1. the "control host" is a "RHEL-ish" Linux machine (Fedora, CentOS, ...) on which you'll prepare the configuration for the Fedora Desktop, and use Ansible to start the deployment.
1. the "desktop", even if it might be a laptop or any other form factor, even a VM, is the machine you are planning to install Fedora onto.
1. the "webserver" is a web server, which one doesn't matter, from which you'll serve the kickstart file necessary to steer the installation.
The control host can be used as webserver.

## Installation on the control host

1. get the collection on your control host, either using Git or ansible-galaxy, and change to the corresponding directory:

```
# using Git with SSH key (requires a GitHub account)
git clone git@github.com:redhat-cop/automate_fedora_desktop.git
cd automate_fedora_desktop

# using Git with HTTPS (without GitHub account necessary)
git clone https://github.com/redhat-cop/automate_fedora_desktop.git
cd automate_fedora_desktop

# or using ansible-galaxy (once this collection has been released)
ansible-galaxy collection install redhat_cop.automate_fedora_desktop
cd ~/.ansible/collections/ansible_collections/redhat_cop/automate_fedora_desktop/
```

2. Call `./scripts/00_control_bootstrap.sh` to install the necessary pre-requisites on the control node.
You will need sudo rights to install Ansible and a few other dependencies.
The `-h` option gives you a short usage help.
The developer mode only makes sense if you've downloaded this collection using Git, and plan to modify it.

3. Call `./scripts/10_inventory_create.sh <desktop-name>` to create a basic inventory for the desktop.
The `-h` option gives you a short usage help.
In the Ansible world, an inventory is a set of hosts and their variables.
Go through the variable files created under `./inventory.myown.d/host_vars/<desktop-name>` and adapt them to your needs.
Each file should have a set of YAML variables sufficiently explained, but in doubt you can check the file `roles/<role-name>/README.md` where role-name is the same as the file's name in the inventory.

4. Download the (latest) [Fedora Server Network Install ISO](https://fedoraproject.org/server/download/) image, and verify it according to the instructions on the web page!
Then copy the ISO image to the _correct_ USB stick (pay attention to the correct **X** according to `lsblk`! See [preparation details](https://docs.fedoraproject.org/en-US/fedora-server/installation/#_preparations)) with `sudo dd if=Fedora-Server-netinst-x86_64-38-1.6.iso of=/dev/sdX bs=8M status=progress`.

5. Call `./scripts/20_desktop_create.sh -so <desktop-name>` to create the desktop.
The `-h` option gives you a short usage help.
In the current state of the implementation, only a [kickstart file](https://docs.fedoraproject.org/en-US/fedora/f36/install-guide/appendixes/Kickstart_Syntax_Reference/) is created and served via a simple but insecure approach.
Perhaps we can do more in the future, but for now the control host acts as webserver.
The playbook will hang for one hour, giving you ample time to install your new desktop.
You can kill the playbook but beware that the HTTP server will continue to run and needs to be killed if you want to restart the playbook with the same port.

6. From now on, be VERY CAREFUL: the new desktop will be completely **WIPED**.
   Boot the new desktop from the previously created USB stick (how depends on its make), then
    a. Select the first line of the menu (Start Fedora...) with the up/down keys and press 'e' for Edit.
    b. Edit the 'linuxefi' line: `linuxefi inst.stage2=hd:LABEL=Fedora-S-dvd-x86_64-38 inst.ks=http://my.own.web.server/myhost.ks` (basically replace `quiet` with `inst.ks=...`).
Check https://docs.fedoraproject.org/en-US/fedora/rawhide/install-guide/advanced/Boot_Options/[more boot options].
    c. Press Ctrl-x to start
    d. Wait until the laptop is installed and rebooted.
You can login as local admin and continue with the configuration, SSHD runs and Ansible is installed.
If defined so, this Git repo is already available in `/var/tmp/automate_fedora_desktop` to continue.
