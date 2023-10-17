#!/usr/bin/env bash

set -e

# Install all

sysdeps=$1   # sys dependencies list
renv_lock=$2 # renv lock file path or URL
repos=$3     # repos list
other_pkg=$4 # R pkg list
renv_version=$5

if [ ! -z "${sysdeps}" ]; then
	echo "Run install_sysdeps ${sysdeps}"
	/scripts/install_sysdeps.sh "${sysdeps}"
fi

if [ ! -z "${renv_lock}" ]; then
	echo "Run restore renv"
	/scripts/restore_renv.sh ${renv_version}
fi

if [ ! -z "${other_pkg}" ]; then
	echo "Run install_other_pkgs - packages: ${other_pkg}"
	Rscript /scripts/install_other_pkgs.R "${repos}" "${other_pkg}"
fi
