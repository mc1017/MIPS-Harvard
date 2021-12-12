#!/bin/bash
set -eou pipefail

source_directory="$1"

instruction="${2:-all_cases}"
echo "Src Directory: $source_directory"
echo "Instruction: $instruction"

if [[ $instruction != "all_cases" ]]; then
    TESTCASES="test/${instruction}*"
    for i in ${TESTCASES} ; do
        echo "$i"
        TESTNAME=$(basename ${i} .v)
        echo "$TESTNAME"

        #compile program
        iverilog -Wall -g 2012 \
            -s test/${TESTNAME} \
            -o test/${TESTNAME} ${i} $1/mips_cpu_harvard.v $1/alucontrol.v $1/data_address_control.v $1/hilo.v $1/link.v $1/lw.v $1/pc_update.v $1/register_file.v $1/control.v $1/data_memory.v $1/instruction_memory.v $1/load.v $1/pc.v $1/unsign.v $1/alu.v $1/branch_data.v $1/shift_control.v $1/sb.v

        #run program    
        set +e
        ./test/${TESTNAME}
        RESULT=$?
        set -e
        if [[ RESULT -eq 0 ]] ; then
            echo "${TESTNAME} ${instruction} Pass"
        else
            echo "${TESTNAME} ${instruction} Fail"
        fi
    done
else
    echo "Implement all instruction"
    TESTCASES="test/*.v"
    for i in ${TESTCASES} ; do
        echo "$i"
        TESTNAME=$(basename ${i} .v)
        echo "$TESTNAME"
        #compile program
        iverilog -Wall -g 2012 \
            -s test/${TESTNAME} \
            -o test/${TESTNAME} ${i} $1/mips_cpu_harvard.v $1/alucontrol.v $1/data_address_control.v $1/hilo.v $1/link.v $1/lw.v $1/pc_update.v $1/register_file.v $1/control.v $1/data_memory.v $1/instruction_memory.v $1/load.v $1/pc.v $1/unsign.v $1/alu.v $1/branch_data.v $1/shift_control.v $1/sb.v

        #run program    
        set +e
        ./test/${TESTNAME}
        RESULT=$?
        set -e
        if [[ RESULT -eq 0 ]] ; then
            echo "${TESTNAME} ${TESTNAME:: -1} Pass"
        else
            echo "${TESTNAME} ${TESTNAME:: -1} Fail"
        fi

        
    done

fi

