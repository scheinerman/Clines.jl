using Clines, SimpleDrawing, Plots

function originals()
    X = Line(-1, 7)

    C1 = Circle(1, 1, 1)
    C2 = Circle(2.5, 1, 0.5)
    C3 = Circle(4, 1, 1)

    pts = [1, 2 + im, 3 + im]
    SS = Cline(pts...)



    return [X, C1, C2, C3, SS]
end

function fourway(F::LFT)
    x = originals()
    y = F.(x)
    newdraw()
    draw.(y[1:4])
    try
        draw(y[5], linestyle = :dash)
    catch
        draw(y[5])
    end
    finish()
end

function fourway(z::Number = 2 + 4im)
    F = LFT(0, 1, 1, -z)
    fourway(F)
end
