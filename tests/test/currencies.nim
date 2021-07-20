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
    TOTAL_CURRENCIES = 170

    suiteNameCurrencies = when 
        defined(embedCurrencies):
            "Currencies (embedded data)"
        else:
            "Currencies"


template test_euro(c: Option[Currency]) =
    check c.isSome
    check c.get().name == "Euro"
    check c.get().alpha3 == "EUR"
    check c.get().numeric == "978"


proc firstCharInNameIsE(c: Currency): bool =
    c.name.startsWith("E")


suite suiteNameCurrencies:
    test "Can get count":
        check Currency.count() == TOTAL_CURRENCIES

    test "Can get items":
        check Currency.all().len == TOTAL_CURRENCIES

    test "Item not found":
        check Currency.byName("Narnia").isSome == false
        check Currency.byAlpha3("Narnia").isSome == false
        check Currency.byNumeric("00000000").isSome == false
        
    test "Find by name":
        let found = Currency.byName("Euro")
        test_euro(found)

    test "Find by alpha3":
        let found = Currency.byAlpha3("EUR")
        test_euro(found)

    test "Find by numeric":
        let found = Currency.byNumeric("978")
        test_euro(found)

    test "Find by predicate (all)":
        let found = Currency.find(firstCharInNameIsE)
        check found.len > 0
        for c in found:
            check c.name.startsWith("E")

    test "Find by predicate (iterator)":
        var found = false
        for c in Currency.find(firstCharInNameIsE):
            check c.name.startsWith("E")
            found = true
        check found == true
        
    test "Find by predicate (first)":
        let found = Currency.findFirst(firstCharInNameIsE)
        check found.isSome
        check found.get().name.startsWith("E")
        
        