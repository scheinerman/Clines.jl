function force_draw(R::Ray; args...)
    a = R.a
    b = R.b
    draw_segment(a, b, color = :black, arrow = true; args...)
    finish()
end

function draw(R::Ray; args...)
    Blines = _border_lines()
    Psets = collect(R ∩ L for L in Blines)
    Plist = union(Psets...)
    p = first(Plist)
    a = vertex(R)
    force_draw(Ray(a, p); args...)
end
