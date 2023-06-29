# 3p-assimp

[Autobuild][autobuild] bottling of the [Open Asset Import Library][assimp]
(assimp).

## Development

Requirements:
- [autobuild][]
- [cmake][]
- [cygwin][] (Windows)

Clone this repository and its submodules:
```
git clone --recurse-submodules https://github.com/secondlife/3p-assimp
```

If you already have the code checked out, initialize and pull the assimp submodule:
```
cd 3p-assimp
git submodule init
git submodule update
```

Build and package:
```
autobuild configure
autobuild build
autobuild package
```

### Updating assimp

3p-assimp uses a submodule to vendor its library, this makes it incredibly easy
to perform updates:

```
cd assimp
git fetch
git checkout <tag or other ref>
cd ..
git commit -am "Updated assimp to ..."
```

### Publishing new versions

1. Create a Pull Request (this is required for complete release notes)
2. Merge into `main`
3. [Create a new release](https://github.com/secondlife/3p-assimp/releases)

### Build Troubleshooting

Some previously encountered issues:
1.  When running:
```
$ autobuild configure
Warning: no --id argument or AUTOBUILD_BUILD_ID environment variable specified;
    using SCM version (0.0.1-dev7.g12ebb06), which may not be unique
ERROR: no configuration for build configuration 'RelWithDebInfo' found; one may
be created using 'autobuild edit build'
For more information: try re-running your command with --verbose or --debug
```
Fix with:
```
$ export AUTOBUILD_CONFIGURATION=default
```

2.  Error with autobuild build:
```
<lots of output, build.sh completes OK>
fatal: No names found, cannot describe anything.
<python traceback with failure result from the git describe command>
```
This may be due to an older version of git, possibly caused by the version that Cygwin will install.   Try removing the git package from Cygwin and configure your PATH so the Windows install of git will be used instead.

3.   Grab download manually
curl can get the package needed if you are having trouble installing this package
```
cd $AUTOBUILD_INSTALLABLE_CACHE
curl -v -L -O https://github.com/secondlife/3p-assimp/releases/download/v5.2.5-r3/assimp-windows64-5.2.5-r3.tar.bz2
```
   
5.   
[assimp]: https://github.com/assimp/assimp
[autobuild]: https://github.com/secondlife/autobuild
[cmake]: https://cmake.org/
[cygwin]: https://www.cygwin.com/
