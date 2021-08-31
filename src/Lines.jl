"""
    Line

This is a line in the plane, constructed by two complex numbers or four real numbers:
* `Line(w,z)`
* `Line(x1,y1,x2,y2)` 
"""
struct Line <: Cline
    a::Complex{Float64}
    b::Complex{Float64}

    function Line(aa::Number, bb::Number)
        if aa == bb || isinf(aa) || isinf(bb)
            error("Line must be specified by two finite points")
        end
        new(aa, bb)
    end
end

Line(x::Real, y::Real, xx::Real, yy::Real) = Line(Complex(x, y), Complex(xx, yy))

import Base: (==)

function (==)(L::Line, M::Line)
    if non_colinear_check(L.a, L.b, M.a) || non_colinear_check(L.a, L.b, M.b)
        return false
    end
    return true
end

"""
    in(z,L::Line)
Check if the point `z` lies on the line `L`.

**Warning**: Very sensitive to roundoff errors.
"""
function in(z::Number, L::Line)
    return !non_colinear_check(Complex(z), L.a, L.b)
end




export Line
