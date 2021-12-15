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
        ./test/Outputs/${TESTNAME}
        RESULT=$?
        set -e
        if [[ RESULT -eq 0 ]] ; then
            echo "${TESTNAME} ${instruction} Pass"
        else
            echo "${TESTNAME} ${instruction} Fail"
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
        ./test/Outputs/${TESTNAME}
        RESULT=$?
        set -e
        if [[ RESULT -eq 0 ]] ; then
            echo "${TESTNAME} ${TESTNAME:: -1} Pass"
        else
            echo "${TESTNAME} ${TESTNAME:: -1} Fail"
        fi
        rm -r test/Outputs
        
    done

fi



