PLATFORM=linux/amd64

GIT_HASH ?= $(shell git log --format="%h" -n 1)

DOCKER_USERNAME=menazord

HADOOP_BASE_IMAGE_NAME=hadoop-base
HADOOP_NAMENODE_IMAGE_NAME=hadoop-namenode
HADOOP_DATANODE_IMAGE_NAME=hadoop-datanode
HADOOP_HIVE_METASTORE_IMAGE_NAME=hive-metastore
NOTEBOOKS_IMAGE_NAME=jupyter-notebooks

build-base:
	@echo "Building ${HADOOP_BASE_IMAGE_NAME} image"
	docker build --platform ${PLATFORM} hadoop-base/ --tag ${HADOOP_BASE_IMAGE_NAME}:latest --tag ${DOCKER_USERNAME}/${HADOOP_BASE_IMAGE_NAME}:${GIT_HASH}

push-base:
	@echo "Pushing ${HADOOP_BASE_IMAGE_NAME} image"
	docker push ${DOCKER_USERNAME}/${HADOOP_BASE_IMAGE_NAME}:${GIT_HASH}

release-base:
	@echo "Releasing ${HADOOP_BASE_IMAGE_NAME} image"
	docker pull ${DOCKER_USERNAME}/${HADOOP_BASE_IMAGE_NAME}:${GIT_HASH}
	docker tag  ${DOCKER_USERNAME}/${HADOOP_BASE_IMAGE_NAME}:${GIT_HASH} ${DOCKER_USERNAME}/${HADOOP_BASE_IMAGE_NAME}:latest
	docker push ${DOCKER_USERNAME}/${HADOOP_BASE_IMAGE_NAME}:latest

build-namenode:
	@echo "Building ${HADOOP_NAMENODE_IMAGE_NAME} image"
	docker build --platform ${PLATFORM} hadoop-namenode/ --tag ${HADOOP_NAMENODE_IMAGE_NAME}:latest --tag ${DOCKER_USERNAME}/${HADOOP_NAMENODE_IMAGE_NAME}:${GIT_HASH}

push-namenode:
	@echo "Pushing ${HADOOP_NAMENODE_IMAGE_NAME} image"
	docker push ${DOCKER_USERNAME}/${HADOOP_NAMENODE_IMAGE_NAME}:${GIT_HASH}

release-namenode:
	@echo "Releasing ${HADOOP_NAMENODE_IMAGE_NAME} image"
	docker pull ${DOCKER_USERNAME}/${HADOOP_NAMENODE_IMAGE_NAME}:${GIT_HASH}
	docker tag  ${DOCKER_USERNAME}/${HADOOP_NAMENODE_IMAGE_NAME}:${GIT_HASH} ${DOCKER_USERNAME}/${HADOOP_NAMENODE_IMAGE_NAME}:latest
	docker push ${DOCKER_USERNAME}/${HADOOP_NAMENODE_IMAGE_NAME}:latest

build-datanode:
	@echo "Building ${HADOOP_DATANODE_IMAGE_NAME} image"
	docker build --platform ${PLATFORM} hadoop-datanode/ --tag ${HADOOP_DATANODE_IMAGE_NAME}:latest --tag ${DOCKER_USERNAME}/${HADOOP_DATANODE_IMAGE_NAME}:${GIT_HASH}

push-datanode:
	@echo "Pushing ${HADOOP_DATANODE_IMAGE_NAME} image"
	docker push ${DOCKER_USERNAME}/${HADOOP_DATANODE_IMAGE_NAME}:${GIT_HASH}

release-datanode:
	@echo "Releasing ${HADOOP_DATANODE_IMAGE_NAME} image"
	docker pull ${DOCKER_USERNAME}/${HADOOP_DATANODE_IMAGE_NAME}:${GIT_HASH}
	docker tag  ${DOCKER_USERNAME}/${HADOOP_DATANODE_IMAGE_NAME}:${GIT_HASH} ${DOCKER_USERNAME}/${HADOOP_DATANODE_IMAGE_NAME}:latest
	docker push ${DOCKER_USERNAME}/${HADOOP_DATANODE_IMAGE_NAME}:latest

build-metastore:
	@echo "Building ${HADOOP_HIVE_METASTORE_IMAGE_NAME} image"
	docker build --platform ${PLATFORM} hive-metastore/ --tag ${HADOOP_HIVE_METASTORE_IMAGE_NAME}:latest --tag ${DOCKER_USERNAME}/${HADOOP_HIVE_METASTORE_IMAGE_NAME}:${GIT_HASH}

push-metastore:
	@echo "Pushing ${HADOOP_HIVE_METASTORE_IMAGE_NAME} image"
	docker push ${DOCKER_USERNAME}/${HADOOP_HIVE_METASTORE_IMAGE_NAME}:${GIT_HASH}

release-metastore:
	@echo "Releasing ${HADOOP_HIVE_METASTORE_IMAGE_NAME} image"
	docker pull ${DOCKER_USERNAME}/${HADOOP_HIVE_METASTORE_IMAGE_NAME}:${GIT_HASH}
	docker tag  ${DOCKER_USERNAME}/${HADOOP_HIVE_METASTORE_IMAGE_NAME}:${GIT_HASH} ${DOCKER_USERNAME}/${HADOOP_HIVE_METASTORE_IMAGE_NAME}:latest
	docker push ${DOCKER_USERNAME}/${HADOOP_HIVE_METASTORE_IMAGE_NAME}:latest

build-jupyter:
	@echo "Building ${NOTEBOOKS_IMAGE_NAME} image"
	docker build --platform ${PLATFORM} jupyter/ --tag ${NOTEBOOKS_IMAGE_NAME}:latest --tag  ${DOCKER_USERNAME}/${NOTEBOOKS_IMAGE_NAME}:${GIT_HASH}

push-jupyter:
	@echo "Pushing ${NOTEBOOKS_IMAGE_NAME} image"
	docker push ${DOCKER_USERNAME}/${NOTEBOOKS_IMAGE_NAME}:${GIT_HASH}

release-jupyter:
	@echo "Releasing ${NOTEBOOKS_IMAGE_NAME} image"
	docker pull ${DOCKER_USERNAME}/${NOTEBOOKS_IMAGE_NAME}:${GIT_HASH}
	docker tag  ${DOCKER_USERNAME}/${NOTEBOOKS_IMAGE_NAME}:${GIT_HASH} ${DOCKER_USERNAME}/${NOTEBOOKS_IMAGE_NAME}:latest
	docker push ${DOCKER_USERNAME}/${NOTEBOOKS_IMAGE_NAME}:latest

run:
	@echo "Running stack"
	docker compose up -d

stop:
	@echo "Stopping stack"
	docker compose down

destroy:
	@echo "Destroying stack and volumes"
	docker compose down -v

build-all:build-base build-namenode build-datanode build-metastore build-jupyter

push-all:push-base push-namenode push-datanode push-metastore push-jupyter

release-all: release-base release-namenode release-datanode release-metastore release-jupyter

all: build-all push-all release-all