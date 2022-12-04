cmake_minimum_required (VERSION 3.0)
project(${MODULE_PLOTTER_NAME} VERSION 1.0.1 DESCRIPTION "Plotting library")

# [BEGIN] Matplot++ Library setup
# important setting for accessing the library
set(Matplot++_DIR "${NUM_STOCH_CALC_ROOT}/install/matplotpp/lib/cmake/Matplot++")
message("CMake matplot++ path: ${Matplot++_DIR}")

find_package(Matplot++ REQUIRED)

set(MPP_INCLUDE_DIR "${NUM_STOCH_CALC_ROOT}/install/matplotpp/include" )
message("Matplot++ include path: ${MPP_INCLUDE_DIR}")

# [END] Matplot++ Library setup

add_library(${MODULE_PLOTTER_NAME} SHARED
    ${MODULE_PLOTTER_DIR}/src/plotter.cpp
)

target_include_directories(${MODULE_LINALG_NAME} PUBLIC ${MPP_INCLUDE_DIR})
target_include_directories(${MODULE_PLOTTER_NAME} PRIVATE ${MODULE_LINALG_DIR}/inc)
target_include_directories(${MODULE_PLOTTER_NAME} PRIVATE ${MODULE_PLOTTER_DIR}/inc)

target_link_libraries(${MODULE_PLOTTER_NAME} PRIVATE ${MODULE_LINALG_NAME})
target_link_libraries(${MODULE_PLOTTER_NAME} PUBLIC Matplot++::matplot)
set_target_properties(${MODULE_PLOTTER_NAME} PROPERTIES VERSION ${PROJECT_VERSION})

include(GNUInstallDirs)
install(TARGETS ${MODULE_PLOTTER_NAME}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
