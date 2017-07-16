#!/bin/bash

function print_help {
    echo "./mv-recursive -f [--from] <FROM> -t [--to] <TO>"
    echo "where is FROM is the place from copy dir tree, TO - is the place to copy dir tree"
    echo
}

if [ "$1" = "-h" -o "$1" = "--help" ]; then
    print_help
    exit 0
fi

FROM_KEY=$1;FROM=$2;TO_KEY=$3;TO=$4;

if [ "$FROM_KEY" != "-f" -a "$FROM_KEY" != "--from" -a -z "$FROM" ]; then
    print_help
    echo "please enter from which directory move files"
    exit 0
fi

if [ "$TO_KEY" != "-t" -a "$TO_KEY" != "--to" -a -z "$TO" ]; then
    print_help
    echo "please enter to which directory move files"
    exit 0
fi

FROM_LEN=${#FROM}+1
TO_LEN=${#TO}+1
RELATIVE_EXISTS=
for ABSOLUTE_PATH in $( find "$FROM" ); do
    RELATIVE_PATH=${ABSOLUTE_PATH:$FROM_LEN}
    
    if ! [ -a "$TO"/"$RELATIVE_PATH" ]; then
	if [ -a "$ABSOLUTE_PATH" ]; then
	    echo mv "$FROM"/"$RELATIVE_PATH" "$TO"/"$RELATIVE_EXISTS"
	    mv "$FROM"/"$RELATIVE_PATH" "$TO"/"$RELATIVE_EXISTS"
	fi
    else
	if ! [ -d "$FROM"/"$RELATIVE_PATH" ]; then
	    if [ -a "$ABSOLUTE_PATH" ]; then
		echo cp -r "$FROM"/"$RELATIVE_PATH" "$TO"/"$RELATIVE_PATH"
		cp -r "$FROM"/"$RELATIVE_PATH" "$TO"/"$RELATIVE_PATH"
	    fi
	else
	    RELATIVE_EXISTS=${ABSOLUTE_PATH:$FROM_LEN}
	fi
    fi
done

