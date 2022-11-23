#!/bin/bash -xe

SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

if [ ! -d "${SCRIPT_DIR}/install/eigen" ]; then
    # Take action if install $DIR does not exists. #
    echo "Installing Eigen library in ${SCRIPT_DIR}/install/eigen..."
    mkdir -p ${SCRIPT_DIR}/build/eigen
    mkdir -p ${SCRIPT_DIR}/install/eigen
    mkdir -p ${SCRIPT_DIR}/cmake/eigen

    cmake ${SCRIPT_DIR}/deps/eigen                           \
          -DCMAKE_INSTALL_PREFIX=${SCRIPT_DIR}/install/eigen \
          -B ${SCRIPT_DIR}/build/eigen

    make -C build/eigen install -j 4

    mkdir -p cmake
    cp ${SCRIPT_DIR}/install/eigen/share/eigen3/cmake/* ${SCRIPT_DIR}/cmake/eigen

    echo "Eigen library installation complete"
else
    echo "Eigen library already installed, skipping installation"
fi

if [ ! -d "${SCRIPT_DIR}/install/matplotpp" ]; then
    # Take action if install $DIR does not exists. #
    echo "Installing Matplot++ library in ${SCRIPT_DIR}/install/matplotpp..."
    mkdir -p ${SCRIPT_DIR}/build/matplotpp
    mkdir -p ${SCRIPT_DIR}/install/matplotpp
    mkdir -p ${SCRIPT_DIR}/cmake/matplotpp

    cmake ${SCRIPT_DIR}/deps/matplotplusplus  \
        -B ${SCRIPT_DIR}/build/matplotpp      \
        -DBUILD_EXAMPLES=OFF                  \
        -DBUILD_SHARED_LIBS=ON                \
        -DBUILD_TESTS=OFF                     \
        -DCMAKE_BUILD_TYPE=Release            \
        -DCMAKE_INSTALL_PREFIX="${SCRIPT_DIR}/install/matplotpp" \
        -DCMAKE_INTERPROCEDURAL_OPTIMIZATION=ON

    cmake --build build/matplotpp -j 4
    cmake --install build/matplotpp

    echo "Matplot++ library installation complete"
else
    echo "Matplot++ library already installed, skipping installation"
fi
