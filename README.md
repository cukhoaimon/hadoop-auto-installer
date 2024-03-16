# Hadoop Auto Installer
## Purpose
This repository is an installer for who want to Setting up a **Hadoop Single Node Cluster** on Windows using WSL.
 
## Prerequisites
A Windows OS with WSL installed, notice that this repository was just tested on Ubuntu distribution. 

Install git in WSL
```
sudo apt-get update && sudo apt-get install git
```

## Usage
### Clone repository 
Open windows terminal, start WSL
```
wsl --distribution Ubuntu # or Ubuntu-22.04, ....
```

```
git clone https://github.com/cukhoaimon/hadoop-auto-installer && cd hadoop-auto-installer
```

### Change environment variables
#### In file `conf/config.sh`
- Change `HADOOP_USER_PASSWORD` to the password of your wsl. 
```
HADOOP_USER_PASSWORD=[your wsl-password]
```

- Change `HADOOP_PARENT_DIR` to your username. Note that the `username` is the `username` of WSL distribution, not your windows `username` (but some case your windows username and wsl username is the same). 
```
HADOOP_PARENT_DIR=/home/[wsl-username]/hadoop
```

#### In file `conf/hadoop/hadoop-env.sh`
- Change all below env variables to your wsl username
```
# Set Hadoop-specific environment variables here.
export HDFS_NAMENODE_USER=[wsl-username]
export HDFS_DATANODE_USER=[wsl-username]
export HDFS_SECONDARYNAMENODE_USER=[wsl-username]
export YARN_RESOURCEMANAGER_USER=[wsl-username]
export YARN_NODEMANAGER_USER=[wsl-username]
``` 

#### In file `conf/hadoop/hdfs-site.xml`
Change the value of username to your username

```
<configuration>
     <property>
         <name>dfs.replication</name>
         <value>1</value>
     </property>
     <property>
         <name>dfs.namenode.name.dir</name>
         <value>/home/[wsl-username]/hadoop/dfs/name332</value>
     </property>
     <property>
         <name>dfs.datanode.data.dir</name>
         <value>/home/[wsl-username]/hadoop/dfs/data332</value>
     </property>
</configuration>
```

### Run installer
```
chmod +rwx install-hadoop.sh && ./install-hadoop.sh
```

### Verify install
```
cd ~/hadoop/hadoop-3.3.6/
```

Run format name node
```
bin/hdfs namenode -format
```

Start Daemon
```
sbin/start-dfs.sh
```

Go to web browser and check NameNode at `http://localhost:9870/`

Start YARN
```
sbin/start-yarn.sh
```

Go to web browser and check Yarn `http://localhost:8088/`

## Reference
For Vietnamese step-by-step guide, please check this [link](https://tan-egg-884.notion.site/Hadoop-C-i-t-Single-Node-Cluster-fc4db79869b746229ec1a2cdf42ae259?pvs=4)
