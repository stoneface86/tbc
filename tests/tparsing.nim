
import tbcpkg/parsing
import std/unittest

test "maybeParseDuration":
  check:
    maybeParseDuration("1:30") == 90
    maybeParseDuration("3") == 180
    maybeParseDuration("foo") == -1
    maybeParseDuration("2:bar") == -1
    maybeParseDuration("2:100") == -1
    maybeParseDuration("0:0") == 0
    maybeParseDuration("0:59") == 59
    maybeParseDuration("1:23:34") == -1

test "maybeParseInt":
  check:
    maybeParseInt("foo") == none(int)
    maybeParseInt("123") == some(123)
    maybeParseInt("") == none(int)
    maybeParseInt("-1") == some(-1)
    maybeParseInt("00012") == some(12)
