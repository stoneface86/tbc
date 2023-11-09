
import common, logging
import libtrackerboy/exports/wav

export SongDuration, songDuration

type
  Config* = object
    input*: string
    output*: string
    verb*: Verbosity
    samplerate*: Positive
    channels*: ChannelSet
    songs*: SongSelection
    duration*: SongDuration

const
  DefaultConfig* = Config(
    samplerate: 44100,
    channels: {ch1..ch4},
    verb: verbNormal,
    duration: songDuration(1)
  )

func init*(_: typedesc[Config]): Config =
  DefaultConfig
