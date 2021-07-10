# Package

version       = "0.3.0"
author        = "kraptor"
description   = "ISO codes for Nim"
license       = "MIT"
srcDir        = "src"

# Dependencies

requires "nim >= 1.4.0"
requires "jsony >= 1.0.3"

task update_codes, "Update ISO codes from source repository":
    exec "nim r scripts/iso_update_resources"