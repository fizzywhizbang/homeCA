#!/usr/bin/env bash
echo "This creates the CSR and generates the certificate:"
read -p "Certificate Authority for this request:" CA
read -p "Enter Common Name (Workstation 1):" CN
read -p "Two Letter Country:" C
read -p "Two Letter State:" ST
read -p "City:" L
read -p "Organization:" O
read -p "Organizational Unit:" OU
read -p "Host name (ws1.example.com):" HOST
mkdir -p clients
JSON_STRING='
{
  "CN": "'${CN}'",
  "key": {
    "algo": "rsa",
    "size": 2048
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
  "hosts": ["'${HOST}'"]
}
'

echo $JSON_STRING > "clients/${HOST}-csr.json"
cfssl gencert -ca="intermediate/${CA}_sig.pem" -ca-key="intermediate/${CA}-key.pem" -config="intermediate/${CA}-config.json" -profile=client "clients/${HOST}-csr.json" | cfssljson -bare "clients/${HOST}"