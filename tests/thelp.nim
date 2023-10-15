
import utils
import std/unittest

import tbcpkg/docs

const expectedStdout = Help & '\n'

template helpTest(args: openArray[string]): untyped =
  test "help: " & $args:
    let res = execTbc(args)
    check:
      res.exitcode == 0
      res.stdout == expectedStdout
      not res.hasStderr

helpTest(["--help"])
helpTest(["-h"])
helpTest(["foo", "bar", "-h"])
