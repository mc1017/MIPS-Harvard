#!/bin/bash
set -eou pipefail

source_directory="$1"

instruction="${2:-all_cases}"




if [[ $instruction != "all_cases" ]]; then
    TESTCASES="test/*/${instruction}[0-9]*.v"
    #strip instructin that ends with 0-9
    for i in ${TESTCASES} ; do
        mkdir test/Outputs
        
        dir=$(basename "$(dirname ${i})")
        #middle directory
        
        TESTNAME=$(basename ${i} .v)

        #compile program
        iverilog -g 2012 \
            -o test/Outputs/${TESTNAME} ${i} $1/mips_cpu_*.v test/DataMem/mips_cpu_data_memory.v

        #run program
        set +e
        ./test/Outputs/${TESTNAME} > test/4-Output/${TESTNAME}.stdout
        RESULT=$?
        set -e
        if [[ "${RESULT}" -ne 0 ]] ; then
            echo "${TESTNAME} ${instruction} Fail"
            exit
        fi
        PATTERN="CPU : OUT :"
        NOTHING=""
        set +e
        grep "${PATTERN}" test/4-Output/${TESTNAME}.stdout > test/4-Output/${TESTNAME}.out-lines
        set -e

        sed -e "s/${PATTERN}/${NOTHING}/g" test/4-Output/${TESTNAME}.out-lines > test/4-Output/${TESTNAME}.out
        set +e
        diff -w test/5-Reference/${TESTNAME}.out test/4-Output/${TESTNAME}.out > /dev/null
        RESULT=$?
        set -e
        if [[ "${RESULT}" -ne 0 ]] ; then
            echo "${TESTNAME} ${instruction} Fail"
        else
            echo "${TESTNAME} ${instruction} Pass"
        fi
        
        rm -r test/Outputs
    done
else
    TESTCASES="test/*/*[0-9]*.v"
    for i in ${TESTCASES} ; do
        mkdir test/Outputs
        dir=$(basename "$(dirname ${i})")
        #middle directory
    
        TESTNAME=$(basename ${i} .v)
        
        #compile program
        iverilog -Wall -g 2012 \
            -o test/Outputs/${TESTNAME} ${i} $1/mips_cpu_*.v test/DataMem/mips_cpu_data_memory.v

        #run program    
        set +e
        ./test/Outputs/${TESTNAME} > test/4-Output/${TESTNAME}.stdout
        RESULT=$?
        set -e
        if [[ "${RESULT}" -ne 0 ]] ; then
            echo "${TESTNAME} ${TESTNAME:: -1} Fail"
            exit
        fi
        PATTERN="CPU : OUT :"
        NOTHING=""
        set +e
        grep "${PATTERN}" test/4-Output/${TESTNAME}.stdout > test/4-Output/${TESTNAME}.out-lines
        set -e

        sed -e "s/${PATTERN}/${NOTHING}/g" test/4-Output/${TESTNAME}.out-lines > test/4-Output/${TESTNAME}.out
        set +e
        diff -w test/5-Reference/${TESTNAME}.out test/4-Output/${TESTNAME}.out > /dev/null
        RESULT=$?
        set -e
        if [[ "${RESULT}" -ne 0 ]] ; then
            echo "${TESTNAME} ${TESTNAME:: -1} Fail"
        else
            echo "${TESTNAME} ${TESTNAME:: -1} Pass"
        fi
        rm -r test/Outputs
        
    done

fi



