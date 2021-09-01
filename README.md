# Clines

A [cline](https://en.wikipedia.org/wiki/Generalised_circle) is a circle or a line in the plane. 

## Construction

A cline is specified by three points in the plane represented by complex numbers. If the three points are collinear, then a line is created. Otherwise, there is a unique circle containing those three points and that is what is returned.
```julia
julia> using Clines

julia> C = Cline(2,3im,1-im)
Circle(0.10000000000000009, 0.9, 2.1023796041628637)

julia> L = Cline(0, 1+im, -1-im)
Line(1.0 + 1.0im, -1.0 - 1.0im)
```
Note that the `Clines` module defines two data types: `Circle` and `Line`, and these are subtypes of the abstract type `Cline`.

Circles can be directly constructed by specifying a center `z` and a radius `r`.