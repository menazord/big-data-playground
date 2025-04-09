PLATFORM=linux/amd64

build-hadoop-base:
	@echo "Building haddop base image"
	docker build --platform ${PLATFORM} hadoop-base/ -t "hadoop:base"

build-hadoop-namenode:
	@echo "Building haddop base image"
	docker build --platform ${PLATFORM} hadoop-namenode/ -t "hadoop:namenode"

build-hadoop-datanode:
	@echo "Building haddop base image"
	docker build --platform ${PLATFORM} hadoop-datanode/ -t "hadoop:datanode"

build-spark:
	@echo "Building Spark"
	docker build --platform ${PLATFORM} spark/ -t "spark:iceberg"

build-metastore:
	@echo "Building Hive Metastore"
	docker build --platform ${PLATFORM} hive-metastore/ -t "hive:metastore"

all:build-hadoop-base build-hadoop-namenode build-hadoop-datanode build-spark build-metastore