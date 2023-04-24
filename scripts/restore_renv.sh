
# Script that restore renv packages

if [ -f "/workspace/renv.lock" ]
then
    echo "renv file found - launching renv::restore()"
    export RENV_PATHS_LIBRARY renv/library
    R -e "renv::restore()"
else
    echo "renv.lock file not found"
    exit 1
fi
