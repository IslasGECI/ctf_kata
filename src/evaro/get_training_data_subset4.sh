#!/usr/bin/env bash

csvsql --query "select Peso as x,target from 'train' where not Peso='NA'" pollos_petrel/train.csv
