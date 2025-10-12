# Qt Build Environment

This repository contains a `Dockerfile` used to configure an environment which 
can build the entire [Qt](https://qt.io) platform from the [Qt sources](https://doc.qt.io/qt-6/getting-sources-from-git.html).

# Usage
## Building the Docker Image
To build the environment image, run:
```shell
docker build [OPTIONS] -t [NAME] .
```

# Licensing
## Dockerfile
The `Dockerfile` in this repository is licensed under the **MIT** License. 
It is provided as a tool to automate the building of Qt from source and does not
include Qt binaries.

## Qt Source Code
This project uses Qt as a git submodule. Qt is licensed under **LGPLv3** (or 
GPLv2/GPLv3). Qt's License files are included in the submodule directory.
Users are responsible for complying with Qt's license for any binaries built or 
distributed.
