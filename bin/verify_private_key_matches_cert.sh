#!/bin/bash

CERT_PATH=$1
PRIVATE_KEY_PATH=$2

CERT_CHECKSUM="$(openssl x509 -noout -modulus -in $CERT_PATH | openssl md5)"
PRIVATE_KEY_CHECKSUM="$(openssl rsa -noout -modulus -in $PRIVATE_KEY_PATH | openssl md5)"

echo "CERT CHECKSUM:       $CERT_CHECKSUM"
echo "PRIVATE KEY CHECKSM: $PRIVATE_KEY_CHECKSUM"

# Exit status based on whether they match or not
[ "$CERT_CHECKSUM" = "$PRIVATE_KEY_CHECKSUM" ]
