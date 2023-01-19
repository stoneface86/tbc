
import utils
import std/unittest

template versionTest(args: openArray[string]): untyped =
    test "version: " & $args:
        let res = execTbc(args)
        check:
            res.exitcode == 0
            res.hasStdout
            not res.hasStderr

versionTest(["--version"])
versionTest(["foo", "bar", "--version"])
