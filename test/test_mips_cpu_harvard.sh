#!/bin/bash
chmod +rwx test_mips_cpu_harvard.sh
set -eou pipefail

source_directory="$1"

if [ $2 ] ; then
    instruction="$2"
    
else 
    instruction="all_cases"
fi
echo "$source_directory"
echo "$instruction"

if [[ instruction!= "all_cases"]]

cd rtl

for i in ${TESTCASES} ; do
    TESTNAME=$(basename ${i} .v)

    set +e
    iverilog -Wall -g 2012 \
    -s  \
    -o multiplier_iterative_tb \
    multiplier_iterative_${VARIANT}.v multiplier_iterative_tb.v 
    RESULT=$?
    set -e
    if [[ RESULT -ne 0 ]] ; then
        echo "$i,Fail,Compilation"
    
    else
        set +e
        ./$TESTNAME
        RESULT=$?
        set -e
        if [[ RESULT -eq 0 ]] ; then
            echo "$i,Pass"
        else
            echo "$i,Fail,Execution"
        fi
    fi


    set +e
    ./${i}
    # Capture the exit code of the simulator in a variable
    RESULT=$?
    set -e

    
done