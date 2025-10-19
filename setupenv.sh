#!/usr/bin/env bash

. env.sh

echo "Cleaning from previous runs"
rm -fr apache-maven-*
rm -fr zulu*

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
