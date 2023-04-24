# Install all  

sysdeps=$1 # sys dependencies list
renv_lock=$2 # renv lock file path or URL
other_pkg=$3 # R pkg list
repos=$4 # repos list

if [ -z "${sysdeps}" ]
then
        /scripts/install_sysdeps.sh "${sysdeps}"
fi

if [ -z "${renv_lock}" ]
then
        Rscript /scripts/restore_renv.R
fi

if [ -z "${other_pkg}" ]
then
        /scripts/install_other_pkgs.sh "${other_pkg}" "${repos}"
fi