
import utils
import std/unittest

test "-h, --help":
    for helpopt in ["-h", "--help"]:
        withInitHelper(helpopt):
            check:
                exitcode == exitSuccess
                app.shortCircuit == shortHelp
                app.subcmd == none(SubCommand)

    withInitHelper("wav -h"):
        check:
            exitcode == exitSuccess
            app.shortCircuit == shortHelp
            app.subcmd == some(scWav)

test "-v, --version":
    for versopt in ["-v", "--version"]:
        withInitHelper(versopt):
            check:
                exitcode == exitSuccess
                app.shortCircuit == shortVersion
                app.subcmd == none(SubCommand)

