
function _make_radii(a::Complex, b::Complex, c::Complex)
    dab = abs(a - b)
    dbc = abs(b - c)
    dac = abs(a - c)
    rhs = [dab; dbc; dac]
    A = [1 1 0; 0 1 1; 1 0 1]

    radii = A \ rhs
end


"""
    kiss
(z1,z2,z3)

Given three points (as complex numbers) find three circles 
centered at those points that are mutually tangent.

See: `touch_points`
"""
function kiss(a::Complex, b::Complex, c::Complex)
    rads = _make_radii(a, b, c)
    ctrs = [a, b, c]

    [Circle(ctrs[k], rads[k]) for k = 1:3]
end

export kiss, touch_points


"""
    touch_points(z1,z2,z3)

Given three points (as complex numbers) determine the points of tangency
of three mutually tangent circles centered at those points. 

See: `kiss`
"""
function touch_points(a::Complex, b::Complex, c::Complex)
    radii = _make_radii(a, b, c)
    ra, rb, rc = radii

    ab = (b - a) * (ra / (ra + rb)) + a
    ac = (c - a) * (ra / (ra + rc)) + a
    bc = (c - b) * (rb / (rb + rc)) + b
    return [ab; ac; bc]
end


"""
    soddy_radii(r1, r2, r3)
Given three radii (real numbers) of mutually tangent circles,
give the radii of a fourth circle that is mutually tangent to the
three that are given as a 2-tuple of real numbers. 

The positive result (first entry) is the radius of a small circle
nestled between the other three, and the negative result (second entry)
is negative the radius of a circle that is tangent to and surrounds the
three.
"""
function soddy_radii(r1, r2, r3)
    k1 = 1 / r1
    k2 = 1 / r2
    k3 = 1 / r3

    common = 2 * sqrt(k1 * k2 + k2 * k3 + k3 * k1)

    k4a = k1 + k2 + k3 + common
    k4b = k1 + k2 + k3 - common

    return 1 / k4a, 1 / k4b
end


soddy_radii(C1::Circle, C2::Circle, C3::Circle) = soddy_radii(C1.r, C2.r, C3.r)


function soddy_center(C1::Circle, C2::Circle, C3::Circle)
    r = soddy_radii(C1, C2, C3)[1]

    D1 = Circle(center(C1), radius(C1) + r)
    D2 = Circle(center(C2), radius(C2) + r)

    zz = collect(D1 ∩ D2)

    d1 = abs(center(C3) - zz[1]) - (radius(C3) + r) |> abs
    d2 = abs(center(C3) - zz[2]) - (radius(C3) + r) |> abs

    d1 < d2 ? zz[1] : zz[2]

end


export soddy

function soddy(C1::Circle, C2::Circle, C3::Circle)
    r = soddy_radii(C1, C2, C3)[1]
    z = soddy_center(C1, C2, C3)
    return Circle(z, r)
end
