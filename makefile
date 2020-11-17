SHELL := /bin/bash
.DEFAULT_GOAL := help

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

env: ## Init Env file
	cp .env.dist .env

run: ## Start docker
	./sh/run.sh

run-build: ## Build docker and start it
	./sh/run.sh -f

run-php: ## Access into your container php
	./sh/run-php.sh

generate-vhosts: ## Create vhosts files .conf
	./sh/run-vhosts.sh

check-vhosts: ## Check if url is available
	./sh/run-vhosts-check.sh

refresh-repos: ## Git Pull on ALL FOLDER of project
	./sh/git-refresh-projects.sh
