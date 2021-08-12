#!/usr/bin/env bash

slope=$(cat m.txt)
intercept=$(cat b.txt)
sed "s/NA/0/g" pollos_petrel/test.csv > pollos_petrel/test3.csv
csvsql --query "select id,((${slope}*Longitud_tarso)+${intercept}) as 'target' from 'test3'" pollos_petrel/test3.csv > pollos_petrel/tmp_submission.csv
mean_target=$(csvstat pollos_petrel/train.csv | grep Mean | tail -1 | grep --extended-regexp --only-matching --regexp=[0-9]+\.[0-9]+)
sed "s/${intercept}/${mean_target}/g" pollos_petrel/tmp_submission.csv
