### Generic Variables
SHELL := /bin/bash

.PHONY: help
help: ## Display help message (*: main entry points / []: part of an entry point)
	@grep -E '^[0-9a-zA-Z_-]+\.*[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


################################################################################
# Hawaiian Airlines POC
################################################################################

.PHONY: install-collections
install-collections: ## Install ansible collections
	ansible-galaxy collection install git+https://github.com/ClausHolbechArista/ansible-avd.git#/ansible_collections/arista/avd/,feat/plugins/new-cvp-integration-library --force
	#  ansible-galaxy collection install git+https://github.com/gmuloc/avd.git#/ansible_collections/arista/avd/,make-wan-router-vteps-again --force
	# ansible-galaxy collection install community.general --force


.PHONY: wan-build
wan-build: ## Build wan WAN artifacts
	ansible-playbook playbooks/wan-build.yml -i inventory/inventory.yml

.PHONY: wan-deploy
wan-deploy: ## Deploy config to CV
	ansible-playbook playbooks/wan-deploy.yml -i inventory/inventory.yml -v

.PHONY: wan-validate
wan-validate: ## Deploy config to CV
	ansible-playbook playbooks/wan-validate.yml -i inventory/inventory.yml
