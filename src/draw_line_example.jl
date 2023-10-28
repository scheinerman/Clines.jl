using Clines, SimpleDrawing, Plots

function one_line()
    newdraw()
    draw(Line(0, 0, 1, 1))
end


function two_lines_small()
    newdraw()
    draw(Circle(0, 0, 1), color = :black, style = :dash)
    draw(Line(0, 0, 1, 2), color = :green)
    draw(Line(-5, 0.5, 2, 1), color = :red)
    draw(Line(-5, 1.5, 5, 1.5), color = :blue)
    draw(Circle(0, 0, 2), color = :black, style = :dash)
    savefig("two_lines_small.png")
    finish()
end

function two_lines_big()
    newdraw()
    draw(Circle(0, 0, 2), color = :black, style = :dash)
    draw(Line(0, 0, 1, 2), color = :green)
    draw(Line(-5, 0.5, 2, 1), color = :red)
    draw(Line(-5, 1.5, 5, 1.5), color = :blue)
    draw(Circle(0, 0, 1), color = :black, style = :dash)
    savefig("two_lines_big.png")
    finish()
end

function force_example()
    newdraw()
    draw(Circle(0, 0, 1), color = :black, style = :dash)
    draw(Line(-5, 0.5, 2, 1), color = :red)
    draw(Line(0, 0, 1, 2), color = :green)
    force_draw(Line(-5, 1.5, 5, 1.5), color = :blue)
    draw(Circle(0, 0, 2), color = :black, style = :dash)
    savefig("force_example.png")
    finish()
end
