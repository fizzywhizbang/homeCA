#!/usr/bin/env bash
echo "This creates the JSON version of the server CSR then create the encrypted CSR"

echo "These will be saved in the root directory"
read -p "Enter Common Name (Smith CO Root CA):" CN
read -p "Two Letter Country:" C
read -p "Two Letter State:" ST
read -p "City:" L
read -p "Organization:" O
read -p "Organizational Unit:" OU
read -p "Name for the CSR (rootca.example.com):" FNAME
mkdir -p root
JSON_STRING='
{
  "CN": "'${CN}'",
  "key": {
    "algo": "ecdsa",
    "size": 256
  },
  "names": [
  {
    "C": "'${C}'",
    "ST": "'${ST}'",
    "L": "'${L}'",
    "O": "'${O}'",
    "OU": "'${OU}'"
  }
  ],
  "ca": {
    "expiry": "87600h"
  }
}
'
echo $JSON_STRING > "root/${FNAME}-csr.json"

echo "Creating keys"
cfssl gencert -initca "root/${FNAME}-csr.json" | cfssljson -bare root/${FNAME} -