import tbcpkg/version as mTbcVersion

# Package

version       = TbcVersion
author        = "stoneface"
description   = "Trackerboy Compiler, command line front end for libtrackerboy"
license       = "MIT"
binDir        = "bin"
bin           = @["tbc"]

# Dependencies

requires "nim >= 1.6.0"
requires "argparse >= 4.0.0"
requires "https://github.com/stoneface86/libtrackerboy#v0.8.3"

include "tasks.nims"
