

export force_draw
"""
    force_draw(L::Line; args...)

Draw the line `L` as an arrowed segment joining its defining points.
"""
function force_draw(L::Line; args...)
    a = L.a
    c = L.b
    b = (a + c) / 2
    draw_segment(b, a, arrow = true, linecolor = :black, args...)
    draw_segment(b, c, arrow = true, linecolor = :black, args...)
end

_default_factor = 0.05

"""
    _frame(factor::Real = 0.05)

Get corners for a rectangle inside the current window such that
drawing inside that rectangle shouln't resize the window (I hope).
"""
function _frame(factor::Real = _default_factor)
    # get the x,y-coordinates of the window
    ab, cd = corners()
    a = real(ab)
    b = imag(ab)
    c = real(cd)
    d = imag(cd)

    aa = a + factor * (c - a)
    bb = b + factor * (d - b)

    cc = c - factor * (c - a)
    dd = d - factor * (d - b)

    return aa + im * bb, cc + im * dd
end

"""
    _border_lines(factor::Real = _default_factor)

Return a list of four lines that are on the sides of the rectangle
given by `_frame`.
"""
function _border_lines(factor::Real = _default_factor)
    ab, cd = _frame(factor)
    a = real(ab)
    b = imag(ab)
    c = real(cd)
    d = imag(cd)

    L1 = Line(a, b, c, b)
    L2 = Line(a, b, a, d)
    L3 = Line(c, d, a, d)
    L4 = Line(c, d, c, b)

    return L1, L2, L3, L4
end


"""
    _between_check(L::Line, z::Complex{Float64})::Bool

See if the point `z`, presumed to be on the line `L`, lies between the two points 
defining `L`
"""
function _between_check(L::Line, z::Complex)::Bool
    a = L.a
    b = L.b

    r = (z - a) / (b - a)
    return 0 <= real(r) <= 1
end

function _border_cross(L::Line, BLine::Line)::Set{ComplexF64}
    X = L ∩ BLine 
    if isempty(X)
        return X 
    end
    if _between_check(BLine, first(X))
        return X
    end
    return Set{ComplexF64}()
end


function draw(L::Line; args...)

    Blines = _border_lines()

    # if L is a border line, draw it
    for LL in Blines
        if LL == L
            force_draw(LL, args...)
            return
        end
    end

    # otherwise, find the points where L meets a border line
    XX = (_border_cross(L, LL) for LL in Blines)
    Xset = union(XX...)

    @show Xset

    if length(Xset) != 2 
        return 
    end

    P,Q = collect(Xset)
    force_draw(Line(P,Q))


    # # old code here
    # a = L.a
    # c = L.b
    # b = (a + c) / 2
    # draw_segment(b, a, arrow = true, linecolor = :black, args...)
    # draw_segment(b, c, arrow = true, linecolor = :black, args...)
end




export _frame, _border_lines, _between_check, _border_cross   # temp
