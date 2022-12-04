#!/bin/bash -xe

# SCRIPT_DIR must be set
if [ -z "${SCRIPT_DIR}" ]; then
    echo "SCRIPT_DIR is not set"
    exit 1
fi

# Public: Run commands to build dependencies.
#
# Takes four arguments:
#
# $1 - Name of the dependency (name in deps where it's source codes are downloaded).
# $2 - Name of the dependency for debug printing.
# $3 - Cmake project setup function
# $4 - Custom post-build command. (Usually some installation rootine)
#
# Examples
#
#   build_dep eigen Eigen eigen_generate_project eigen_post_install_command
#
# Returns nothing
build_dep () {
    if [ ! -d "${SCRIPT_DIR}/install/$1" ]; then
        # Take action if install $DIR does not exists. #
        echo "Installing $2 library in ${SCRIPT_DIR}/install/$1..."
        mkdir -p ${SCRIPT_DIR}/build/$1
        mkdir -p ${SCRIPT_DIR}/install/$1
        mkdir -p ${SCRIPT_DIR}/cmake/$1

        $3;

        cmake --build build/$1 -j 8
        cmake --install build/$1

        mkdir -p cmake
        $4;

        echo "$2 library installation complete"
    else
        echo "$2 library already installed, skipping installation"
    fi
}
