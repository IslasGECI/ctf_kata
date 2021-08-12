#!/usr/bin/env bash

csvsql --query "select Longitud_tarso,target from 'train' where not Longitud_tarso='NA'" pollos_petrel/train.csv
