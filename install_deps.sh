#!/bin/bash -xe

SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

eigen_generate_project() {
    cmake ${SCRIPT_DIR}/deps/eigen                         \
        -DCMAKE_INSTALL_PREFIX=${SCRIPT_DIR}/install/eigen \
        -B ${SCRIPT_DIR}/build/eigen
}

eigen_post_install_command() {
    cp ${SCRIPT_DIR}/install/eigen/share/eigen3/cmake/* ${SCRIPT_DIR}/cmake/eigen
}

mpp_generate_project() {
    cmake ${SCRIPT_DIR}/deps/matplotplusplus  \
        -B ${SCRIPT_DIR}/build/matplotpp      \
        -DBUILD_EXAMPLES=OFF                  \
        -DBUILD_SHARED_LIBS=ON                \
        -DBUILD_TESTS=OFF                     \
        -DCMAKE_BUILD_TYPE=Release            \
        -DCMAKE_INSTALL_PREFIX="${SCRIPT_DIR}/install/matplotpp" \
        -DCMAKE_INTERPROCEDURAL_OPTIMIZATION=ON
}

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

build_dep eigen Eigen eigen_generate_project eigen_post_install_command
build_dep matplotpp "Matplot++" mpp_generate_project