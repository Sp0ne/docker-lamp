SHELL := /bin/bash
.DEFAULT_GOAL := help

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

env: ## Init Env file
	cp .env.dist .env

run: ## Start docker
	./console/run.sh

run-build: ## Build docker and start it
	./console/run.sh -f

run-php: ## Access into your container php
	./console/run-php.sh

generate-vhosts: ## Create vhosts files .conf
	./console/run-vhosts.sh

check-vhosts: ## Check if url is available
	./console/run-vhosts-check.sh

refresh-repos: ## Git Pull on ALL FOLDER of project
	./console/git-refresh-projects.sh
