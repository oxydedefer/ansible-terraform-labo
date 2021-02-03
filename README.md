# ansible-terraform-labo
In this repo you will find everything you need to create an AWS EC2 instance orchestrated by Ansible. The goal is to learn the basic use of terraform - ansible. 

### Requirements:
Make => ```sudo apt-get install build-essential on ubuntu```
docker => https://docs.docker.com/engine/install/ubuntu/ 


### How to get started:

Build the docker image by doing 
make build 
or
docker build -t oxydedefer-labo / ansible-terraform: latest.


First you will have to create a vault file with the following variable 
```
access_key: "XXXXXXXXXXXXXXXXXXXXX"
secret_key: "XXXXXXXXXXXXXXXXXXXXXXXXXXX"
ssh_public_key: "ssh-rsa XXXXXXXXXXXXXXXXXXXXXXXXXx
```
After you have create your vault file you need to set the path on ``` inventories/TARGET/group_vars/all.yml```
more information avout ansible vault : https://docs.ansible.com/ansible/latest/user_guide/vault.html



### RUN locally
```make deploy_aws```
or
```
bash deploy-aw
```
Insert your informations, be careful to follow the formatting.


### Debug and development

You can debug directly by launching the docker container with:
```make debug```
or
```
docker run --rm -ti -v / home / seb / workspace / ansible-terraform-labo: / app -v /$YOUR_HOME_FOLDER/.ssh:/home/.ssh oxydedefer-labo / ansible-terraform: latest sh
```