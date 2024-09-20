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
    vertex(R::Ray)

Return the vertex of the ray `R`.
"""
vertex(R::Ray) = R.a


"""
    Ray(x::Real, y::Real, xx::Real, yy::Real)

TBW
"""
Ray(x::Real, y::Real, xx::Real, yy::Real) = Ray(Complex(x, y), Complex(xx, yy))


Line(R::Ray) = Line(R.a, R.b)

three_points(R::Ray) = [R.a, 0.5 * (R.a + R.b), R.b]

function in(z::Number, R::Ray)::Bool
    a = R.a
    b = R.b

    if z == a || z == b
        return true
    end

    if !collinear(Complex(z), a, b)
        return false
    end

    rat = real((z - a) / (b - a))

    return rat > 0
end

function (==)(R::Ray, RR::Ray)::Bool
    # check they have the same vertex
    if abs(R.a - RR.a) > get_tolerance()
        return false
    end

    # check if the other point of R is in RR 
    return R.b ∈ RR
end

"""
    issubset(R::Ray, RR::Ray)
    R ⊆ RR

Test of ray `R` is completely contained in `RR`.
"""
function issubset(R::Ray, RR::Ray)
    a = R.a
    b = R.b
    aa = RR.a
    bb = RR.b

    if a ∉ RR || b ∉ RR
        return false
    end

    rat = real((b - a) / (bb - aa))
    return rat >= 0

end


"""
    (-)(R::Ray)::Ray

`-R`, for a ray `R`, is a ray with the same vertex but pointing
in the opposite direction. 
"""
function (-)(R::Ray)::Ray
    a = R.a
    b = R.b

    bb = 2a - b
    return Ray(a, bb)
end



include("draw_ray.jl")
