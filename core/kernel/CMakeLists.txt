project(kernel)

message(STATUS "Configure kernel")

include(ExternalProject)
include(ProcessorCount)
ProcessorCount(N)

message(DEBUG "Find processors ${N}")

get_property(KERNEL_GET_TYPE GLOBAL PROPERTY KERNEL_GET_TYPE)

if (KERNEL_GET_TYPE STREQUAL "ZIP")
    message("Kernel get from ZIP")

    get_property(KERNEL_GET_TYPE_ZIP_FILE GLOBAL PROPERTY KERNEL_GET_TYPE_ZIP_FILE)
    cmake_path(GET KERNEL_GET_TYPE_ZIP_FILE FILENAME KERNEL_GET_TYPE_ZIP_FILENAME_FULL)
    cmake_path(GET KERNEL_GET_TYPE_ZIP_FILENAME_FULL STEM LAST_ONLY KERNEL_GET_TYPE_ZIP_FILENAME)

    message("Kernel zip path ${KERNEL_GET_TYPE_ZIP_FILE}")
    message("Kernel zip file full ${KERNEL_GET_TYPE_ZIP_FILENAME_FULL}")
    message("Kernel zip file ${KERNEL_GET_TYPE_ZIP_FILENAME}")

    set(DOWNLOAD_COMMAND
            DOWNLOAD_COMMAND unzip -qo -d . ${KERNEL_GET_TYPE_ZIP_FILE}
            COMMAND rm -r ${PROJECT_NAME}
            COMMAND mv -f ${KERNEL_GET_TYPE_ZIP_FILENAME} ${PROJECT_NAME}
    )
elseif (KERNEL_GET_TYPE STREQUAL "GIT")
    message("Kernel get from GIT")
    get_property(KERNEL_GET_TYPE_GIT_REPOSITORY GLOBAL PROPERTY KERNEL_GET_TYPE_GIT_REPOSITORY)
    get_property(KERNEL_GET_TYPE_GIT_TAG GLOBAL PROPERTY KERNEL_GET_TYPE_GIT_TAG)

    message("Kernel git repository ${KERNEL_GET_TYPE_GIT_REPOSITORY}")
    message("Kernel git tag ${KERNEL_GET_TYPE_GIT_TAG}")

    set(DOWNLOAD_COMMAND
            GIT_REPOSITORY ${KERNEL_GET_TYPE_GIT_REPOSITORY}
            GIT_TAG ${KERNEL_GET_TYPE_GIT_TAG}
            GIT_PROGRESS TRUE
    )
else ()
    message(FATAL_ERROR "unknown kernel get type")
endif ()

ExternalProject_Add(${PROJECT_NAME}
        ${DOWNLOAD_COMMAND}

        CONFIGURE_COMMAND make -C <SOURCE_DIR> O=<BINARY_DIR> defconfig
        BUILD_COMMAND make -j${N} -C <SOURCE_DIR> O=<BINARY_DIR>
        INSTALL_COMMAND make O=<BINARY_DIR> modules_install install INSTALL_PATH=${CMAKE_INSTALL_PREFIX} INSTALL_MOD_PATH=${CMAKE_INSTALL_PREFIX}
)

ExternalProject_Add_StepTargets(${PROJECT_NAME} download)

add_dependencies(fetch ${PROJECT_NAME}-download)
