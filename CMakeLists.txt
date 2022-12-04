cmake_minimum_required (VERSION 3.0)
project (num_stoch_calc)

set(CMAKE_CXX_STANDARD 17 CACHE STRING "Default C++ standard")
set(NUM_STOCH_CALC_EXAMPLE_EXE num_stoch_calc_exe)
set(NUM_STOCH_CALC_ROOT ${CMAKE_CURRENT_LIST_DIR})

function(SETUP_MODULE MODULE_NAME_LOWERCASE)
    set(MODULE_NAME ${MODULE_NAME_LOWERCASE})
    string(TOUPPER ${MODULE_NAME} MODULE_NAME_U)

    message(STATUS "Configuring project ${MODULE_NAME}...")

    # For the purpose of using these variables in both parent scope and function scope, we set them twice...
    set(MODULE_${MODULE_NAME_U}_NAME ${MODULE_NAME})
    set(MODULE_${MODULE_NAME_U}_DIR ${NUM_STOCH_CALC_ROOT}/source/modules/${MODULE_NAME})
    set(MODULE_${MODULE_NAME_U}_NAME ${MODULE_NAME} PARENT_SCOPE)
    set(MODULE_${MODULE_NAME_U}_DIR ${NUM_STOCH_CALC_ROOT}/source/modules/${MODULE_NAME} PARENT_SCOPE)

    # Shorter alias
    set(MODULE_DIR ${MODULE_${MODULE_NAME_U}_DIR})

    message(STATUS "Configuring project ${MODULE_DIR}...")

    add_subdirectory(${MODULE_DIR})

    message(STATUS "Project ${MODULE_NAME} is successfully configured.")
endfunction()

function(ADD_MODULE_TO_EXE)
    cmake_parse_arguments(
        PARSE_ARGV 0
        ADD_MODULE_TO_EXE_PREFIX
        "" # Flags
        "EXE_NAME;MODULE_NAME_LOWERCASE" # One value args
        "" # Multi-value args
    )
    set(MODULE_NAME ${ADD_MODULE_TO_EXE_PREFIX_MODULE_NAME_LOWERCASE})
    set(EXE_NAME ${ADD_MODULE_TO_EXE_PREFIX_EXE_NAME})
    string(TOUPPER ${MODULE_NAME} MODULE_NAME_U)

    # Shorter alias
    set(MODULE_DIR ${MODULE_${MODULE_NAME_U}_DIR})

    message(STATUS "Including and linking project ${MODULE_NAME} to exe ${EXE_NAME}...")

    target_include_directories(${EXE_NAME} PRIVATE ${MODULE_DIR}/inc)
    target_link_libraries(${EXE_NAME} PUBLIC ${MODULE_NAME})

    message(STATUS "Project ${MODULE_NAME} is successfully added to ${EXE_NAME}.")
endfunction()

add_executable (${NUM_STOCH_CALC_EXAMPLE_EXE} source/main.cpp)

set(submodules_list "linalg" "rnd" "plotter")

foreach(sub_module_name ${submodules_list})
    setup_module(${sub_module_name})
endforeach()

foreach(sub_module_name ${submodules_list})
    add_module_to_exe(
        EXE_NAME ${NUM_STOCH_CALC_EXAMPLE_EXE}
        MODULE_NAME_LOWERCASE ${sub_module_name}
    )
endforeach()
