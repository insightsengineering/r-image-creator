# Install all  

sysdeps=$1 # sys dependencies list
renv_lock=$2 # renv lock file path or URL
other_pkg=$3 # R pkg list
repos=$4 # repos list

if [ -z "${sysdeps}" ]
then    
        echo "Run install_sysdeps"
        /scripts/install_sysdeps.sh "${sysdeps}"
fi

if [ -z "${renv_lock}" ]
then
        echo "Run restore renv"
        /scripts/restore_renv.sh
fi

if [ -z "${other_pkg}" ]
then
        echo "Run install_other_pkgs - packages: ${other_pkg}"
        Rscript /scripts/install_other_pkgs.R "${other_pkg}" "${repos}"
fi