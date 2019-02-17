module Codify

using FieldMetadata, Requires

import FieldMetadata: flattenable, @flattenable

export codify

# Optionally load Unitful
function __init__()
    @require Unitful="1986cc42-f94f-5a68-af5c-568840ba703d" begin
        using Unitful
        codify(x::Unitful.Quantity, spaces) = begin 
            io = IOBuffer()
            print(IOContext(io, :showoperators => true), x)
            str = String(take!(io))
            # Replace space before units with u"" string macro
            occursin(" ", str) ? (replace(str, " " => "u\"") * "\"",) : (str,)
        end
    end
end

linebreak(exps) = length(exps) > 0 ? :("\n", spaces) : :("",)

codify_inner(T) = codify_combiner(T, [Expr(:..., codify_builder(T, fn)) for fn in fieldnames(T)])
codify_combiner(T, exps) = :(string($T.name.name, "(", $(exps...), $(linebreak(exps))..., ")"))
codify_combiner(T::Type{<:Tuple}, exps) = :(string("(", $(exps...), $(linebreak(exps))..., ")"))
codify_builder(T::Type{<:Tuple}, fname) = quote
    string.("\n    ", spaces, codify(getfield(t, $(QuoteNode(fname))), spaces * "    "), ",")
end
codify_builder(T, fname) = quote
    if flattenable($T, Val{$(QuoteNode(fname))})
        string.("\n    ", spaces, $(QuoteNode(fname)), " = ", codify(getfield(t, $(QuoteNode(fname))), spaces * "    "), ",")
    else
        ()
    end
end

codify(x::Nothing, args...) = ("nothing",)
codify(x::Number, args...) = ("$x",)
codify(x::Symbol, args...) = (":$x",)
codify(t) = codify(t, "")
@generated codify(t, spaces) = codify_inner(t)

end # module
