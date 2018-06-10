resource kubernetes_service redis_master {
  metadata {
    name      = "${local.fullname}-master"
    namespace = "${var.kubernetes_namespace}"

    labels {
      app     = "${local.name}"
      chart   = "${local.chart}"
      release = "${var.release_name}"
    }

    annotations = "${var.master_service_annotations}"
  }

  spec {
    type             = "${var.master_service_type}"
    load_balancer_ip = "${var.master_service_loadbalancer_ip}"

    port {
      name        = "redis"
      port        = 6379
      target_port = "${var.master_port}"
    }

    selector {
      app  = "${local.name}"
      role = "master"
    }
  }
}
