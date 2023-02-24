#!/bin/bash
set -e
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color
basicAuth="${username}:${password}"
basicAuthBase64=$(echo -n "${basicAuth}" | base64)
tokenAuth="${token}"
resultsFile="${SmokeTestFrameworkParallelQuitFast}/results.log"
displayNoColour=$1

backgroundTearDown(){
  if test ! -f "${SmokeTestFrameworkParallelQuitFast}/errorStatus.txt"; then
      echo "Please note, the job aborted early!" > "${SmokeTestFrameworkParallelQuitFast}/errorStatus.txt" &
  fi
  trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT
  exit ${1}
}

runCleanUp() {
  fail=`grep -wc "FAILED!" ${resultsFile} || true`
  success=`grep -wc "OK!" ${resultsFile} || true`
  results=`cat ${resultsFile}`
  failer=`cat "${SmokeTestFrameworkParallelQuitFast}/errorStatus.txt" || true`
  printf "${results} \n"
  if [[ ${displayNoColour} = true ]]
  then
    printf "${failer} \n"
    printf "Successful Calls ${success} || Failed Calls: ${fail} \n"
  else
    printf "${RED}${failer}${NC} \n"
    printf "${GREEN}Successful Calls ${success} ${NC} || ${RED}Failed Calls: ${fail} ${NC} \n"
  fi
  rm ${resultsFile}
  if test -f "${SmokeTestFrameworkParallelQuitFast}/errorStatus.txt"; then
      rm "${SmokeTestFrameworkParallelQuitFast}/errorStatus.txt"
  fi
  exit ${1}
}

k6Run(){
  set -e
  k6 run --no-summary --quiet=true --env dataAnyInput="$2" --env token="Basic ${basicAuthBase64}" "$1" --console-output=${resultsFile} --address localhost:0 || backgroundTearDown 74 &
}

spinner()
{
  pid=$! # Process Id of the previous running command
  spin='-\|/'
  i=0
  while kill -0 $pid 2>/dev/null
  do
    i=$(( (i+1) %4 ))
    printf "\r${spin:$i:1}"
    sleep .1
  done
}

testRunner(){
  set -e
  #k6Run "${SmokeTestFrameworkParallelQuitFast}/FAILER.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  #k6Run "${SmokeTestFrameworkParallelQuitFast}/FAILER.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  #k6Run "${SmokeTestFrameworkParallelQuitFast}/FAILER.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"

  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadySmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestPositive.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CleanCoffeeMachineSmokeTestSpecialChars.js"
  k6Run "${SmokeTestFrameworkParallelQuitFast}/CoffeeReadyEmptyNameSmokeTest.js"

  milks=`cd ${SmokeTestFrameworkParallelQuitFast} && cat ../../TestData/milk.json`

  #echo -n ${milks} | jq -c '.milks[]' | while read milkIn; do
   # k6Run "${SmokeTestFrameworkParallelQuitFast}/MakeCoffeeSmokeTestPositive.js" "${milkIn}" &
  #done
 # k6Run "${SmokeTestFrameworkParallelQuitFast}/multipleStagedCallsMachineAudit.js"

  wait
}

testRunner & spinner && runCleanUp 0