#
#
# INPUTs:
#   ANGLE_ROOT: Absolute path to ANGLE source

cmake_minimum_required(VERSION 3.16)
project(ANGLE C CXX)
if(APPLE)
    enable_language(OBJC OBJCXX)
endif()

if(NOT ANGLE_ROOT)
    message(FATAL_ERROR "ANGLE_ROOT is not defined")
endif()

if(NOT EXISTS ${ANGLE_ROOT})
    message(FATAL_ERROR "ANGLE_ROOT is not found (${ANGLE_ROOT})")
endif()

if(NOT CHROMIUM_ZLIB_ROOT)
    message(FATAL_ERROR "CHROMIUM_ZLIB is not defined")
endif()

if(NOT EXISTS ${CHROMIUM_ZLIB_ROOT})
    message(FATAL_ERROR "CHROMIUM_ZLIB is not found (${CHROMIUM_ZLIB_ROOT})")
endif()

if(NOT ANGLE_BACKEND)
    set(ANGLE_BACKEND DirectX)
endif()

include(./angle-srcs.cmake)

set(srcs)

include_directories(${ANGLE_ROOT}/src/common/base
    ${ANGLE_ROOT}/src/common/third_party/xxhash
    )

if(ANGLE_VULKAN_HEADERS_ROOT)
    include_directories(${ANGLE_VULKAN_HEADERS_ROOT}/include)
endif()

if(ANGLE_SPIRV_HEADERS_ROOT)
    include_directories(${ANGLE_SPIRV_HEADERS_ROOT}/include)
endif()
if(ANGLE_SPIRV_TOOLS_ROOT)
    include_directories(${ANGLE_SPIRV_TOOLS_ROOT}/include)
endif()
if(ANGLE_GLSLANG_ROOT)
    include_directories(${ANGLE_GLSLANG_ROOT})
endif()
if(ANGLE_VOLK_ROOT)
    include_directories(${ANGLE_VOLK_ROOT})
endif()
if(ANGLE_SPIRV_CROSS_ROOT)
    include_directories(${ANGLE_SPIRV_CROSS_ROOT})
endif()

list(APPEND srcs
    ${angle_version_info_srcs}
    ${angle_frame_capture_mock_srcs}
    ${angle_preprocessor_sources}
    ${angle_translator_sources}
    ${angle_translator_essl_symbol_table_sources}
    ${angle_libangle_common_sources}
    ${angle_libangle_common_shader_state_sources}
    ${angle_libangle_sources}
    ${angle_xxhash_sources}
    ${angle_libegl_sources}
    ${angle_libangle_image_util_sources}
    ${angle_libglesv2_sources}
    ${angle_libangle_libangle_gpu_info_util_sources}
    ${angle_gl_enum_utils}
)

if(NOT ANGLE_EXCLUDE_ENTRYPOINTS)
    message(STATUS "WARING: Implement split entrypoint mode!")
    #    list(APPEND srcs
    #    ${angle_libglesv2_entrypoints_srcs})
endif()

# debug
#list(APPEND srcs
#    ${angle_gl_enum_utils})

if(${ANGLE_BACKEND} STREQUAL Vulkan)
    list(APPEND srcs
        ${angle_translator_lib_spirv_sources}
        ${angle_vulkan_backend_sources}
        ${angle_spirv_srcs}
        ${angle_vk_mem_alloc_wrapper_srcs}
        ${angle_vulkan_icd_srcs}
        ${angle_libangle_gpu_info_util_vulkan_sources}
        ${angle_libvulkan_loader_srcs}
        )
    # Workaround
    list(APPEND srcs
        ${CMAKE_CURRENT_LIST_DIR}/WAR_vk_cache_utils.cpp
    )
    # See SHA256 for 1aaa3e415528dd621b043c96adbc58e147874eb27ea8594a0ce2cc6d462b5ed4
    file(SHA256 ${ANGLE_ROOT}/src/libANGLE/renderer/vulkan/vk_cache_utils.cpp _hash)
    if(NOT "${_hash}" STREQUAL 1aaa3e415528dd621b043c96adbc58e147874eb27ea8594a0ce2cc6d462b5ed4)
        # 2nd chance for CRLF line endings
        if(NOT "${_hash}" STREQUAL 2a1524a35e94109ea422307c3bbe1f3616006d032d57644be61e304d17bfa1d5)
            message(FATAL_ERROR "vk_cache_utils.cpp hash did not match.")
        endif()
    endif()

    set_source_files_properties(
        ${CMAKE_CURRENT_LIST_DIR}/WAR_vk_cache_utils.cpp
        PROPERTIES
        INCLUDE_DIRECTORIES ${ANGLE_ROOT}/src
    )
elseif(${ANGLE_BACKEND} STREQUAL Metal)
    list(APPEND srcs
        ${angle_translator_lib_spirv_sources}
        ${angle_translator_lib_msl_sources}
        )
