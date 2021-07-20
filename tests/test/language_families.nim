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
    TOTAL_LANGUAGE_FAMILIES = 115

    suiteNameLanguageFamilies = when 
        defined(embedLanguageFamilies):
            "Language Families (embedded data)"
        else:
            "Language Families"


proc firstCharInNameIsE(c: LanguageFamily): bool =
    c.name.startsWith("E")


suite suiteNameLanguages:
    test "Can get count":
        check LanguageFamily.count() == TOTAL_LANGUAGE_FAMILIES

    test "Can get items":
        check LanguageFamily.all().len == TOTAL_LANGUAGE_FAMILIES

    test "Item not found":
        check LanguageFamily.byName("Narnia").isSome == false
        check LanguageFamily.byAlpha3("Narnia").isSome == false
        
    test "Find by name":
        let found = LanguageFamily.byName("Artificial languages")
        check found.isSome
        check found.get().alpha3 == "art"

    test "Find by alpha3":
        let found = LanguageFamily.byAlpha3("art")
        check found.isSome
        check found.get().name == "Artificial languages"

    test "Find by predicate (all)":
        let found = LanguageFamily.find(firstCharInNameIsE)
        check found.len > 0
        for c in found:
            check c.name.startsWith("E")

    test "Find by predicate (iterator)":
        var found = false
        for c in LanguageFamily.find(firstCharInNameIsE):
            check c.name.startsWith("E")
            found = true
        check found == true
        
    test "Find by predicate (first)":
        let found = LanguageFamily.findFirst(firstCharInNameIsE)
        check found.isSome
        check found.get().name.startsWith("E")
        
        