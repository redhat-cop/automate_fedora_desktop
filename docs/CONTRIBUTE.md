# Contributor guide

- be nice
- be reasonable
- create a pull request (PR) to contribute
- use [Conventional Commits](https://www.conventionalcommits.org/) to help with the changelog and versioning
- follow the [Good Practices for Ansible](https://redhat-cop.github.io/automation-good-practices/) and use ansible-lint before submitting PRs.
- a few additional rules apply:
   - `system_...` roles configure the whole system and need root rights
   - `user_...` roles configure an individual user's environment and do _not_ need root rights
   - `system_sw_...` and `user_sw_...` are reserved for the installation resp. configuration of software not packaged in Fedora.
It would be better to package them, but redistribution isn't always possible and a role is often more quickly written.
They both comply to the system/user rules.
   - roles do _nothing_ by default unless duly configured in the inventory.
   - tasks needing root rights are explicitly using `become: true` (i.e. using `-b` resp. `--become` is _not_ necessary).
