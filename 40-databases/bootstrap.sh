#!/bin/bash

component=$1
environment=$2

dnf install ansible -y
# pip3.9 install botocore boto3
cd /home/ec2-user
git clone https://github.com/jayakumarm06/roboshop-ansible-v3.git
cd roboshop-ansible-v3
git pull # when you are runing for 2nd time,if there is any change in repo we can pull the changes
ansible-playbook -e component=$component -e env=$environment main.yaml