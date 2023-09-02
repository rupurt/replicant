# Replicant

Kafka based query & log CDC orchestration with [Ploomber](https://github.com/ploomber/ploomber)

## Setup

1. Install Nix

```shell
./scripts/boostrap
```

2. Start a Nix devshell

```shell
nix develop -c $SHELL
```

3. Install dependencies, create a k3d cluster, install helm packages/operators & apply k8s manifests

```shell
./scripts/setup
```

## Development

Bring the cluster up

```shell
./scripts/up
```

Apply k8s manifests

```shell
./scripts/apply
```

Shutdown the cluster when not in use

```shell
./scripts/down
```

Destroy the cluster and clean up all resources

```shell
./scripts/teardown
```

Run tests for all services

```
./scripts/tests
```

## Endpoints

Use proxy scripts to bind services without ingress to a port on the host

```shell
./scripts/proxy/postgres_source
./scripts/proxy/postgres_sink
./scripts/proxy/mariadb_source
./scripts/proxy/mariadb_sink
./scripts/proxy/db2_source
./scripts/proxy/db2_sink
```

| Service          | URI                                                         |
| ---------------- | ----------------------------------------------------------- |
| Grafana          | [grafana.127.0.0.1.nip.io](http://grafana.127.0.0.1.nip.io) |
| MinIO            | [minio.127.0.0.1.nip.io](http://minio.127.0.0.1.nip.io)     |
| Kafka Console    | [kafka.127.0.0.1.nip.io](http://kafka.127.0.0.1.nip.io)     |
| Postgres Source  | [localhost:5532](http://localhost:5532)                     |
| Postgres Sink    | [localhost:5533](http://localhost:5533)                     |
| MariaDB Source   | [localhost:51000](http://localhost:51000)                   |
| MarioDB Sink     | [localhost:51001](http://localhost:51001)                   |
| Db2 Source       | [localhost:51000](http://localhost:51000)                   |
| Db2 Sink         | [localhost:51001](http://localhost:51001)                   |

## Kafka

The `kafka` cluster is managed by the [strimzi operator](https://strimzi.io/docs/operators/latest/configuring).
You can communicate with the kafka brokers using [kafkactl](https://github.com/deviceinsight/kafkactl) which has
been [configured](./templates/dot-config/kafkactl/config.yml) to run as a pod within the local k3d cluster.

```shell
kafkactl -C .config/kafkactl/config.yml produce test.topic -v 'hello world' -r -1
```

```shell
kafkactl -C .config/kafkactl/config.yml consume test.topic -b --tail 1
```

## Db2

A `source` & `sink` Db2 instance runs within the k8s cluster. To access them in local development use the
proxy scripts.

```shell
./scripts/proxy/db2_source
./scripts/proxy/db2_sink
```

## Db2

A `source` & `sink` Db2 instance runs within the k8s cluster. To access them in local development use the
proxy scripts.

```shell
./scripts/proxy/db2_source
./scripts/proxy/db2_sink
```

Connect to the instances with the credentials

### ksource

- host: `localhost`
- database: `ksource`
- port: `51000`
- user: `db2inst1`
- password: `password`

### ksink

- host: `localhost`
- database: `ksink`
- port: `51001`
- user: `db2inst1`
- password: `password`
