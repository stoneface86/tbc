
import libtrackerboy/common
export ChannelId, ByteIndex

type
  ChannelSet* = set[ChannelId]

  SongSelection* = object
    idmap: set[uint8]

func init*(_: typedesc[SongSelection]): SongSelection =
  SongSelection(idmap: { uint8.low .. uint8.high })

func init*(_: typedesc[SongSelection], single: ByteIndex): SongSelection =
  SongSelection(idmap: { single.uint8 })

func init*(_: typedesc[SongSelection], slice: Slice[ByteIndex]): SongSelection =
  SongSelection(idmap: { slice.a.uint8 .. slice.b.uint8 })

proc incl*(sel: var SongSelection, i: ByteIndex) =
  sel.idmap.incl(i.uint8)

proc incl*(sel: var SongSelection, i: Slice[ByteIndex]) =
  sel.idmap.incl( { i.a.uint8 .. i.b.uint8 } )

proc incl*(sel: var SongSelection, val: SongSelection) =
  sel.idmap.incl(val.idmap)

func contains*(s: SongSelection, i: ByteIndex): bool =
  i.uint8 in s.idmap

iterator items*(sel: SongSelection): ByteIndex =
  for id in sel.idmap:
    yield id.ByteIndex

func len*(sel: SongSelection): int =
  sel.idmap.card

func first*(sel: SongSelection): ByteIndex =
  for id in sel.idmap:
    return id

template contains*(T: typedesc[range], val: SomeOrdinal): bool =
  contains(T.low .. T.high, val)
