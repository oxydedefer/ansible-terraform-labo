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

test_alive:
	docker run --rm -v $(ROOT_DIR):/app -v $(SSH_LOCATION):/home/.ssh $(NAME):latest bash -c "echo $(ANSIBLE_VAULT_PASSWORD) > /tmp/.vault_pass; ansible-playbook --vault-password-file /tmp/.vault_pass -i inventories/TARGET playbook_hosts_alive.yml"

edit_vault:
	ansible-vault edit $(VAULT_PATH)

