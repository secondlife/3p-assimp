#!/usr/bin/env bash

set -ex

CMAKE_OPTs="-DCMAKE_BUILD_TYPE=Release"
ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
NPROC=${AUTOBUILD_CPU_COUNT:-$(nproc)}

# Step into staging directory
mkdir -p $ROOT/build
cd $ROOT/build

# Create destdir structure
mkdir -p lib/release
mkdir -p include/assimp
mkdir -p LICENSES 

case "$AUTOBUILD_PLATFORM" in
  windows*)
    # Configure and build
    cmake -G "$AUTOBUILD_WIN_CMAKE_GEN" ../assimp $CMAKE_OPTS
    cmake --build . --config Release
    # Shuffle files into autobuild destdir structure
    mv bin/Release/assimp-*.dll ./lib/release/assimp.dll
  ;;
  linux*)
    # Configure and build
    cmake ../assimp $CMAKE_OPTS
    make -j$NPROC
    # Shuffle files into autobuild destdir structure
    mv bin/libassimp.so.*.* ./lib/release/libassimp.so
  darwin*)
    # Configure and build
    cmake ../assimp $CMAKE_OPTS
    make -j$NPROC
    # Shuffle files into autobuild destdir structure
    ls bin
    mv bin/libassimp.dylib.* ./lib/release/libassimp.dylib
  ;;
esac

# Copy headers
cp ../assimp/include/assimp/*.h include/assimp

# Copy license
cp ../assimp/LICENSE  LICENSES/assimp.txt
