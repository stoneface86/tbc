
import std/[options, strutils, times]
export options, times

func maybeParseInt*(str: string): Option[int] =
  try: some(str.parseInt)
  except: none(int)

func maybeParseDuration*(str: string): Option[Duration] =
  # parses a duration of time in format mm:ss or mm, where mm is the minutes
  # and ss is seconds. some(Duration) is returned if str was parsed sucessfully,
  # none(Duration) otherwise.
  #
  var parts: DurationParts
  var minutes = true
  for word in str.split(':', 1):
    let parsed = maybeParseInt(word)
    if parsed.isNone() or parsed.get() < 0:
      return none(Duration)
    if minutes:
      parts[Minutes] = parsed.get()
      minutes = false
    else:
      if parsed.get() notin 0..59:
        return none(Duration)
      parts[Seconds] = parsed.get()
  result = some(initDuration(minutes = parts[Minutes],
                             seconds = parts[Seconds]))
