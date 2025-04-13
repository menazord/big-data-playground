#!/bin/bash
set -e

echo "JAVA_HOME is ${JAVA_HOME}..."

# Start Hadoop (necessary for Hive)
$HADOOP_HOME/sbin/start-dfs.sh

# Initialize the Hive Metastore schema if not already initialized
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
if schematool -dbType postgres -info | grep -q "Schema version"; then
    echo "Hive schema already initialized."
else
    echo "Initializing Hive schema..."
    schematool -dbType postgres -initSchema || echo "Schema already initialized or encountered an error"
fi
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

# Start Hive Metastore
hive --service metastore &

# Start HiveServer2
hive --service hiveserver2