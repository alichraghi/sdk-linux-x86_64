#!/usr/bin/env bash
set -ex

mirror='http://mirrors.kernel.org'

rm -rf root/
mkdir -p root/

declare -a packages=(
    "$mirror/ubuntu/pool/main/libx/libx11/libx11-dev_1.6.4-3ubuntu0.4_amd64.deb"
    "$mirror/ubuntu/pool/main/libx/libxcursor/libxcursor-dev_1.1.15-1_amd64.deb"
    "$mirror/ubuntu/pool/main/libx/libxrandr/libxrandr-dev_1.5.1-1_amd64.deb"
    "$mirror/ubuntu/pool/main/libx/libxinerama/libxinerama-dev_1.1.3-1_amd64.deb"
    "$mirror/ubuntu/pool/main/libx/libxi/libxi-dev_1.7.9-1_amd64.deb"
    "$mirror/ubuntu/pool/main/m/mesa/mesa-common-dev_19.2.8-0ubuntu0~18.04.2_amd64.deb"
    "$mirror/ubuntu/pool/main/libx/libxi/libxi-dev_1.7.9-1_amd64.deb"
    "$mirror/ubuntu/pool/universe/v/vulkan/libvulkan-dev_1.1.70+dfsg1-1_amd64.deb"
    "$mirror/ubuntu/pool/main/x/xorgproto/x11proto-dev_2018.4-4_all.deb"
    "$mirror/ubuntu/pool/main/libx/libxrender/libxrender-dev_0.9.10-1_amd64.deb"
    "$mirror/ubuntu/pool/main/libx/libxext/libxext-dev_1.3.3-1_amd64.deb"
    "$mirror/ubuntu/pool/main/libx/libxfixes/libxfixes-dev_5.0.3-1_amd64.deb"
    "$mirror/ubuntu/pool/main/libx/libxcb/libxcb1-dev_1.13-1_amd64.deb"
    "$mirror/ubuntu/pool/main/libx/libxau/libxau-dev_1.0.8-1_amd64.deb"
    "$mirror/ubuntu/pool/main/libx/libxdmcp/libxdmcp-dev_1.1.2-3_amd64.deb"
)

mkdir -p deb/
for i in "${packages[@]}"
do
    echo "$i"
    deb="deb/$(basename $i)"
    if [ ! -f "$deb" ]; then
        curl -Ls "$i" > "$deb"
    fi
    ar vx "$deb"

    if [ -f ./data.tar.xz ]; then
        tar -xvf data.tar.xz -C root/
    else
        tar -xvf data.tar.gz -C root/
    fi

    rm -rf *.tar.xz *.tar.gz debian-binary
done