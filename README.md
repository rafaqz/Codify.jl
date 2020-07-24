# Codify

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
