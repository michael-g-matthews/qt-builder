#------------------------------------------------------------------------------
# @file
# @author Mike Matthews (michael.g.matthews3@gmail.com)
# @brief Docker Image configuration to build Qt from source.
#
# Qt is licensed under LGPLv3 (or GPLv2/GPLv3). Users must comply with Qt's
# license when building or distributing Qt binaries.
#
# @copyright Copyright (c) 2025 Michael Matthews under the MIT License
#
#------------------------------------------------------------------------------

FROM ubuntu:jammy AS qt-build-env

#-------------------------------------------------------------------------------
# Set UTF locale encoding, not ASCII
#-------------------------------------------------------------------------------
ENV LANG="C.UTF-8"
ENV LC_ALL="${LANG}"

RUN apt update && apt install --no-install-recommends -y \
    #---------------------------------------------------------------------------
    # Web tools
    #---------------------------------------------------------------------------
    git \
    wget \
    curl \
    ca-certificates \
    #---------------------------------------------------------------------------
    # Build tools
    #---------------------------------------------------------------------------
    # CMake 3.22+
    cmake \
    # Ninja
    ninja-build \
    # Python version 3
    python3 \
    #---------------------------------------------------------------------------
    # Compilers
    #---------------------------------------------------------------------------
    # C++ compiler (GCC 11.x)
    build-essential \
    #------------------------------------------------------------------------------
    # Qt for X11 Requirements
    #------------------------------------------------------------------------------
    # Fontconfig (>=2.6)
    # - Font Customization and Configuration
    libfontconfig-dev \
    # FreeType (>=2.3.0)
    # - Font Engine
    libfreetype-dev \
    # glib (>=2.8.3)
    # - Common Event Loop Handling
    # - provided by libgtk-3-dev as libglib2.0-dev
    libgtk-3-dev \
    # ICE (>=6.3.5)
    # - Inter-Client Exchange
    # - provided by libsm-dev as libice-dev
    # pthread (>=2.3.5)
    # - Multithreading
    # - provided by libxcb1-dev as libpthread-stubs0-dev
    # SM (>=6.0.4)
    # - X Session Management
    # - provided by libgtk-3-dev as libsm-dev
    # X11 (>=6.2.1)
    # - X11 Client-Side Library
    libx11-dev \
    # X11-xcb (>=1.3.2)
    # - XLib/XCB Interface Library
    libx11-xcb-dev \
    # xcb-cursor0 (>=0.1.1)
    # - Utility Library for XCB for Cursor
    libxcb-cursor-dev \
    ## glx extension for the X C Bindings
    libxcb-glx0-dev \
    # xcb-icccm (>=0.3.9)
    # - X C Bindings for ICCCM Protocol
    libxcb-icccm4-dev \
    # xcb-image (>=0.3.9)
    # - Utility Library for XCB for XImage and XShmImage
    # - used for QBackingStore and Cursor Support
    libxcb-image0-dev \
    # xcb-keysyms (>=0.3.9)
    # - Utility Library for XCB for Keycode Conversion
    libxcb-keysyms1-dev \
    # xcb-randr
    # - X C Bindings for Resize and Rotate Extension
    libxcb-randr0-dev \
    # xcb-render-util (>=0.3.9)
    # - Utility Library for XCB for Render Extension
    libxcb-render-util0-dev \
    # xcb-render (>=1.11)
    # - X C Bindings for Render Extension
    # - Provided by xcb-render-util as libxcb-render0-dev
    # xcb-shape (>=1.11)
    # - X C Bindings for Shape Extension
    libxcb-shape0-dev \
    # xcb-shm (>=1.11)
    # - X C Bindings for Shared Memory Extension
    libxcb-shm0-dev \
    # xcb-sync (>=1.11)
    # - X C Bindings for Sync Extension
    libxcb-sync-dev \
    # xcb-util (>=0.3.9)
    # - Utility Library for XCB for atom, aux and event
    libxcb-util-dev \
    # xcb-xfixes
    libxcb-xfixes0-dev \
    # xcb-xkb (>=1.11)
    # - X C Bindings for XKeyboard Extension
    libxcb-xkb-dev \
    # xcb (>=1.11)
    # - X C Binding Library
    libxcb1-dev \
    # Xext (>=6.4.3)
    # - X Extensions
    libxext-dev \
    # Provides an X Window System client interface to the XFIXES extension to
    # the X protocol
    libxfixes-dev \
    # Provides an X Window System client interface to the XINPUT extension to
    # the X protocol
    libxi-dev \
    # xkbcommon (>=0.5.0)
    # - Keymap Handling
    libxkbcommon-dev \
    # xkbcommon-x11 (>=0.5.0)
    # - Keymap Handling
    libxkbcommon-x11-dev \
    # XRender (>=0.9.0)
    # - X Rendering Extension; used for anti-aliasing and alpha cursor support
    libxrender-dev \
    #---------------------------------------------------------------------------
    # Qt Accessibility Dependencies
    #---------------------------------------------------------------------------
    #   Assistive Technology Service Provider Interface (AT-SPI)
    #       libatspi2.0-dev provided by libgtk-3-dev
    #   DBUS
    #       libdbus-1-3 and libdbus-1-dev provided by libgtk-3-dev
    #   OpenGL Dependencies
    #       libopengl0 and libopengl-dev provided by libgtk-3-dev
    #---------------------------------------------------------------------------
    # Qt WebEngine Platform Dependencies
    #---------------------------------------------------------------------------
    # C++20 compiler support
    # CMake (>=3.19)
    # 64-bit Nodejs (>=14.9)
    # Python (>=3.8)
    # Ninja (>=3.8)
    # Python3 html5lib
    python3-html5lib \
    python3-pip \
    # GNU gperf binary
    gperf \
    # GNU bison binary
    bison \
    # GNU flex binary
    flex \
    # A pkg-config binary
    pkg-config \
    # Glibc (>=2.16)
    # Mesa development headers
    mesa-common-dev \
    # Nss library (>=3.26)
    libnss3-dev \
    # GCC (>=10.0)
    # Clang (>=17.0)
    # Use available built-in libraries: 
    #   glib (>=2.32)
    #   harfbuzz (>=4.3)
    #   libudev
    #   libpng (>=1.6)
    #   libtiff (>=4.5)
    #   re2 (>=11.0)
    #   icu (>=70)
    #   opus (>=1.3.1)
    #   vpx (>= 1.10.0)
    #   libavutil (>= 58.29.100)
    #   libavcodec (>= 60.31.102)
    #   libavformat (>=60.16.100)
    #   openh264 (>=2.4.1)
    # pkg-config must find:
    #   dbus-1
    #   fontconfig
    #   x11
    #   libdrm
    #   xcomposite
    #   xcursor
    #   xrandr
    #   xi
    #   xproto
    #   xshmfence
    libxshmfence-dev \
    #   xtst
    #   xkbcommon
    #   xkbfile
    libxkbfile-dev \
    #   xcbdri3
    libxcb-dri3-dev \
    #---------------------------------------------------------------------------
    # Qt Multimedia
    #---------------------------------------------------------------------------
    # Depends on FFmpeg headers and libraries (TODO: use multistage-build)
    #---------------------------------------------------------------------------
    # QDoc Dependencies
    #---------------------------------------------------------------------------
    # needs Clang 17.0+ (ClangConfig.cmake)
    # compatible versions: 20.1, 19.1, 18.1, 17.0.6
    p7zip \
    #---------------------------------------------------------------------------
    # Undocumented libraries that cause warnings and errors when missing
    #---------------------------------------------------------------------------
    libgbm-dev 
