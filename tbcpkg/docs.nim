# Help and usage string consts

import std/[os, strformat]

import libtrackerboy/version

template slurpText(filename: string): string =
    slurp("text" / filename).fmt('`', '`')

const
    Usage* = "tbc [options] <input> <format={wav}>"
    FormatsHelp* = slurpText("FormatsHelp.txt")

    Help* = slurpText("Help.txt")
        
    NimblePkgVersion* {.strdefine.} = ""
    
    VersionStr* = &"TrackerBoy Compiler v{NimblePkgVersion} [libtrackerboy v{currentVersion}]"
