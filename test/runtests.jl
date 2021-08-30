using Test, Clines, LinearFractionalTransformations

@testset "Construction" begin
    C = Circle(1 + 0im, im, -im)
    @test radius(C) == 1
    @test center(C) == 0

    D = Circle(0, 0, 1)
    @test C == D

    E = Circle(0im, 1)
    @test C == E
end

@testset "Properties" begin
    C = Circle(2, 3, 2)
    @test area(C) == 4π
    @test circumference(C) == 4π
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

@testset "LFT" begin
    C = Circle(1 + im, 3)
    F = LFT()
    D = F(C)
    @test abs(center(C) - center(D)) <= 10^-6
    @test abs(radius(C) - radius(D)) <= 10^-6
end
