#!/bin/bash

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <DATASET>" >&2
    exit 1
fi

DATASET="$1"
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
EXPECTED_FILE="${SCRIPT_DIR}/results/_query_results/expected_${DATASET}"
ACTUAL_FILE="${SCRIPT_DIR}/results/_query_results/actual_${DATASET}"

if [[ ! -f "$EXPECTED_FILE" ]]; then
    echo "Error: expected query results file not found: $EXPECTED_FILE" >&2
    exit 1
fi

echo "Comparing query results:" >&2
echo "  expected: $EXPECTED_FILE" >&2
echo "  actual:   $ACTUAL_FILE" >&2

if ! cmp -s "$EXPECTED_FILE" "$ACTUAL_FILE"; then
    echo "Error: actual query results differ from expected query results." >&2
    diff -u "$EXPECTED_FILE" "$ACTUAL_FILE" >&2 || true
    exit 1
fi

echo "Query results match expected output." >&2
