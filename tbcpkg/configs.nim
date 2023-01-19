
import common, logging
import libtrackerboy/exports/wav

export Duration, DurationKind

type

    Config* = object
        input*: string
        output*: string
        verb*: Verbosity
        samplerate*: Positive
        channels*: ChannelSet
        songs*: SongSelection
        duration*: Duration

const
    DefaultConfig* = Config(
        samplerate: 44100,
        channels: {ch1..ch4},
        verb: verbNormal,
        duration: Duration(kind: dkLoops, amount: 1)
    )

func init*(_: typedesc[Config]): Config =
    DefaultConfig
