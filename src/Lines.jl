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

export Line

import Base: (==)

function (==)(L::Line, M::Line)
    return collinear(L.a, L.b, M.a) && collinear(L.a, L.b, M.b)
end


import Base: in
"""
    in(z,L::Line)
Check if the point `z` lies on the line `L`.
"""
function in(z::Number, L::Line)
    return collinear(Complex(z), L.a, L.b)
end

export slope
function slope(L::Line)::Float64
    x, y = reim(L.a)
    xx, yy = reim(L.b)
    return (y - yy) / (x - xx)
end


"""
    sort_points(a,b,c)

Given three collinear points (expressed as complex numbers) return them as a 
3-tuple ensuring the 2nd entry in the tuple lies between the other two points
on the line that contains them.
"""
function sort_points(a::Number, b::Number, c::Number)
    if !collinear(a, b, c)
        @warn "The three points are not collinear. Nonsense may ensue."
    end

    rat = real((c - a) / (b - a))

    if rat >= 1
        return a, b, c
    end

    if rat <= 0
        return b, a, c
    end

    return a, c, b
end

"""
    three_points(L::Line)
Return a list of three points on the line `L`.
"""
function three_points(L::Line)
    x = L.a
    y = L.b
    z = (x + y) / 2
    return [x, z, y]
end

"""
    dilate(L::Line, factor=2)
Create a new line in which the distance between the defining points, `X.a` and `X.b`,
is magnified by `factor` from those of `L`. The resulting line is equal to `L`.
"""
function dilate(L::Line, factor = 2)
    a = L.a
    b = L.b
    m = (a + b) / 2

    aa = m + factor * (a - m)
    bb = m + factor * (b - m)

    return Line(aa, bb)
end
export dilate


# THIS IS A BAD DRAWING METHOD FOR LINES, BUT WILL HAVE TO DO FOR NOW
# It simply draws an arrowed line segment between L.a and L.b
# See: dilate

function draw(L::Line; args...)
    a = L.a
    c = L.b
    b = (a + c) / 2
    draw_segment(b, a, arrow = true, linecolor = :black, args...)
    draw_segment(b, c, arrow = true, linecolor = :black, args...)
end
