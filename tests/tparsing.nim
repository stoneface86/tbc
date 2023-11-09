
import tbcpkg/parsing
import std/unittest

test "maybeParseDuration":
  check:
    maybeParseDuration("1:30") == some(initDuration(minutes = 1, seconds = 30))
    maybeParseDuration("3") == some(initDuration(minutes = 3))
    maybeParseDuration("foo").isNone()
    maybeParseDuration("2:bar").isNone()
    maybeParseDuration("2:100").isNone()
    maybeParseDuration("0:0") == some(DurationZero)
    maybeParseDuration("0:59") == some(initDuration(seconds = 59))
    maybeParseDuration("1:23:34").isNone()

test "maybeParseInt":
  check:
    maybeParseInt("foo") == none(int)
    maybeParseInt("123") == some(123)
    maybeParseInt("") == none(int)
    maybeParseInt("-1") == some(-1)
    maybeParseInt("00012") == some(12)
