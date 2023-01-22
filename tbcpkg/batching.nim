# utility for batching formats. For formats such as wav we can only do 1 song
# per file.


import common, logging
export common

import std/[os, strformat]

type
    SongBatchItem* = object
        dest*: string
        song*: ByteIndex

    SongBatch* = object
        songs: SongSelection
        outputPath: string
        outputExt: string
        noOutputGiven: bool
        willBatch: bool

func init*(
    _: typedesc[SongBatch],
    input: string,
    output: string,
    songs: SongSelection,
    outputExt: string
): SongBatch =
    result.songs = songs
    result.outputExt = outputExt
    result.noOutputGiven = output == ""
    result.willBatch = songs.len > 1
    result.outputPath = block:
        if result.noOutputGiven:
            if result.willBatch:
                input & "-out"
            else:
                input.changeFileExt(outputExt)
        else:
            output

proc errorOnAutomaticPath(b: SongBatch, msg: string) =
    error(&"cannot use automatic path '{b.outputPath}': {msg}\nHint: override the automatic path with -o or --out")

proc makeDir*(b: SongBatch): bool =
    if b.willBatch:
        try:
            # check if the path exists already
            let info = getFileInfo(b.outputPath)
            if info.kind == pcFile or info.kind == pcLinkToFile:
                if b.noOutputGiven:
                    errorOnAutomaticPath(b, "path already exists and is not a directory")
                else:
                    error("output needs to be a directory when multiple songs are selected")
                return true
        except OSError:
            # path does not exist, create it
            try:
                createDir(b.outputPath)
            except OSError:
                const msg = "could not create output directory"
                if b.noOutputGiven:
                    errorOnAutomaticPath(b, msg)
                else:
                    error(&"{msg} '{b.outputPath}'")
                return true

func batchItem(b: SongBatch, song: ByteIndex): SongBatchItem =
    result.song = song
    if b.willBatch:
        result.dest = b.outputPath / &"{song}.{b.outputExt}"
    else:
        result.dest = b.outputPath

iterator items*(b: SongBatch): SongBatchItem =
    for song in b.songs:
        yield b.batchItem(song)
