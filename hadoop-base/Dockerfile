# Use base image

FROM ubuntu:latest

MAINTAINER Cristian Meneses <hello@cristianmeneses.io>

ARG HADOOP_VERSION=3.4.1
ENV HADOOP_HOME=${HADOOP_HOME:-"/opt/hadoop"}

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
      gnupg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download binaries, checksum, signature, verify integrity and install
RUN curl -fsSL https://dlcdn.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz -o hadoop-${HADOOP_VERSION}.tar.gz \
    && curl -fsSL https://downloads.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz.asc -o hadoop-${HADOOP_VERSION}.tar.gz.asc \
    && curl -fsSL https://downloads.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz.sha512 -o hadoop-${HADOOP_VERSION}.tar.gz.sha512 \
    && curl -fsSL https://downloads.apache.org/hadoop/common/KEYS | gpg --quiet --import - \
    && gpg --batch --verify hadoop-${HADOOP_VERSION}.tar.gz.asc hadoop-${HADOOP_VERSION}.tar.gz \
    && sha512sum -c hadoop-${HADOOP_VERSION}.tar.gz.sha512 \
    && mkdir -p ${HADOOP_HOME} \
    && tar -zxvf hadoop-${HADOOP_VERSION}.tar.gz --directory ${HADOOP_HOME} --strip-components=1 \
    && rm -r ${HADOOP_HOME}/share/doc \
    && rm -rf hadoop-${HADOOP_VERSION}.tar.*

# Directory setup
RUN ln -s ${HADOOP_HOME}/etc/hadoop /etc/hadoop \
    && mkdir ${HADOOP_HOME}/log \
    && mkdir /hadoop-data

# Environment setup
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV MULTIHOMED_NETWORK=1
ENV USER=root
ENV PATH $HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/

ADD entrypoint.sh /entrypoint.sh

RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

