
import utils
import std/[unittest, strformat]


test "wav -s":
    const badSongMsg = "Error: invalid song index\n"
    withInitHelper("wav module -i:-1"):
        check:
            exitcode == exitBadArguments
            app.output == badSongMsg
    withInitHelper("wav module --song:256"):
         check:
            exitcode == exitBadArguments
            app.output == badSongMsg
    withInitHelper("wav module -i:3"):
        check:
            exitcode == exitSuccess
            app.output == ""
            app.subcmdConfig.wavConfig.song == 3

test "wav -o":
    const testfilename = "blah.wav"
    for opt in ["-o", "--output"]:
        withInitHelper(&"wav module {opt}:{testfilename}"):
            check:
                exitcode == exitSuccess
                app.output == ""
                app.subcmdConfig.wavConfig.filename == testfilename
