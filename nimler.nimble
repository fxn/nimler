mode = ScriptMode.Verbose

version = "0.0.1"
author = "wltsmrz"
description = "Erlang/Elixir NIF wrapper"
license = "MIT"
srcDir = "src"
skipDirs = @["test"]
# installFiles = @["nif_interface.nim"]
requires "nim >= 1.0.0"

--cincludes:"/usr/lib/erlang/usr/include"

proc configTest() =
  --verbosity:1
  --forceBuild
  --hints:off
  --warnings:off
  --stacktrace:on
  --linetrace:on
  --debuginfo
  --gc:"none"
  --noMain
  --app:lib
  --path:"."
  --out:"test/nif.so"


task test, "noop": quit()

task build_test, "build Erlang NIF shared obj for integration test":
  configTest()
  setCommand("compile", "test/nif")

task test_integration, "run Elixir integration test":
  exec("elixir test/test.exs")