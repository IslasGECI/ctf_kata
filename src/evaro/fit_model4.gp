#!/usr/bin/env gnuplot

set datafile separator ","
set fit logfile "fit4.log"
g(x) = a*x**2 + b*x + c
fit g(x) 'pollos_petrel/train2.csv' using 1:2 via a, b, c
