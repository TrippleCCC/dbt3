#!/bin/bash
#
# This file is released under the terms of the Artistic License.
# Please see the file LICENSE, included in this package, for details.
#
# Copyright (C) 2003-2006 Jenny Zhang & Open Source Development Labs, Inc.
#
# May 26, 2005
# Mark Wong
# Rewritten from perl to bash.
#

DIR=`dirname $0`
source ${DIR}/dbt3_profile || exit 1

FLAG_POWER_TEST=0
FLAG_THROUGHPUT_TEST=0
while getopts "23i:n:o:p:s:z" OPT; do
	case ${OPT} in
	2)
		FLAG_POWER_TEST=1
		;;
	3)
		FLAG_THROUGHPUT_TEST=1
		;;
	i)
		INFILE=${OPTARG}
		;;
	n)
		STREAMS=${OPTARG}
		;;
	o)
		OUTFILE=${OPTARG}
		;;
	p)
		PERFNUM=${OPTARG}
		;;
	s)
		SCALE_FACTOR=${OPTARG}
		;;
	z)
		NO_REFRESH_FLAG="-z"
		;;
	esac
done

SCRIPT_DIR="${DBT3_HOME}/scripts/${DATABASE}";

#
# Make sure the outfile is created.
#
cat /dev/null >  ${OUTFILE}

if [ ${FLAG_POWER_TEST} -eq 1 ]; then
	POWER=`${SCRIPT_DIR}/dbt3-power-score -i ${INFILE} -p ${PERFNUM} -s ${SCALE_FACTOR} ${NO_REFRESH_FLAG}`
	echo "power = ${POWER}" | tee -a ${OUTFILE}
fi

if [ ${FLAG_THROUGHPUT_TEST} -eq 1 ]; then
	THROUGHPUT=`${SCRIPT_DIR}/get-throughput -i ${INFILE} -p ${PERFNUM} -s ${SCALE_FACTOR}`
	echo "throughput = ${THROUGHPUT}" | tee -a ${OUTFILE}
fi

if [ ${FLAG_POWER_TEST} -eq 1 ] && [ ${FLAG_THROUGHPUT_TEST} -eq 1 ]; then
	COMPOSITE=`echo "scale=2; sqrt(${POWER} * ${THROUGHPUT})" | bc -l`
	echo "composite = ${COMPOSITE}" | tee -a ${OUTFILE}
fi

exit 0
