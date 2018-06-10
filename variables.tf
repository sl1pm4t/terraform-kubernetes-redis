variable release_name {
  description = "A user specified descriptor of this deployment"
  default     = "redis"
}

variable redis_image_registry {
  description = "The docker image registry used to retrieve the redis image"
  default     = "docker.io"
}

variable redis_image_repository {
  default = "bitnami/redis"
}

variable redis_image_tag {
  default = "4.0.9"
}

variable redis_image_pull_policy {
  description = "One of Always, Never, IfNotPresent. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise."
  default     = "IfNotPresent"
}

##
## Redis settings
##
variable use_password {
  description = "Set to 'false' to disable password protected access to redis."
  default     = true
}

variable password {
  description = <<EOF
Redis password (both master and slave)
Defaults to a random 10-character alphanumeric string if not set and usePassword is true
EOF

  default = ""
}

##
## Cluster settings
##
variable cluster_enabled {
  description = "Set to 'false' to deploy a redis master only."
  default     = true
}

variable cluster_slave_count {
  description = "The number of redis slave pods to deploy."
  default     = 1
}

##
## Metrics settings
##
variable metrics_enabled {
  description = "Should the Redis Prometheus metrics exporter pod be deployed?"
  default     = true
}

variable metrics_port {
  description = "The port the metrics exporter will listen for scrape requests."
  default     = "9121"
}

variable metrics_image_registry {
  description = "The docker image registry used to retrieve the redis_exporter image"
  default     = "docker.io"
}

variable metrics_image_repository {
  description = "The redis metrics exporter docker image that will be deployed."
  default     = "oliver006/redis_exporter"
}

variable metrics_image_tag {
  description = "The redis metrics exporter docker tag / version that will be deployed."
  default     = "v0.11"
}

variable metrics_image_pull_policy {
  description = "One of Always, Never, IfNotPresent. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise."
  default     = "IfNotPresent"
}

variable metrics_image_pull_secrets {
  type    = "list"
  default = []
}

variable metrics_resource_requests {
  type = "map"

  description = <<EOF
Redis metrics resource requests
ref: http://kubernetes.io/docs/user-guide/compute-resources/
  metrics_resource_requests = {
    memory = "256Mi"
    cpu = "100m"
  }
EOF

  default = {}
}

variable metrics_resource_limits {
  type = "map"

  description = <<EOF
Redis metrics resource limits
ref: http://kubernetes.io/docs/user-guide/compute-resources/
  metrics_resource_limits = {
    memory = "256Mi"
    cpu = "100m"
  }
EOF

  default = {}
}

variable metrics_pod_annotations {
  type    = "map"
  default = {}
}

##
## Kubernetes settings
##
variable kubernetes_namespace {
  default = "default"
}

variable kubernetes_node_selector {
  type    = "map"
  default = {}
}

##
## Redis Master parameters
##
variable master_port {
  default = "6379"
}

variable master_args {
  type = "list"

  description = <<EOF
Redis command arguments.
Can be used to specify command line arguments, for example:

master_args = [
 "redis-server",
 "--maxmemory-policy volatile-ttl"
]
EOF

  default = []
}

variable master_extra_flags {
  type = "list"

  description = <<EOF
 Redis additional command line flags
 Can be used to specify command line flags, for example:

 redisExtraFlags = [
  "--maxmemory-policy volatile-ttl",
  "--repl-backlog-size 1024mb"
 ]
EOF

  default = []
}

variable master_disable_commands {
  type = "list"

  description = <<EOF
Comma-separated list of Redis commands to disable
Can be used to disable Redis commands for security reasons.
ref: https://github.com/bitnami/bitnami-docker-redis#disabling-redis-commands
EOF

  default = [
    "FLUSHDB",
    "FLUSHALL",
  ]
}

variable master_pod_labels {
  type = "map"

  description = <<EOF
Redis Master additional pod labels
ref: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/
EOF

  default = {}
}

variable master_resource_requests {
  type = "map"

  description = <<EOF
Redis Master resource requests
ref: http://kubernetes.io/docs/user-guide/compute-resources/
  master_resource_requests = {
    memory = "256Mi"
    cpu = "100m"
  }
EOF

  default = {}
}

variable master_resource_limits {
  type = "map"

  description = <<EOF
Redis Master resource limits
ref: http://kubernetes.io/docs/user-guide/compute-resources/
  master_resource_limits = {
    memory = "256Mi"
    cpu = "100m"
  }
EOF

  default = {}
}

variable master_liveness_probe {
  type        = "map"
  description = "Redis Master Liveness Probe configuration"

  default = {
    enabled               = true
    initial_delay_seconds = 30
    period_seconds        = 10
    timeout_seconds       = 5
    success_threshold     = 1
    failure_threshold     = 5
  }
}

variable master_readiness_probe {
  type        = "map"
  description = "Redis Master Readiness Probe configuration"

  default = {
    enabled               = true
    initial_delay_seconds = 30
    period_seconds        = 10
    timeout_seconds       = 5
    success_threshold     = 1
    failure_threshold     = 5
  }
}

variable master_pod_annotations {
  type    = "map"
  default = {}
}

variable master_security_context {
  default {
    enabled     = true
    fs_group    = 1001
    run_as_user = 1001
  }
}

variable master_persistence_enabled {
  default = true
}

variable master_persistence_path {
  default = "/bitnami/redis/data"
}

variable master_persistence_sub_path {
  default = ""
}

variable master_persistence_access_modes {
  default = [
    "ReadWriteOnce",
  ]
}

variable master_persistence_size {
  default = "8Gi"
}

variable master_persistence_storage_class {
  default = ""
}

variable master_service_type {
  default = "ClusterIP"
}

variable master_service_annotations {
  type    = "map"
  default = {}
}

variable master_service_loadbalancer_ip {
  default = ""
}

##
## Redis Slave parameters
##
variable slave_replica_count {
  default = 3
}

variable slave_pod_annotations {
  default = {}
}

variable slave_port {
  default = "6379"
}

variable slave_args {
  default = []
}

variable slave_resource_requests {
  type = "map"

  description = <<EOF
Redis Slave resource requests
ref: http://kubernetes.io/docs/user-guide/compute-resources/
  slave_resource_requests = {
    memory = "256Mi"
    cpu = "100m"
  }
EOF

  default = {}
}

variable slave_resource_limits {
  type = "map"

  description = <<EOF
Redis Slave resource limits
ref: http://kubernetes.io/docs/user-guide/compute-resources/
  slave_resource_limits = {
    memory = "256Mi"
    cpu = "100m"
  }
EOF

  default = {}
}

variable slave_service_annotations {
  type = "map"

  default = {
    "prometheus.io/scrape" = "true"
    "prometheus.io/port"   = "9121"
  }
}

variable slave_service_type {
  default = "ClusterIP"
}

variable slave_service_loadbalancer_ip {
  default = ""
}
