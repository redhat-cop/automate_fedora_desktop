#!/bin/bash
# a helper script to call an individual role on the default inventory

FEDORA_COLLECTION=redhat_cop.fedora_desktop
INVENTORY=$(dirname $(dirname "${0}"))/inventory.myown.d
VERBOSE=--one-line
VAULT=

function usage() {
	local exit_code=${1:-0}
	echo "Usage: $0 [-h] [-v] [-a] <one or more role(s)>"
	echo "       -h - output usage and exit"
	echo "       -v - verbose"
	echo "       -a - ask for vault password for encrypted variables"
	echo "       one or more roles to call on the default inventory"
	exit ${exit_code}
}

# parse the parameters

while getopts hva opt
do
	case "${opt}" in
	h)
		usage 0
		;;
	v)
		VERBOSE=--verbose
		;;
	a)
		VAULT=--ask-vault-password
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
	echo "No role given" >&2
	usage 1
fi

# call the role(s) from the command line
for role in "$@"
do
	if [[ ${role} != user_* ]]
	then  # the role might need root access
		sudo -v  # to be sure to have an actual token
	fi
	ansible --inventory "${INVENTORY}" ${VERBOSE} ${VAULT} \
		-m include_role -a name=${FEDORA_COLLECTION}.${role} \
		--connection local "$(hostname)"
done
