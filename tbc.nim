# tbc - TrackerBoy Compiler
# Usage: tbc <input> <format> [options]

import std/[
  exitprocs,
  os,
  sequtils,
  strformat,
  streams
]

import argparse

import libtrackerboy/[data, io]

import tbcpkg/[
  common,
  configs,
  docs,
  formats,
  parsing,
  logging
]

type
  ExitCode = enum
    exitSuccess = 0
    exitFailure = 1
    exitBadArguments = 2

template mainError(msg: string) =
  error(msg)
  return exitFailure

proc main(): ExitCode =
  let p = newParser:
    nohelpflag()
    # general options
    flag("--version", shortcircuit=true)
    flag("-h", "--help", shortcircuit=true)
    flag("--formats", shortcircuit=true)
    flag("--verbose")
    flag("--silent")
    option("-o", "--out")
    # song selection options
    flag("-a", "--all")
    option("-s", "--song", multiple=true)
    # channel selection flags
    flag("-1", "--ch1")
    flag("-2", "--ch2")
    flag("-3", "--ch3")
    flag("-4", "--ch4")
    # synthesized format flags
    #flag("--mono")
    option("-r", "--samplerate")
    option("-l", "--loops")
    option("-t", "--duration")

    arg("input")
    arg("format")

  let opts = block:
    try: 
      p.parse()
    except UsageError:
      stderr.write(&"Usage: {Usage}\n")
      stderr.write(getCurrentExceptionMsg())
      stderr.write('\n')
      return exitBadArguments
    except ShortCircuit as e:
      case e.flag
      of "formats":
        echo FormatsHelp
      of "help":
        echo Help
      of "version":
        echo VersionStr
      return exitSuccess


  # determine output format
  let format = block:
    var oFormat = parseOutputFormat(opts.format)
    if oFormat.isNone():
      mainError("unknown output format, see --formats or --help for available formats\n")
    oFormat.get()

  # read the input module
  var input = Module.init()
  try:
    let strm = openFileStream(opts.input)
    defer: strm.close()
    let inputError = input.deserialize(strm)
    if inputError != frNone:
      mainError(&"could not read module: {inputError}")
  except IOError:
    let errmsg = getCurrentExceptionMsg()
    mainError(&"could not read '{opts.input}', {errmsg}")

  # make config from the parsed arguments
  let (config, failed) = block:
    var cfg = Config.init()
    var failed = false
    template optError(msg: string) =
      error(msg)
      failed = true

    cfg.input = opts.input
    cfg.output = opts.`out`
    if opts.samplerate != "":
      let samplerate = maybeParseInt(opts.samplerate)
      if samplerate.isSome() and samplerate.get() in Positive:
        cfg.samplerate = samplerate.get()
      else:
        optError("-r,--samplerate: parameter must be a positive number")

    block:
      var channels: ChannelSet
      if opts.ch1:
        channels.incl(ch1)
      if opts.ch2:
        channels.incl(ch2)
      if opts.ch3:
        channels.incl(ch3)
      if opts.ch4:
        channels.incl(ch4)
      if channels.len > 0:
        cfg.channels = channels
    
    # if --silent and --verbose are both present, prefer --silent
    if opts.silent:
      cfg.verb = verbSilent
    elif opts.verbose:
      cfg.verb = verbVerbose

    # --all takes precedence over --song and --song-range
    let songIndexBounds = 0..(input.songs.len.int - 1)
    if opts.all:
      cfg.songs.incl(songIndexBounds.a.ByteIndex .. songIndexBounds.b.ByteIndex)
    else:
      
      for param in opts.song:
        let parsed = maybeParseInt(param)
        if parsed.isSome():
          if parsed.get() in songIndexBounds:
            cfg.songs.incl(parsed.get().ByteIndex)
          else:
            optError(&"-s,--song: module does not have a song with index { parsed.get() }")
        else:
          optError("-s,--song: parameter must be a number")
    
    # --loops takes precedence over --duration
    if opts.loops != "":
      let parsed = maybeParseInt(opts.loops)
      if parsed.isSome() and parsed.get() > 0:
        cfg.duration = Duration(kind: dkLoops, amount: parsed.get())
      else:
        optError("-l,--loops: parameter must be a positive number")
    elif opts.duration != "":
      let duration = maybeParseDuration(opts.duration)
      if duration > 0:
        cfg.duration = Duration(kind: dkSeconds, amount: duration)
      else:
        optError("-t,--duration: parameter must be in format minutes[:seconds] and cannot be 0")
    
    (cfg, failed) # result of the block
  
  if failed:
    return exitBadArguments
  
  # dispatch
  result = if dispatch(format, input, config): exitFailure else: exitSuccess


setProgramResult( main().ord )
