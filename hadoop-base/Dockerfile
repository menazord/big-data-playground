# Use base image

FROM ubuntu:latest

MAINTAINER Cristian Meneses <hello@cristianmeneses.io>

ARG DEBIAN_FRONTEND=noninteractive
ARG HADOOP_VERSION=3.4.1
ENV HADOOP_HOME=${HADOOP_HOME:-"/home/hadoop"}

# Install pre-requisites and clean cache
RUN apt-get -q update && \
    apt-get -q install -y --no-install-recommends \
      ca-certificates \
      curl \
      coreutils \
      openjdk-11-jdk \
      ssh \
      pdsh \
      netcat-openbsd \
      net-tools \
      sudo \
      gnupg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/sshd
RUN service ssh start

# Download binaries, checksum, signature, verify integrity and install
RUN \
    mkdir -p ${HADOOP_HOME} && \
    curl -fsSL https://dlcdn.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz -o hadoop-${HADOOP_VERSION}.tar.gz && \
    curl -fsSL https://downloads.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz.asc -o hadoop-${HADOOP_VERSION}.tar.gz.asc && \
    curl -fsSL https://downloads.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz.sha512 -o hadoop-${HADOOP_VERSION}.tar.gz.sha512 && \
    curl -fsSL https://downloads.apache.org/hadoop/common/KEYS | gpg --quiet --import - && \
    gpg --batch --verify hadoop-${HADOOP_VERSION}.tar.gz.asc hadoop-${HADOOP_VERSION}.tar.gz && \
    sha512sum -c hadoop-${HADOOP_VERSION}.tar.gz.sha512 && \
    mkdir -p ${HADOOP_HOME} && \
    tar -zxvf hadoop-${HADOOP_VERSION}.tar.gz --directory ${HADOOP_HOME} --strip-components=1 && \
    rm -r ${HADOOP_HOME}/share/doc && \
    rm -rf hadoop-${HADOOP_VERSION}.tar.*

# Directory setup
RUN \
    ln -s ${HADOOP_HOME}/etc/hadoop /etc/hadoop && \
    mkdir ${HADOOP_HOME}/tmp && \
    mkdir ${HADOOP_HOME}/logs && \
    mkdir ${HADOOP_HOME}/data && \
    useradd -m hdfs && \
    chown -R hdfs:hdfs ${HADOOP_HOME}


ENV HADOOP_USER_NAME=hdfs
ENV HDFS_NAMENODE_USER=hdfs
ENV HDFS_DATANODE_USER=hdfs
ENV HDFS_SECONDARYNAMENODE_USER=hdfs
ENV PATH=$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

# Set up passwordless SSH for Hadoop communication
RUN ssh-keygen -q -t rsa -N "" -f ~/.ssh/id_rsa && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    chmod 0600 ~/.ssh/authorized_keys

COPY config/core-site.xml $HADOOP_HOME/etc/hadoop/
COPY config/hdfs-site.xml $HADOOP_HOME/etc/hadoop/
COPY scripts/hadoop-env.sh $HADOOP_HOME/etc/hadoop/hadoop-env.sh
