# Copyright (c) 2021 kraptor
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

import jsony
import options
export options

type
    Country* = object
        name*: string
        alpha_2*: string
        alpha_3*: string
        numeric*: string
        official_name*: string
        common_name*: string

    Countries* = object
        objects: seq[Country]

    FindCountryPredicateProc* = proc(c: Country): bool


proc renameHook*(v: var Countries, fieldname: var string) =
    if fieldname == "3166-1":
        fieldname = "objects"


const
    embedCountries   {.booldefine.} = true
    useCountriesFile {.strdefine.}  = "resources/iso_3166-1.json"


when embedCountries:
    const data = fromJson(staticRead useCountriesFile, Countries)
when not embedCountries:
    let data = fromJson(readFile useCountriesFile, Countries)


proc count*(T: type Country): Natural = 
    return data.objects.len()


proc all*(T: type Country): seq[Country] =
    return data.objects


iterator allIt*(T: type Country): Country =
    for c in data.objects:
        yield c


proc byName*(T: type Country, name: string): Option[Country] =
    for c in data.objects:
        if c.name == name:
            return some(c)


proc byAlpha2*(T: type Country, value: string): Option[Country] =
    for c in data.objects:
        if c.alpha_2 == value:
            return some(c)


proc byAlpha3*(T: type Country, value: string): Option[Country] =
    for c in data.objects:
        if c.alpha_3 == value:
            return some(c)


proc byNumeric*(T: type Country, value: string): Option[Country] =
    for c in data.objects:
        if c.numeric == value:
            return some(c)


proc byOfficialName*(T: type Country, name: string): Option[Country] =
    for c in data.objects:
        if c.official_name == name:
            return some(c)


proc byCommonName*(T: type Country, name: string): Option[Country] =
    for c in data.objects:
        if c.common_name == name:
            return some(c)


proc find*(T: type Country, predicate: FindCountryPredicateProc): seq[Country] =
    for item in data.objects:
        if predicate(item):
            result.add(item)


iterator findIt*(t: type Country, predicate: FindCountryPredicateProc): Country =
    for item in data.objects:
        if predicate(item):
            yield item


proc findFirst*[T: Country](t: type T, predicate: FindCountryPredicateProc): Option[T] =
    for item in data.objects:
        if predicate(item):
            return some(item)