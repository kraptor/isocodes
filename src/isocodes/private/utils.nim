# Copyright (c) 2021 kraptor
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

import macros
import options


macro declareCount*(T: type, data: untyped, procname: untyped) =
    quote do:
        proc `procname`*(U: type `T`): Natural =
            return `data`.len()

macro declareAll*(T: type, data: untyped, procname: untyped) =
    quote do:
        proc `procname`*(U: type `T`): seq[`T`] = `data`


macro declareAllIt*(T: type, data: untyped, itname: untyped) =
    quote do:
        iterator `itname`*(U: type `T`): `T` =
            for x in `data`:
                yield x


macro declareOpt*(T: type, data: untyped, procname: untyped, field: untyped) =
    quote do:
        proc `procname`*(U: type `T`, name: string): Option[`T`] =
            for c in `data`:
                if c.`field` == name:
                    return some(c)


macro declareSeq*(T: type, data: untyped, procname: untyped, field: untyped) =
    quote do:
        proc `procname`*(U: type `T`, value: string): seq[`T`] =
            for x in `data`:
                if x.`field` == value:
                    result.add(x)


macro declareIt*(T: type, data: untyped, procname: untyped, field: untyped) =
    quote do:
        iterator `procname`*(U: type `T`, value: string): `T` =
            for x in `data`:
                if x.`field` == value:
                    yield x


macro declareFind*(T: type, data: untyped, procname: untyped, ProcType: type) =
    quote do:
        proc `procname`*(U: type `T`, predicate: `ProcType`): seq[`T`] =
            for x in `data`:
                if predicate(x):
                    result.add(x)

macro declareFindIt*(T: type, data: untyped, procname: untyped, ProcType: type) =
    quote do:
        iterator `procname`*(U: type `T`, predicate: `ProcType`): seq[`T`] =
            for x in `data`:
                if predicate(x):
                    yield x


macro declareFindFirst*(T: type, data: untyped, procname: untyped, ProcType: type) =
    quote do:
        proc `procname`*(U: type `T`, predicate: `ProcType`): Option[`T`] =
            for x in `data`:
                if predicate(x):
                    return some(x)