resource kubernetes_secret redis {
  metadata {
    name      = "${local.fullname}"
    namespace = "${var.kubernetes_namespace}"

    labels {
      app     = "${local.name}"
      chart   = "${local.chart}"
      release = "${var.release_name}"
    }
  }

  data {
    "redis-password" = "${trimspace(coalesce(var.password, join("", random_string.redis_password.*.result), " "))}"
  }

  type = "Opaque"
}

resource random_string redis_password {
  count   = "${var.use_password ? 1 : 0}"
  special = false
  length  = 10
}
