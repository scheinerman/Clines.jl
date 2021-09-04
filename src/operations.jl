
import Base.in

"""
    in(z,C)
Check if the point `z` is on the circle `C`. 
May be invoked as `z ∈ C`.
"""
function in(z::Number, C::Circle)::Bool
    d = abs(z - center(C))
    return abs(d - radius(C)) <= get_tolerance()
end

import Base.issubset

function issubset(C::Circle, D::Circle)
    z = center(C)
    w = center(D)
    d = abs(z - w)  # distance between centers
    r = radius(C)
    s = radius(D)

    return d + r <= s + get_tolerance()
end


function (==)(C::Circle, D::Circle)
    dx = C.x - D.x
    dy = C.y - D.y
    dr = C.r - D.r

    return dx^2 + dy^2 + dr^2 <= get_tolerance()
end

(==)(::Circle, ::Line) = false
(==)(::Line, ::Circle) = false
