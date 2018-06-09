resource kubernetes_secret redis {
  metadata {
    name      = "${local.fullname}"
    namespace = "${var.kubernetes_namespace}"

    labels {
      app   = "${local.name}"
      chart = "${local.chart}"
    }
  }

  data {
    "redis-password" = "${coalesce(var.password, random_string.redis_password.result)}"
  }

  type = "Opaque"
}

resource random_string redis_password {
  count   = "${length(var.password) > 0 ? 0 : 1}"
  special = false
  length  = 10
}
