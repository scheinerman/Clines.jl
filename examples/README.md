# Examples for the `Clines` module

This is documentation for the code in the `examples` directory of the `Clines` module.

## Apollonian Circles: `apollo.jl`


The function `apollo` is used to create an Apollonian circle packing picture. Starting with three mutually tangent circles, place a fourth circle mutually tangent to those three (using the `soddy` function) and then recurse three times using pairs of the original circles and the new circle.

The simplest invocation is `apollo()`. However, there are other options.

+ `apollo(z1,z2,z3)` creates the picture using three complex numbers as the centers of the original circles.
+ `apollo(C1,C2,C3)` creates the picture using three mutually tangent circles as the original circles.

In all cases, a final `min_radius` option may be specified to halt the recursion and not draw any circle whose radius is smaller than `min_radius`. 

See the included file `apollo.pdf` (which has been cropped) to see the result of `apollo()`. 

<hr>

## Ring of Four Circles: `fourway.jl`

One of my favorite theorems from basic geometry is this: 

*Suppose we have four circles, `C1` through `C4` in which `C1` is tangent to `C2` is tangent to `C3` is tangent to `C4` is tangent to `C1`. Then the four points of tangency lie on a common cline (typically a circle).*

The function `fourway()` produces an illustration of this fact and the result is available in `fourway.pdf`.

<hr>

## Pencil of Circles: `pencil.jl`

A collection of concurrent lines (lines all which contain a given point `z`) is called a *pencil* of lines. If we apply a linear fractional transformation to the lines in a pencil, the result is an (elliptic) pencil of circles. These circles all contain a given pair of points `A` and `B`, the centers of these circles all lie on the perpendicular bisector of the line segment `AB`.

Use `pencil(n)` to create a picture showing `n` circles. The file `pencil.pdf` shows the result of `pencil(6)`. 