else()
    list(APPEND srcs
        ${angle_translator_hlsl_sources}
        ${angle_d3d_shared_sources}
        # D3D9
        ${angle_d3d11_backend_sources}
    )
endif()

if(${CMAKE_SYSTEM_NAME} STREQUAL "WindowsStore")
    # Assume UWP
    list(APPEND srcs
        ${angle_d3d_format_tables}
        ${angle_libangle_common_sources_winuwp}
        ${angle_d3d11_backend_sources_winuwp}
        ${angle_d3d11_backend_sources_compositor_native_window})
    add_definitions(
        -DANGLE_ENABLE_WINDOWS_UWP
        -DANGLE_ENABLE_D3D11_COMPOSITOR_NATIVE_WINDOW
        -DANGLE_IS_WINUWP
        -D_SCL_SECURE_NO_WARNINGS
        -D_CRT_SECURE_NO_WARNINGS)
elseif(WIN32)
    list(APPEND srcs
        ${angle_libangle_common_sources_win32})
    if(${ANGLE_BACKEND} STREQUAL Vulkan)
        list(APPEND srcs
            ${angle_vulkan_backend_sources_win32})
    else()
        list(APPEND srcs
            ${angle_d3d_format_tables}
            ${angle_d3d_format_tables_nowinuwp}
            ${angle_d3d11_backend_sources_win32}
            ${angle_d3d11_backend_sources_compositor_native_window})
        add_definitions(-DANGLE_ENABLE_D3D11
            -DANGLE_ENABLE_D3D11_COMPOSITOR_NATIVE_WINDOW)
    endif()

    # MinGW header bug workaround
    # https://github.com/msys2/MINGW-packages/issues/22160
    add_definitions(-D____FIReference_1_boolean_INTERFACE_DEFINED__)
elseif(APPLE)
    list(APPEND srcs
        ${angle_libangle_common_sources_apple})
    if(${ANGLE_BACKEND} STREQUAL Metal)
        list(APPEND srcs
            ${angle_metal_backend_sources}
            )
    elseif(${ANGLE_BACKEND} STREQUAL Vulkan)
        list(APPEND srcs
            ${angle_vulkan_backend_sources_mac}
            )
    endif()
    if("${CMAKE_SYSTEM_NAME}" STREQUAL iOS OR
            "${CMAKE_SYSTEM_NAME}" STREQUAL tvOS OR
            "${CMAKE_SYSTEM_NAME}" STREQUAL visionOS)
        list(APPEND srcs
            ${angle_libangle_common_sources_ios}
            ${angle_libangle_gpu_info_util_ios_sources})
    else()
        list(APPEND srcs
            ${angle_libangle_mac_sources}
            ${angle_libangle_common_sources_mac}
            ${angle_libangle_gpu_info_util_mac_sources})
    endif()
    add_definitions(
        -Wno-nullability-completeness
        -Wno-unguarded-availability
        -fno-objc-arc
        )
elseif(UNIX)
    # Linux
    list(APPEND srcs
        ${angle_libangle_common_sources_linux}
        ${angle_libangle_gpu_info_util_linux_sources}
        ${angle_dma_buf_srcs}
        )
    if(${ANGLE_BACKEND} STREQUAL Vulkan)
        if(ANDROID)
            add_definitions(-DVK_USE_PLATFORM_ANDROID_KHR)
            message(STATUS "FIXME: DisplayVkAndroid")
            list(APPEND srcs
                ${angle_libangle_gpu_info_util_android_sources}
                ${angle_vulkan_backend_sources_android}
            )
        else()
            add_definitions(-DVK_USE_PLATFORM_WAYLAND_KHR
                -DANGLE_PLATFORM_LINUX
                -DANGLE_USE_GBM
                -DANGLE_USE_WAYLAND
                -DANGLE_USE_VULKAN_DISPLAY # Do we need this?
            )
            add_definitions(-DVK_USE_PLATFORM_XCB_KHR
                -DANGLE_USE_X11
            )

            list(APPEND srcs 
                ${angle_vulkan_backend_sources_wayland}
                ${angle_vulkan_backend_dma_buf_sources}
                ${angle_vulkan_backend_sources_gbm}
                ${angle_vulkan_backend_sources_x11}
            )
        endif()
    endif()
endif()

# Rebase sources
function(rebase_sources var)
    set(srcs0)
    foreach(s ${ARGN})
        if("${s}" MATCHES "^/" OR "${s}" MATCHES "^.:/")
            set(srcname ${s})
        else()
            set(srcname ${ANGLE_ROOT}/${s})
        endif()
        list(APPEND srcs0 ${srcname})
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

if(MSVC)
    add_compile_options(/MP)
endif()

# Configurations
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_definitions(
    -DANGLE_REVISION=9999
    -DANGLE_TRANSLATOR_IMPLEMENTATION
    -DLIBGLESV2_IMPLEMENTATION
    -DLIBEGL_IMPLEMENTATION
    -DLIBANGLE_IMPLEMENTATION
    -DGL_GLEXT_PROROTYPES
    -DEGL_EGLEXT_PROTOTYPES
    )

