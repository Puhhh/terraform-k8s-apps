data "kubernetes_all_namespaces" "all_ns" {}

resource "helm_release" "release" {
  count = length(var.helm_config)

  create_namespace = contains(data.kubernetes_all_namespaces.all_ns.namespaces, var.namespace_name) ? false : true
  namespace        = var.namespace_name
  name             = coalesce(var.helm_config[count.index].release_name, var.helm_config[count.index].chart_name)
  chart            = var.helm_config[count.index].chart_name
  repository       = var.helm_config[count.index].chart_repo
  version          = var.helm_config[count.index].chart_version
  values = var.use_helm_custom_values ? [templatefile(var.helm_config[count.index].values_path, {
    client_secret      = lookup(var.helm_custom_values, "client_secret", ""),
    cookie_secret      = lookup(var.helm_custom_values, "cookie_secret", ""),
    admin_password     = lookup(var.helm_custom_values, "admin_password", ""),
    pem_crt            = lookup(var.helm_custom_values, "pem_crt", ""),
    pem_key            = lookup(var.helm_custom_values, "pem_key", ""),
    custom_secret_name = lookup(var.helm_custom_values, "custom_secret_name", ""),
  })] : []
}

resource "null_resource" "delay" {
  count = var.use_namespace_labels || var.create_custom_secrets ? 1 : 0

  provisioner "local-exec" {
    command = "sleep 10"
  }
}

resource "kubernetes_labels" "namespace_labels" {
  depends_on = [null_resource.delay]

  count = var.use_namespace_labels ? 1 : 0

  api_version = "v1"
  kind        = "Namespace"
  metadata {
    name = var.namespace_name
  }
  labels = var.namespace_labels
}

resource "kubernetes_manifest" "custom_secrets" {
  depends_on = [null_resource.delay]

  count = var.create_custom_secrets ? length(var.custom_secrets) : 0

  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Secret"
    "metadata" = {
      "name"      = var.custom_secrets[count.index]["name"]
      "namespace" = var.namespace_name
    }
    "type" = "kubernetes.io/tls"
    "data" = var.custom_secrets[count.index]["data"]
    "type" = var.custom_secrets[count.index]["type"]
  }
}
