cmake_minimum_required (VERSION 3.0)
project (num_stoch_calc)

set(CMAKE_CXX_STANDARD 17 CACHE STRING "Default C++ standard")
set(NUM_STOCH_CALC_EXAMPLE_EXE num_stoch_calc_exe)
set(NUM_STOCH_CALC_ROOT ${CMAKE_CURRENT_LIST_DIR})

include("./tools/cmake/utils.cmake")

add_executable (${NUM_STOCH_CALC_EXAMPLE_EXE} source/main.cpp)

set(submodules_list "linalg" "rnd" "plotter")

foreach(sub_module_name ${submodules_list})
    setup_module(
        MODULE_NAME_LOWERCASE ${sub_module_name}
        PROJECT_ROOT ${NUM_STOCH_CALC_ROOT}
    )
endforeach()

foreach(sub_module_name ${submodules_list})
    add_module_to_exe(
        EXE_NAME ${NUM_STOCH_CALC_EXAMPLE_EXE}
        MODULE_NAME_LOWERCASE ${sub_module_name}
    )
endforeach()
