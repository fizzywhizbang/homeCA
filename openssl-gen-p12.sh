#!/usr/bin/env bash

read -p "Enter the certificate file name without file extension '.pem':" PEM
read -p "Include the CA bundle (Y or N):" B

if [ $B == "Y" ] || [ $B == "y" ]
then
read -p "Please include the CA name for bundle:" CA
    openssl pkcs12 -export -out "clients/${PEM}-bundle.p12" -inkey "clients/${PEM}-key.pem" -in "clients/${PEM}.pem" -certfile "intermediate/${CA}_sig.pem"
else
    openssl pkcs12 -export -out "clients/${PEM}.p12" -inkey "clients/${PEM}-key.pem" -in "clients/${PEM}.pem"
fi