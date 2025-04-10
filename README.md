# Big Data Playground
Local playground for Spark and Jupyter notebooks, plus Iceberg support

## Motivation

Learning more about data analytics tooling, especially Spark and interactive
notebooks such as Jupyter.

## Pre-requisites

- Colima
- Docker

TODO: Expand on this list with detailed instructions.

## Building the images

Just use the Makefile!
```shell
make all
```

## Spinning up the environment

For interactive mode, simply run 
```shell
docker compose up
```

Or for detached mode
```shell
docker compose up -d
```

To stop the stack
```shell
docker compose down
```

## Relevant bookmarks

Services that can be accessed once the stack is active

- Hadoop NameNode: 
  - http://localhost:9870/
- Hadoop DataNode: 
  - http://localhost:9864/
- Jupyter Notebooks 
  - http://localhost:8888/
- Hive Metastore (via BeeLine)
  - `beeline -u jdbc:hive2://localhost:10000`

## Next steps

- Tag images properly
- Pre-configured kernel with Hive and Iceberg support
- Sample data preloaded on HDFS.
