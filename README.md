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
