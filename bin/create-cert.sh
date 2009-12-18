#!/bin/bash

THISDIR="`dirname $0`"
LIBDIR="$THISDIR/../etc/"
if [ ! -f $LIBDIR/common-env.sh ]; then
  echo "Failure, cannot find environment definitions" >&2
  exit 1
fi
source $LIBDIR/common-env.sh

TARGET_DIR=$1
NEW_CN=$2
PUBPEM=$3
PRIVPEM=$4
PUBCA=$5
PRIVCA=$6


# ----------------------------------------------------------------------------

HOSTDN=`$JAVA_BIN $JAVA_OPTS $EXE_CREATE_NEW_CERT $TARGET_DIR $NEW_CN $PUBPEM $PRIVPEM $PUBCA $PRIVCA`
if [ $? -ne 0 ]; then
  echo "Problem creating cert, exiting."
  exit 1
fi

NEW_PRIVPEM="$TARGET_DIR/$PRIVPEM"

chmod 400 $NEW_PRIVPEM
if [ $? -ne 0 ]; then
  echo "Problem setting permissions on $NEW_PRIVPEM"
  exit 1
fi

echo "Created certificate for '$NEW_CN' @ $TARGET_DIR/$PUBPEM"
