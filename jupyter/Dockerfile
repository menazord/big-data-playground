FROM jupyter/pyspark-notebook:latest

ENV SPARK_MAJOR_VERSION=3.5
ENV SCALA_VERSION=2.12
ENV ICEBERG_VERSION=1.8.1
ENV ICEBERG_JAR="iceberg-spark-runtime-${SPARK_MAJOR_VERSION}_2.12-${ICEBERG_VERSION}.jar"

ENV SPARK_HOME="/usr/local/spark"
# Add any additional configurations or dependencies if needed
# For example:
USER root
# RUN apt-get update && apt-get install -y your-package-name

# Iceberg support
RUN \
    mkdir -p /home/iceberg/spark-events && \
    chown -R $NB_UID:${NB_GID} /home/iceberg/spark-events && \
    curl https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-${SPARK_MAJOR_VERSION}_2.12/${ICEBERG_VERSION}/$ICEBERG_JAR -Lo ${SPARK_HOME}/jars/$ICEBERG_JAR

# Spark defaults
COPY config/spark-defaults.conf $SPARK_HOME/conf/spark-defaults.conf

# Switch back to the default jovyan user
USER $NB_UID

# Just for fun, let's add more kernels
RUN \
    pip install toree && \
    jupyter toree install --user --spark_home=${SPARK_HOME}

ENV HADOOP_USER_NAME=hdfs