# This is just an example to get you started. A typical library package
# exports the main API in this file. Note that you cannot rename this file
# but you can remove it if you wish.

import os
import strformat
import httpclient

const 
    RESOURCES = [
        ("Countries", "https://salsa.debian.org/iso-codes-team/iso-codes/-/raw/main/data/iso_3166-1.json"),
        ("Country Subdivisions", "https://salsa.debian.org/iso-codes-team/iso-codes/-/raw/main/data/iso_3166-2.json")
    ]


if isMainModule:
    var
        targetFolder = if paramCount() > 0: paramStr(1) else: ""
        client = newHttpClient()

    createDir targetFolder

    for (name, url) in RESOURCES:
        let 
            filename = joinPath(targetFolder, extractFilename(url))

        echo fmt"Downloading '{name}' to '{filename}'..."
        
        let 
            data = client.getContent(url)
            target = open(filename, FileMode.fmWrite)

        target.write(data)

        defer:
            target.close()
