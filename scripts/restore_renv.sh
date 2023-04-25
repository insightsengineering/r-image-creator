
# Script that restore renv packages

if [ -f "/workspace/renv.lock" ]
then
    echo "renv file found - launching renv::restore()"
    cd /workspace
    R -e "renv::init(bare = TRUE)"
    R -e "renv::restore()"
else
    echo "renv.lock file not found"
    exit 1
fi
