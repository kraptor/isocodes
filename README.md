<!--
 Copyright (c) 2021 kraptor
 
 This software is released under the MIT License.
 https://opensource.org/licenses/MIT
-->

[![made-with-nim](https://img.shields.io/badge/Made%20with-Nim-ffc200.svg)](https://nim-lang.org/) ![Build](https://github.com/kraptor/isocodes/workflows/Build/badge.svg)

# `isocodes`

ISO codes for Nim that allows to embed the data within the executable (or load 
them automatically at runtime).

Provides the utility `isocodes_download` to download latest JSON packages when
you don't want to use the provided ones (or if they become obsolete).


## Supported ISO standards

- ISO 3166-1 (countries)
- ISO 3166-2 (country subdivisions)
- ISO 3166-3 (removed countries)

## Example

```nim
    import isocodes

    if isMainModule:
        for c in Country.allIt():
            echo c.name
```

## API

All procedures/iterators can be accessed by using the corresponding type.
For example: `Country`.

Procedures either return an `Option[T]` object or a `seq[T]` (when multiple
values can be requested).

> **IMPORTANT**: Procedures ending in `It` return an iterator, instead of a
`seq[T]`, if you don't want to store/build a copy of the data requested.

### Country API

#### Country Attributes

The following attributes are available for each `Country` instance:

| Attribute | Description |
|-|-|
|`name`         | country name.                   |
|`official_name`| official name of the country.   |
|`common_name`  | common name for the country.    |
|`alpha_2`      | country ISO code (2 characters).|
|`alpha_3`      | country ISO code (3 characters).|
|`numeric`      | numeric code for the country. **NOTE**: this is a string. |

#### Country Procedures

| Procedure | Description |
|-|-|
|`.count()`            | Number of countries                                      |
|`.all()`              | `seq` for all countries.                                 |
|`.allIt()`            | Iterator for all countries.                              |
|`.byName(str)`        | `Option[Country]` with the specified name.               |
|`.byAlpha2(str)`      | `Option[Country]` with the specified alpha2 code.        |
|`.byAlpha3(str)`      | `Option[Country]` with the specified alpha3 code.        |
|`.byNumeric(str)`     | `Option[Country]` with the specified numeric code.       |
|`.byOfficialName(str)`| `Option[Country]` with the specified official name.      |
|`.byCommonName(str)`  | `Option[Country]` with the specified common name.        |
|`.find(proc)`         | `seq` for all countries that proc evaluates to `true`.   |
|`.findIt(proc)`       | Iterator for all countries that proc evaluates to `true`.|
|`.findFirst(proc)`    | `Option[Country]` were proc evaluates to `true`.         |

### CountrySubdivision API

#### CountrySubdivision Attributes

| Attribute | Description |
|-|-|
|`code`   | Subdivision code.               |
|`name`   | Name of the subdivision.        |
|`type`   | Type of the subdivision.<br />**NOTE**: use [stropping](https://en.wikipedia.org/wiki/Nim_%28programming_language%29#Stropping) to access this field because type is a reserved word.<br />Example: ``echo subdivision.`type` ``.|
|`parent` | Parent code.|

#### CountrySubdivision Procedures

| Procedure | Description |
|-|-|
|`.count()`             | Number of subdivisions                                      |
|`.all()`               | `seq` for all subdivisions.                                 |
|`.allIt()`             | Iterator for all subdivisions.                              |
|`.byCountryCode(str)`  | `seq` for subdivisions for an specific country code.        |
|`.byCountryCodeIt(str)`| Iterator for subdivisions for an specific country code.     |
|`.byCode(str)`         | `seq` for subdivisions by specified code.                   |
|`.byCodeIt(str)`       | Iterator for subdivisions specified by code.                |
|`.byCodeStart(str)`    | `seq` for subdivisions where code starts by a value.        |
|`.byCodeStartIt(str)`  | Iterator subdivisions where code starts by a value.         |
|`.byName(str)`         | `seq` for subdivisions with specified name.                 |
|`.byNameIt(str)`       | Iterator for subdivisions with specified name.              |
|`.byType(str)`         | `seq` for subdivisions with the specified type.             |
|`.byTypeIt(str)`       | Iterator for subdivisions with the specified type.          |
|`.byParent(str)`       | `seq` for subdivisions with the specified parent value.     |
|`.byParentIt(str)`     | Iterator for subdivisions with the specified parent value.  |
|`.findIt(proc)`        | Iterator for all subdivisions that proc evaluates to `true`.|
|`.findFirst(proc)`     | `Option[CountrySubdivision]` were proc evaluates to `true`. |

## RemovedCountry API

#### RemovedCountry Attributes

| Attribute | Description |
|-|-|
|`name`           | country name.                    |
|`official_name`  | official name of the country.    |
|`alpha_2`        | country ISO code (2 characters). |
|`alpha_3`        | country ISO code (3 characters). |
|`alpha_4`        | country ISO code (4 characters). |
|`numeric`        | numeric code for the country. <br/> **NOTE**: this is a string.|
|`comment`        | comment about the country.       |
|`withdrawal_date`| date of withdrawal (format: YYYY or YYYY-MM-DD) <br/> **NOTE**: this is a string.|

#### RemovedCountry Procedures

| Procedure | Description |
|-|-|
|`.count()`               | Number of countries                                      |
|`.all()`                 | `seq` for all countries.                                 |
|`.allIt()`               | Iterator for all countries.                              |
|`.byName(str)`           | `Option[Country]` with the specified name.               |
|`.byAlpha2(str)`         | `Option[Country]` with the specified alpha2 code.        |
|`.byAlpha3(str)`         | `Option[Country]` with the specified alpha3 code.        |
|`.byAlpha4(str)`         | `Option[Country]` with the specified alpha4 code.        |
|`.byNumeric(str)`        | `Option[Country]` with the specified numeric code.       |
|`.byNumeric(str)`        | `Option[Country]` with the specified numeric code.       |
|`.byWithdrawalDate(str)`  | `seq` for all countries with specified date.             |
|`.byWithdrawalDateIt(str)`| Iterator all countries with specified date.              |
|`.byWithdrawalYear(str)`  | `seq` for all countries with specified year.             |
|`.byWithdrawalYearIt(str)`| Iterator all countries with specified year.              |
|`.find(proc)`            | `seq` for all countries that proc evaluates to `true`.   |
|`.findIt(proc)`          | Iterator for all countries that proc evaluates to `true`.|
|`.findFirst(proc)`       | `Option[Country]` were proc evaluates to `true`.         |

## Compilation flags

With the following flags it's possible to embed the data (or not) and specify the JSON
file to embed/load. This could be useful if the provided files are outdated and you want
to provide your own files.

| flag | comment |
|-|-|
|`-d:embedCountries=true`         | Embed countries data within the executable.        |
|`-d:embedCountries=false`        | Load countries data at runtime.                    |
|`-d:embedSubdivisions=true`      | Embed subdivisions data within the executable.     |
|`-d:embedSubdivisions=false`     | Load subdivisions data at runtime.                 |
|`-d:embedRemovedCountries=true`  | Embed removed countries data within the executable.|
|`-d:embedRemovedCountries=false` | Load removed countries data at runtime.            |
|`-d:useCountriesFile=PATH`       | Use a specific countries JSON file.                |
|`-d:useSubdivisionsFile=PATH`    | Use a specific subdivisions JSON file.             |
|`-d:useRemovedCountriesFile=PATH`| Use a specific subdivisions JSON file.             |

## Source

The ISO codes JSON files are synced verbatim from Debian's `iso-codes`
repository here:

- https://salsa.debian.org/iso-codes-team/iso-codes/
