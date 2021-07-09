# Copyright (c) 2021 kraptor
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

import jsony
import options
export options

type
    CountrySubdivision* = object
        code*: string
        name*: string
        `type`*: string 
        parent*: string # optional

    CountrySubdivisions* = object
        objects: seq[CountrySubdivision]

    FindCountrySubdivisionPredicateProc* = proc(c: CountrySubdivision): bool


proc renameHook*(v: var CountrySubdivisions, fieldname: var string) =
    if fieldname == "3166-2":
        fieldname = "objects"


const
    embedSubdivisions {.booldefine.} = true
    useSubdivisionsFile {.strdefine.}  = "resources/iso_3166-2.json"    


when embedSubdivisions:
    const data = fromJson(staticRead useSubdivisionsFile, CountrySubdivisions)
when not embedSubdivisions:
    let data = fromJson(readFile useSubdivisionsFile, CountrySubdivisions)


proc count*(T: type CountrySubdivision): Natural = 
    return data.objects.len()


proc all*(T: type CountrySubdivision): seq[CountrySubdivision] =
    return data.objects


proc allIt*(T: type CountrySubdivision): seq[CountrySubdivision] =
    for c in data.objects:
        yield c


proc byCode*(T: type CountrySubdivision, code: string): Option[CountrySubdivision] =
    for c in data.objects:
        if c.code == code:
            return some(c)


proc byCodeStart*(T: type CountrySubdivision, code_start: string): seq[CountrySubdivision] =
    for c in data.objects:
        if c.code.startsWith(code_start):
            result.add(c)


iterator byCodeStartIt*(T: type CountrySubdivision, code_start: string): CountrySubdivision =
    for c in data.objects:
        if c.code.startsWith(code_start):
            yield c


proc byName*(T: type CountrySubdivision, name: string): seq[CountrySubdivision] =
    for c in data.objects:
        if c.name == name:
            result.add(c)


iterator byNameIt*(T: type CountrySubdivision, name: string): CountrySubdivision =
    for c in data.objects:
        if c.name == name:
            yield c


proc byType*(T: type CountrySubdivision, `type`: string): seq[CountrySubdivision] =
    for c in data.objects:
        if c.`type` == `type`:
            result.add(c)


iterator byTypeIt*(T: type CountrySubdivision, `type`: string): CountrySubdivision =
    for c in data.objects:
        if c.`type` == `type`:
            yield c


proc byParent*(T: type CountrySubdivision, parent: string): seq[CountrySubdivision] =
    for c in data.objects:
        if c.parent == parent:
            result.add(c)


proc byParentIt*(T: type CountrySubdivision, parent: string): CountrySubdivision =
    for c in data.objects:
        if c.parent == parent:
            yield c


iterator findIt*(t: type CountrySubdivision, predicate: FindCountrySubdivisionPredicateProc): CountrySubdivision =
    for item in data.objects:
        if predicate(item):
            yield item


proc findFirst*(t: type CountrySubdivision, predicate: FindCountrySubdivisionPredicateProc): Option[CountrySubdivision] =
    for item in data.objects:
        if predicate(item):
            return some(item)