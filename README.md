# Codify

[![Build Status](https://travis-ci.org/rafaqz/Codify.jl.svg?branch=master)](https://travis-ci.org/rafaqz/Codify.jl)
[![codecov.io](http://codecov.io/github/rafaqz/Codify.jl/coverage.svg?branch=master)](http://codecov.io/github/rafaqz/Codify.jl?branch=master)


Codify converts julia structs to the code for their keyword-argument
constructor, using `codify(x)`. This returns a string of julia code to rebuild 
the struct from a script, a more user friendly alternative than saving a `.jld` file.


It uses `flattenable` from FieldMetadata.jl to select witch fields to include in
the code (all by default). It's is intended for use with structs where Flatten.jl 
is already used to flatten models for optimiser, or a live interface
that changes their field values. 



`codify(x)` assumes that all nested structs have keyword constructors with at
least the same keywords as the flattenable field names. Using FieldDefaults.jl
or Parameters.jl are easy ways to achieve this.


It works with basic types like `Number`, `Symbol` and `Nothing` and
Unitful.jl units, and structs or tuple nested to any depth.
If you need additional types to be converted to code text, you can define:

```julia
Codify.codify(x::TheType, space) = ("the code",)
```

And yes, the code needs to be wrapped in a tuple, so that empty fields can be splatted away. 
You don't have to add the nesting `space` manually to your code output, it's added at the struct level,
but needs to be passed through to every field in case they too are structs.
