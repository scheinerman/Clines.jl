# Clines

A [cline](https://en.wikipedia.org/wiki/Generalised_circle) is a circle or a line in the plane. 

## Construction

A cline is specified by three points in the plane represented by complex numbers. If the three points are collinear, then a line is created. Otherwise, there is a unique circle containing those three points and that is what is returned.
```julia
julia> using Clines

julia> Cline(2-im, 3im, 1-im)
Circle(1.5, 1.25, 2.3048861143232218)

julia> L = Cline(0, 1+im, -1-im)
Line(1.0 + 1.0im, -1.0 - 1.0im)
```

**Notes**

+ If two of the arguments to `Cline` are equal, then a `Line` is created through the two distince points. 

+ If one of the arguments to `Cline` is infinite, a `Line` is created through the two (finite) points. 

+ Note that the `Clines` module defines two data types: `Circle` and `Line`, and these are subtypes of the abstract type `Cline`.

+ A `Circle` can be directly constructed by specifying a center `z` and a radius `r` like this: `Circle(z,r)`.

+ A `Line` can be directly constructed by specifying two points `w` and `z` like this: `Line(w,z)`. 


## Containment

For a point `z` and a cline `C`, use `in(z,C)` or `z ∈ C` to test of if `z` lies on `C`.
```julia
julia> C = Circle(0im,1)
Circle(0.0, 0.0, 1.0)

julia> z = 0.6 + 0.8im
0.6 + 0.8im

julia> z ∈ C
true
```

For two circles `C` and `D`, use `issubset(C,D)` or `C ⊆ D` to test if the circle `C` is contained inside circle `D`. 

## Intersection

Given two circles `C` and `D` use `intersect(C,D)` or `C ∩ D` to return a set of points that are common to the two circles. This set may have zero, one, or two elements. 
```julia
julia> C = Circle(0im, 1)
Circle(0.0, 0.0, 1.0)

julia> D = Circle(0.5im,1)
Circle(0.0, 0.5, 1.0)

julia> C ∩ D
Set{ComplexF64} with 2 elements:
  -0.9682458365518543 + 0.25im
  0.9682458365518543 + 0.25im
```

*This should be extended to the intersection of any two clines.*

## Inversion

To find the [inversion](https://en.wikipedia.org/wiki/Inversive_geometry) of a point or a cline through another cline, use `inv`:
+ `inv(C,z)` finds the image of the point `z` by inversion through `C`.
+ `inv(C,D)` finds the image of cline `D` by inversion through `C`.




