#!/usr/bin/env bash

echo ""
echo "Running Docker container."
echo ""

source "./.env"

DOCKER="docker-compose -f ./docker-compose.yml -p ${PROJECT_NAME}"

echo "${DOCKER}"
echo ""

# stop current containers
${DOCKER} stop

# if options
case $1 in
        -f|--f|-force|--force)
            #stop current containers
            ${DOCKER} stop
            #force recreate to
            ${DOCKER} rm -f
            #build and run
            ${DOCKER} build
            #recreate
            ${DOCKER} up -d --force-recreate
        ;;
    *)
    ${DOCKER} up -d "$1"
esac

echo ""
echo "All done."
echo ""