# Debugging
add_definitions(
    #-DANGLE_ENABLE_DEBUG_TRACE=1
    #-DANGLE_ENABLE_TRACE_EVENTS=1
    )

# MSVCRT speicfic?
add_definitions(-DNOMINMAX)

# Backend selection
if(${ANGLE_BACKEND} STREQUAL Vulkan)
    add_definitions(-DANGLE_ENABLE_VULKAN)
    add_definitions(-DANGLE_USE_CUSTOM_VULKAN_CMD_BUFFERS=1
        -DANGLE_ENABLE_VULKAN_GPU_TRACE_EVENTS=1)
    if(WIN32)
        add_definitions(-DVK_USE_PLATFORM_WIN32_KHR)
    endif()
    if(ANGLE_VOLK_ROOT)
        list(APPEND srcs ${ANGLE_VOLK_ROOT}/volk.c)
        add_definitions(-DANGLE_SHARED_LIBVULKAN=1)
    endif()
    if(ANGLE_VMA_ROOT)
        list(APPEND srcs vma_gen.cpp)
        add_definitions(-DANGLE_VMA_VERSION=3001000)
        include_directories(${ANGLE_VMA_ROOT}/include)
    endif()
elseif(${ANGLE_BACKEND} STREQUAL Metal)
    add_definitions(-DANGLE_ENABLE_METAL)

    rebase_sources(_vulkan_fe_srcs
        ${angle_fe_translator_lib_vulkan_srcs})

    set_source_files_properties(
        ${_vulkan_fe_srcs}
        PROPERTIES
        COMPILE_DEFINITIONS "ANGLE_ENABLE_VULKAN")
else()
    add_definitions(-DANGLE_ENABLE_HLSL)
    #add_definitions(-DANGLE_ENABLE_D3D9) # Requires d3d9
    add_definitions(-DANGLE_ENABLE_D3D11) # Requires dxguid
    add_definitions(-DANGLE_ENABLE_D3D11_COMPOSITOR_NATIVE_WINDOW)
endif()

if(CMAKE_SIZEOF_VOID_P EQUAL 4)
    set(sixtyfour OFF)
else()
    set(sixtyfour ON)
endif()
if(sixtyfour)
    add_definitions(-DANGLE_IS_64_BIT_CPU)
else()
    add_definitions(-DANGLE_IS_32_BIT_CPU)
endif()

# FIXME: Correct?
add_definitions(
    "-DANGLE_PRELOADED_D3DCOMPILER_MODULE_NAMES={ \"d3dcompiler_47.dll\", \"d3dcompiler_46.dll\", \"d3dcompiler_43.dll\" }"
    )
add_definitions(
    "-DANGLE_VK_MOCK_ICD_JSON=\"\""
    "-DANGLE_VK_LAYERS_DIR=\"\""
    )

# Headers required for User
# Definitions required for User
add_definitions(
    # Use static-link
    -DANGLE_EXPORT=
    -DKHRONOS_STATIC
    #-DEGLAPI=
    #-DGL_API=
    #-DGL_APIENTRY=
    #-DGL_APICALL=

    # zlib
    -DCPU_NO_SIMD
    -DCHROMIUM_ZLIB_NO_CHROMECONF
    )

set(chromium_zlib_srcs
    ${CHROMIUM_ZLIB_ROOT}/adler32.c
    ${CHROMIUM_ZLIB_ROOT}/compress.c
    ${CHROMIUM_ZLIB_ROOT}/cpu_features.c
    ${CHROMIUM_ZLIB_ROOT}/crc32.c
    ${CHROMIUM_ZLIB_ROOT}/deflate.c
    ${CHROMIUM_ZLIB_ROOT}/gzclose.c
    ${CHROMIUM_ZLIB_ROOT}/gzlib.c
    ${CHROMIUM_ZLIB_ROOT}/gzread.c
    ${CHROMIUM_ZLIB_ROOT}/gzwrite.c
    ${CHROMIUM_ZLIB_ROOT}/infback.c
    ${CHROMIUM_ZLIB_ROOT}/inffast.c
    ${CHROMIUM_ZLIB_ROOT}/inflate.c
    ${CHROMIUM_ZLIB_ROOT}/inftrees.c
    ${CHROMIUM_ZLIB_ROOT}/trees.c
    ${CHROMIUM_ZLIB_ROOT}/uncompr.c
    ${CHROMIUM_ZLIB_ROOT}/zutil.c

    ${CHROMIUM_ZLIB_ROOT}/google/compression_utils_portable.cc
    )

include_directories(
    ${CHROMIUM_ZLIB_ROOT}
    ${CHROMIUM_ZLIB_ROOT}/google)

add_library(angle_static STATIC ${srcs}
    ${chromium_zlib_srcs})

