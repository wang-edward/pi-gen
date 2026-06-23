#!/bin/bash -e
on_chroot << EOF
cd /opt
curl -fL https://ziglang.org/download/0.15.1/zig-aarch64-linux-0.15.1.tar.xz | tar xJ
ln -sf /opt/zig-aarch64-linux-0.15.1/zig /usr/local/bin/zig
systemctl enable ssh
git config --system pull.rebase true
EOF
