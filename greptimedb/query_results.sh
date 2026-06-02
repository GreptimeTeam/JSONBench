#!/bin/bash

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <DATASET>" >&2
    exit 1
fi

DATASET="$1"
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
OUTPUT_FILE="${SCRIPT_DIR}/results/_query_results/actual_${DATASET}"

mkdir -p "$(dirname "$OUTPUT_FILE")"

QUERY_NUM=1

set -f
{
while IFS= read -r query; do
    if [[ "$QUERY_NUM" != "1" ]]; then
        echo
    fi

    echo "------------------------------------------------------------------------------------------------------------------------"
    echo "Result for query Q$QUERY_NUM:"
    echo

    curl -s --fail "http://localhost:4000/v1/sql?db=public&format=table" \
        --data-urlencode "sql=$query"
    exit_code=$?
    if [[ "$exit_code" != "0" ]]; then
        echo "Error: query Q$QUERY_NUM failed with exit code $exit_code"
    fi

    QUERY_NUM=$((QUERY_NUM + 1))
done < "${SCRIPT_DIR}/queries.sql"
} | tee "$OUTPUT_FILE"
