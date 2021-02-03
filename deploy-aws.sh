#!/bin/bash
# Read Password
echo -n Password:
read -s password
echo ""
echo -n version [18.04-20.04]:
read  version

echo -n App to install  [docker,apache2,node-expoter] separator [,]:
read  app


docker run --rm -v $(pwd):/app -v $HOME/.ssh:/home/.ssh oxydedefer-labo/ansible-terraform:latest sh -c \
"ansible-galaxy install -r roles/requirements.yml; \
echo $password > /tmp/.vault_pass; \
ansible-playbook --vault-password-file /tmp/.vault_pass -i inventories/TARGET -e version=$version playbook-terraform.yml; \
ansible-playbook -i /tmp/hosts -e '{apps: [$app]}' playbook-aws-config.yml"