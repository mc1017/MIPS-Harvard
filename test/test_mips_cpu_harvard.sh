#!/bin/bash
set -eou pipefail

source_directory="$1"

instruction="${2:-all_cases}"
echo "$source_directory"
echo "$instruction"

if [[ $instruction != "all_cases" ]]; then
    TESTCASES="test/${instruction}*"
    for i in ${TESTCASES} ; do
        echo "$i"
        TESTNAME=$(basename ${i} .v)
        echo "$TESTNAME"

        iverilog -Wall -g 2012 \
            -s test/$TESTNAME \
            -o test/$TESTNAME test/$TESTNAME.v $i $1/mips_cpu_harvard.v $1/alucontrol.v $1/data_address_control.v $1/hilo.v $1/link.v $1/lw.v $1/pc_update.v $1/register_file.v $1/control.v $1/data_memory.v $1/instruction_memory.v $1/load.v $1/pc.v $1/unsign.v $1/tb.v $1/alu.v $1/branch_data.v $1/shift_control.v $1/sb.v
    done
fi


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