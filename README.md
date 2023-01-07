# homeCA
To keep it simple I created some bash scripts to quickly and easily setup a root CA and intermediate CA  
These scripts will ask questions and build the json files for you executing the necessary CFSSL  
commands to generate your Certificate Authority.

## Requirements
Install CFSSL https://github.com/cloudflare/cfssl  
MacOS or Linux system with Bash

## Instructions
each of these steps will ask for all the necessary input to complete its task  
If you like you can run the menu (./menu.sh) which may help getting started *or not*  
Run Step 1 to create your root ca *(this will create a directory named root)*  
Run Step 2 to generate CSR for your intermediate CA *(this will create a directory named intermediate and create your intermediate config file)*  
*note: these scripts allow for multiple intermediates*  
Run Step 3 to sign the certificates for the intermediate CA *(these will be saved with _sig in the name)*  
Run either of the two Step 4 files to create a client or a server certificate *(this will create a directory named clients)*  
  
### Additional files  
a script to convert pem to p12  
### MacOS
a script to add your cert to a MacOS trust store *(this will need to be manually trusted)*  
