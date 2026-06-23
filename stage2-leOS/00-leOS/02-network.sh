#!/bin/bash -e
install -m 600 files/user-data "${ROOTFS_DIR}/boot/firmware/user-data"
install -m 600 files/network-config "${ROOTFS_DIR}/boot/firmware/network-config"

# usb gadget
echo "dtoverlay=dwc2,dr_mode=peripheral" >> "${ROOTFS_DIR}/boot/firmware/config.txt"
sed -i 's/$/ modules-load=dwc2,g_ether/' "${ROOTFS_DIR}/boot/firmware/cmdline.txt"
