PLATFORM=linux/amd64

build-hadoop-resource-manager:
	echo "Building haddop resource manager"
	docker build --platform ${PLATFORM} hadoop-resource-manager/ -t "hadoop:resource-manager"

build-hadoop-node-manager:
	echo "Building haddop node manager"
	docker build --platform ${PLATFORM} hadoop-node-manager/ -t "hadoop:node-manager"

build-hadoop-history-server:
	echo "Building haddop history server"
	docker build --platform ${PLATFORM} hadoop-history-server/ -t "hadoop:history-server"

all:build-hadoop-resource-manager build-hadoop-node-manager build-hadoop-history-server
