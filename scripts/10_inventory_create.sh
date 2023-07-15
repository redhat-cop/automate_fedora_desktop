#!/bin/sh
# Script to install the pre-requisites required on the control host
# Make sure you have sudo rights, avoid calling directly as root!

# the RPMs we want to install
RPMS=(ansible-core git pykickstart curl mediawriter)
FEDORA_COLLECTION=redhat_cop.automate_fedora_desktop
DEVELOPER_MODE=
INTERACTIVE=
VERBOSE=

function usage() {
	local exit_code=${1:-0}
	echo "Usage: $0 [-h] <one or more hosts>"
	echo "       -h - output usage and exit"
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

# call the playbook with the host(s) as minimal inventory but run on localhost
ansible-playbook -i "$*," \
	redhat_cop.automate_fedora_desktop.control_prepare.yml \
	-e ansible_host=localhost
