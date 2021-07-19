# Copyright (c) 2021 kraptor
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

import jsony
import options
export options

import private/utils


type
    Currency* = object
        alpha_3*: string
        name*: string
        numeric*: string
        

    Currencies* = object
        objects: seq[Currency]

    FindCurrencyPredicateProc* = proc(c: Currency): bool


proc renameHook*(v: var Currencies, fieldname: var string) =
    if fieldname == "4217":
        fieldname = "objects"


const
    embedCurrencies   {.booldefine.} = true
    useCurrenciesFile {.strdefine.}  = "resources/iso_4217.json"


when embedCurrencies:
    const data = fromJson(staticRead useCurrenciesFile, Currencies)
when not embedCurrencies:
    let data = fromJson(readFile useCurrenciesFile, Currencies)


declareCount     Currency, data.objects, count
declareAll       Currency, data.objects, all
declareAllIt     Currency, data.objects, allIt
declareOpt       Currency, data.objects, byName, name
declareOpt       Currency, data.objects, byAlpha3, alpha_3
declareOpt       Currency, data.objects, byNumeric, numeric
declareFind      Currency, data.objects, find, FindCurrencyPredicateProc
declareFindIt    Currency, data.objects, findIt, FindCurrencyPredicateProc
declareFindFirst Currency, data.objects, findFirst, FindCurrencyPredicateProc