FROM hadoop:base

# https://medium.com/@sanjeets1900/hadoop-hive-and-hue-with-postgress-metastore-from-scratch-fd4425d13831
# Lifted from: https://github.com/joshuarobinson/presto-on-k8s/blob/1c91f0b97c3b7b58bdcdec5ad6697b42e50d74c7/hive_metastore/Dockerfile

# see https://downloads.apache.org/hive/
ARG HIVE_VERSION=4.0.1
# see https://jdbc.postgresql.org/download.html#current
ARG POSTGRES_CONNECTOR_VERSION=42.2.23

# Set necessary environment variables.
ENV HADOOP_HOME=${HADOOP_HOME:-"/home/hadoop"}
ENV HIVE_HOME=${HIVE_HOME:-"/home/hive"}
ENV PATH="${HADOOP_HOME}/bin:${HIVE_HOME}/bin:${PATH}"

RUN \
    curl -fsSL https://dlcdn.apache.org/hive/hive-$HIVE_VERSION/apache-hive-${HIVE_VERSION}-bin.tar.gz -o apache-hive-${HIVE_VERSION}-bin.tar.gz && \
    curl -fsSL https://dlcdn.apache.org/hive/hive-$HIVE_VERSION/apache-hive-${HIVE_VERSION}-bin.tar.gz.asc -o apache-hive-${HIVE_VERSION}-bin.tar.gz.asc && \
    curl -fsSL https://dlcdn.apache.org/hive/hive-$HIVE_VERSION/apache-hive-${HIVE_VERSION}-bin.tar.gz.sha256 -o apache-hive-${HIVE_VERSION}-bin.tar.gz.sha256 && \
    curl -fsSL https://downloads.apache.org/hive/KEYS | gpg --quiet --import - && \
    gpg --batch --verify apache-hive-${HIVE_VERSION}-bin.tar.gz.asc apache-hive-${HIVE_VERSION}-bin.tar.gz && \
    sha256sum -c apache-hive-${HIVE_VERSION}-bin.tar.gz.sha256 && \
    mkdir -p ${HIVE_HOME} && \
    tar -zxvf apache-hive-${HIVE_VERSION}-bin.tar.gz --directory ${HIVE_HOME} --strip-components=1 && \
    rm -rf apache-hive-${HIVE_VERSION}-bin.tar.gz.* && \
    curl -L https://jdbc.postgresql.org/download/postgresql-$POSTGRES_CONNECTOR_VERSION.jar --output /${HIVE_HOME}/lib/postgresql-$POSTGRES_CONNECTOR_VERSION.jar

COPY config/hive-site.xml $HIVE_HOME/conf/hive-site.xml

RUN chown -R hdfs:hdfs $HIVE_HOME

EXPOSE 10000 10002

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

CMD ["/entrypoint.sh"]
