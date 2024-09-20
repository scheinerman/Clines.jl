"""
    Ray 

This is a ray in the plane constructed by two complex numbers or four real numbers:
*  `Ray(w, z)`
*  `Ray(x::Real, y::Real, xx::Real, yy::Real)`
The first point (`w` or `(x,y)`) is the vertex of the `Ray`. The other point is on the `Ray`.
"""
struct Ray
    a::Complex{Float64}
    b::Complex{Float64}

    function Ray(aa::Number, bb::Number)
        if aa == bb || isinf(aa) || isinf(bb)
            error("Ray must be specified by two distinct finite points")
        end
        new(aa, bb)
    end
end

"""
    Ray(x::Real, y::Real, xx::Real, yy::Real)

TBW
"""
Ray(x::Real, y::Real, xx::Real, yy::Real) = Ray(Complex(x, y), Complex(xx, yy))
