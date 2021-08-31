module Clines

abstract type Cline end
export Cline


_DEFAULT_TOL = 1e-10

export set_tolerance, get_tolerance

"""
    set_tolerance(tol)
Set the tolerance to Cline roundoff errors.
"""
function set_tolerance(tol::Real)
    if tol < 0
        error("Tolerance cannot be set to $tol; must be positive")
    end
    global _DEFAULT_TOL = tol
end
"""
    get_tolerance(tol)
Return the current tolerance to Cline roundoff errors.
"""
function get_tolerance()
    return _DEFAULT_TOL
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

    return abs(d) < get_tolerance()
end

export collinear


include("Circles.jl")
include("Lines.jl")

function Cline(a::Number, b::Number, c::Number)::Cline
    if isnan(a) || isnan(b) || isnan(c)
        error("Cannot construct a Cline with a NaN argument")
    end

    two_inf = "Cannot construct a Cline with two infinite arguments"
    two_dif = "Cannot construct a Cline through a single point"


    # If any of the arguments is ∞ then we make a line

    if isinf(a)
        if isinf(b) || isinf(c)
            error(two_inf)
        end
        b != c || error(two_dif)
        return Line(b, c)
    end

    if isinf(b)   # know that a is not infinite
        a != c || error(two_dif)
        return Line(a, c)
    end

    if isinf(c)   # we know a and b are not infinite
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
        return Line(a, b)  # may want to use the two "extreme" points 
    end

    # Otherwise, it's a circle
    return Circle(Complex(a), Complex(b), Complex(c))
end

Cline(a::Number, b::Number) = Cline(a, b, Inf)


end # module
