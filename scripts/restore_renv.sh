#!/usr/bin/env bash
# Script that restore renv packages

RENV_PATHS_CACHE=${RENV_PATHS_CACHE:-"/renv/cache"}
R_LIBS=${R_LIBS:-"/renv/libs"}

if [ -f "/workspace/renv.lock" ]
then
    echo "renv file found - launching renv::restore()"
    # update global libPath if enabled
    if [ -z "${update_libpath}" ]
    then
        echo "create $RENV_PATHS_CACHE and $R_LIBS folders "
        mkdir -p "$RENV_PATHS_CACHE"
        mkdir -p "$R_LIBS"

        echo "Install renv R package..."
        mkdir /tmp/renv-cache
        cd /tmp/renv-cache
        cp /workspace/renv.lock ./renv.lock

        echo "update Renviron and Renviron.site files"
        echo "R_LIBS=$R_LIBS" >> $R_HOME/etc/Renviron.site
        echo "RENV_PATHS_CACHE=$RENV_PATHS_CACHE" >> $R_HOME/etc/Renviron.site

        # Install remote
        R -e "install.packages(c('remotes'), repos='https://cloud.r-project.org/', lib='$R_LIBS')"

        # Install renv from GitHub.
        RENV_VERSION=1.0.0
        R -e "install.packages('https://packagemanager.posit.co/cran/latest/src/contrib/renv_1.0.0.tar.gz', type='source', lib='$R_LIBS')"

        R -e 'renv::init(bare=TRUE)'
        R -e "renv::restore(library='$R_LIBS', prompt=FALSE)"

        cd ..

        # clean up /tmp and /workspace folders
        rm -rf /tmp/renv-cache
        rm -rf /tmp/Rtmp*
        rm /workspace/renv.lock

        # change /renv/cache permissions (users might want to install their own librairies)
        chmod 777 "$RENV_PATHS_CACHE"
        chmod 777 "$R_LIBS"
    fi
else
    echo "renv.lock file not found"
    exit 1
fi
