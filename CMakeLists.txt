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
    ${angle_image_util_srcs}
    ${angle_libglesv2_srcs})

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
    ${CMAKE_CURRENT_LIST_DIR}/angle_commit
    ${CMAKE_CURRENT_BINARY_DIR}/angle/includes)

if(${CMAKE_SYSTEM_NAME} STREQUAL "WindowsStore")
    add_definitions(/wd4996) # FIXME:
endif()

if(WIN32)
    add_definitions(-DANGLE_IS_WIN)
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

# FIXME: 32bit??
set(sixtyfour ON)
if(sixtyfour)
    add_definitions(-DANGLE_IS_64_BIT_CPU)
else()
    add_definitions(-DANGLE_IS_32_BIT_CPU)
endif()

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
    -DGL_APICALL=

    # zlib
    -DCPU_NO_SIMD
    -DCHROMIUM_ZLIB_NO_CHROMECONF
    )

set(chromium_zlib_srcs
    chromium_zlib/adler32.c
    chromium_zlib/compress.c
    chromium_zlib/cpu_features.c
    chromium_zlib/crc32.c
    chromium_zlib/deflate.c
    chromium_zlib/gzclose.c
    chromium_zlib/gzlib.c
    chromium_zlib/gzread.c
    chromium_zlib/gzwrite.c
    chromium_zlib/infback.c
    chromium_zlib/inffast.c
    chromium_zlib/inflate.c
    chromium_zlib/inftrees.c
    chromium_zlib/trees.c
    chromium_zlib/uncompr.c
    chromium_zlib/zutil.c

    chromium_zlib/google/compression_utils_portable.cc
    )

include_directories(
    chromium_zlib
    chromium_zlib/google)

add_library(angle_static OBJECT ${srcs}
    ${chromium_zlib_srcs})
