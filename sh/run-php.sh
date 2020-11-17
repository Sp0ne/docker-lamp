#!/usr/bin/env bash

source "./.env"

DOCKER="docker-compose -f ./docker-compose.yml -p ${PROJECT_NAME}"
echo "${DOCKER}"
echo ""

#docker
${DOCKER} exec --user www-data webserver bash
