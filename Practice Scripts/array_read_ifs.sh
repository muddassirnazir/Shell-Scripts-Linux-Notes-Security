#!/bin/bash

old=$IFS
IFS=$ '\n'
file={ `cat $1` }
echo
