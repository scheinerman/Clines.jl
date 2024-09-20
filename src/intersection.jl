complex_empty = Set{Complex{Float64}}()
identical_warn = "Intersection of identical clines returns the empty set"

"""
    intersect(C::Cline,D::Cline)
    C ∩ D 

Find the points common to the clines `C` and `D` as a set of complex numbers.

Note that if `C==D` a warning is issued and the emptyset is returned.
"""
function intersect(C::Circle, D::Circle)::Set{Complex{Float64}}
    if C == D
        @warn identical_warn
        return complex_empty
    end

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


function intersect(L::Line, M::Line)::Set{Complex{Float64}}
    if L == M
        @warn identical_warn
        return complex_empty
    end

    # check if parallel
    m1 = slope(L)
    m2 = slope(M)
    if (isinf(m1) && isinf(m2)) || (abs(m1 - m2) < get_tolerance())
        return complex_empty
    end

    a = L.a
    b = L.b

    ax, ay = reim(a)
    bx, by = reim(b)

    aa = M.a
    bb = M.b

    aax, aay = reim(aa)
    bbx, bby = reim(bb)


    MAT = zeros(2, 2)
    MAT[1, 1] = ax - bx
    MAT[1, 2] = bbx - aax
    MAT[2, 1] = ay - by
    MAT[2, 2] = bby - aay

    RHS = [bbx - bx, bby - by]
    st = MAT \ RHS

    s = st[1]
    z = s * L.a + (1 - s) * L.b
    return Set(z)
end



function intersect(C::Cline, D::Cline)::Set{Complex{Float64}}
    if C == D
        @warn identical_warn
        return complex_empty
    end

    F = LFT(C)  # map C to x-axis
    G = inv(F)
    DD = F(D)  # apply that to D and find where DD crosses the x-axis 

    # if the images of D is a circle
    if isa(DD, Circle)
        x, y = reim(center(DD))
        r = radius(DD) + get_tolerance()

        if r < abs(y)
            return complex_empty = Set{Complex{Float64}}()
        end

        δ = sqrt(r^2 - y^2)
        a = G(x + δ)
        b = G(x - δ)
        if abs(a - b) < get_tolerance()  # if the points are too close, we say they're the same
            ab = (a + b) / 2
            return Set{Complex{Float64}}(ab)
        else
            return Set{Complex{Float64}}([a, b])
        end
    end

    # otherwise, DD, the image of D, is a line

    X = Line(0, 1)  # x-axis 
    S = X ∩ DD
    return G.(S)
end




## RAY INTERSECTION WITH OTHER RAYS, LINES, and Circles

function intersect(R::Ray, RR::Ray)
    msg = "Intersection of overlapping rays returns the empty set"

    if R ⊆ RR || RR ⊆ R 
        @warn msg
        return complex_empty
    end

    L = Line(R)
    LL = Line(RR)

    if L==LL  # lines are the same, but no containment
        a = vertex(R)
        aa = vertex(RR)
        if abs(a-aa) <= get_tolerance()
            return Set(a)
        end
        @warn msg 
        return complex_empty
    end

    S = L ∩ LL
    if length(S) == 0 # they don't intersect
        return S
    end
    p = first(S)  # should be only one point 
    if p ∈ R && p ∈ RR
        return S
    end
    return complex_empty

end
