
import std/[os, strformat]

import libtrackerboy/data
import libtrackerboy/exports/wav

import ../configs, ../common, ../logging, ../batching


proc onWav*(module: Module, config: Config): bool =
    withLogging(config.verb):
        var wavConfig = WavConfig.init()
        wavConfig.samplerate = config.samplerate
        wavConfig.duration = config.duration
        wavConfig.channels = config.channels

        let songBatch = SongBatch.init(config.input, config.output, config.songs, "wav")
        if songBatch.makeDir():
            return true
        for item in songBatch:
            wavConfig.filename = item.dest
            wavConfig.song = item.song
            if not module.exportWav(wavConfig):
                error(&"failed to export song #{item.song} to '{item.dest}'")
                return true
