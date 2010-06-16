#!/bin/bash

THISDIR="`dirname $0`"
LIBDIR="$THISDIR/../etc/"
if [ ! -f $LIBDIR/common-env.sh ]; then
  echo "Failure, cannot find environment definitions" >&2
  exit 1
fi
source $LIBDIR/common-env.sh

if [ $# -ne 4 ]; then
  echo "Not enough arguments, see README" >&2
  exit 1
fi

CERT_PATH=$1
KEY_PATH=$2
STORE_PATH=$3
PASSWORD=$4

# ----------------------------------------------------------------------------

$JAVA_BIN $JAVA_OPTS $EXE_KEYSTORE_FROM_PEM $CERT_PATH $KEY_PATH $STORE_PATH $PASSWORD
if [ $? -ne 0 ]; then
  echo "Problem creating keystore, exiting." >&2
  exit 1
fi

chmod 600 $STORE_PATH
if [ $? -ne 0 ]; then
  echo "Problem setting permissions on $STORE_PATH" >&2
  exit 1
fi

echo "Created keystore @ $STORE_PATH"
