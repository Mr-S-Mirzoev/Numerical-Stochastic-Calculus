cmake_minimum_required (VERSION 3.0)
project(${MODULE_RAND_NAME} VERSION 1.0.1 DESCRIPTION "Pseudo-random numbers library")

add_library(${MODULE_RAND_NAME} SHARED
    ${MODULE_RAND_DIR}/src/bm.cpp
    ${MODULE_RAND_DIR}/src/random.cpp
)

target_include_directories(${MODULE_RAND_NAME} PRIVATE ${MODULE_LINALG_DIR}/inc)
target_include_directories(${MODULE_RAND_NAME} PRIVATE ${MODULE_RAND_DIR}/inc)
target_link_libraries(${MODULE_RAND_NAME} PRIVATE ${MODULE_LINALG_NAME})
set_target_properties(${MODULE_RAND_NAME} PROPERTIES VERSION ${PROJECT_VERSION})

include(GNUInstallDirs)
install(TARGETS ${MODULE_RAND_NAME}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
