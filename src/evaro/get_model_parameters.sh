#!/usr/bin/env bash

slope=$(grep --extended-regexp --regexp='m +=' fit.log | grep --extended-regexp --only-matching --regexp='\-*[0-9]+\.[0-9]+' | head -1)
intercept=$(grep --extended-regexp --regexp='b +=' fit.log | grep --extended-regexp --only-matching --regexp='\-*[0-9]+\.[0-9]+' | head -1)
echo "Slope: m = ${slope}"
echo "Y-intercept: b = ${intercept}"
echo "${slope}" > slope.txt
echo "${intercept}" > intercept.txt
