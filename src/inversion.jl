import Base: inv

"""
    inv(C::Cline, z::Number) 
    inv(C::Cline, D::Cline)
Invert the point `z`  [or the cline `D`] with respect to the circle `C`
giving a new point [cline].
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
