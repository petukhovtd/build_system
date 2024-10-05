project(busybox)

include(ExternalProject)
include(ProcessorCount)

ProcessorCount(N)

get_property(INITRAMFS_DIR GLOBAL PROPERTY INITRAMFS_DIR)

ExternalProject_Add(${PROJECT_NAME}
        GIT_REPOSITORY https://git.busybox.net/busybox
        GIT_TAG 1_36_stable
        GIT_PROGRESS TRUE
        CONFIGURE_COMMAND make KBUILD_SRC=<SOURCE_DIR> -f <SOURCE_DIR>/Makefile defconfig
        BUILD_COMMAND make -j${N} LDFLAGS="-static"
        INSTALL_COMMAND make CONFIG_PREFIX=${INITRAMFS_DIR} LDFLAGS="-static" install
)

ExternalProject_Add_StepTargets(${PROJECT_NAME} download)

add_dependencies(fetch ${PROJECT_NAME}-download)
