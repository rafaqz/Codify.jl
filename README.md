# Codify

[![Build Status](https://travis-ci.org/rafaqz/Codify.jl.svg?branch=master)](https://travis-ci.org/rafaqz/Codify.jl)
[![codecov.io](http://codecov.io/github/rafaqz/Codify.jl/coverage.svg?branch=master)](http://codecov.io/github/rafaqz/Codify.jl?branch=master)


Codify converts julia structs to the code for their keyword-argument
constructor. It works with basic types like Number, Symbol and Nothing and
Unitful.jl units, and structs or tuple nested to any depth.

It uses `flattenable` from FieldMetadata.jl, and is intended for use with
structs where Flatten.jl is used in conjuction with an optimiser or an interface
that changes their field values. Using `codify(x)` returns julia code to rebuild
the struct from a script, a more user friendly alternative than saving a `.jld`
file.

`codify(x)` assumes that all nested structs have keyword constructors with at
least the same keywords as the flattenable field names. Using FieldDefaults.jl
or Parameters.jl are easy ways to achieve this.

If you need additional types to be converted to code text, you can define:

```julia
Codify.codify(x::TheType, space) = ("the code",)
```

And yes, the code needs to be in a tuple, so that empty fields can be splatted away. You don't have to
add the nesting `space` manually to your code output, it's added at the struct level.
