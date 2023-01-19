
import std/[options]

import configs
import formats/[wav]

import libtrackerboy/data

type
    OutputFormat* = enum
        ofWav

const
    OutputFormatNames*: array[OutputFormat, string] = [
        "wav"
    ]

template `$`*(format: OutputFormat): string =
    OutputFormatNames[format]

func parseOutputFormat*(str: string): Option[OutputFormat] =
    case str
    of $ofWav:
        some(ofWav)
    else:
        none(OutputFormat)

proc dispatch*(format: OutputFormat, module: Module, config: Config): bool =
    case format
    of ofWav:
        onWav(module, config)
