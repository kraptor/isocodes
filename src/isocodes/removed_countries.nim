# Copyright (c) 2021 kraptor
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

import jsony
import options
export options

import private/utils


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


declareCount     RemovedCountry, data.objects, count
declareAll       RemovedCountry, data.objects, all
declareAllIt     RemovedCountry, data.objects, allIt
declareOpt       RemovedCountry, data.objects, byName, name
declareOpt       RemovedCountry, data.objects, byAlpha2, alpha_2
declareOpt       RemovedCountry, data.objects, byAlpha3, alpha_3
declareOpt       RemovedCountry, data.objects, byAlpha4, alpha_4
declareOpt       RemovedCountry, data.objects, byNumeric, numeric
declareSeq       RemovedCountry, data.objects, byWithdrawalDate, withdrawal_date
declareIt        RemovedCountry, data.objects, byWithdrawalDateIt, withdrawal_date
declareFind      RemovedCountry, data.objects, find, FindRemovedCountryPredicateProc
declareFindIt    RemovedCountry, data.objects, findIt, FindRemovedCountryPredicateProc
declareFindFirst RemovedCountry, data.objects, findFirst, FindRemovedCountryPredicateProc


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