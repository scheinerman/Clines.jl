import Base: inv

"""
    inv(C::Circle, z::Number) 
    inv(C::Circle, D::Circle)
Invert the point `z`  [or the circle `D`] with respect to the circle `C`
giving a new point [new circle].

Note: If `z` is at the center of `C`, we return `Inf + Inf*im`. 
If `D` passes through the center of `C` an error will occur. 
"""
function inv(C::Circle, z::Number)::Complex{Float64}
    c = center(C)
    d = abs(c - z)    # distance from center to the point
    r = radius(C)

    if d == 0
        return Inf + Inf * im
    end

    u = (z - c) / d   # unit vector from center to the point


    return c + (r^2 / d) * u
end


function inv(C::Circle, D::Circle)::Circle
    pp = three_points(D)
    qq = [inv(C, p) for p in pp]
    try
        return Circle(qq...)
    catch
        error("In inv(C,D), circle D may not pass through the center of C")
    end
end
