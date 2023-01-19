
import common, logging

type
    Config* = object
        input*: string
        output*: string
        verb*: Verbosity
        samplerate*: Positive
        channels*: ChannelSet
        songs*: SongSelection

const
    DefaultConfig* = Config(
        samplerate: 44100,
        channels: {ch1..ch4},
        verb: verbNormal
    )

func init*(_: typedesc[Config]): Config =
    DefaultConfig
