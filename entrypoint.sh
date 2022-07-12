#!/bin/bash

set -e

#source /software/geant4/install/bin/geant4.sh

cd $1

eval "${@:2}"
