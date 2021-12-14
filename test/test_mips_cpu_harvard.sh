#!/bin/bash
set -eou pipefail

source_directory="$1"

instruction="${2:-all_cases}"




if [[ $instruction != "all_cases" ]]; then
    TESTCASES="test/*/${instruction}[0-9]*.v"
    #strip instructin that ends with 0-9
    for i in ${TESTCASES} ; do
        mkdir test/4-Outputs
        
        dir=$(basename "$(dirname ${i})")
        #middle directory
        
        TESTNAME=$(basename ${i} .v)

        #compile program
        iverilog -g 2012 \
            -o test/4-Outputs/${TESTNAME} ${i} $1/mips_cpu_*.v

        #run program
        set +e
        ./test/4-Outputs/${TESTNAME}
        RESULT=$?
        set -e
        if [[ RESULT -eq 0 ]] ; then
            echo "${TESTNAME} ${instruction} Pass"
        else
            echo "${TESTNAME} ${instruction} Fail"
        fi

        rm -r test/4-Outputs
    done
else
    TESTCASES="test/*/*.v"
    for i in ${TESTCASES} ; do
        mkdir test/4-Outputs
        dir=$(basename "$(dirname ${i})")
        #middle directory
    
        TESTNAME=$(basename ${i} .v)
        
        #compile program
        iverilog -Wall -g 2012 \
            -o test/4-Outputs/${TESTNAME} ${i} $1/mips_cpu_*.v

        #run program    
        set +e
        ./test/4-Outputs/${TESTNAME}
        RESULT=$?
        set -e
        if [[ RESULT -eq 0 ]] ; then
            echo "${TESTNAME} ${TESTNAME:: -1} Pass"
        else
            echo "${TESTNAME} ${TESTNAME:: -1} Fail"
        fi
        rm -r test/4-Outputs
        
    done

fi



