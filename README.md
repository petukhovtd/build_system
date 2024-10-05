# requrement deb
sudo apt install xorriso mtools
# run raw
cd install\
qemu-system-x86_64 -kernel vmlinuz-5.15.0 -initrd initramfs.cpio.gz -nographic -append "console=ttyS0"
# run iso
cd install\
qemu-system-x86_64 -nographic -boot d -cdrom myos.iso