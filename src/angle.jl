_dot2(v::Vector, w::Vector) = v[1] * w[1] + v[2] * w[2]

_no_intersect_error = "The two clines do not intersect; no angle can be calculated."

function angle(L::Line, M::Line)::Float64

    if slope(L) == slope(M)
        return 0
    end

    v = collect(reim(L.a - L.b))
    w = collect(reim(M.a - M.b))

    top = _dot2(v, w)
    bot = sqrt(_dot2(v, v) * _dot2(w, w))
    θ = abs(acos(top / bot))

    if θ > π / 2
        θ = π - θ
    end
    return θ

end

"""
    angle(C::Cline, D::Cline)
Return the angle between two clines. If `C` and `D` are equal, or are parallel lines, return 0.
Otherwise, if `C` and `D` do not intersect, an error is thrown.
"""
function angle(C::Cline, D::Cline)
    if C == D
        return 0
    end

    X = C ∩ D

    if length(X) == 0
        error(_no_intersect_error)
    end

    z = first(X)
    F = LFT(0, 1, 1, -z)

    CC = F(C)
    DD = F(D)
    if !(isa(CC, Line) && isa(DD, Line))
        error("This can't happen, but it did.")
    end
    return angle(CC, DD)
end
