#!/usr/bin/env bash
# Install all

sysdeps=$1 # sys dependencies list
renv_lock=$2 # renv lock file path or URL
update_libpath=$3 # update .libPaths() paths
other_pkg=$4 # R pkg list
repos=$5 # repos list

if [ ! -z "${sysdeps}" ]
then
        echo "Run install_sysdeps ${sysdeps}"
        /scripts/install_sysdeps.sh "${sysdeps}"
fi

if [ ! -z "${renv_lock}" ]
then
        echo "Run restore renv"
        /scripts/restore_renv.sh "${update_libpath}"
fi

if [ ! -z "${other_pkg}" ]
then
        echo "Run install_other_pkgs - packages: ${other_pkg}"
        Rscript /scripts/install_other_pkgs.R "${other_pkg}" "${repos}"
fi
