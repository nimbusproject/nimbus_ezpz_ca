#!/bin/bash

THISDIR="`dirname $0`"
LIBDIR="$THISDIR/../etc/"
if [ ! -f $LIBDIR/common-env.sh ]; then
  echo "Failure, cannot find environment definitions" >&2
  exit 1
fi
source $LIBDIR/common-env.sh

# ----------------------------------------------------------------------------

if [ ! -d $1 ]; then
  echo "Directory does not exist: $1" >&2
  exit 1
fi

$JAVA_BIN $JAVA_OPTS $EXE_CREATE_NEW_CA $1 $2
if [ $? -ne 0 ]; then
  echo "Problem creating new certificate authority, exiting." >&2
  exit 1
fi

CA_PUBPEM="$1/$2.pem"
CA_PUBPEM2="$1/$2.0"
CA_SIGNING_POLICY="$1/$2.signing_policy"
CA_PRIVPEM="$1/private-key-$2.pem"

chmod 400 $CA_PRIVPEM
if [ $? -ne 0 ]; then
  echo "Problem setting permissions on $CA_PRIVPEM" >&2
  exit 1
fi

$JAVA_BIN $JAVA_OPTS $EXE_WRITE_SIGNING_POLICY $CA_PUBPEM $CA_SIGNING_POLICY
if [ $? -ne 0 ]; then
  echo "Problem creating new certificate authority signing policy, exiting." >&2
  exit 1
fi

cp $CA_PUBPEM $CA_PUBPEM2
if [ $? -ne 0 ]; then
  echo "Problem creating certificate authority, exiting." >&2
  exit 1
fi

echo "Created certificate authority @ $1"
