#!/bin/sh
# Create the desktop using the corresponding playbook
# The playbook creates a kickstart file and serves it optionally via HTTP

FEDORA_COLLECTION=redhat_cop.fedora_desktop
INVENTORY=$(dirname $(dirname "${0}"))/inventory.myown.d
VERBOSE=
SERVE_OPTIONS="--skip-tags kickstart_serve"
OPEN=

function usage() {
	local exit_code=${1:-0}
	echo "Usage: $0 [-h] <one or more hosts>"
	echo "       -h - output usage and exit"
	echo "       -s - serve the created kickstart with a minmal"
	echo "            unsecure web server"
	echo "            Do this ONLY in a SAFE environment!"
	echo "       -o - open the port 8000 (requires root via sudo)"
	echo "       -v - verbose"
	echo "       one or more hosts separated by commas, without blanks"
	exit ${exit_code}
}

# parse the parameters

while getopts hsov opt
do
	case "${opt}" in
	h)
		usage 0
		;;
	s)
		SERVE_OPTIONS="--ask-become-pass"
		;;
	o)
		OPEN="--extra-vars ks_serve_open_port=true"
		echo "You will be asked for your password to become root (sudo)"
		;;
	v)
		VERBOSE=--verbose
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
ansible-playbook --inventory "${INVENTORY}" ${VERBOSE} \
	${FEDORA_COLLECTION}.desktop_create \
	--extra-vars ansible_host=localhost --connection local \
	--limit "${*}" ${SERVE_OPTIONS} ${OPEN}
