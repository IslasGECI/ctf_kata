#!/usr/bin/env bash

slope=$(cat m.txt)
intercept=$(cat b.txt)
sed 's/NA/0/g' pollos_petrel/test.csv > pollos_petrel/test2.csv
csvsql --query "select id,Longitud_tarso as 'target' from 'test2'" pollos_petrel/test2.csv
