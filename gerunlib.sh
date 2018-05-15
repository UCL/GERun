#!/usr/bin/env bash

# Define functions to output to stderr.
stderrmsg() { 
    echo "GERun: $@" 1>&2 
}
stderrprintf() {
    printf "GERun: $@" 1>&2
}

stderrcat() {
    awk '{print "GERun: " $0}' "$@" 1>&2
}


