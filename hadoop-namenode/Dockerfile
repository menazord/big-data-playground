FROM hadoop-base:latest

MAINTAINER Cristian Meneses <hello@cristianmeneses.io>

ENV HADOOP_HOME=${HADOOP_HOME:-"/home/hadoop"}

HEALTHCHECK CMD curl -f http://localhost:9870/ || exit 1

RUN mkdir -p /hadoop/dfs/name
VOLUME /hadoop/dfs/name

EXPOSE 9870

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

CMD ["/entrypoint.sh"]