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
# Read and use the content of an INI file
- name: read and save in variable content of given INI file
  redhat_cop.fedora_desktop.configreader:
    path: ~/.mozilla/firefox/profiles.ini
  register: __firefox_profiles

- name: output content of Firefox INI file
  debug:
    var: __firefox_profiles.content
'''

RETURN = r'''
# These are examples of possible return values, and in general should use other names for return values.
path:
    description: the full path to the INI file read.
    type: str
    returned: always
    sample: '/home/jsmith/.config/myconf.ini'
exists:
    description: tells if the INI file exists or not
    type: bool
    returned: always
    sample: True
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

    # create an AnsibleModule object
    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=True
    )

    # prepare the result with sensible values
    result = dict(
        changed=False,
        path='',
        content={},
        exists=True,
    )

    # get the canonical and absolute form of the path and check existence
    result['path'] = os.path.realpath(os.path.abspath(
        os.path.expanduser(module.params['path'])
    ))
    if not os.path.exists(result['path']):
        result['exists'] = False
        if module.params['fail_if_missing']:
            module.fail_json(
                msg="INI file '{}' doesn't exist".format(result['path']),
                **result,
            )
        else:  # we can't do no more, we return an empty dict as content
            module.exit_json(**result)

    # if the file exists, try to read it. If not possible, just fail
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
    # note that we ignore hence any DEFAULT section
    for section in config.sections():
        result['content'][section] = dict(config[section])

    # return finally the result
    module.exit_json(**result)


def main():
    run_module()


if __name__ == '__main__':
    main()
