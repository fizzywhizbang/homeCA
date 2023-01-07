#!/usr/bin/env bash

RED='\033[0;41;30m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
STD='\033[0;0;39m'

pasue(){
    echo "Done"
    sleep 1
}

if [ -d "root" ]
then
    ROOT="True"
else
    ROOT="False"
fi
if [ -d "intermediate" ]
then
    INTERMEDIATE="True"
else
    INTERMEDIATE="False"
fi

show_menuOpts() {
    clear
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    if [ ${ROOT} == "True" ]
    then
       echo -e " ${BLUE}CFSSL Script Menu ${RED}(Root CA exists)${STD}"
    else
       echo -e " ${BLUE}CFSSL Script Menu${STD}"
    fi 
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo -e "1. ${GREEN}Generate Root CA CSR (only need to do this once)${STD}"
    #these options shoudn't be available if there is no root
    if [ ${ROOT} == "True" ] 
    then
        echo -e "2. ${GREEN}Generate Intermediate CA CSR${STD}"
        if [ ${INTERMEDIATE} == "True" ] 
        then
            echo -e "3. ${GREEN}Sign Intermediate CA CSR${STD}"
            echo -e "4. ${GREEN}Generate a Client Certificate${STD}"
            echo -e "5. ${GREEN}Generate a Server Certificate${STD}"
        fi
    fi
    echo -e "q. ${BLUE}Exit${STD}"
}

read_options(){
    local choice
    read -p "Enter choice: " choice
    case $choice in
        1) one ;;
        2) two ;;
        3) three ;;
        4) four ;;
        5) five ;;
        # 99) exit 0;;
        [q,Q]) exit 0 ;;

        *) echo -e "${RED}Error... Command not correct ${STD}" && sleep 1 #capture error
    esac
}

one() {
    ./step1_genrootcsr.sh
}
two() {
    ./step2_genintermediatecsr.sh
}
three() {
    ./step3_signintermediate.sh
}
four() {
    ./step4_genclient.sh
}
five() {
    ./step4_genserver.sh
}

while true  
    do
        show_menuOpts
        read_options
    done