#
#
# INPUTs:
#   ANGLE_ROOT: Absolute path to ANGLE source

cmake_minimum_required(VERSION 2.8.11)
project(ANGLE C CXX)

if(NOT ANGLE_ROOT)
    message(FATAL_ERROR "ANGLE_ROOT is not defined")
endif()

if(NOT EXISTS ${ANGLE_ROOT})
    message(FATAL_ERROR "ANGLE_ROOT is not found (${ANGLE_ROOT})")
endif()

include(./angle-srcs.cmake)

set(srcs)

list(APPEND srcs
    ${angle_fe_translator_srcs}
    ${angle_fe_preprocessor_srcs}
    ${angle_fe_translator_lib_srcs}
    ${angle_common_srcs}
    ${angle_common_win_srcs}
    ${angle_libangle_srcs}
    ${angle_libangle_d3d_common_srcs}
    #${angle_libangle_d3d_9_srcs}
    ${angle_libangle_d3d_11_srcs}
    ${angle_egl_srcs}
    ${angle_image_util_srcs})

if(ANGLE_BUILD_ES1)
    list(APPEND srcs ${angle_libgles1_cm_srcs})
else()
    list(APPEND srcs ${angle_libglesv2_srcs})
endif()

if(${CMAKE_SYSTEM_NAME} STREQUAL "WindowsStore")
    # Assume UWP
    list(APPEND srcs
        ${angle_libangle_d3d_11_winrt_srcs})
    add_definitions(
            -D_SCL_SECURE_NO_WARNINGS
            -D_CRT_SECURE_NO_WARNINGS)
    # FIXME: Patching srcs below
elseif(WIN32)
    list(APPEND srcs
         ${angle_systeminfo_srcs}
         ${angle_libangle_d3d_11_win32_srcs})
endif()

# Rebase sources
function(rebase_sources var)
    set(srcs0)
    foreach(s ${ARGN})
        list(APPEND srcs0 ${ANGLE_ROOT}/${s})
    endforeach()
    set(${var} ${srcs0} PARENT_SCOPE)
endfunction()

rebase_sources(srcs ${srcs})

# Common definitions

include_directories(
    ${ANGLE_ROOT}/src
    ${ANGLE_ROOT}/include
    ${ANGLE_ROOT}/src/common/third_party/base
    ${CMAKE_CURRENT_BINARY_DIR}/angle/includes)

# FIXME: This disables binary with ANGLE_DISABLE_PROGRAM_BINARY_LOAD
configure_file(${ANGLE_ROOT}/src/commit.h
    ${CMAKE_CURRENT_BINARY_DIR}/angle/includes/id/commit.h
    COPYONLY)

if(${CMAKE_SYSTEM_NAME} STREQUAL "WindowsStore")
    list(APPEND srcs
        ${CMAKE_CURRENT_LIST_DIR}/patch-uwp/NativeWindow11WinRT.cpp)
    include_directories(BEFORE
        ${CMAKE_CURRENT_LIST_DIR}/patch-uwp)
    add_definitions(/wd4996) # FIXME:
endif()

# Configurations
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_definitions(
    -DANGLE_TRANSLATOR_IMPLEMENTATION
    -DLIBGLESV2_IMPLEMENTATION
    -DLIBEGL_IMPLEMENTATION
    -DLIBANGLE_IMPLEMENTATION
    -DGL_GLEXT_PROROTYPES
    -DEGL_EGLEXT_PROTOTYPES
    )

# MSVCRT speicfic?
add_definitions(-DNOMINMAX)

# Backend selection
add_definitions(-DANGLE_ENABLE_HLSL)
#add_definitions(-DANGLE_ENABLE_D3D9) # Requires d3d9
add_definitions(-DANGLE_ENABLE_D3D11) # Requires dxguid

# FIXME: Correct?
add_definitions(
    "-DANGLE_PRELOADED_D3DCOMPILER_MODULE_NAMES={ \"d3dcompiler_47.dll\", \"d3dcompiler_46.dll\", \"d3dcompiler_43.dll\" }"
    )

# Headers required for User
# Definitions required for User
add_definitions(
    # Use static-link
    -DANGLE_EXPORT=
    -DEGLAPI=
    -DGL_API=
    -DGL_APIENTRY=
    -DGL_APICALL=)

add_library(angle_static OBJECT ${srcs})
