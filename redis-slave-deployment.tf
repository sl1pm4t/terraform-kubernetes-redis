resource kubernetes_deployment redis_slave {
  metadata {
    name      = "${local.fullname}-slave"
    namespace = "${var.kubernetes_namespace}"

    labels {
      app     = "${local.name}"
      chart   = "${local.chart}"
      release = "${var.release_name}"
    }
  }

  spec {
    replicas = "${var.slave_replica_count}"

    selector {
      app  = "${local.name}"
      role = "slave"
    }

    template {
      metadata {
        labels {
          app  = "${local.name}"
          role = "slave"

          # TODO: merge pod labels from input variable
        }

        annotations = "${var.slave_pod_annotations}"
      }

      spec {
        node_selector = "${var.kubernetes_node_selector}"

        container {
          name              = "${local.fullname}"
          image             = "${local.redis_image}"
          image_pull_policy = "${var.redis_image_pull_policy}"
          args              = "${coalescelist(var.slave_args, var.master_args)}"

          env {
            name  = "REDIS_REPLICATION_MODE"
            value = "slave"
          }

          env {
            name  = "REDIS_MASTER_HOST"
            value = "${local.fullname}-master"
          }

          env {
            name  = "REDIS_PORT"
            value = "${var.slave_port}"
          }

          env {
            name  = "REDIS_MASTER_PORT_NUMBER"
            value = "${var.master_port}"
          }

          env {
            name = "REDIS_PASSWORD"

            value_from {
              secret_key_ref {
                name = "${local.fullname}"
                key  = "redis-password"
              }
            }
          }

          env {
            name = "REDIS_MASTER_PASSWORD"

            value_from {
              secret_key_ref {
                name = "${local.fullname}"
                key  = "redis-password"
              }
            }
          }

          env {
            name  = "ALLOW_EMPTY_PASSWORD"
            value = "${var.use_password ? "no" : "yes"}"
          }

          env {
            name  = "REDIS_DISABLE_COMMANDS"
            value = "${join(",", var.master_disable_commands)}"
          }

          env {
            name  = "REDIS_EXTRA_FLAGS"
            value = "${join(" ", var.master_extra_flags)}"
          }

          port {
            name           = "redis"
            container_port = "${var.slave_port}"
          }

          resources {
            requests = ["${merge(local.default_resource_requests, var.slave_resource_requests)}"]

            limits = ["${merge(local.default_resource_limits, var.slave_resource_limits)}"]
          }
        }
      }
    }
  }
}
