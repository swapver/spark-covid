#!/bin/bash
sudo yum -y update
sudo yum install -y ruby
sudo yum install -y java-1.8.0-openjdk

## code deploy agent
cd /home/ec2-user
curl -O https://aws-codedeploy-us-east-2.s3.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto

wget https://artfiles.org/apache.org/spark/spark-2.4.5/spark-2.4.5-bin-hadoop2.7.tgz
tar -xzf spark-2.4.5-bin-hadoop2.7.tgz