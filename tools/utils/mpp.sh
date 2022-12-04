#!/bin/bash -xe

# SCRIPT_DIR must be set
if [ -z "${SCRIPT_DIR}" ]; then
    echo "SCRIPT_DIR is not set"
    exit 1
fi

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
