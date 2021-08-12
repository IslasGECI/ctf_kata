#!/usr/bin/env gnuplot

set autoscale
set datafile separator ","
set terminal dumb size 120, 30
f(x) = m*x + b
fit f(x) 'pollos_petrel/train2.csv' using 1:2 via m, b
plot 'pollos_petrel/train2.csv' using 1:2, f(x)
