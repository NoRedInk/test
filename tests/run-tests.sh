#!/usr/bin/env bash

DIM="\e[2m";
COLOR_OFF="\e[0m";

echo -en "${DIM}";
echo "Navigating to the tests/ directory"
cd "${0%/*}" # Change current working directory to this one.

LIBRARY_PATH=$(cd .. && pwd)
PACKAGE_NAME="elm-explorations/test"
PACKAGE_VERSION="1.2.2"
ORIGINAL_ELM_HOME="${ELM_HOME}"
ELM_HOME="elm_home"
PACKAGE_PATH="${ELM_HOME}/0.19.1/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}"

echo "Remembering original ELM_HOME=${ORIGINAL_ELM_HOME}"
echo "Temporarily setting ELM_HOME=${ELM_HOME}"
export ELM_HOME

echo "Cleaning up elm.js, elm-stuff, ${ELM_HOME}"
rm -rf elm.js
rm -rf elm-stuff
rm -rf "${ELM_HOME}"

echo "Copying the library from ${LIBRARY_PATH} to ${PACKAGE_PATH}"
mkdir -p "${PACKAGE_PATH}"
cp -r ../src       "${PACKAGE_PATH}/src"
cp -r ../elm.json  "${PACKAGE_PATH}/elm.json"
cp -r ../README.md "${PACKAGE_PATH}/README.md"
cp -r ../LICENSE   "${PACKAGE_PATH}/LICENSE"

echo "Compiling the test suite"
echo -en "${COLOR_OFF}";
elm make src/Main.elm --output elm.js

echo -en "${DIM}";
echo "Running the test suite"
echo "----------------------------------------------------"
echo -en "${COLOR_OFF}";
node elm.js

echo -en "${DIM}";
echo "----------------------------------------------------"
echo "Restoring the original ELM_HOME=${ORIGINAL_ELM_HOME}"
export ELM_HOME="${ORIGINAL_ELM_HOME}"

echo "Navigating back to the original directory"
cd - >/dev/null
echo -en "${COLOR_OFF}";
