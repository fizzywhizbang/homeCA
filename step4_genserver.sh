#!/usr/bin/env bash
echo "This creates the JSON version of the server CSR"
read -p "Enter Common Name (example.com):" CN
read -p "Two Letter Country:" C
read -p "Two Letter State:" ST
read -p "City:" L
read -p "Organization:" O
read -p "Organizational Unit:" OU
read -p "Host/alternative names comma separated and quoted (\"www.go.com\",\"go.com\",\"web1.go.com\"...):" HOSTS
read -p "Server Certificate is for (web1.example.com):" FNAME
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
  "hosts": [
    '${HOSTS}'
  ]
}
'

echo $JSON_STRING > "csr/${FNAME}-csr.json"
cfssl gencert -ca="intermediate/${CA}_sig.pem" -ca-key="intermediate/${CA}-key.pem" -config="intermediate/${CA}-config.json" -profile=server "clients/${FNAME}-csr.json" | cfssljson -bare "clients/${FNAME}"