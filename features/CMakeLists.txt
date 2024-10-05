project(features)

get_property(PLATFORM_FEATURES GLOBAL PROPERTY PLATFORM_FEATURES)
foreach (feature ${PLATFORM_FEATURES})
    add_subdirectory(${feature})
endforeach ()