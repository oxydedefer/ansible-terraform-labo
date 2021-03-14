NAME = oxydedefer-labo/ansible-terraform
ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
SSH_LOCATION:=$(HOME)/.ssh
ANSIBLE_VAULT_PASSWORD=?
VAULT_PATH= $(ROOT_DIR)/inventories/TARGET/group_vars/vault.yml

all: build

build:
	docker build -t $(NAME):latest .

clean:
	docker stop $(NAME)
	docker rm $(NAME)

run:
	docker run --rm -ti $(NAME) ansible --version

debug:
	docker run --rm -ti -v $(ROOT_DIR):/app -v $(SSH_LOCATION):/home/.ssh $(NAME):latest sh

deploy_aws:
	bash deploy-aws.sh

edit_vault:
	ansible-vault edit $(VAULT_PATH)

