
import std/[options, strutils]

func maybeParseInt*(str: string): Option[int] =
    try: some(str.parseInt)
    except: none(int)


