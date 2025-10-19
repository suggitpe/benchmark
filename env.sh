#!/usr/bin/env bash

SCRIPT_DIR=`pwd`
MVN_VERSION=3.8.5
MVN_URL="https://archive.apache.org/dist/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.tar.gz"
MVN_FILE="${SCRIPT_DIR}/maven.tar.gz"
ZULU11_URL=`curl -s "https://api.azul.com/metadata/v1/zulu/packages/?java_version=11&os=linux&arch=x86&java_package_type=jdk&archive_type=tar.gz&availability_types=CA&release_status=ga&page=1&page_size=1" \
  | jq -r '.[0].download_url'`
ZULU11_FILE="${SCRIPT_DIR}/zulu11.tar.gz"
ZULU21_URL=`curl -s "https://api.azul.com/metadata/v1/zulu/packages/?java_version=21&os=linux&arch=x86&java_package_type=jdk&archive_type=tar.gz&availability_types=CA&release_status=ga&page=1&page_size=1" \
  | jq -r '.[0].download_url'`
ZULU21_FILE="${SCRIPT_DIR}/zulu21.tar.gz"