if [ ! "X$AUTOCOMMON_ENVIRONMENT_DEFINED" = "X" ]; then
  return 0
fi

BASEDIR_REL="`dirname $0`/.."
BASEDIR=`cd $BASEDIR_REL; pwd`

AUTOCOMMON_DIST_DIR=$BASEDIR/dist
export AUTOCOMMON_DIST_DIR

AUTOCOMMON_BUILD_FILE=$BASEDIR/build.xml
export AUTOCOMMON_BUILD_FILE

JAVA_BIN="java"

function nobin() {
  echo -e "\nERROR: cannot find $1\n - install $1\n - OR adjust the configuration value at the top of this script to point to $1\n" >&2
  exit 1
}

JAVA_OPTS="-classpath ."

AUTOCOMMON_CLASSPATH_BASE1=$BASEDIR/dist
AUTOCOMMON_CLASSPATH_BASE2=$BASEDIR/lib

for directory in $AUTOCOMMON_CLASSPATH_BASE1 $AUTOCOMMON_CLASSPATH_BASE2; do
    if [ -d $directory ]; then
      for f in `ls $directory`; do
        JAVA_OPTS="$JAVA_OPTS:$directory/$f"
      done
    fi
done

export JAVA_OPTS

EXE_JVMCHECK="org.nimbustools.auto_common.JVMCheck"
export EXE_JVMCHECK

CAPTURE=`$JAVA_BIN -version 2>&1`
if [ $? -ne 0 ]; then
  nobin java
fi

$JAVA_BIN $JAVA_OPTS $EXE_JVMCHECK
if [ $? -ne 0 ]; then
  exit 1
fi

EXE_HOSTGUESS="org.nimbustools.auto_common.HostGuess"
export EXE_HOSTGUESS

EXE_LOGICAL_HOST="org.nimbustools.auto_common.confmgr.AddOrReplaceLogicalHost"
export EXE_LOGICAL_HOST

EXE_PUBLISH_HOST="org.nimbustools.auto_common.confmgr.AddOrReplacePublishHostname"
export EXE_PUBLISH_HOST

EXE_GLOBUS_SECDESC="org.nimbustools.auto_common.confmgr.AddOrReplaceGlobalSecDesc"
export EXE_GLOBUS_SECDESC

EXE_NEW_GRIDMAPFILE="org.nimbustools.auto_common.confmgr.ReplaceGridmap"
export EXE_NEW_GRIDMAPFILE

EXE_NEW_HOSTCERTFILE="org.nimbustools.auto_common.confmgr.ReplaceCertFile"
export EXE_NEW_HOSTCERTFILE

EXE_NEW_HOSTKEYFILE="org.nimbustools.auto_common.confmgr.ReplaceKeyFile"
export EXE_NEW_HOSTKEYFILE

EXE_CREATE_CONTAINER_DIR="org.nimbustools.auto_common.dirmgr.CreateNewNumberedDirectory"
export EXE_CREATE_CONTAINER_DIR

EXE_CREATE_NEW_CA="org.nimbustools.auto_common.ezpz_ca.GenerateNewCA"
export EXE_CREATE_NEW_CA

EXE_CREATE_NEW_CERT="org.nimbustools.auto_common.ezpz_ca.GenerateNewCert"
export EXE_CREATE_NEW_CERT

EXE_WRITE_SIGNING_POLICY="org.nimbustools.auto_common.ezpz_ca.SigningPolicy"
export EXE_WRITE_SIGNING_POLICY

EXE_CREATE_CRL="org.nimbustools.auto_common.ezpz_ca.GenerateCRL"
export EXE_CREATE_CRL

EXE_KEYSTORE_FROM_PEM="org.nimbustools.auto_common.ezpz_ca.KeystoreFromPEM"
export EXE_KEYSTORE_FROM_PEM

EXE_FIND_CA_PUBPEM="org.nimbustools.auto_common.ezpz_ca.FindCAPubFile"
EXE_FIND_CA_PRIVPEM="org.nimbustools.auto_common.ezpz_ca.FindCAPrivFile"
export EXE_FIND_CA_PUBPEM EXE_FIND_CA_PRIVPEM

EXE_CREATE_NEW_CERT_SHELL_SCRIPT_NAME="create-new-cert.sh"
export EXE_CREATE_NEW_CERT_SHELL_SCRIPT_NAME

AUTOCOMMON_ENVIRONMENT_DEFINED="X"
export AUTOCOMMON_ENVIRONMENT_DEFINED
