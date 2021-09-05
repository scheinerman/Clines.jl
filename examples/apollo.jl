using Clines, SimpleDrawing, Plots

function apollo_work(C1::Circle, C2::Circle, C3::Circle, min_radius)
    S = soddy(C1, C2, C3)
    if radius(S) < min_radius
        return
    end
    draw(S, linewidth = 0.25)
    apollo_work(C1, C2, S, min_radius)
    apollo_work(C1, C3, S, min_radius)
    apollo_work(C2, C3, S, min_radius)
end

function apollo(C1::Circle, C2::Circle, C3::Circle, min_radius::Real = 0.01)
    for C in [C1, C2, C3]
        draw(C, linewidth = 0.25)
    end
    apollo_work(C1, C2, C3, min_radius)
    finish()
end

function apollo(z1::Number, z2::Number, z3::Number, min_radius::Real = 0.01)
    newdraw()
    CC = kiss(z1, z2, z3)
    apollo(CC..., min_radius)
end

function apollo(min_radius::Real = 0.01)
    angles = [(2 * pi * k / 3 + pi / 6) * im for k = 1:3]
    zz = exp.(angles)
    apollo(zz..., min_radius)
end
