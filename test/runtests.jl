using Codify, Test, FieldDefaults, FieldMetadata, Unitful

import FieldMetadata: flattenable, @flattenable

@flattenable @default_kw struct SubTest 
    x::Float64 | 3.0 | false
    y::Float64 | 7.0 | true
end

@default_kw struct TestStruct{T}
    a::Float64 | 2.0
    b::Any     | 5.0
    c::T       | nothing
end

t = TestStruct(1.0, 1.0u"m*s^-1",SubTest(8.0,9.0))
s = Codify.codify_inner(typeof(t))
s = codify(t)
@test s == "TestStruct(\n    a = 1.0,\n    b = 1.0u\"m*s^-1\",\n    c = SubTest(\n        y = 9.0,\n    ),\n)"

t2 = eval(Meta.parse(s))

@test typeof(t) == typeof(t2)
@test t.a == t2.a
@test t.b == t2.b
@test t.c.y == 9.0
@test t2.c.x == 3.0
