module Circles
using SimpleDrawing, LinearFractionalTransformations

export Circle

"""
    Circle

Represents a circle in the plane. Constructors:
* `circle(x,y,r)` based on center coordinates and radius 
* `circle(z,r)` based on center given as a complex number and a radius
* `circle(a,b,c)` based on three complex numbers that represent points on the circle
"""
struct Circle
    x::Float64
    y::Float64
    r::Float64
    function Circle(a::Real, b::Real, rad::Real)
        rad >= 0 || error("Radius must be nonnegative")
        new(a, b, rad)
    end
end

Circle(z::Complex, r::Real) = Circle(real(z), imag(z), r)

function Circle(a::Complex, b::Complex, c::Complex)
    z = find_center(a, b, c)
    !isinf(z) || error("Cannot construct a circle through three collinear points")
    r = abs(a - z)
    return Circle(z, r)
end

# copy constructor
Circle(C::Circle) = Circle(C.x, C.y, C.r)

# standard stuff

export radius, area, circumference, center

"""
    radius(C)
Return the radius of the circle.
"""
radius(C::Circle) = C.r

"""
    area(C)
Return the area of the circle.
"""
area(C::Circle) = π * C.r * C.r

"""
    circumference(C)
Return the circumference of the circle.
"""
circumference(C::Circle) = 2 * π * C.r


import Plots: center
"""
    center(C)
Return the center of the circle as a complex number. 
"""
center(C::Circle) = Complex(C.x, C.y)

"""
    three_points(C)
Return a list of three points on the circle as complex numbers.
"""
function three_points(C::Circle)
    z = center(C)
    r = radius(C)
    [z + r * exp(k * (2π * im / 3)) for k = 0:2]
end
export three_points

import SimpleDrawing: draw

const _FILL_COLOR = :lightgray
const _LINE_COLOR = :black

"""
    draw(C::Circle, fill::Bool=false; args...)
Draw the circle `C`. With `fill=true`, fill in the interior in color.

Example:
`draw(C,true,color=:yellow, linecolor=:red, fillalpha=0.3)`
"""
function draw(C::Circle, fill::Bool = false; args...)
    if fill
        draw_disc(
            center(C),
            radius(C);
            linecolor = _LINE_COLOR,
            color = _FILL_COLOR,
            args...,
        )
    else
        draw_circle(center(C), radius(C); linecolor = _LINE_COLOR, args...)
    end
end

# applying LFT to a Circle

function (F::LFT)(C::Circle)
    pp = three_points(C)
    qq = F.(pp)
    return Circle(qq...)
end

include("operations.jl")
include("kiss.jl")
include("inversion.jl")

end # module
