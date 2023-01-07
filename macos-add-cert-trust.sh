read -p "Enter the name of the CA to add to your trust store:" CA
read -p "Is this an intermediate or root (I or R)" OPT

if [ $OPT == "I" ] || [ $OPT == "i" ]
then
    sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain "intermediate/${CA}_sig.pem"
else
    sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain "root/${CA}.pem"
fi