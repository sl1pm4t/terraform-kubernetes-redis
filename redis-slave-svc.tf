resource kubernetes_service redis_slave {
  metadata {
    name      = "${local.fullname}-slave"
    namespace = "${var.kubernetes_namespace}"

    labels {
      app     = "${local.name}"
      chart   = "${local.chart}"
      release = "${var.release_name}"
    }

    annotations = "${var.slave_service_annotations}"
  }

  spec {
    type             = "${var.slave_service_type}"
    load_balancer_ip = "${var.slave_service_loadbalancer_ip}"

    port {
      name        = "redis"
      port        = 6379
      target_port = "${var.slave_port}"
    }

    port {
      name        = "metrics"
      port        = 9121
      target_port = "${var.metrics_port}"
    }

    selector {
      app  = "${local.name}"
      role = "slave"
    }
  }
}
