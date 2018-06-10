resource kubernetes_deployment redis_metrics {
  count = "${var.metrics_enabled ? 1 : 0}"

  metadata {
    name      = "${local.fullname}-metrics"
    namespace = "${var.kubernetes_namespace}"

    labels {
      app     = "${local.name}"
      chart   = "${local.chart}"
      release = "${var.release_name}"
    }
  }

  spec {
    selector {
      app  = "${local.name}"
      role = "metrics"
    }

    template {
      metadata {
        labels {
          app  = "${local.name}"
          role = "metrics"

          # TODO: merge pod labels from input variable
        }

        annotations = "${var.metrics_pod_annotations}"
      }

      spec {
        image_pull_secrets = ["${var.metrics_image_pull_secrets}"]

        node_selector = "${var.kubernetes_node_selector}"

        container {
          name              = "metrics"
          image             = "${local.metrics_image}"
          image_pull_policy = "${var.metrics_image_pull_policy}"

          env {
            name  = "REDIS_ADDR"
            value = "${local.metrics_redis_addr}"
          }

          env {
            name  = "REDIS_ALIAS"
            value = "${local.fullname}"
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

          port {
            name           = "metrics"
            container_port = "${var.metrics_port}"
          }

          resources {
            requests = ["${merge(local.default_resource_requests, var.metrics_resource_requests)}"]

            limits = ["${merge(local.default_resource_limits, var.metrics_resource_limits)}"]
          }
        }
      }
    }
  }
}
