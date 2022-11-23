cmake_minimum_required (VERSION 3.0)
project (num_stoch_calc)

set(CMAKE_CXX_STANDARD 17 CACHE STRING "Default C++ standard")
set(NUM_STOCH_CALC_EXAMPLE_EXE num_stoch_calc_exe)
set(NUM_STOCH_CALC_ROOT ${CMAKE_CURRENT_LIST_DIR})

add_executable (${NUM_STOCH_CALC_EXAMPLE_EXE} source/main.cpp)

set(MODULE_LINALG_NAME linalg)
set(MODULE_LINALG_DIR ${NUM_STOCH_CALC_ROOT}/source/modules/${MODULE_LINALG_NAME})
add_subdirectory(${MODULE_LINALG_DIR})
target_include_directories(${NUM_STOCH_CALC_EXAMPLE_EXE} PRIVATE ${MODULE_LINALG_DIR}/inc)
target_link_libraries(${NUM_STOCH_CALC_EXAMPLE_EXE} PUBLIC ${MODULE_LINALG_NAME})

set(MODULE_RAND_NAME rnd)
set(MODULE_RAND_DIR ${NUM_STOCH_CALC_ROOT}/source/modules/${MODULE_RAND_NAME})
add_subdirectory(${MODULE_RAND_DIR})
target_include_directories(${NUM_STOCH_CALC_EXAMPLE_EXE} PRIVATE ${MODULE_RAND_DIR}/inc)
target_link_libraries(${NUM_STOCH_CALC_EXAMPLE_EXE} PUBLIC ${MODULE_RAND_NAME})

set(MODULE_PLOTTER_NAME plotter)
set(MODULE_PLOTTER_DIR ${NUM_STOCH_CALC_ROOT}/source/modules/${MODULE_PLOTTER_NAME})
add_subdirectory(${MODULE_PLOTTER_DIR})
target_include_directories(${NUM_STOCH_CALC_EXAMPLE_EXE} PRIVATE ${MODULE_PLOTTER_DIR}/inc)
target_link_libraries(${NUM_STOCH_CALC_EXAMPLE_EXE} PUBLIC ${MODULE_PLOTTER_NAME})