#-------------------------------------------------------------------------------
# Install Qt's prebuilt llvm/clang package for QDoc
#-------------------------------------------------------------------------------
ARG CLANG_VERSION="20.1"
ARG QT_CLANG_BINS="https://download.qt.io/development_releases/prebuilt/libclang/qt"

RUN clang_download=$(curl -sL "${QT_CLANG_BINS}" \
    | grep -oP '(?<=href=")[^"]+' \
    | grep -i "ubuntu22.04" \
    | grep -E "\.7z\$" \
    | grep "${CLANG_VERSION}") && \
    wget "${QT_CLANG_BINS}/${clang_download}" && p7zip -d ${clang_download} && \
    mv libclang /usr/local/
ENV LLVM_INSTALL_DIR="/usr/local/libclang"

#-------------------------------------------------------------------------------
# Install LLVM's clang packages for QDoc
# ------------------------------------------------------------------------------
# ARG CLANG_VERSION="21"
# RUN wget -qO /etc/apt/keyrings/apt.llvm.org.asc https://apt.llvm.org/llvm-snapshot.gpg.key \
#     && cat <<EOF | tee /etc/apt/sources.list.d/llvm.list > /dev/null
# # ${CLANG_VERSION}
# deb [signed-by=/etc/apt/keyrings/apt.llvm.org.asc] http://apt.llvm.org/$(lsb_release -sc)/ llvm-toolchain-$(lsb_release -sc)-${CLANG_VERSION} main
# deb-src  [signed-by=/etc/apt/keyrings/apt.llvm.org.asc] http://apt.llvm.org/$(lsb_release -sc)/ llvm-toolchain-$(lsb_release -sc)-${CLANG_VERSION} main
# EOF

