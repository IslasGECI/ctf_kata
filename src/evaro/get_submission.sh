#!/usr/bin/env bash

mean_target=$(csvstat pollos_petrel/train.csv | grep Mean | tail -1 | grep --extended-regexp --only-matching --regexp=[0-9]+\.[0-9]+)
csvsql --query "select id,$mean_target as 'target' from 'example_submission'" pollos_petrel/example_submission.csv
