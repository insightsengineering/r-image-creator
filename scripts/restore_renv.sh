#!/usr/bin/env bash
# Script that restore renv packages

if [ -f "/workspace/renv.lock" ]
then
    echo "renv file found - launching renv::restore()"
    cd /workspace
    R -e "renv::init(bare = TRUE)"
    R -e "renv::restore()"
    R -e "renv::isolate()" # isolate renv to be independent from cache librairies and store everything under renv/library
else
    echo "renv.lock file not found"
    exit 1
fi
