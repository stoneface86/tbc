import std/[os, strformat, strutils]

# Package

version       = "0.0.1"
author        = "stoneface"
description   = "Trackerboy Compiler, command line front end for libtrackerboy"
license       = "MIT"
binDir        = "bin"
bin           = @["tbc"]

# Dependencies

requires "nim >= 1.6.0"

task docs, "Generates documentation":
    exec "nim rst2html --hints:off --index:off --outdir:htmldocs docs/tbc.rst"

task tester, "Builds the unit tester":
    switch("outDir", binDir)
    setCommand("c", "tests/tester.nim")
