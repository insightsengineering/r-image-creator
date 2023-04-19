
# Script that restore renv packages
# if specified, first argument shoud be path to renv.lock local file, or a public URL to an renv.lock file
renv="${1}"

if [ -f "$renv" ]{
    echo "renv file found - launching renv::restore()"
    export RENV_PATHS_LIBRARY renv/library
    R -e "renv::restore()"
}
elif [ ! -z "$renv" ] {
    curl -LJO "$renv"
    if [ -f "./renv.lock" ]{
        echo "Fail to download renv.lock file from $renv URL"
        exit 1
    }
}
else {
    echo "wrong argument used for renv path/url : should be path to renv or an URL to download renv file"
    exit 1
}
fi
