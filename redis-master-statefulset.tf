resource kubernetes_stateful_set redis_master {
  metadata {
    name      = "redis-master"
    namespace = "${var.kubernetes_namespace}"

    labels {
      app     = "${local.name}"
      chart   = "${local.chart}"
      release = "${var.release_name}"
    }
  }

  spec {
    selector {
      role = "master"
      app  = "${local.name}"
    }

    service_name = "redis-master"

    template {
      metadata {
        labels {
          role = "master"
          app  = "${local.name}"
        }

        annotations = "${var.master_pod_annotations}"
      }

      spec {
        security_context {
          fs_group    = "${var.master_security_context["fs_group"]}"
          run_as_user = "${var.master_security_context["run_as_user"]}"
        }

        node_selector = "${var.kubernetes_node_selector}"

        #TODO: tolerations
        container {
          name              = "${local.fullname}"
          image             = "${local.redis_image}"
          image_pull_policy = "${var.redis_image_pull_policy}"
          args              = "${var.master_args}"

          env {
            name  = "REDIS_REPLICATION_MODE"
            value = "master"
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
            name  = "ALLOW_EMPTY_PASSWORD"
            value = "${var.use_password ? "no" : "yes"}"
          }

          env {
            name  = "REDIS_PORT"
            value = "${var.master_port}"
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
            container_port = "${var.master_port}"
          }

          liveness_probe {
            initial_delay_seconds = "${var.master_liveness_probe["initial_delay_seconds"]}"
            period_seconds        = "${var.master_liveness_probe["period_seconds"]}"
            timeout_seconds       = "${var.master_liveness_probe["timeout_seconds"]}"
            success_threshold     = "${var.master_liveness_probe["success_threshold"]}"
            failure_threshold     = "${var.master_liveness_probe["failure_threshold"]}"

            exec {
              command = [
                "redis-cli",
                "ping",
              ]
            }
          }

          readiness_probe {
            initial_delay_seconds = "${var.master_readiness_probe["initial_delay_seconds"]}"
            period_seconds        = "${var.master_readiness_probe["period_seconds"]}"
            timeout_seconds       = "${var.master_readiness_probe["timeout_seconds"]}"
            success_threshold     = "${var.master_readiness_probe["success_threshold"]}"
            failure_threshold     = "${var.master_readiness_probe["failure_threshold"]}"

            exec {
              command = [
                "redis-cli",
                "ping",
              ]
            }
          }

          resources {
            requests = ["${merge(local.default_resource_requests, var.master_resource_requests)}"]

            limits = ["${merge(local.default_resource_limits, var.master_resource_limits)}"]
          }

          volume_mount {
            name       = "redis-data"
            mount_path = "${var.master_persistence_path}"
            sub_path   = "${var.master_persistence_sub_path}"
          }
        }

        # TODO: find a way to switch beteen this or Volume Claim
        # volume {
        #   name = "redis-data"
        #   empty_dir {}
        # }
      }
    }

    volume_claim_templates {
      metadata {
        name = "redis-data"

        labels {
          app       = "${local.name}"
          component = "master"
          chart     = "${local.chart}"
        }
      }

      spec {
        access_modes = "${var.master_persistence_access_modes}"

        resources {
          requests {
            storage = "${var.master_persistence_size}"
          }
        }

        storage_class_name = "${var.master_persistence_storage_class}"
      }
    }
  }
}
