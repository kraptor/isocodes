# Copyright (c) 2021 kraptor
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

# Copyright (c) 2021 kraptor
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

{.warning[UnusedImport]: off.}

import unittest
import strutils
import options

import isocodes


const 
    TOTAL_LANGUAGES = 486

    suiteNameLanguages = when 
        defined(embedLanguages):
            "Languages (embedded data)"
        else:
            "Languages"


template test_greek(c: Option[Language]) =
    # "alpha_2": "el",
    # "alpha_3": "ell",
    # "bibliographic": "gre",
    # "name": "Greek, Modern (1453-)"
    check c.isSome
    check c.get().name == "Greek, Modern (1453-)"
    check c.get().alpha2 == "el"
    check c.get().alpha3 == "ell"
    check c.get().bibliographic == "gre"


proc firstCharInNameIsE(c: Language): bool =
    c.name.startsWith("E")


suite suiteNameLanguages:
    test "Can get count":
        check Language.count() == TOTAL_LANGUAGES

    test "Can get Languages":
        check Language.all().len == TOTAL_LANGUAGES

    test "Language not found":
        check Language.byName("Narnia").isSome == false
        check Language.byAlpha2("Narnia").isSome == false
        check Language.byAlpha3("Narnia").isSome == false
        check Language.byBibliographic("00000000").isSome == false
        check Language.byCommonName("Narnia").isSome == false

    test "Find by name":
        let found = Language.byName("Greek, Modern (1453-)")
        test_greek(found)

    test "Find by alpha2":
        let found = Language.byAlpha2("el")
        test_greek(found)

    test "Find by alpha3":
        let found = Language.byAlpha3("ell")
        test_greek(found)

    test "Find by bibliographic":
        let found = Language.byBibliographic("gre")
        test_greek(found)

    test "Find by common name":
        let found = Language.byCommonName("Bangla")
        check found.isSome
        check found.get().name == "Bengali"

    test "Find by predicate (all)":
        let found = Language.find(firstCharInNameIsE)
        check found.len > 0
        for c in found:
            check c.name.startsWith("E")

    test "Find by predicate (iterator)":
        var found = false
        for c in Language.find(firstCharInNameIsE):
            check c.name.startsWith("E")
            found = true
        check found == true
        
    test "Find by predicate (first)":
        let found = Language.findFirst(firstCharInNameIsE)
        check found.isSome
        check found.get().name.startsWith("E")
        
        