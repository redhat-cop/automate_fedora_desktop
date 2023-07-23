#!/bin/sh
# Create the desktop using the corresponding playbook

FEDORA_COLLECTION=redhat_cop.automate_fedora_desktop
INVENTORY=$(dirname $(dirname "${0}"))/inventory.myown.d
VERBOSE=

function usage() {
	local exit_code=${1:-0}
	echo "Usage: $0 [-h] <one or more hosts>"
	echo "       -h - output usage and exit"
	echo "       -v - verbose"
	echo "       one or more hosts separated by commas, without blanks"
	exit ${exit_code}
}

# parse the parameters

while getopts hdiv opt
do
	case "${opt}" in
	h)
		usage 0
		;;
	v)
		VERBOSE=-v
		;;
	?)
		echo "Unknown option" >&2
		usage 1
		;;
	esac
done

shift $((OPTIND - 1))

if [[ -z "$*" ]]
then
	echo "No host given" >&2
	usage 1
fi

# call the playbook with the previously created inventory
ansible-playbook -i "${INVENTORY}" ${VERBOSE} \
	${FEDORA_COLLECTION}.desktop_create \
	-e ansible_host=localhost --connection local \
	--limit "${*}"
