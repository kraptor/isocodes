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

import iso_codes


const 
    TOTAL_SUBDIVISIONS = 4883

    suiteNameSubdivisions = when 
        defined(embedCountries):
            "Country subdivisions (embedded data)"
        else:
            "Country subdivisions"


suite suiteNameSubdivisions:
    test "Can get count":
        check CountrySubdivision.count() == TOTAL_SUBDIVISIONS

    test "Can get subdivisions":
        check CountrySubdivision.all().len == TOTAL_SUBDIVISIONS

    test "Subdivions not found":
        check CountrySubdivision.byName("Narnia").len == 0
        check CountrySubdivision.byCode("Narnia").isSome == false
        check CountrySubdivision.byType("Narnia").len == 0
        check CountrySubdivision.byParent("Narnia").len == 0
        # check CountrySubdivision.byNameIt("Narnia").seq().len == 0

    test "Find by code":
        let found = CountrySubdivision.byCode("AL-01")
        check found.isSome
        check found.get().code == "AL-01"

    test "Find by code (start)":
        let found = CountrySubdivision.byCodeStart("AL")
        check found.len > 0
        for item in found:
            check item.code.startsWith("AL")

    test "Find by code (start + iterator)":
        for item in CountrySubdivision.byCodeStartIt("AL"):
            check item.code.startsWith("AL")

    test "Find by name (seq)":
        let found = CountrySubdivision.byName("Berat")
        check found.len > 0
        for item in found:
            check item.name == "Berat"

    test "Find by name (iterator)":
        var found = false
        for item in CountrySubdivision.byNameIt("Berat"):
            check item.name == "Berat"
            found = true
        check found

    test "Find by type (seq)":
        let found = CountrySubdivision.byType("County")
        check found.len > 0
        for item in found:
            check item.`type` == "County"

    test "Find by type (iterator)":
        var found = false
        for item in CountrySubdivision.byTypeIt("County"):
            check item.`type` == "County"
            found = true
        check found

    test "Find by parent code (seq)":
        var found = CountrySubdivision.byParent("01")
        check found.len > 0
        for item in found:
            check item.parent == "01"

    test "Find by parent code (iterator)":
        var found = false
        for item in CountrySubdivision.byParent("01"):
            check item.parent == "01"
            found = true
        check found