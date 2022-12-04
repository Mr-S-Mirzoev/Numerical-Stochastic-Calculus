#!/bin/bash -xe

export SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

source ${SCRIPT_DIR}/tools/utils/build_dep.sh

source ${SCRIPT_DIR}/tools/utils/eigen.sh
build_dep eigen Eigen eigen_generate_project eigen_post_install_command

source ${SCRIPT_DIR}/tools/utils/mpp.sh
build_dep matplotpp "Matplot++" mpp_generate_project
