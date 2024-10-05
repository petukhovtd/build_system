project(platforms)

function(print_property prop)
    get_property(${prop} GLOBAL PROPERTY ${prop})
    message("${prop}=${${prop}}")
endfunction()

message(STATUS "Configure platforms. PLATFORM=${PLATFORM}")

if (PLATFORM STREQUAL "TEST")
    include(PlatformTEST.cmake)
else ()
    message(FATAL_ERROR "unknown PLATFORM")
endif ()

foreach (prop
        KERNEL_GET_TYPE
        KERNEL_GET_TYPE_ZIP_FILE
        KERNEL_GET_TYPE_GIT_REPOSITORY
        KERNEL_GET_TYPE_GIT_TAG

        PLATFORM_FEATURES
)
    print_property(${prop})
endforeach ()
