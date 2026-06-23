#!/bin/bash -e
install -m 600 files/user-data "${ROOTFS_DIR}/boot/firmware/user-data"
install -m 600 files/network-config "${ROOTFS_DIR}/boot/firmware/network-config"
