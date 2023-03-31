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
    TOTAL_REMOVED_COUNTRIES = 31

    suiteNameRemovedCountries = when 
        defined(embedRemovedCountries):
            "Removed Countries (embedded data)"
        else:
            "Removed Countries"


template test_afi(c: RemovedCountry) =
    check c.name == "French Afars and Issas"
    check c.alpha2 == "AI"
    check c.alpha3 == "AFI"
    check c.alpha4 == "AIDJ"
    check c.numeric == "262"
    check c.withdrawal_date == "1977"


template test_afi_option(c: Option[RemovedCountry]) =
    check c.isSome
    test_afi(c.get()) 


proc firstCharInNameIsB(c: RemovedCountry): bool =
    c.name.startsWith("B")


suite suiteNameRemovedCountries:
    test "Can get count":
        check RemovedCountry.count() == TOTAL_REMOVED_COUNTRIES

    test "Can get items":
        check RemovedCountry.all().len == TOTAL_REMOVED_COUNTRIES

    test "Item not found":
        check RemovedCountry.byName("Narnia").isSome == false
        check RemovedCountry.byAlpha2("Narnia").isSome == false
        check RemovedCountry.byAlpha3("Narnia").isSome == false
        check RemovedCountry.byAlpha4("Narnia").isSome == false
        check RemovedCountry.byNumeric("00000000").isSome == false
        check RemovedCountry.byWithdrawalDate("0000").len == 0
        
    test "Find by name":
        let found = RemovedCountry.byName("French Afars and Issas")
        test_afi_option(found)

    test "Find by alpha2":
        let found = RemovedCountry.byAlpha2("AI")
        test_afi_option(found)

    test "Find by alpha3":
        let found = RemovedCountry.byAlpha3("AFI")
        test_afi_option(found)

    test "Find by alpha4":
        let found = RemovedCountry.byAlpha4("AIDJ")
        test_afi_option(found)

    test "Find by numeric":
        let found = RemovedCountry.byNumeric("262")
        test_afi_option(found)

    test "Find by withdrawal date":
        let found = RemovedCountry.byWithdrawalDate("1977")
        test_afi(found[0])

    test "Find by withdrawal date (iterator)":
        for c in RemovedCountry.byWithdrawalDateIt("1977"):
            test_afi(c)
            break

    test "Find by withdrawal year":
        let found = RemovedCountry.byWithdrawalYear("1993")
        check found.len == 2

    test "Find by withdrawal date (iterator)":
        var count = 0
        for c in RemovedCountry.byWithdrawalYearIt("1993"):
            inc count
        check count == 2
    
    test "Find by predicate (all)":
        let found = RemovedCountry.find(firstCharInNameIsB)
        check found.len > 0
        for c in found:
            check c.name.startsWith("B")

    test "Find by predicate (iterator)":
        var found = false
        for c in RemovedCountry.find(firstCharInNameIsB):
            check c.name.startsWith("B")
            found = true
        check found == true
        
    test "Find by predicate (first)":
        let found = RemovedCountry.findFirst(firstCharInNameIsB)
        check found.isSome
        check found.get().name.startsWith("B")
        
        