#!/usr/bin/env bash

set -e

# Install all

sysdeps=$1   # sys dependencies list
renv_lock=$2 # renv lock file path or URL
repos=$3     # repos list
other_pkg=$4 # R pkg list
renv_version=$5
description=$6

if [ "${sysdeps}" != "None" ]; then
	echo "Run install_sysdeps ${sysdeps}"
	/workspace/scripts/install_sysdeps.sh "${sysdeps}"
fi

if [ "${renv_lock}" != "None" ]; then
	echo "Run restore renv"
	/workspace/scripts/restore_renv.sh "${renv_version}"
fi

if [ "${other_pkg}" != "None" ]; then
	echo "Run install_other_pkgs - packages: ${other_pkg}"
	Rscript /workspace/scripts/install_other_pkgs.R "${repos}" "${other_pkg}"
fi

if [ "${description}" != "None" ]; then
	# set up R_LIBS_USER variable
	echo "Update Renviron.site files"
	echo "R_LIBS_USER=/usr/local/lib/R/site-library" >> $R_HOME/etc/Renviron.site
	echo "Run install_pkgs_from_description"
	cd /workspace
	R -e "
	repos_list <- as.list(strsplit('$repos', ','))[[1]]
	options(repos=repos_list)
	install.packages('devtools')
	devtools::install(force = TRUE, dependencies = TRUE)
	"
fi

echo "Installed Packages"
R -e "installed_packages <- as.data.frame(installed.packages()); print(installed_packages[, c('Package', 'Version', 'LibPath')])"
