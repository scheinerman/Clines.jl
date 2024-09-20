"""
    inv(C::Cline, z::Number) 
    inv(C::Cline, D::Cline)
    inv(C::Cline)
Invert the point `z`  [or the cline `D`] with respect to the cline `C`
giving a new point [cline].

`inv(C)` returns a function `F` such that `F(X) = inv(C,X)`.
"""
function inv(X::Cline, z::Number)::Complex{Float64}
    pp = three_points(X)
    F = LFT(pp...)
    zz = F(z)
    return (inv(F))(conj(zz))
end



function inv(C::Cline, D::Cline)::Cline
    pp = three_points(D)
    qq = [inv(C, p) for p in pp]

    return Cline(qq...)
end


function inv(C::Cline)::Function
    return x -> inv(C, x)
end
