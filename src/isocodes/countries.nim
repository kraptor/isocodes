# Copyright (c) 2021 kraptor
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

import jsony
import options
export options

import private/utils


type
    Country* = object
        name*: string
        alpha_2*: string
        alpha_3*: string
        numeric*: string
        official_name*: string
        common_name*: string
        flag*: string

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


declareCount     Country, data.objects, count
declareAll       Country, data.objects, all
declareAllIt     Country, data.objects, allIt
declareOpt       Country, data.objects, byName, name
declareOpt       Country, data.objects, byAlpha2, alpha_2
declareOpt       Country, data.objects, byAlpha3, alpha_3
declareOpt       Country, data.objects, byNumeric, numeric
declareOpt       Country, data.objects, byOfficialName, official_name
declareOpt       Country, data.objects, byCommonName, common_name
declareFind      Country, data.objects, find, FindCountryPredicateProc
declareFindIt    Country, data.objects, findIt, FindCountryPredicateProc
declareFindFirst Country, data.objects, findFirst, FindCountryPredicateProc