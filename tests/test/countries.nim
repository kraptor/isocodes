# Copyright (c) 2021 kraptor
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

{.warning[UnusedImport]: off.}

import unittest
import iso_codes
import strutils


const 
    TOTAL_COUNTRIES = 249

    suiteNameCountries = when 
        defined(embedCountries):
            "Countries (embedded data)"
        else:
            "Countries"


template test_aruba(c: Option[Country]) =
    check c.isSome
    check c.get().name == "Aruba"
    check c.get().alpha2 == "AW"
    check c.get().alpha3 == "ABW"
    check c.get().numeric == "533"


proc firstCharInNameIsE(c: Country): bool =
    c.name.startsWith("E")


suite suiteNameCountries:
    test "Can get count":
        check Country.count() == TOTAL_COUNTRIES

    test "Can get countries":
        check Country.all().len == TOTAL_COUNTRIES

    test "Country not found":
        check Country.byName("Narnia").isSome == false
        check Country.byAlpha2("Narnia").isSome == false
        check Country.byAlpha3("Narnia").isSome == false
        check Country.byNumeric("00000000").isSome == false
        check Country.byOfficialName("Narnia").isSome == false
        check Country.byCommonName("Narnia").isSome == false

    test "Find by name":
        let found = Country.byName("Aruba")
        test_aruba(found)

    test "Find by alpha2":
        let found = Country.byAlpha2("AW")
        test_aruba(found)

    test "Find by alpha3":
        let found = Country.byAlpha3("ABW")
        test_aruba(found)

    test "Find by numeric":
        let found = Country.byNumeric("533")
        test_aruba(found)

    test "Find by official name":
        let found = Country.byOfficialName("Republic of Angola")
        check found.isSome
        check found.get().name == "Angola"

    test "Find by common name":
        let found = Country.byCommonName("Bolivia")
        check found.isSome
        check found.get().alpha_2 == "BO"

    test "Find by predicate (all)":
        let found = Country.find(firstCharInNameIsE)
        check found.len > 0
        for c in found:
            check c.name.startsWith("E")
        
    test "Find by predicate (first)":
        let found = Country.findFirst(firstCharInNameIsE)
        check found.isSome
        check found.get().name.startsWith("E")
        
        