#!/usr/bin/env bash

set -ex

CMAKE_OPTs="-DCMAKE_BUILD_TYPE=Release"
ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

# Step into staging directory
mkdir -p $ROOT/build
cd $ROOT/build

# Create destdir structure
mkdir -p lib/release
mkdir -p include/assimp/Compiler
mkdir -p LICENSES 

autobuild source_environment > .env
. .env

NPROC=${AUTOBUILD_CPU_COUNT:-$(nproc)}

case "$AUTOBUILD_PLATFORM" in
  windows*)
    load_vsvars

    cmake_arch="x64"
    case "$AUTOBUILD_ADDRSIZE" in
      32)
        cmake_arch="Win32"
        ;;
    esac

    # Configure and build
    cmake -G "$AUTOBUILD_WIN_CMAKE_GEN" -A "$cmake_arch" ../assimp $CMAKE_OPTS
    cmake --build . --config Release
    # Shuffle files into autobuild destdir structure
    mv bin/Release/assimp-*.dll ./lib/release/
    mv ./lib/release/assimp-*.lib ./lib/release/
  ;;
  linux*)
    # Configure and build
    cmake ../assimp $CMAKE_OPTS
    make -j$NPROC
    # Shuffle files into autobuild destdir structure
    mv bin/libassimp.so.*.* ./lib/release/libassimp.so
  ;;
  darwin*)
    # Configure and build
    cmake ../assimp $CMAKE_OPTS
    make -j$NPROC
    # Shuffle files into autobuild destdir structure
    mv bin/libassimp.*.*.*.dylib ./lib/release/libassimp.dylib
  ;;
esac

# Copy headers
cp ../assimp/include/assimp/*.h include/assimp
cp ../assimp/include/assimp/*.hpp include/assimp
cp ../assimp/include/assimp/*.inl include/assimp
cp ../assimp/include/assimp/Compiler/*.h include/assimp/Compiler/

# Copy license
cp ../assimp/LICENSE  LICENSES/assimp.txt
