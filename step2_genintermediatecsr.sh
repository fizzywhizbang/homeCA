#!/usr/bin/env bash
echo "This creates the JSON version of the server CSR then create the encrypted CSR"

echo "These will be saved in the intermediate directory"
read -p "Enter Common Name (Smith CO Intermediate CA):" CN
read -p "Two Letter Country:" C
read -p "Two Letter State:" ST
read -p "City:" L
read -p "Organization:" O
read -p "Organizational Unit:" OU
read -p "Name for the CSR (intca.example.com):" FNAME
mkdir -p intermediate
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
  ]
}
'
echo $JSON_STRING > "intermediate/${FNAME}-csr.json"

echo "Creating keys"
cfssl genkey "intermediate/${FNAME}-csr.json" | cfssljson -bare intermediate/${FNAME} -

echo "Generating Intermediate Config"
JSON_STRING='
{
  "signing": {
    "default": {
      "expiry": "8760h"
    },
    "profiles": {
      "intermediate": {
        "usages": ["cert sign", "crl sign"],
        "expiry": "70080h",
        "ca_constraint": {
          "is_ca": true,
          "max_path_len": 1
        }
      }
    }
  }
}
'
echo $JSON_STRING > "intermediate/${FNAME}-config.json"

echo "Please check configurations before signing the intermediate certificates"