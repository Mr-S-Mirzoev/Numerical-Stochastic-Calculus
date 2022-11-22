cmake_minimum_required (VERSION 3.0)
project(${MODULE_LINALG_NAME} VERSION 1.0.1 DESCRIPTION "Linear algebra library")

# [BEGIN] EIGEN Library setup
# important setting for accessing the eigen library
list(APPEND CMAKE_MODULE_PATH "${NUM_STOCH_CALC_ROOT}/cmake")
find_package(Eigen3 REQUIRED)

set(EIGEN3_INCLUDE_DIR "${NUM_STOCH_CALC_ROOT}/install/eigen/include/eigen3" )
if(NOT EIGEN3_INCLUDE_DIR)
    message(FATAL_ERROR "Please point the environment variable EIGEN3_INCLUDE_DIR to the include directory of your Eigen3 installation.")
endif()

message("CMake module path: ${CMAKE_MODULE_PATH}")
message("Eigen include path: ${EIGEN3_INCLUDE_DIR}")

# [END] EIGEN Library setup

add_library(${MODULE_LINALG_NAME} SHARED
    ${MODULE_LINALG_DIR}/src/algorithms.cpp
    ${MODULE_LINALG_DIR}/src/matrix.cpp
    ${MODULE_LINALG_DIR}/src/ops.cpp
    ${MODULE_LINALG_DIR}/src/vector.cpp
)

target_include_directories(${MODULE_LINALG_NAME} PUBLIC ${EIGEN3_INCLUDE_DIR})
target_include_directories(${MODULE_LINALG_NAME} PRIVATE ${MODULE_LINALG_DIR}/inc)

target_link_libraries(${MODULE_LINALG_NAME} PRIVATE ${Eigen_LIBRARIES})
target_link_libraries(${MODULE_LINALG_NAME} PRIVATE ${Eigen_INCLUDE_DIRS})
set_target_properties(${MODULE_LINALG_NAME} PROPERTIES VERSION ${PROJECT_VERSION})

include(GNUInstallDirs)
install(TARGETS ${MODULE_LINALG_NAME}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})