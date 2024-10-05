project(platform)

function(write_property prop)
    get_property(${prop} GLOBAL PROPERTY ${prop})
    file(APPEND ${PLATFORM_DEFS} "${prop}=${${prop}}\n")
endfunction()

message(STATUS "Configure platform. ${PLATFORM}")

set(PLATFORM_DEFS platform.defs)
file(WRITE ${PLATFORM_DEFS} "test")

foreach (prop
        PLATFORM_PROPERTY_1
        PLATFORM_PROPERTY_2
        PLATFORM_PROPERTY_3
        PLATFORM_PROPERTY_4
        PLATFORM_FEATURES
)
    write_property(${prop})
endforeach ()
