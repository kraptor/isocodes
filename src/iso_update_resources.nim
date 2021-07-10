# This is just an example to get you started. A typical library package
# exports the main API in this file. Note that you cannot rename this file
# but you can remove it if you wish.

import os
import strformat
import httpclient

const 
    RESOURCES_FOLDER = joinPath("src", "isocodes", "resources")
    RESOURCES = [
        ("Countries", "https://salsa.debian.org/iso-codes-team/iso-codes/-/raw/main/data/iso_3166-1.json"),
        ("Country Subdivisions", "https://salsa.debian.org/iso-codes-team/iso-codes/-/raw/main/data/iso_3166-2.json")
    ]


if isMainModule:
    var client = newHttpClient()
    for (name, url) in RESOURCES:
        let 
            filename = extractFilename(url)
            target_filename = joinPath(RESOURCES_FOLDER, filename)

        echo fmt"Downloading {name}: {filename} ..."
        
        let 
            data = client.getContent(url)
            target = open(target_filename, FileMode.fmWrite)

        target.write(data)

        defer:
            target.close()
