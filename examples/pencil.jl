using Clines, SimpleDrawing, Plots, LinearFractionalTransformations

function pencil_lines(n::Int)
    n>1 || error("Number of lines must be at least 2")

    angles = [k*pi/n for k=0:n-1]
    zz = exp.(angles * im)

    LL = [ Line(-z,z) for z in zz ]
    return LL
end

function pencil(F::LFT, n::Int=5)
    newdraw()
    LL = F.(pencil_lines(n))
    draw.(LL)
    finish()
end

function pencil(z::Number, n::Int=5)
    F = LFT(0,1,1,-z)
    pencil(F,n)
end

function pencil(n::Int)
    z = exp(pi*im/(2n))
    pencil(z,n)
end



function double_pencil(n::Int)
    LL = pencil_lines(n)
    CC = [Circle(0im,k) for k=1:n]
    r = floor(n/2) + 0.5
    z = r*exp(pi*im/(2n))
    F = LFT(0,1,1,-z)

    LL = F.(LL)
    CC = F.(CC)
    
    newdraw()
    for L in LL
        draw(L,linecolor=:blue)
    end
    for C in CC
        draw(C,linecolor=:red)
    end
    finish()
end