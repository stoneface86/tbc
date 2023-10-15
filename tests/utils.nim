
import std/[os, osproc, streams]

let workingDir = getAppDir()

type
  ExecTbcResult* = object
    exitcode*: int
    stdout*: string
    stderr*: string

  SimpleCheck* = enum
    scNoErrorCode
    scHasStdout
    scHasStderr

func hasStdout*(res: ExecTbcResult): bool =
  res.stdout != ""

func hasStderr*(res: ExecTbcResult): bool =
  res.stderr != ""


proc execTbc*(args: openArray[string] = []): ExecTbcResult =
  let p = startProcess(
    "./tbc", 
    workingDir, 
    args, 
    options = {}
  )
  let pout = p.outputStream()
  let perr = p.errorStream()
  var line = newStringOfCap(120)
  while true:
    var noreads = true
    template readFromStream(stream: Stream, outvar: var string) =
      if stream.readLine(line):
        noreads = false
        outvar.add(line)
        outvar.add('\n')
    readFromStream(pout, result.stdout)
    readFromStream(perr, result.stderr)
    if noreads and not p.running():
      break

  result.exitcode = p.peekExitCode()
  p.close()
