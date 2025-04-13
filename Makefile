PLATFORM=linux/amd64

build-base:
	@echo "Building haddop base image"
	docker build --platform ${PLATFORM} hadoop-base/ -t "hadoop:base"

build-namenode:
	@echo "Building haddop base image"
	docker build --platform ${PLATFORM} hadoop-namenode/ -t "hadoop:namenode"

build-datanode:
	@echo "Building haddop base image"
	docker build --platform ${PLATFORM} hadoop-datanode/ -t "hadoop:datanode"

build-metastore:
	@echo "Building Hive Metastore"
	docker build --platform ${PLATFORM} hive-metastore/ -t "hive:metastore"

build-jupyter:
	@echo "Building Jupyter"
	docker build --platform ${PLATFORM} jupyter/ -t "jupyter:notebook"


all:build-base build-namenode build-datanode build-metastore build-jupyter