module Clines

abstract type Cline end

const _DEFAULT_TOL = 1e-10
_TOLERANCE = _DEFAULT_TOL

import Plots: center
import SimpleDrawing: draw
import Base: (==), angle, in, inv, issubset, intersect

export Circle,
    Cline,
    Line,
    Ray,
    area,
    center,
    circumference,
    collinear,
    dilate,
    force_draw,
    get_tolerance,
    kiss,
    radius,
    set_tolerance,
    slope,
    soddy,
    three_points,
    touch_objects

"""
    set_tolerance(tol)
Set the tolerance to Cline roundoff errors.
"""
function set_tolerance(tol::Real = _DEFAULT_TOL)
    if tol <= 0
        error("Tolerance cannot be set to $tol; must be positive")
    end
    global _TOLERANCE = tol
end
"""
    get_tolerance(tol)
Return the current tolerance to Cline roundoff errors.
"""
function get_tolerance()
    return _TOLERANCE
end



""" 
    collinear(a,b,c)
Determine if the three points `a`, `b`, and `c` are collinear.
Here the inputs are finite complex numbers. 
"""
function collinear(a::Number, b::Number, c::Number)::Bool
    x1, y1 = reim(a)
    x2, y2 = reim(b)
    x3, y3 = reim(c)

    d = x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2)

    return abs(d) <= get_tolerance()
end


is_huge(z::Number) = isinf(z) || abs(z) >= 1 / get_tolerance()

function Cline(a::Number, b::Number, c::Number)::Cline
    if isnan(a) || isnan(b) || isnan(c)
        error("Cannot construct a Cline with a NaN argument")
    end

    two_inf = "Cannot construct a Cline with two infinite arguments"
    two_dif = "Cannot construct a Cline through a single point"


    # If any of the arguments is ∞ then we make a line

    if is_huge(a)
        if is_huge(b) || is_huge(c)
            error(two_inf)
        end
        b != c || error(two_dif)
        return Line(b, c)
    end

    if is_huge(b)   # know that a is not infinite
        a != c || error(two_dif)
        return Line(a, c)
    end

    if is_huge(c)   # we know a and b are not infinite
        a != b || error(two_dif)
        return Line(a, b)
    end

    # if two of the arguments are equal, we make a line

    if a == b == c     # but not if three are equal
        error(two_dif)
    end

    if a == b
        return Line(a, c)
    end
    if a == c
        return Line(a, b)
    end
    if b == c
        return Line(a, b)
    end

    # if the arguments are collienar, we make a line
    if collinear(a, b, c)
        x, y, z = sort_points(a, b, c)
        return Line(x, z)
    end

    # Otherwise, it's a circle
    return Circle(Complex(a), Complex(b), Complex(c))
end

Cline(a::Number, b::Number) = Cline(a, b, Inf)

import SimpleDrawing: draw

include("Lines.jl")
include("Circles.jl")
include("intersection.jl")
include("angle.jl")
include("Rays.jl")



# applying LFT to a Cline

function (F::LFT)(C::Cline)
    pp = three_points(C)
    qq = F.(pp)
    return Cline(qq...)
end


# create a LFT from a pair of Clines

import LinearFractionalTransformations: LFT

"""
    LFT(C::Cline, D::Cline)
Return a linear fractional transformation that maps `C` to `D`. If `D` is
omitted, it is assumed to be the x-axis. 
"""
function LFT(C::Cline, D::Cline)::LFT
    F = LFT(C)
    G = LFT(D)
    return inv(G) * F
end


function LFT(C::Circle)::LFT
    return LFT(three_points(C)...)
end

function LFT(L::Line)::LFT
    return LFT(L.a, L.b, Inf)
end

end # module
