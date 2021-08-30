import Base.intersect

"""
    intersect(C, D)
Return the point(s) of intersection of two circles as a set of complex numbers.
"""
function intersect(C::Circle, D::Circle)::Set{Complex{Float64}}
    z = center(C)
    r = radius(C)

    w = center(D)
    s = radius(D)

    d = abs(z - w)

    if d > r + s || d + s < r || d + r < s
        return Set{Complex{Float64}}()
    end


    θ = acos((r^2 + d^2 - s^2) / (2 * r * d))
    u = (w - z) / abs(w - z)
    uu = u * exp(θ * im)
    a = z + uu * r
    uu = u * exp(-θ * im)
    b = z + uu * r
    return Set([a, b])
end

import Base.in

"""
    in(z,C)
Check if the point `z` is inside (or on the edge of) the circle `C`. 
May be invoked as `z ∈ C`.
"""
function in(z::Number, C::Circle)::Bool
    d = abs(z - center(C))
    return d <= radius(C)
end

import Base.issubset

function issubset(C::Circle, D::Circle)
    z = center(C)
    w = center(D)
    d = abs(z - w)
    r = radius(C)
    s = radius(D)

    return d + r <= s
end
