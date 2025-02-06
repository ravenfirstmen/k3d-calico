#!/usr/bin/env bash

CERTS_FOLDER="./certs"

rm -rdf "${CERTS_FOLDER}"
mkdir -p "${CERTS_FOLDER}"


CA_FILE_NAME="ca"
ROOT_DOMAIN="127-0-0-1.nip.io"
CA_CN="ca.${ROOT_DOMAIN}"

# CA
openssl genrsa -out "${CERTS_FOLDER}/${CA_FILE_NAME}.key" 4096
openssl req -x509 -new -nodes \
  -key "${CERTS_FOLDER}/${CA_FILE_NAME}.key" \
  -sha256 -days 1826 \
  -out "${CERTS_FOLDER}/${CA_FILE_NAME}.crt" \
  -subj "/CN=${CA_CN}/C=PT/ST=Braga/L=Famalicao/O=Casa"

# Cert
DOMAIN="httpbin.${ROOT_DOMAIN}"
CERT_FILE_NAME="tls"

openssl genrsa -out "${CERTS_FOLDER}/${CERT_FILE_NAME}.key" 4096
openssl req -new \
  -key "${CERTS_FOLDER}/${CERT_FILE_NAME}.key" \
  -out "${CERTS_FOLDER}/${CERT_FILE_NAME}.csr" \
  -subj "/CN=${DOMAIN}/C=PT/ST=Braga/L=Famalicao/O=Casa"

cat <<EOT > "${CERTS_FOLDER}/${CERT_FILE_NAME}.ext"
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
IP.1 = 127.0.0.1
DNS.1 = localhost
DNS.2 = ${DOMAIN}
EOT

openssl x509 -req -in "${CERTS_FOLDER}/${CERT_FILE_NAME}.csr" \
  -CA "${CERTS_FOLDER}/${CA_FILE_NAME}.crt" \
  -CAkey "${CERTS_FOLDER}/${CA_FILE_NAME}.key" \
  -CAcreateserial \
  -out "${CERTS_FOLDER}/${CERT_FILE_NAME}.crt" \
  -days 825 -sha256 -extfile "${CERTS_FOLDER}/${CERT_FILE_NAME}.ext"

mkdir -p "${CERTS_FOLDER}"
cat <<EOT | kubectl apply -f -
---
apiVersion: v1
kind: Namespace
metadata:
  name: gloo-system
  labels:
    name: gloo-system
---
apiVersion: v1
kind: Secret
metadata:
  name: gloo-tls-ca
  namespace: gloo-system
type: kubernetes.io/tls  
data:
  tls.crt: $(base64 -w0 ${CERTS_FOLDER}/${CA_FILE_NAME}.crt)
  tls.key: $(base64 -w0 ${CERTS_FOLDER}/${CA_FILE_NAME}.key)
---
apiVersion: v1
kind: Secret
metadata:
  name: gloo-tls
  namespace: gloo-system
type: kubernetes.io/tls  
data:
  tls.crt: $(base64 -w0 ${CERTS_FOLDER}/${CERT_FILE_NAME}.crt)
  tls.key: $(base64 -w0 ${CERTS_FOLDER}/${CERT_FILE_NAME}.key)
EOT
