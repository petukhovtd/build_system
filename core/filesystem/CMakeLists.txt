project(filesystem)

add_custom_target(${PROJECT_NAME})

set_property(GLOBAL PROPERTY INITRAMFS_DIR ${CMAKE_INSTALL_PREFIX}/initramfs/)

install(DIRECTORY initramfs/ DESTINATION initramfs/ )
install(PROGRAMS initramfs/init DESTINATION initramfs/)

install(DIRECTORY iso/ DESTINATION iso/ )
