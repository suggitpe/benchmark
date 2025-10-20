#!/usr/bin/env bash

SCRIPT_DIR=`pwd`
MAVEN_HOME=$(realpath `find . -type d -name "apache-maven-*" -print -quit`)
ZULU_11_HOME=$(realpath `find . -type d -name "zulu11*" -print -quit`)
ZULU_21_HOME=$(realpath `find . -type d -name "zulu21*" -print -quit`)

[ -z "$MAVEN_HOME" ] && echo "No Maven installed" || echo "Maven   - OK"
[ -z "$ZULU_11_HOME" ] && echo "No Zulu 11 installed" || echo "Zulu 11 - OK"
[ -z "$ZULU_21_HOME" ] && echo "No Zulu 21 installed" || echo "Zulu 21 - OK"

JAVA_HOME=${ZULU_21_HOME}
chmod 755 ${MAVEN_HOME}/bin/*
MAVEN_OPTS="-Dmaven.wagon.http.ssl.insecure=true -Dmaven.resolver.transport=wagon -Dmaven.javadoc.skip=true -Dmaven.repo.local=${SCRIPT_DIR}/m2"
PATH=${JAVA_HOME}/bin:/bin:/usr/bin:${MAVEN_HOME}/bin:${PATH}

echo "cleaning up from last run"
rm -fr ${SCRIPT_DIR}/guava
rm -fr ${SCRIPT_DIR}/m2
rm -f *.txt

echo "Cloning a fresh copy of Guava ... this will take a moment"
export GIT_NO_SSL_VERIFY=true
{ time git clone https://github.com/google/guava.git ; } 2> clone-time.txt
if [ ! -d "$SCRIPT_DIR/guava" ]; then
	echo "Failed to get clone of gauva"
	exit 1
fi

pushd guava

echo "Switching to version 33.3.1 for consistent timing"
git checkout tags/33.3.1

echo "deleting the consistently failing test"
rm -f guava-tests/test/com/google/common/util/concurrent/ServiceManagerTest.java

echo "clean build with no cached maven artifacts"
{ time mvn $MAVEN_OPTS clean -U install ; } 2> ../mvn-package-uncached.txt

echo "clean build with previously cached maven artifacts"
{ time mvn $MAVEN_OPTS clean install ; } 2> ../mvn-package-cached.txt

popd

echo "Clone time    --> $(cat clone-time.txt | grep "real" | awk '{print $2}')"
echo "Uncached time --> $(cat mvn-package-uncached.txt | grep real | awk '{print $2}')"
echo "Cached time   --> $(cat mvn-package-cached.txt | grep real | awk '{print $2}')"
echo "CPU Model     --> $(grep -m 1 "model name" /proc/cpuinfo | cut -d ':' -f2 | sed 's/^ *//')"
echo "Processor     --> $(nproc) Logical Cores"
echo "RAM           --> $(free -g | awk '/^Mem:/ {print $2}') Gb"


