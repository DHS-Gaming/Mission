#!/bin/bash

BLACKLIST="${1}"

FILE="${2}"

for BLACKLISTED in ${BLACKLIST}; do
  echo "// WARNING bin/slice.sh FILE IS BLACKLISTED: ${FILE}" | grep "${BLACKLISTED}" && exit 0
done

echo "//"
echo "// BEGIN OF bin/slice.sh ${2}"
echo "//"

LINES="$(grep -B99999 'class Intro' "${FILE}" | grep -A99999 -P '^\tclass Vehicles' | tail -n '+4' | wc -l)"

grep -B99999 'class Intro' "${FILE}" | \
    grep -A99999 -P '^\tclass Vehicles' | \
    tail -n '+4' | \
    head -n "$(( ${LINES} - 3 ))"

echo "//"
echo "// END OF bin/slice.sh ${2}"
echo "//"

