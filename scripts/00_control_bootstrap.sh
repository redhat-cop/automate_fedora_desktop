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
	echo "Usage: $0 [-h][-d][-i][-v]"
	echo "       -h - output usage and exit"
	echo "       -d - developer mode, link current Git repo to collection"
	echo "       -i - interactive mode, where applicable"
	echo "       -v - verbose mode"
	exit ${exit_code}
}

# parse the parameters

while getopts hdiv opt
do
	case "${opt}" in
	h)
		usage 0
		;;
	d)
		DEVELOPER_MODE=1
		;;
	i)
		INTERACTIVE=1
		;;
	v)
		VERBOSE=--verbose
		;;
	?)
		usage 1
		;;
	esac
done

# Install the necessary packages

if rpm -q "${RPMS[@]}" | grep -q ' is not installed$'
then
	# this needs to run as root to bootstrap Ansible
	if [[ ${INTERACTIVE} ]]
	then
		sudo dnf ${VERBOSE} install "${RPMS[@]}"
	else
		sudo dnf --assumeyes ${VERBOSE} install "${RPMS[@]}"
	fi
else
	[[ ${VERBOSE} ]] && echo "Packages '${RPMS[*]}' already installed"
fi

# make sure the collection can be used also as collection by installing it,
# or symlinking it (in developer mode)

COLLECTION_DIR=~/.ansible/collections/ansible_collections/$(echo ${FEDORA_COLLECTION} | tr '.' '/')

if [[ ! -d "${COLLECTION_DIR}" ]]
then
	if [[ ${DEVELOPER_MODE} ]]
	then
		mkdir --parents ${VERBOSE} $(dirname "${COLLECTION_DIR}")
		SOURCE_DIR=$(dirname $(dirname $(realpath "$0")))
		ln --symbolic ${VERBOSE} "${SOURCE_DIR}/" "${COLLECTION_DIR}"
	else
		ansible-galaxy collection install --upgrade ${FEDORA_COLLECTION}
	fi
else
	[[ ${VERBOSE} ]] && echo "Collection '${FEDORA_COLLECTION}' already installed"
fi
