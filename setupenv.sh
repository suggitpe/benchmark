#!/bin/sh
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

echo "Cleaning from previous runs"
rm -fr apache-maven-*

echo "Running in ${SCRIPT_DIR}"
echo "📦 Downloading Apache Maven ${MVN_VERSION}..."
if curl -o ${MVN_FILE} -fLO "$MVN_URL"; then
    echo "✅ Download complete."
else
    echo "❌ Download failed from $MVN_URL"
    exit 1
fi

tar -xf ${MVN_FILE}
rm ${MVN_FILE}

echo "📦 Downloading Zulu 11 from ${ZULU11_URL}"
if curl -o ${ZULU11_FILE} -fLO "$ZULU11_URL"; then
    echo "✅ Download complete."
else
    echo "❌ Download failed from $ZULU11_URL"
    exit 1
fi

echo "📦 Downloading Zulu 21 from ${ZULU21_URL}"
if curl -o ${ZULU21_FILE} -fLO "$ZULU21_URL"; then
    echo "✅ Download complete."
else
    echo "❌ Download failed from $ZULU21_URL"
    exit 1
fi

tar -xf ${ZULU11_FILE}
tar -xf ${ZULU21_FILE}
rm ${ZULU11_FILE}
rm ${ZULU21_FILE}
