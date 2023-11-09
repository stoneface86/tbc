# Help and usage string consts

import std/[os, strformat]

import libtrackerboy/version

import version as tbcVersion

template slurpText(filename: string): string =
  slurp("text" / filename).fmt('`', '`')

const
  Usage* = "tbc [options] <input> <format={wav}>"
  FormatsHelp* = slurpText("FormatsHelp.txt")

  Help* = slurpText("Help.txt")
  
  VersionStr* = &"TrackerBoy Compiler v{TbcVersion} [libtrackerboy v{currentVersionString}]"
