#!/usr/bin/env bash

a=$(cat a.txt)
b=$(cat b.txt)
c=$(cat c.txt)
sed "s/NA/0/g" pollos_petrel/test.csv > pollos_petrel/test4.csv
csvsql --query "select id,(${a}*Peso*Peso+${b}*Peso+${c}) as 'target' from 'test4'" pollos_petrel/test4.csv > pollos_petrel/tmp_submission.csv
mean_target=$(csvstat pollos_petrel/train.csv | grep Mean | tail -1 | grep --extended-regexp --only-matching --regexp=[0-9]+\.[0-9]+)
sed "s/${c}/${mean_target}/g" pollos_petrel/tmp_submission.csv
