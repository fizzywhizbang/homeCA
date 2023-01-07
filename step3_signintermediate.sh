read -p "Intermediate CA CSR Name (intermediate.example.com):" INT
read -p "Root CA Certificate name (rootca.example.com):" ROOT
#cfssl sign -ca [ca cert] -ca-key [ca key] -config [config file to use] -profile [profile in the config] intermediate CSR | cfssljson to sign the CSR
cfssl sign -ca "root/${ROOT}.pem" -ca-key "root/${ROOT}-key.pem" -config "intermediate/${INT}-config.json" -profile "intermediate" "intermediate/${INT}.csr" | cfssljson -bare "intermediate/${INT}_sig"

echo "Please secure the root key ${ROOT}-key.pem in a safe place\nas the intermediate CA will handle issuing certs"