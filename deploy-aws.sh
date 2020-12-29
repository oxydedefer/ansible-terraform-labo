#!/bin/bash
# Read Password
echo -n Password:
read -s password
#docker run hello-world
docker run --rm -v $(pwd):/app -v $HOME/.ssh:/home/.ssh oxydedefer-labo/ansible-terraform:latest sh -c \
"ansible-galaxy install -r roles/requirements.yml; \
echo $password > /tmp/.vault_pass; \
ansible-playbook --vault-password-file /tmp/.vault_pass -i inventories/TARGET -e version=20.04 playbook-terraform.yml; \
ansible-playbook -i /tmp/hosts -e '{apps: [apache2]}' playbook-aws-config.yml"