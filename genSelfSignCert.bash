#!/bin/bash
openssl genrsa -out site1.internal.key 4096
openssl req -new -out site1.internal.csr -sha256 -key site1.internal.key -subj "/C=US/ST=California/L=Northridge/O=CIT384/OU=DogeSmirk/CN=site1.internal"
openssl x509 -req -in site1.internal.csr -days 365 -signkey site1.internal.key -out site1.internal.cert -outform PEM