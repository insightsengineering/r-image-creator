#!/usr/bin/env bash
# Script that restore renv packages

set -e

RENV_PATHS_CACHE=${RENV_PATHS_CACHE:-"/renv/cache"}
RENV_PATHS_LIBRARY=${RENV_PATHS_LIBRARY:-"/renv/lib"}
TMP_LIB=${TMP_LIB:-"/tmp/lib"}

echo "Update Renviron.site files"
echo "
RENV_PATHS_CACHE=$RENV_PATHS_CACHE
RENV_PATHS_LIBRARY=$RENV_PATHS_LIBRARY
RENV_CONFIG_SANDBOX_ENABLED=FALSE
RENV_PATHS_PREFIX_AUTO=FALSE
" >>$R_HOME/etc/Renviron.site

if [ -f "/workspace/renv.lock" ]; then {
	echo "Create $RENV_PATHS_CACHE and $RENV_PATHS_LIBRARY directories"
	mkdir -p $RENV_PATHS_CACHE $RENV_PATHS_LIBRARY $TMP_LIB
	RENV_VERSION=${1:-"1.0.3"}
	# Install remote
	R -e "
    install.packages(
        'remotes',
        lib = '$TMP_LIB',
	repos = 'https://cloud.r-project.org'
    )
    library(
        'remotes',
        lib.loc = '$TMP_LIB',
        quietly = TRUE,
        verbose = FALSE
    )
    install_version(
        'renv',
        version = '$RENV_VERSION',
        lib = '$TMP_LIB',
        repos = 'https://cloud.r-project.org'
    )
    library(
        'renv',
        lib.loc = '$TMP_LIB',
        quietly = TRUE,
        verbose = FALSE
    )
    init(
        bare = TRUE,
        force = TRUE,
        restart = FALSE
    )
    restore(
        lockfile = '/workspace/renv.lock',
        prompt = FALSE,
        clean = TRUE
    )
    "
	# Get the renv platform prefix
	RENV_PLATFORM_PREFIX=$(Rscript -e "cat(renv:::renv_platform_prefix())" | tail -1)
	# Update Renviron.site with libpath
	echo "R_LIBS=$RENV_PATHS_LIBRARY/$RENV_PLATFORM_PREFIX" >>$R_HOME/etc/Renviron.site
	# Clean up the /tmp directory
	rm -rf /tmp/*
	# change /renv/cache permissions (users might want to install their own librairies)
	chmod 777 $RENV_PATHS_CACHE $RENV_PATHS_LIBRARY "$RENV_PATHS_LIBRARY/$RENV_PLATFORM_PREFIX"
}; else
	{
		echo "renv.lock file not found"
		exit 1
	}
fi
