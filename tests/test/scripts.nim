# Copyright (c) 2021 kraptor
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

{.warning[UnusedImport]: off.}

import unittest
import isocodes
import strutils
import options


const 
    TOTAL_SCRIPTS = 182

    suiteNameScripts = when 
        defined(embedScripts):
            "Scripts (embedded data)"
        else:
            "Scripts"


template test_adlam(c: Option[Script]) =
    check c.isSome
    check c.get().name == "Adlam"
    check c.get().alpha4 == "Adlm"
    check c.get().numeric == "166"


proc firstCharInNameIsE(c: Script): bool =
    c.name.startsWith("E")


suite suiteNameScripts:
    test "Can get count":
        check Script.count() == TOTAL_SCRIPTS

    test "Can get Scripts":
        check Script.all().len == TOTAL_SCRIPTS

    test "Script not found":
        check Script.byName("Narnia").isSome == false
        check Script.byAlpha4("Narnia").isSome == false
        check Script.byNumeric("00000000").isSome == false
        
    test "Find by name":
        let found = Script.byName("Adlam")
        test_adlam(found)

    test "Find by alpha4":
        let found = Script.byAlpha4("Adlm")
        test_adlam(found)
    
    test "Find by numeric":
        let found = Script.byNumeric("166")
        test_adlam(found)
    
    test "Find by predicate (all)":
        let found = Script.find(firstCharInNameIsE)
        check found.len > 0
        for c in found:
            check c.name.startsWith("E")

    test "Find by predicate (all)":
        var found = false
        for c in Script.findIt(firstCharInNameIsE):
            check c.name.startsWith("E")
            found = true
        check found
        
    test "Find by predicate (first)":
        let found = Script.findFirst(firstCharInNameIsE)
        check found.isSome
        check found.get().name.startsWith("E")
        
        