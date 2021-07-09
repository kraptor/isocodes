# Package

version       = "0.1.0"
author        = "kraptor"
description   = "ISO codes for Nim"
license       = "MIT"
srcDir        = "src"
binDir = "bin"
bin = @["iso_update_resources"]

# Dependencies

requires "nim >= 1.4.0"
requires "jsony >= 1.0.3"


task clean, "Clean build artifacts":
    rmDir binDir
