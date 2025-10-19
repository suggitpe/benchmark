#!/usr/bin/env bash

SCRIPT_DIR=`pwd`
MAVEN_HOME=$(realpath `find . -type d -name "apache-maven-*" -print -quit`)
ZULU_11_HOME=$(realpath `find . -type d -name "zulu11*" -print -quit`)
ZULU_21_HOME=$(realpath `find . -type d -name "zulu21*" -print -quit`)
JAVA_HOME=${ZULU_11_HOME}
GIT_HOME=`which git`
chmod 755 ${MAVEN_HOME}/bin/*
MAVEN_OPTS="-Dmaven.wagon.http.ssl.insecure=true -Dmaven.resolver.transport=wagon -Dmaven.javadoc.skip=true -Dmaven.repo.local=${SCRIPT_DIR}/m2"
PATH=${JAVA_HOME}/bin:/bin:/usr/bin:${MAVEN_HOME}/bin:${PATH}

rm -fr ${SCRIPT_DIR}/guava
rm -fr ${SCRIPT_DIR}/m2

git status
