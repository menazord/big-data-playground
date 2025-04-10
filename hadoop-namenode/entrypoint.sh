#!/bin/bash
set -e

echo "JAVA_HOME is ${JAVA_HOME}..."
if [ ! -d "/home/hadoop/dfs/name/current" ]; then
  echo "Formatting NameNode..."
  $HADOOP_HOME/bin/hdfs namenode -format -force -nonInteractive
else
  echo "NameNode already formatted."
fi

echo "Starting HDFS services..."
$HADOOP_HOME/sbin/start-dfs.sh

echo "Starting NameNode..."
$HADOOP_HOME/bin/hdfs namenode
