#!/bin/bash -xe

SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

if [ ! -d "${SCRIPT_DIR}/install/eigen" ]; then
    # Take action if install $DIR does not exists. #
    echo "Installing config files in ${DIR}..."
    mkdir -p ${SCRIPT_DIR}/build/eigen
    mkdir -p ${SCRIPT_DIR}/install/eigen
    cmake  ${SCRIPT_DIR}/deps/eigen                        \
        -DCMAKE_INSTALL_PREFIX=${SCRIPT_DIR}/install/eigen \
        -B ${SCRIPT_DIR}/build/eigen

    make -C build/eigen install -j 4
    echo "Eigen library installation complete"
else
    echo "Eigen library already installed, skipping installation"
fi

mkdir -p cmake
cp install/eigen/share/eigen3/cmake/* cmake
