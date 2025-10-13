# Qt Builder

This repository contains a `Dockerfile` used to configure an environment which 
can build the entire [Qt](https://qt.io) platform from the 
[Qt sources](https://doc.qt.io/qt-6/getting-sources-from-git.html).

# Why Qt Builder?

GUI Projects depend on specific versions and configurations of Qt that are not 
consistently available via OS package managers. Distribution-provided Qt 
packages are often:

- Missing required modules
- Built with unknown or incompatible configuration flags
- Tied to older compiler or libc versions
- Difficult to reproduce across developer machines and CI

While package managers like Conan exist, they currently lack full coverage of 
required Qt modules and configurations for many use cases.

# Docker Image

## What's Included

The image starts from a stable Linux base and includes:

- **Compilers**: GCC and Clang toolchains
- **Build tools**: CMake, Make, Ninja
- **Qt build dependencies**:
  - X11 development libraries
  - OpenGL support
  - ICU (International Components for Unicode)
  - Multimedia support (FFmpeg)
  - WebEngine prerequisites
  - Quick 3D dependencies
  - gRPC prerequisites

## What's NOT Included

- Qt source code
- Pre-built Qt binaries

# Usage
## Building the Image
To build the environment image, run:
```shell
docker build [OPTIONS] -t qt-builder:<tag> .
```
## Image Tags

Images are tagged with:
- Image version
- OS version (e.g., `ubuntu-22.04`)
- Compiler version (e.g., `gcc-11`)

Following the form:
```
qt-builder:<image version>[-<base OS>][-<compiler>]
```
For example: 
- `qt-builder:1.0.0-ubuntu22.04-gcc11`

> Portions of the tag may be omitted if using the default values. 

## Defaults:
- OS: Ubuntu 22.04 (Jammy)
- Compiler: GCC 11.x (as provided by Canonical)

## Using the Image
### Interactive Development

Pull the image and start a container:

```shell
docker run -it qt-builder:latest
```

### Custom Qt Build Example
```shell
# Inside the container
./configure \
  -prefix /opt/qt-custom \
  -opensource -confirm-license \
  -debug
cmake --build .
cmake --install .
```

### Qt Build Options
```shell
./configure -h
./configure -list-features
```

### With Volume Mounts
Mount your Qt source and output directories:

```bash
docker run -it \
  -v /path/to/qt-source:/qt \
  -v /path/to/output:/opt/qt-6.2.4/x86_64-linux-gnu \
  qt-builder:latest bash
```

# Licensing
The `Dockerfile` in this repository is licensed under the **MIT** License. 
It is provided as a tool to automate the building of Qt from source and does not
include Qt binaries.

## Qt Build Requirements
For detailed Qt build requirements, refer to the official documentation:

- [Qt 6 Build from Source](https://doc.qt.io/qt-6/build-sources.html)
- [Qt for X11 Requirements](https://doc.qt.io/qt-6/linux-requirements.html)
- [Linux Building](https://doc.qt.io/qt-6/linux-building.html)
- [QtWebEngine Platform Notes](https://doc.qt.io/qt-6/qtwebengine-platform-notes.html)
- [QtQuick3D Building from Source](https://doc.qt.io/qt-6/qtquick3d-index.html#building-from-source)
- [QtMultimedia Building from Source](https://doc.qt.io/qt-6/qtmultimedia-building-from-source.html)
- [QtMultimedia FFmpeg on Linux](https://doc.qt.io/qt-6/qtmultimedia-building-ffmpeg-linux.html)
- [QtGrpc Module Prerequisites](https://doc.qt.io/qt-6/qtgrpc-index.html#module-prerequisites)
