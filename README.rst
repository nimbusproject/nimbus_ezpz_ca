\:warning: **The Nimbus infrastructure project is no longer under development.** :warning:

For more information, please read the `news announcement <http://www.nimbusproject.org/news/#440>`_. If you are interested in providing IaaS capabilities to the scientific community, see `CHI-in-a-Box <https://github.com/chameleoncloud/chi-in-a-box>`_, a packaging of the `Chameleon testbed <https://www.chameleoncloud.org>`_, which has been in development since 2014.

----

=======================================
Passwordless/scriptable X509 CA library
=======================================


**This should only be used for test situations**

    http://github.com/nimbusproject/nimbus_ezpz_ca

    http://www.apache.org/licenses/LICENSE-2.0
    Copyright 2010 University of Chicago

    This library is used from scripts or Java.  Example invocations can be
    found in the bin directory, the "autocontainer/bin" Nimbus directory, and
    the "web/src/python/nimbusweb/setup/autoca.py" Nimbus file.

Prerequisites: Java 1.5+, Ant 1.6+

Build: ant dist

Usage example of the bin/ samples:

Create CA cert/key::

    CA_BASENAME=testca
    mkdir /tmp/ezpz_test
    ./bin/create-ca.sh /tmp/ezpz_test $CA_BASENAME
    
Create a trusted certificate directory with expected file names::

    mkdir /tmp/ezpz_test/trusted-certs
    CA_HASH=`openssl x509 -hash -noout -in /tmp/ezpz_test/$CA_BASENAME.0`
    CA_PUB="/tmp/ezpz_test/trusted-certs/$CA_HASH.0"
    CA_SP="/tmp/ezpz_test/trusted-certs/$CA_HASH.signing_policy"
    cp /tmp/ezpz_test/$CA_BASENAME.0 $CA_PUB
    cp /tmp/ezpz_test/$CA_BASENAME.signing_policy $CA_SP


Create a cert::

    CA_PRIV=/tmp/ezpz_test/private-key-$CA_BASENAME.pem
    HOSTNAME=example.com
    mkdir /tmp/ezpz_test/hostcertdir
    ./bin/create-cert.sh /tmp/ezpz_test/hostcertdir $HOSTNAME hostcert.pem hostkey.pem $CA_PUB $CA_PRIV

Create a JKS keystore for the host cert::

    HOSTCERT=/tmp/ezpz_test/hostcertdir/hostcert.pem
    HOSTKEY=/tmp/ezpz_test/hostcertdir/hostkey.pem
    JKS_TO_CREATE=/tmp/ezpz_test/hostcertdir/hostcert.jks
    JKS_PASSWORD="3con12oij32d"
    
    ./bin/create-jks.sh $HOSTCERT $HOSTKEY $JKS_TO_CREATE $JKS_PASSWORD
