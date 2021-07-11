# Copyright (c) 2021 kraptor
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

import jsony
import options
export options

type
    RemovedCountry* = object
        name*: string
        alpha_2*: string
        alpha_3*: string
        alpha_4*: string
        numeric*: string
        comment*: string
        withdrawal_date*: string

    RemovedCountries* = object
        objects: seq[RemovedCountry]

    FindRemovedCountryPredicateProc* = proc(c: RemovedCountry): bool


proc renameHook*(v: var RemovedCountries, fieldname: var string) =
    if fieldname == "3166-3":
        fieldname = "objects"


const
    embedRemovedCountries   {.booldefine.} = true
    useRemovedCountriesFile {.strdefine.}  = "resources/iso_3166-3.json"


when embedRemovedCountries:
    const data = fromJson(staticRead useRemovedCountriesFile, RemovedCountries)
when not embedRemovedCountries:
    let data = fromJson(readFile useRemovedCountriesFile, RemovedCountries)


proc count*(T: type RemovedCountry): Natural = 
    return data.objects.len()


proc all*(T: type RemovedCountry): seq[RemovedCountry] =
    return data.objects


iterator allIt*(T: type RemovedCountry): RemovedCountry =
    for c in data.objects:
        yield c


proc byName*(T: type RemovedCountry, name: string): Option[RemovedCountry] =
    for c in data.objects:
        if c.name == name:
            return some(c)


proc byAlpha2*(T: type RemovedCountry, value: string): Option[RemovedCountry] =
    for c in data.objects:
        if c.alpha_2 == value:
            return some(c)


proc byAlpha3*(T: type RemovedCountry, value: string): Option[RemovedCountry] =
    for c in data.objects:
        if c.alpha_3 == value:
            return some(c)


proc byAlpha4*(T: type RemovedCountry, value: string): Option[RemovedCountry] =
    for c in data.objects:
        if c.alpha_4 == value:
            return some(c)


proc byNumeric*(T: type RemovedCountry, value: string): Option[RemovedCountry] =
    for c in data.objects:
        if c.numeric == value:
            return some(c)


proc byWithdrawalDate*(T: type RemovedCountry, value: string): seq[RemovedCountry] =
    for c in data.objects:
        if c.withdrawal_date == value:
            result.add(c)


iterator byWithdrawalDateIt*(T: type RemovedCountry, value: string): RemovedCountry =
    for c in data.objects:
        if c.withdrawal_date == value:
            yield c


proc byWithdrawalYear*(T: type RemovedCountry, year: string): seq[RemovedCountry] =
    for c in data.objects:
        let wd = c.withdrawal_date
        if wd.len >= 4 and wd[0 .. 3] == year:
            result.add(c)


iterator byWithdrawalYearIt*(T: type RemovedCountry, year: string): RemovedCountry =
    for c in data.objects:
        let wd = c.withdrawal_date
        if wd.len >= 4 and wd[0 .. 3] == year:
            yield c


proc find*(T: type RemovedCountry, predicate: FindRemovedCountryPredicateProc): seq[RemovedCountry] =
    for item in data.objects:
        if predicate(item):
            result.add(item)


iterator findIt*(t: type RemovedCountry, predicate: FindRemovedCountryPredicateProc): RemovedCountry =
    for item in data.objects:
        if predicate(item):
            yield item


proc findFirst*[T: RemovedCountry](t: type T, predicate: FindRemovedCountryPredicateProc): Option[T] =
    for item in data.objects:
        if predicate(item):
            return some(item)