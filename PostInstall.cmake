message(STATUS "Post install")

message(STATUS "Make initramfs")
execute_process(
        COMMAND bash -c "find . -print0 | cpio --null -ov --format=newc | gzip -9 > ../initramfs.cpio.gz"
        WORKING_DIRECTORY ${CMAKE_INSTALL_PREFIX}/initramfs
)

message(STATUS "Make iso")
execute_process(
        COMMAND bash -c "cp vmlinuz-5.15.0 initramfs.cpio.gz iso/boot/ && grub-mkrescue -o myos.iso iso"
        WORKING_DIRECTORY ${CMAKE_INSTALL_PREFIX}
)
