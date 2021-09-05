# Examples for the `Clines` module

This is documentation for code in the `examples` directory of the `Clines` module.

## Apollonian Circles

The function `apollo` is used to create an Apollonian circle packing picture. Starting with three mutually tangent circles, place a fourth circle mutually tangent to those three (using the `soddy` function) and then recurse three times using pairs of the original circles and the new circle.

The simplest invocation is `apollo()`. However, there are other options.

+ `apollo(z1,z2,z3)` creates the picture using three complex numbers as the centers of the original circles.
+ `apollo(C1,C2,C3)` creates the picture using three mutually tangent circles as the original circles.

In all cases, a final `min_radius` option may be specified to halt the recursion and not draw any circle whose radius is smaller than `min_radius`. 

See the included file `apollo.pdf` (which has been cropped) to see the result of `apollo()`. 

