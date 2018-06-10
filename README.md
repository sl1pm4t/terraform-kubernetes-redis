# Redis Module

Port of the Redis helm chart for Terraform

## Description

Open source, advanced key-value store. It is often referred to as a data structure server since keys can contain strings, hashes, lists, sets and sorted sets.

(http://redis.io/)

## Requirements

This module requires an unofficial Kubernetes provider fork, available [here](https://github.com/sl1pm4t/terraform-provider-kuberbetes). The fork provides support for additional resource types (`Deployment`, `StatefulSet`) that are currently not available in the official build.

## Example Usage

```hcl
module redis {
  source = "git::https://github.com/sl1pm4t/terraform-kubernetes-redis"

  kubernetes_namespace = "redis"

  master_resource_limits = {
    cpu    = "500m"
    memory = "2Gi"
  }
  
  slave_replica_count  = 1
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cluster_enabled | Set to 'false' to deploy a redis master only. | string | `true` | no |
| cluster_slave_count | The number of redis slave pods to deploy. | string | `3` | no |
| kubernetes_namespace | # # Kubernetes settings # | string | `default` | no |
| kubernetes_node_selector |  | map | `<map>` | no |
| master_args | Redis command arguments. Can be used to specify command line arguments, for example:<br><br>master_args = [  "redis-server",  "--maxmemory-policy volatile-ttl" ] | list | `<list>` | no |
| master_disable_commands | Comma-separated list of Redis commands to disable Can be used to disable Redis commands for security reasons. ref: https://github.com/bitnami/bitnami-docker-redis#disabling-redis-commands | list | `<list>` | no |
| master_extra_flags | Redis additional command line flags  Can be used to specify command line flags, for example:<br><br> redisExtraFlags = [   "--maxmemory-policy volatile-ttl",   "--repl-backlog-size 1024mb"  ] | list | `<list>` | no |
| master_liveness_probe | Redis Master Liveness Probe configuration | map | `<map>` | no |
| master_persistence_access_modes |  | string | `<list>` | no |
| master_persistence_enabled |  | string | `true` | no |
| master_persistence_path |  | string | `/bitnami/redis/data` | no |
| master_persistence_size |  | string | `8Gi` | no |
| master_persistence_storage_class |  | string | `` | no |
| master_persistence_sub_path |  | string | `` | no |
| master_pod_annotations |  | map | `<map>` | no |
| master_pod_labels | Redis Master additional pod labels ref: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/ | map | `<map>` | no |
| master_port | # # Redis Master parameters # | string | `6379` | no |
| master_readiness_probe | Redis Master Readiness Probe configuration | map | `<map>` | no |
| master_resource_limits | Redis Master resource limits ref: http://kubernetes.io/docs/user-guide/compute-resources/   master_resource_limits = {     memory = "256Mi"     cpu = "100m"   } | map | `<map>` | no |
| master_resource_requests | Redis Master resource requests ref: http://kubernetes.io/docs/user-guide/compute-resources/   master_resource_requests = {     memory = "256Mi"     cpu = "100m"   } | map | `<map>` | no |
| master_security_context |  | string | `<map>` | no |
| master_service_annotations |  | map | `<map>` | no |
| master_service_loadbalancer_ip |  | string | `` | no |
| master_service_type |  | string | `ClusterIP` | no |
| metrics_enabled | Should the Redis Prometheus metrics exporter pod be deployed? | string | `true` | no |
| metrics_image_pull_policy | One of Always, Never, IfNotPresent. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise. | string | `IfNotPresent` | no |
| metrics_image_pull_secrets |  | list | `<list>` | no |
| metrics_image_registry | The docker image registry used to retrieve the redis_exporter image | string | `docker.io` | no |
| metrics_image_repository | The redis metrics exporter docker image that will be deployed. | string | `oliver006/redis_exporter` | no |
| metrics_image_tag | The redis metrics exporter docker tag / version that will be deployed. | string | `v0.11` | no |
| metrics_pod_annotations |  | map | `<map>` | no |
| metrics_port | The port the metrics exporter will listen for scrape requests. | string | `9121` | no |
| metrics_resource_limits | Redis metrics resource limits ref: http://kubernetes.io/docs/user-guide/compute-resources/   metrics_resource_limits = {     memory = "256Mi"     cpu = "100m"   } | map | `<map>` | no |
| metrics_resource_requests | Redis metrics resource requests ref: http://kubernetes.io/docs/user-guide/compute-resources/   metrics_resource_requests = {     memory = "256Mi"     cpu = "100m"   } | map | `<map>` | no |
| password | Redis password (both master and slave) Defaults to a random 10-character alphanumeric string if not set and usePassword is true | string | `` | no |
| redis_image_pull_policy | One of Always, Never, IfNotPresent. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise. | string | `IfNotPresent` | no |
| redis_image_registry | The docker image registry used to retrieve the redis image | string | `docker.io` | no |
| redis_image_repository |  | string | `bitnami/redis` | no |
| redis_image_tag |  | string | `4.0.9` | no |
| slave_args |  | string | `<list>` | no |
| slave_pod_annotations |  | string | `<map>` | no |
| slave_port |  | string | `6379` | no |
| slave_replica_count | # # Redis Slave parameters # | string | `3` | no |
| slave_resource_limits | Redis Slave resource limits ref: http://kubernetes.io/docs/user-guide/compute-resources/   slave_resource_limits = {     memory = "256Mi"     cpu = "100m"   } | map | `<map>` | no |
| slave_resource_requests | Redis Slave resource requests ref: http://kubernetes.io/docs/user-guide/compute-resources/   slave_resource_requests = {     memory = "256Mi"     cpu = "100m"   } | map | `<map>` | no |
| slave_service_annotations |  | map | `<map>` | no |
| slave_service_loadbalancer_ip |  | string | `` | no |
| slave_service_type |  | string | `ClusterIP` | no |
| use_password | Set to 'false' to disable password protected access to redis. | string | `true` | no |