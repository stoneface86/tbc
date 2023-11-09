
# Tasks

task docs, "Generate documentation":
  --hints:off
  --index:off
  --outdir:htmldocs
  setCommand("rst2html", "docs/tbc.rst")

task buildTests, "Builds the unit tester":
  --hints:off
  selfExec("c --hints:off --outdir:bin tests/tester.nim")

task test, "Runs all unit tests":
  buildTestsTask()
  exec("bin/tester")

