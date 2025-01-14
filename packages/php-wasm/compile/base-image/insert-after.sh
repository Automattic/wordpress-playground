#!/bin/bash 

# This script is used to insert a string after matching a specified substring
# in a file and exits with a non-zero status if the reference substring is not found.

# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euo pipefail;

INSERTION_CONTENT="$1"
AFTER_SUBSTRING="$2"
FILENAME="$3"
ORIGINAL_CONTENT="$( < "$FILENAME")"

PREFIX="${ORIGINAL_CONTENT%%$AFTER_SUBSTRING*}${AFTER_SUBSTRING}"
if [[ -z $PREFIX ]]; then
	echo "Failed to find insertion index in file '$FILENAME' - exiting with non-zero status"
fi

PREFIX_LENGTH="${#PREFIX}"
SUFFIX="${ORIGINAL_CONTENT:PREFIX_LENGTH}"

UPDATED_CONTENT="${PREFIX}${INSERTION_CONTENT}${SUFFIX}"
echo "$UPDATED_CONTENT" > "$FILENAME"
