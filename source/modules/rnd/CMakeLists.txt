cmake_minimum_required (VERSION 3.0)
project(${MODULE_RND_NAME} VERSION 1.0.1 DESCRIPTION "Pseudo-random numbers library")

add_library(${MODULE_RND_NAME} SHARED
    ${MODULE_RND_DIR}/src/bm.cpp
    ${MODULE_RND_DIR}/src/random.cpp
)

target_include_directories(${MODULE_RND_NAME} PRIVATE ${MODULE_LINALG_DIR}/inc)
target_include_directories(${MODULE_RND_NAME} PRIVATE ${MODULE_RND_DIR}/inc)
target_link_libraries(${MODULE_RND_NAME} PRIVATE ${MODULE_LINALG_NAME})
set_target_properties(${MODULE_RND_NAME} PROPERTIES VERSION ${PROJECT_VERSION})

include(GNUInstallDirs)
install(TARGETS ${MODULE_RND_NAME}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
