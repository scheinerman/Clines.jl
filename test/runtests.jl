using Test, Clines, LinearFractionalTransformations

@testset "Construction" begin
    C = Circle(1 + 0im, im, -im)
    @test radius(C) == 1
    @test center(C) == 0

    D = Circle(0, 0, 1)
    @test C == D

    E = Circle(0im, 1)
    @test C == E

    P = three_points(E)
    @test C == Cline(P...)

    L = Line(1, 2)
    @test L == Line(-1, 3)
    @test L == Cline(1, 5, Inf)

    LL = dilate(L)
    @test LL == L
end

@testset "Properties" begin
    C = Circle(2, 3, 2)
    @test area(C) == 4π
    @test circumference(C) == 4π

    L = Cline(0, 1 + im, 2 + 2im)
    @test slope(L) == 1
end

@testset "Set Ops" begin
    C = Circle(0im, 6)
    D = Circle(4 + 0im, 2)
    @test D ⊆ C
    S = C ∩ D
    @test length(S) == 1

    D = Circle(4 + 0im, 3)
    S = C ∩ D
    @test length(S) == 2

    D = Circle(4 + 0im, 1)
    S = C ∩ D
    @test isempty(S)
end

@testset "Intersection" begin
    C = Circle(0, 0, 1)
    L = Line(0, 3 + 4im)
    @test length(C ∩ L) == 2
    D = Circle(2, 0, 1)
    @test length(C ∩ D) == 1

    D = Circle(5, 5, 1)
    @test C ∩ D == Set{Complex{Float64}}()

    X = Line(0, 1)
    Y = Line(im, 2 + im)
    @test length(X ∩ Y) == 0

    Y = Cline(-5, 2, Inf)
    @test X == Y
end


@testset "LFT" begin
    C = Circle(1 + im, 3)
    F = LFT()
    D = F(C)
    @test abs(center(C) - center(D)) <= get_tolerance()
    @test abs(radius(C) - radius(D)) <= get_tolerance()

    D = Circle(2 - im, 5)
    F = LFT(C, D)
    @test F(C) == D
    @test (inv(F))(D) == C

    F = LFT(C)
    X = Line(0, 1)
    @test (inv(F))(X) == C

end

@testset "Inversion" begin
    X = Line(0, 1)
    z = 3 - 2im
    @test inv(X, z) == conj(z)

    C = Circle(2, 3, 5)
    L = Line(0, 1 - im)

    LL = inv(C, L)
    @test inv(C, LL) == L

    F = inv(L)
    @test F(F(C)) == C

end


@testset "Collinearity" begin
    pts = 2 * collect(1:3) - im * collect(1:3)
    @test collinear(pts...)
    @test isa(Cline(pts...), Line)

    C = Circle(4, 6, 10)
    PP = three_points(C)
    @test !collinear(PP...)
end

@testset "Kiss" begin
    pts = [0, 2im, 3 + im]
    CC = kiss(pts...)
    @test length(CC[1] ∩ CC[2]) == 1
    S = soddy(CC...)
    @test length(CC[3] ∩ S) == 1
end


@testset "Rays" begin
    R = Ray(0, 0, 2, 2)
    @test 1 + im ∈ R
    L = Line(R)
    @test -1 - im ∈ L
    @test -1 - im ∉ R

    C = Circle(0, 0, 5)
    R = Ray(0, 6 + 8im)
    p = first(C ∩ R)
    set_tolerance(1e-4)
    @test p ∈ C
    @test p ∈ R
end
