#!/bin/bash -e
on_chroot << EOF
cd /opt
curl -L https://ziglang.org/download/0.15.1/zig-aarch64-linux-0.15.1.tar.xz | tar xJ
ln -sf /opt/zig-aarch64-linux-0.15.1/zig /usr/local/bin/zig
usermod -aG video,render,input "${FIRST_USER_NAME}"
EOF
