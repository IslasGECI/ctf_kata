#!/usr/bin/env bash

slope=$(cat m.txt)
intercept=$(cat b.txt)
mean_tarsus=$(csvstat pollos_petrel/train.csv | grep Mean | head -2 | tail -1 | grep --extended-regexp --only-matching --regexp=[0-9]+\.[0-9]+)
sed "s/NA/${mean_tarsus}/g" pollos_petrel/test.csv > pollos_petrel/test2.csv
csvsql --query "select id,((${slope}*Longitud_tarso)+${intercept}) as 'target' from 'test2'" pollos_petrel/test2.csv
