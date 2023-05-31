#!/usr/bin/env bash
# Script that restore renv packages

RENV_PATHS_CACHE=${RENV_PATHS_CACHE:-"/renv/cache"}

if [ -f "/workspace/renv.lock" ]
then
    echo "renv file found - launching renv::restore()"
    # update global libPath if enabled
    if [ -z "${update_libpath}" ]
    then
        echo "create $RENV_PATHS_CACHE folder"
        mkdir -p "$RENV_PATHS_CACHE"

        echo "Install renv R package..."
        mkdir /tmp/renv-cache
        cd /tmp/renv-cache
        cp /workspace/renv.lock ./renv.lock

        echo "update Renviron and Renviron.site files"
        echo "R_LIBS=/renv/cache" >> $R_HOME/etc/Renviron
        echo "RENV_PATHS_CACHE=/renv/cache" >> $R_HOME/etc/Renviron
        echo "R_LIBS_USER=/renv/cache" >> $R_HOME/etc/Renviron

        # Install remote
        R -e "install.packages(c('remotes'), repos='https://cloud.r-project.org/', lib='$RENV_PATHS_CACHE')"

        # Install renv from GitHub.
        RENV_VERSION=0.17.0
        R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}', lib='$RENV_PATHS_CACHE')"

        R -e 'renv::init(bare=TRUE)'
        R -e "renv::restore(library='$RENV_PATHS_CACHE')"

        cd ..

        # clean up /tmp and /workspace folders
        rm -rf /tmp/renv-cache
        rm -rf /tmp/Rtmp*
        rm /workspace/renv.lock
    fi
else
    echo "renv.lock file not found"
    exit 1
fi