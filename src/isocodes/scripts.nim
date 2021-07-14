# Copyright (c) 2021 kraptor
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

import jsony
import options
export options

import private/utils


type
    Script* = object
        name*: string
        alpha_4*: string
        numeric*: string
        
    Scripts* = object
        objects: seq[Script]

    FindScriptPredicateProc* = proc(c: Script): bool


proc renameHook*(v: var Scripts, fieldname: var string) =
    if fieldname == "15924":
        fieldname = "objects"


const
    embedScripts   {.booldefine.} = true
    useScriptsFile {.strdefine.}  = "resources/iso_15924.json"


when embedScripts:
    const data = fromJson(staticRead useScriptsFile, Scripts)
when not embedScripts:
    let data = fromJson(readFile useScriptsFile, Scripts)


declareCount     Script, data.objects, count
declareAll       Script, data.objects, all
declareAllIt     Script, data.objects, allIt
declareOpt       Script, data.objects, byName, name
declareOpt       Script, data.objects, byAlpha4, alpha_4
declareOpt       Script, data.objects, byNumeric, numeric
declareFind      Script, data.objects, find, FindScriptPredicateProc
declareFindIt    Script, data.objects, findIt, FindScriptPredicateProc
declareFindFirst Script, data.objects, findFirst, FindScriptPredicateProc