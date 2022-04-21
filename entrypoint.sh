#!/bin/bash

set -e

cd $1

eval "${@:2}"
