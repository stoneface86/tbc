
type
  Verbosity* = enum
    verbSilent      # No warnings or info printed to stdout
    verbNormal      # Only warnings printed to stdout
    verbVerbose     # Warnings, info printed to stdout

const
  WarnPrefix = "Warning: "
  ErrorPrefix = "Error: "

template info*(verb: Verbosity, msg: string) =
  if verb == verbVerbose:
    echo msg

proc warnImpl(msg: string) =
  stderr.write(WarnPrefix)
  stderr.writeLine(msg)

template warn*(verb: Verbosity, msg: string) =
  mixin warnImpl
  if verb != verbSilent:
    warnImpl

proc error*(msg: string) =
  # Does not take a verbosity argument since errors are always logged.
  stderr.write(ErrorPrefix)
  stderr.writeLine(msg)

template withLogging*(verb: Verbosity, body: untyped): untyped =
  # convenience template that provides info and warn shortcut overloads with
  # the verb parameter already passed
  template info(msg: string) {.used.} = info(verb, msg)
  template warn(msg: string) {.used.} = warn(verb, msg)
  body
