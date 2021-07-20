# Copyright (c) 2021 kraptor
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

import jsony
import options
export options

import private/utils


type
    LanguageFamily* = object
        alpha_3*: string
        name*: string

    LanguageFamilies* = object
        objects: seq[LanguageFamily]

    FindLanguageFamilyPredicateProc* = proc(c: LanguageFamily): bool


proc renameHook*(v: var LanguageFamilies, fieldname: var string) =
    if fieldname == "639-5":
        fieldname = "objects"


const
    embedLanguageFamilies   {.booldefine.} = true
    useLanguageFamiliesFile {.strdefine.}  = "resources/iso_639-5.json"


when embedLanguageFamilies:
    const data = fromJson(staticRead useLanguageFamiliesFile, LanguageFamilies)
when not embedLanguageFamilies:
    let data = fromJson(readFile useLanguageFamiliesFile, LanguageFamilies)


declareCount     LanguageFamily, data.objects, count
declareAll       LanguageFamily, data.objects, all
declareAllIt     LanguageFamily, data.objects, allIt
declareOpt       LanguageFamily, data.objects, byName, name
declareOpt       LanguageFamily, data.objects, byAlpha3, alpha_3
declareFind      LanguageFamily, data.objects, find, FindLanguageFamilyPredicateProc
declareFindIt    LanguageFamily, data.objects, findIt, FindLanguageFamilyPredicateProc
declareFindFirst LanguageFamily, data.objects, findFirst, FindLanguageFamilyPredicateProc