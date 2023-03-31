# Package

version       = "1.7.2"
author        = "kraptor"
description   = "ISO codes for Nim that allows to embed the data within the executable (or load it automatically at runtime)."
license       = "MIT"
srcDir        = "src"
binDir        = "bin"
bin           = @["isocodes/scripts/isocodes_download"]
installExt    = @[
    "nim", # add nim files to installed package
    "json" # add json datafiles to installed package
]
skipDirs = @["isocodes/scripts"]

# Dependencies

requires "nim >= 1.4.0"
requires "jsony >= 1.0.3"

task update_codes, "Update ISO codes from source repository":
    exec "nim r src/isocodes/scripts/isocodes_download src/isocodes/resources/"

task clean, "Clean-up build artifacts":
    rmDir "bin"
