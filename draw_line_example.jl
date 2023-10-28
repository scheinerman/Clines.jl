using Clines, SimpleDrawing

function one_line()
    newdraw()
    draw(Line(0, 0, 1, 1))
end


function two_lines()
    newdraw()

    draw_rectangle(-1,-1,1,1,color=:gray, style=:dash)
    finish()

    draw(Line(0, 0, 1, 1), color=:green)
    draw(Line(-5,0.5,2,0.6), color=:red)

    finish()
end