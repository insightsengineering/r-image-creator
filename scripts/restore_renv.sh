#!/usr/bin/env bash
# Script that restore renv packages

get_renv_libpaths () {
   output=$(Rscript -e "cat(.libPaths(), sep='\n')")

    IFS=$'\n' read -rd '' -a paths <<< "$output"
    result=""

    for path in "${paths[@]}"; do
    result+="${path}:"
    done

    # Remove the trailing ":" character
    export renv_libpaths="${result%:}"
}

update_libpath="$1"

if [ -f "/workspace/renv.lock" ]
then
    echo "renv file found - launching renv::restore()"
    cd /workspace
    R -e "renv::init(bare = TRUE)"
    R -e "renv::restore()"
    # update global libPath if enabled
    if [ -z "${update_libpath}" ]
    then
        get_renv_libpaths
        echo "R_LIBS=\"\$R_LIBS:${renv_libpaths}\"" >> $R_HOME/etc/Renviron.site
    fi
else
    echo "renv.lock file not found"
    exit 1
fi
