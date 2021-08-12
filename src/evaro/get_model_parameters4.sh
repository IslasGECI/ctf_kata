#!/usr/bin/env bash

a=$(grep --extended-regexp --regexp='a +=' fit4.log | grep --extended-regexp --only-matching --regexp='\-*[0-9]+\.[0-9]+' | head -1)
b=$(grep --extended-regexp --regexp='b +=' fit4.log | grep --extended-regexp --only-matching --regexp='\-*[0-9]+\.[0-9]+' | head -1)
c=$(grep --extended-regexp --regexp='c +=' fit4.log | grep --extended-regexp --only-matching --regexp='\-*[0-9]+\.[0-9]+' | head -1)
echo "A = ${a}"
echo "B = ${b}"
echo "C = ${c}"
echo "${a}" > a.txt
echo "${b}" > b.txt
echo "${c}" > c.txt
