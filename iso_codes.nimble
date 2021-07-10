# Package

version       = "0.2.0"
author        = "kraptor"
description   = "ISO codes for Nim"
license       = "MIT"
srcDir        = "src"
binDir        = "bin"
bin           = @["iso_update_resources"]

# Dependencies

requires "nim >= 1.4.0"
requires "jsony >= 1.0.3"


proc clean_artifacts() =
    rmDir binDir

task clean, "Clean build artifacts":
    clean_artifacts()

task update_codes, "Update ISO codes from source repository":
    exec "nimble build"
    exec "bin/iso_update_resources"
    clean_artifacts()