# Codify

Codify converts julia structs to a string of the code for their constructor.
It works with basic types like Number, Symbol and Nothing and Unitful units, and structs or tuple
nested to any depth.

It uses `flattenable` from FieldMetadata.jl, and is intended for use with structs where Flatten.jl is 
used in conjuction with an optimiser or an interface that changes their field values. Using `codify(x)`
gives julia code to rebuild the struct from a script, a more user friendly alternative than saving a `.jld` file.

`codify(x)` assumes that all nested structs have keyword constructors with the same keywords as the fieldnames.
Using FieldDefaults.jl or Parameters.jl are easy ways to acheive this. Fields that are not flattenable will 
need a default constructor. But if these fields are preassigned memory or similar, that is what you want.
