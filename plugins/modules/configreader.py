#!/usr/bin/python

# Copyright: (c) 2024, Eric Lavarde <elavarde@redhat.com>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)
from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

DOCUMENTATION = r'''
---
module: configreader

short_description: read the content of an INI file

# If this is part of a collection, you need to use semantic versioning,
# i.e. the version is of the form "2.5.0" and not "2.4".
version_added: "1.0.0"

description: read and parse the content of an INI file into an object

options:
    path:
        description: this is the full path to the INI file to read
        required: true
        type: str
    fail_if_missing:
        description:
            - Fails if the given INI file is missing.
            - Else just returns an empty dictionary as content result.
        required: false
        default: true
        type: bool
# Specify this value according to your collection
# in format of namespace.collection.doc_fragment_name
# extends_documentation_fragment:
#     - my_namespace.my_collection.my_doc_fragment_name

author:
    - Eric Lavarde (@ericzolf)
'''

EXAMPLES = r'''
# Pass in a message
- name: Test with a message
  my_namespace.my_collection.my_test:
    name: hello world

# pass in a message and have changed true
- name: Test with a message and changed output
  my_namespace.my_collection.my_test:
    name: hello world
    new: true

# fail the module
- name: Test failure of the module
  my_namespace.my_collection.my_test:
    name: fail me
'''

RETURN = r'''
# These are examples of possible return values, and in general should use other names for return values.
path:
    description: the full path to the INI file read.
    type: str
    returned: always
    sample: '/home/jsmith/.config/myconf.ini'
content:
    description: The content of the ini file as dictionary
    type: dict
    returned: always
    sample: #TODO#
'''

import configparser
import os
from ansible.module_utils.basic import AnsibleModule


def run_module():
    # define available arguments/parameters a user can pass to the module
    module_args = dict(
        path=dict(type='str', required=True),
        fail_if_missing=dict(type='bool', required=False, default=True),
    )

    # seed the result dict in the object
    # we primarily care about changed and state
    # changed is if this module effectively modified the target
    # state will include any data that you want your module to pass back
    # for consumption, for example, in a subsequent task
    result = dict(
        changed=False,
        path='',
        content={},
    )

    # the AnsibleModule object will be our abstraction working with Ansible
    # this includes instantiation, a couple of common attr would be the
    # args/params passed to the execution, as well as if the module
    # supports check mode
    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=True
    )

    # manipulate or modify the state as needed (this is going to be the
    # part where your module will do what it needs to do)
    result['path'] = os.path.abspath(module.params['path'])
    if not os.path.exists(result['path']):
        if module.params['fail_if_missing']:
            module.fail_json(
                msg="INI file '{}' doesn't exist".format(result['path']),
                **result,
            )
        else:  # we can't do no more
            module.exit_json(**result)

    config = configparser.ConfigParser()
    try:
        config.read(result['path'])
    except configparser.Error as exc:
        module.fail_json(
            msg=(
                "Something wrong with the INI file '{}' "
                "because of '{}'".format(result['path'], exc)
            ),
            **result,
        )

    # we read the config file content as dict of dicts
    for section in config.sections():
        result['content'][section] = dict(config[section])

    # in the event of a successful module execution, you will want to
    # simple AnsibleModule.exit_json(), passing the key/value results
    module.exit_json(**result)


def main():
    run_module()


if __name__ == '__main__':
    main()
