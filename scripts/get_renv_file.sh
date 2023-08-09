#!/usr/bin/env bash

set -e

# if specified, first argument shoud be path to renv.lock local file, or a public URL to an renv.lock file
# Script that get renv.lock path from file path or URL

renv="${1}"

if [ -f "$renv" ]; then
	echo "renv file found locally"
	cp "$renv" ./renv.lock
elif [ ! -z "$renv" ]; then
	curl -LJO "$renv"
	if [ -f "./renv.lock" ]; then
		echo "Fail to download renv.lock file from $renv URL"
		exit 1
	fi
else
	echo "wrong argument used for renv path/url : should be path to renv or an URL to download renv file"
	exit 1
fi
