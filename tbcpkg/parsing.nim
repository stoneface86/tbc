
import std/[options, strutils]
export options

func maybeParseInt*(str: string): Option[int] =
    try: some(str.parseInt)
    except: none(int)

func maybeParseDuration*(str: string): int =
    # parses a duration of time in format mm:ss or mm, where mm is the minutes
    # and ss is seconds. The total duration in seconds is returned, or -1 if
    # the string could not be parsed.
    #
    var minutes = true
    for word in str.split(':', 1):
        let parsed = maybeParseInt(word)
        if parsed.isNone() or parsed.get() < 0:
            return -1
        if minutes:
            result = parsed.get() * 60
            minutes = false
        else:
            if parsed.get() notin 0..59:
                return -1
            result += parsed.get()
