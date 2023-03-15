# 3p-assimp

[Autobuild][autobuild] bottling of the [Open Asset Import Library][assimp]
(assimp).

## Development

Requirements:
- [autobuild][]
- [cmake][]

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

1. Create a PR
2. Merge into `main`
3. [Create a new release](https://github.com/secondlife/3p-assimp/releases)

[assimp]: https://github.com/assimp/assimp
[autobuild]: https://github.com/secondlife/autobuild
[cmake]: https://cmake.org/
