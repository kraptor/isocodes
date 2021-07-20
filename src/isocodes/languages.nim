# Copyright (c) 2021 kraptor
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

import jsony
import options
export options

import private/utils


type
    Language* = object
        alpha_3*: string
        name*: string
        alpha_2*: string
        bibliographic*: string
        common_name*: string

    Languages* = object
        objects: seq[Language]

    FindLanguagePredicateProc* = proc(c: Language): bool


proc renameHook*(v: var Languages, fieldname: var string) =
    if fieldname == "639-2":
        fieldname = "objects"


const
    embedLanguages   {.booldefine.} = true
    useLanguagesFile {.strdefine.}  = "resources/iso_639-2.json"


when embedLanguages:
    const data = fromJson(staticRead useLanguagesFile, Languages)
when not embedLanguages:
    let data = fromJson(readFile useLanguagesFile, Languages)


declareCount     Language, data.objects, count
declareAll       Language, data.objects, all
declareAllIt     Language, data.objects, allIt
declareOpt       Language, data.objects, byName, name
declareOpt       Language, data.objects, byAlpha2, alpha_2
declareOpt       Language, data.objects, byAlpha3, alpha_3
declareOpt       Language, data.objects, byBibliographic, bibliographic
declareOpt       Language, data.objects, byCommonName, common_name
declareFind      Language, data.objects, find, FindLanguagePredicateProc
declareFindIt    Language, data.objects, findIt, FindLanguagePredicateProc
declareFindFirst Language, data.objects, findFirst, FindLanguagePredicateProc