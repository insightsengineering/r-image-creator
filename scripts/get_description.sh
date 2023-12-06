#!/usr/bin/env bash

set -e

# if specified, first argument shoud be path to renv.lock local file, or a public URL to an renv.lock file
# Script that get renv.lock path from file path or URL

description="${1}"

if [ -f "$description" ]; then
	echo "DESCRIPTION file found locally"
	cp "$description" ./DESCRIPTION
elif [ ! -z "$description" ]; then
	curl -LJO "$description"
	if [ ! -f "./DESCRIPTION" ]; then
		echo "Fail to download DESCRIPTION file from $description URL"
		exit 1
	fi
else
	echo "wrong argument used for DESCRIPTION path/url : should be path to DESCRIPTION or an URL to download DESCRIPTION file"
	exit 1
fi