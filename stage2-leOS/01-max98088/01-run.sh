#!/bin/bash -e

install -d "${ROOTFS_DIR}/tmp/max98088"
install -m 644 files/max98088.c "${ROOTFS_DIR}/tmp/max98088/"
install -m 644 files/max98088.h "${ROOTFS_DIR}/tmp/max98088/"

on_chroot << 'EOF'
set -e
KREL=$(ls /lib/modules | head -n1)
cd /tmp/max98088
printf 'obj-m += max98088.o\nKDIR := /lib/modules/%s/build\nall:\n\t$(MAKE) -C $(KDIR) M=$(PWD) modules\n' "$KREL" > Makefile
make
install -d "/lib/modules/$KREL/kernel/sound/soc/codecs"
install -m 644 max98088.ko "/lib/modules/$KREL/kernel/sound/soc/codecs/"
depmod -a "$KREL"
EOF
#
# compile dts
install -m 644 files/ledaw-codec-overlay.dts "${ROOTFS_DIR}/tmp/max98088/"

on_chroot << 'EOF'
set -e
cd /tmp/max98088
dtc -@ -I dts -O dtb -o ledaw-codec-overlay.dtbo ledaw-codec-overlay.dts
install -d /boot/firmware/overlays
install -m 644 ledaw-codec-overlay.dtbo /boot/firmware/overlays/
rm -rf /tmp/max98088
EOF
