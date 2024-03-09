#!/bin/bash

echo "\n"

echo "*************************************"
echo "*    Hadoop Single Node Cluster     *"
echo "*************************************"

# 0. Loading Variables

# 1. Adding hosts
echo ">>>> 1. Loading variables ..."
source conf/config.sh
printf "<<<< 1. done. \n\n"

# 2. Installing & Configuring SSH
echo $HADOOP_USER_PASSWORD | sudo -S apt update -y 

echo $HADOOP_USER_PASSWORD | sudo -S apt install ssh -y

echo $HADOOP_USER_PASSWORD | sudo -S apt install pdsh -y

echo ">>>> 2. Enabling SSH paswordless connection... <<<<"

ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa # generate ssh key for the node

cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

chmod 0600 ~/.ssh/authorized_keys

printf "<<<< 2. done. \n\n"

# Installing Java 8
echo ">>>> 3. Installing Java... <<<<"

echo $HADOOP_USER_PASSWORD | sudo -S apt install openjdk-8-jre-headless -y 

echo $HADOOP_USER_PASSWORD | sudo -S apt install openjdk-8-jdk -y

# Installing Hadoop 3.3.6
echo ">>>> 4. Installing Hadoop... <<<<"

mkdir -p $HADOOP_PARENT_DIR/dfs/{data322,name332}

echo ">>>> Downloading hadoop-3.3.6 <<<<"

wget $HADOOP_ORIGIN

echo ">>>> Extracting hadoop... <<<<"

echo $HADOOP_USER_PASSWORD | sudo -S tar -xzf hadoop-3.3.6.tar.gz -C $HADOOP_PARENT_DIR && rm -rf hadoop-3.3.6.tar.gz

# Configuring Hadoop
echo ">>>> 5. Configuring Hadoop... <<<<"

echo $HADOOP_USER_PASSWORD | sudo -S bash -c 'source conf/config.sh && echo "export JAVA_HOME=$JAVA_HOME" >> $HADOOP_PARENT_DIR/hadoop-3.3.6/etc/hadoop/hadoop-env.sh'

echo $HADOOP_USER_PASSWORD | sudo -S cp conf/hadoop/* $HADOOP_PARENT_DIR/hadoop-3.3.6/etc/hadoop/

echo $HADOOP_USER_PASSWORD | sudo -S rm $HADOOP_PARENT_DIR/hadoop-3.3.6/libexec/hadoop-functions.sh

echo $HADOOP_USER_PASSWORD | sudo -S cp conf/libexec/hadoop-functions.sh $HADOOP_PARENT_DIR/hadoop-3.3.6/libexec/

printf "<<<< 5. done. \n\n"

# Updating .bashrc
echo ">>>> 6. Updating .bashrc... <<<<"

## Add and export Java
echo $HADOOP_USER_PASSWORD | sudo -S bash -c 'source conf/config.sh && echo "JAVA_HOME=$JAVA_HOME" >> ~/.bashrc'

echo $HADOOP_USER_PASSWORD | sudo -S bash -c 'source conf/config.sh && echo "export JAVA_HOME" >> ~/.bashrc'

## Set PSDSH type to ssh
#echo $HADOOP_USER_PASSWORD | sudo -S bash -c 'echo "PDSH_RCMD_TYPE=ssh" >> ~/.bashrc'

## set Hadoop home directory
echo $HADOOP_USER_PASSWORD | sudo -S bash -c 'source conf/config.sh && echo "HADOOP_HOME=$HADOOP_PARENT_DIR/hadoop-3.3.6" >> ~/.bashrc'

## Update and export PATH
echo $HADOOP_USER_PASSWORD | sudo -S bash -c "source conf/config.sh && echo PATH='$'PATH:'$'HADOOP_HOME/bin:'$'HADOOP_HOME/sbin >> ~/.bashrc"

echo $HADOOP_USER_PASSWORD | sudo -S bash -c 'source conf/config.sh && echo "export PATH" >> ~/.bashrc'

## Load bash profile changes into current terminal session

source ~/.bashrc

printf "<<<< 6. done. \n\n"


