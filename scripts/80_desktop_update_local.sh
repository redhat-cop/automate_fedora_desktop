#!/bin/sh
# Create the desktop using the corresponding playbook
# The playbook creates a kickstart file and serves it optionally via HTTP

FEDORA_COLLECTION=redhat_cop.fedora_desktop
INVENTORY=$(dirname $(dirname "${0}"))/inventory.myown.d
VERBOSE=
REFRESH=

function usage() {
	local exit_code=${1:-0}
	echo "Usage: $0 [-h] <one or more hosts>"
	echo "       -h - output usage and exit"
	echo "       -v - verbose"
	echo "       -r - refresh the packages cache"
	echo "       one or more hosts separated by commas, without blanks"
	exit ${exit_code}
}

# parse the parameters

while getopts hvr opt
do
	case "${opt}" in
	h)
		usage 0
		;;
	v)
		VERBOSE=--verbose
		;;
	r)
		REFRESH=--refresh
		;;
	?)
		echo "Unknown option" >&2
		usage 1
		;;
	esac
done

# we call first dnf directly because ansible doesn't like being updated
# while it runs, so we update its package beforehand
sudo dnf update --assumeyes ${REFRESH} \
       	$(rpm -qf $(which ansible-playbook) --queryformat "%{NAME}")

# call the playbook to update the remaining packages, slightly useless
# after we've called dnf but it's more for demonstration purpose
ansible-playbook --inventory "${INVENTORY}" ${VERBOSE} \
	${FEDORA_COLLECTION}.system_update \
	--connection local --limit "$(hostname)"
