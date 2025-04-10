FROM hadoop:base

MAINTAINER Cristian Meneses <hello@cristianmeneses.io>

ENV HADOOP_HOME=${HADOOP_HOME:-"/home/hadoop"}

HEALTHCHECK CMD curl -f http://localhost:9864/ || exit 1

RUN mkdir -p /hadoop/dfs/data
VOLUME /hadoop/dfs/data

EXPOSE 9000 9864

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

CMD ["/entrypoint.sh"]