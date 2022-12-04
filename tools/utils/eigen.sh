#!/bin/bash -xe

# SCRIPT_DIR must be set
if [ -z "${SCRIPT_DIR}" ]; then
    echo "SCRIPT_DIR is not set"
    exit 1
fi

eigen_generate_project() {
    cmake ${SCRIPT_DIR}/deps/eigen                         \
        -DCMAKE_INSTALL_PREFIX=${SCRIPT_DIR}/install/eigen \
        -B ${SCRIPT_DIR}/build/eigen
}

eigen_post_install_command() {
    cp ${SCRIPT_DIR}/install/eigen/share/eigen3/cmake/* ${SCRIPT_DIR}/cmake/eigen
}
