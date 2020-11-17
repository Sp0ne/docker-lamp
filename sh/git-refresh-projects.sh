#!/usr/bin/env bash

# Var
NOCOLOR='\033[0m'
RED='\033[1;31m'
GREEN='\033[1;32m'
ORANGE='\033[1;33m'
BLUE='\033[1;34m'

source "./.env"

function gitPull() {
    PATH_PROJECT_ABSOLUTE=$1;
    BRANCH=$2;
    if [ -d "${PATH_PROJECT_ABSOLUTE}/.git" ];then
         cd ${PATH_PROJECT_ABSOLUTE}
         git rev-parse --verify ${BRANCH} > /dev/null 2>&1
         if [ $? -eq 0 ]; then
            echo "[${BRANCH}]"
            git stash
            if [ $? -gt 0 ]; then
                return 1
            fi
            git reset --hard
            if [ $? -gt 0 ]; then
                return 2
            fi
            git checkout ${BRANCH}
            if [ $? -gt 0 ]; then
                return 3
            fi
            git pull origin ${BRANCH} --force
            if [ $? -gt 0 ]; then
                return 4
            fi
            echo ""
         fi
    fi

    return 0;
}

function gitFetch() {
    PATH_PROJECT_ABSOLUTE=$1;
    if [ -d "${PATH_PROJECT_ABSOLUTE}/.git" ];then
         cd ${PATH_PROJECT_ABSOLUTE}
         git fetch -a
         if [ $? -gt 0 ]; then
            return 1
         fi
    fi

    return 0;
}
I=0
declare -A ERRORS
function addError() {
    ERRORS[$I]=$1
    I=I+1;
}


echo ${PROJECT_PATH}
PP=${PROJECT_PATH}
TTT=$(cd ${PP} && ls)

for FOLDER_PROJECT in ${TTT}; do
    FOLDER_PROJECT_ABSOLUTE="${PP}/${FOLDER_PROJECT}"
    if [ -d "${FOLDER_PROJECT_ABSOLUTE}/.git" ];then
        echo ""
        echo "---------------------------------------"
        echo -e "${GREEN}${FOLDER_PROJECT}${NOCOLOR}"
        echo "---------------------------------------"

        gitFetch "${FOLDER_PROJECT_ABSOLUTE}"
        if [ $? -gt 0 ]; then
            ERRORS[$I]="${FOLDER_PROJECT}--->[fetch]"
            ((I=I+1));
        fi
        gitPull "${FOLDER_PROJECT_ABSOLUTE}" "master"
        if [ $? -gt 0 ]; then
            ERRORS[$I]="${FOLDER_PROJECT}--->[gitPull-master]"
            ((I=I+1));
        fi
        gitPull "${FOLDER_PROJECT_ABSOLUTE}" "develop"
        if [ $? -gt 0 ]; then
            ERRORS[$I]="${FOLDER_PROJECT}--->[gitPull-develop]"
            ((I=I+1));
        fi
        echo ""
    fi
done

for ER in ${ERRORS[*]}; do
    echo "ERROR ${ER}"
done

echo ""
echo "Done"
