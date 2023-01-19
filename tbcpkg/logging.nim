
type
    Verbosity* = enum
        verbSilent      # No warnings or info printed to stdout
        verbNormal      # Only warnings printed to stdout
        verbVerbose     # Warnings, info printed to stdout

const
    WarnPrefix = "Warning: "
    ErrorPrefix = "Error: "

proc info*(verb: Verbosity, msg: string) =
    if verb == verbVerbose:
        echo msg

proc warn*(verb: Verbosity, msg: string) =
    if verb != verbSilent:
        stderr.write(WarnPrefix)
        stderr.writeLine(msg)

proc error*(msg: string) =
    # Does not take a verbosity argument since errors are always logged.
    stderr.write(ErrorPrefix)
    stderr.writeLine(msg)

template withLogging*(verb: Verbosity, body: untyped): untyped =
    # convenience template that provides info and warn shortcut overloads with
    # the verb parameter already passed
    template info(msg: string) = info(verb, msg)
    template warn(msg: string) = warn(verb, msg)
    body