# # Install clang
# RUN apt update && apt install --no-install-recommends -y \
#     clang-${CLANG_VERSION} \
#     llvm-${CLANG_VERSION}-dev \
#     libclang-${CLANG_VERSION}-dev \
#     libclang-cpp${CLANG_VERSION}-dev \
#     ldd-${CLANG_VERSION}

#-------------------------------------------------------------------------------
# Install Nodejs for Qt WebEngine
#-------------------------------------------------------------------------------
RUN wget -qO /etc/apt/keyrings/nodesource.asc https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.asc] https://deb.nodesource.com/node_22.x nodistro main" \
    | tee /etc/apt/sources.list.d/nodesource.list > /dev/null && \
    cat <<EOF | tee /etc/apt/preferences.d/nodejs > /dev/null
Package: nodejs
Pin: origin deb.nodesource.com
Pin-Priority: 600
EOF

#-------------------------------------------------------------------------------
# Required Python dependencies for Qt WebEngine and Qt Pdf
#-------------------------------------------------------------------------------
# Required Python dependency:  spdx_tools.spdx.clitools.pyspdxtools
RUN pip3 install --no-cache-dir \
    spdx-tools

RUN apt update && apt install --no-install-recommends -y \
    nodejs

#-------------------------------------------------------------------------------
# Cleanup
#-------------------------------------------------------------------------------

RUN apt purge -y \
    p7zip \
    wget \
    curl \
    # remove apt cache
    && rm -rf /var/lib/apt/lists/*

#------------------------------------------------------------------------------
# Create non-root user
#------------------------------------------------------------------------------
ARG USERNAME="user"
ARG UID=1000
ARG GROUP_NAME=${USERNAME}
ARG GID=${UID}
RUN groupadd --gid ${GID} ${USERNAME} && \
    useradd --uid ${UID} --gid ${GID} -s /bin/bash -m ${USERNAME}
USER ${USERNAME}

#-------------------------------------------------------------------------------
# OCI Labelling
#-------------------------------------------------------------------------------
ARG IMAGE_VERSION="0.0.1"
# git config --get remote.origin.url
ARG IMAGE_SOURCE="git@github.com:michael-g-matthews/qt-builder.git"
# git rev-parse HEAD
ARG IMAGE_REVISION
# date --iso-8601=seconds
ARG IMAGE_CREATED
ARG IMAGE_REF_NAME

LABEL org.opencontainers.image.title="Qt Builder" \
    org.opencontainers.image.description="An environment to build Qt from source." \
    org.opencontainers.image.authors="Mike Matthews <michael.g.matthews3@gmail.com>" \
    org.opencontainers.image.vendor="Mike Matthews" \
    org.opencontainers.image.url="https://github.com/michael-g-matthews/qt-builder" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.version="${IMAGE_VERSION}" \
    org.opencontainers.image.source="${IMAGE_SOURCE}" \
    org.opencontainers.image.revision="${IMAGE_REVISION}" \
    org.opencontainers.image.created="${IMAGE_CREATED}" \
    org.opencontainers.image.ref.name="${IMAGE_REF_NAME}" \
    # org.opencontainers.image.base.digest="" \
    org.opencontainers.image.base.name="hub.docker.com/_/ubuntu:22.04"


