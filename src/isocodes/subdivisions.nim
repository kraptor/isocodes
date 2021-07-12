# Copyright (c) 2021 kraptor
#
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

import jsony
import options
export options

import private/utils

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


declareCount  CountrySubdivision, data.objects, count
declareAll    CountrySubdivision, data.objects, all
declareAllIt  CountrySubdivision, data.objects, allIt
declareOpt    CountrySubdivision, data.objects, byCode, code
declareSeq    CountrySubdivision, data.objects, byName, name
declareIt     CountrySubdivision, data.objects, byNameIt, name
declareSeq    CountrySubdivision, data.objects, byType, `type`
declareIt     CountrySubdivision, data.objects, byTypeIt, `type`
declareSeq    CountrySubdivision, data.objects, byParent, parent
declareIt     CountrySubdivision, data.objects, byParentIt, parent
declareFind   CountrySubdivision, data.objects, find, FindCountrySubdivisionPredicateProc
declareFindIt CountrySubdivision, data.objects, findIt, FindCountrySubdivisionPredicateProc


proc byCountryCode*(T: type CountrySubdivision, country_code: string): seq[CountrySubdivision] =
    for c in data.objects:
        if c.code.split("-")[0] == country_code:
            result.add(c)


iterator byCountryCodeIt*(T: type CountrySubdivision, country_code: string): CountrySubdivision =
    for c in data.objects:
        if c.code.split("-")[0] == country_code:
            yield c


proc byCodeStart*(T: type CountrySubdivision, code_start: string): seq[CountrySubdivision] =
    for c in data.objects:
        if c.code.startsWith(code_start):
            result.add(c)


iterator byCodeStartIt*(T: type CountrySubdivision, code_start: string): CountrySubdivision =
    for c in data.objects:
        if c.code.startsWith(code_start):
            yield c