#!/bin/bash
set -e

echo "JAVA_HOME is ${JAVA_HOME}..."
echo "Starting DataNode..."
$HADOOP_HOME/sbin/hadoop-daemon.sh start datanode
tail -f /dev/null
