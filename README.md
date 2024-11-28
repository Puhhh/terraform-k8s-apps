<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.16.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.34.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.release](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_labels.namespace_labels](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/labels) | resource |
| [kubernetes_manifest.custom_secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [null_resource.delay](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [kubernetes_all_namespaces.all_ns](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/all_namespaces) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_custom_secrets"></a> [create\_custom\_secrets](#input\_create\_custom\_secrets) | Create Custom Secrets | `bool` | `false` | no |
| <a name="input_custom_secrets"></a> [custom\_secrets](#input\_custom\_secrets) | Custom Secrets Data | <pre>list(object({<br/>    name = string<br/>    data = map(string)<br/>    type = optional(string, "kubernetes.io/tls")<br/>  }))</pre> | `[]` | no |
| <a name="input_helm_config"></a> [helm\_config](#input\_helm\_config) | Helm Config | <pre>list(object({<br/>    release_name  = optional(string, "")<br/>    chart_name    = string<br/>    chart_repo    = string<br/>    chart_version = string<br/>    values_path   = optional(string, "")<br/>  }))</pre> | `[]` | no |
| <a name="input_helm_custom_values"></a> [helm\_custom\_values](#input\_helm\_custom\_values) | n/a | `map(string)` | `{}` | no |
| <a name="input_kube_context"></a> [kube\_context](#input\_kube\_context) | Kubernetes Context to Use | `string` | `""` | no |
| <a name="input_kubeconfig_path"></a> [kubeconfig\_path](#input\_kubeconfig\_path) | Kubeconfig Path | `string` | `"~/.kube/config"` | no |
| <a name="input_namespace_labels"></a> [namespace\_labels](#input\_namespace\_labels) | Namespace Labels | `map(string)` | `{}` | no |
| <a name="input_namespace_name"></a> [namespace\_name](#input\_namespace\_name) | Namespace Name | `string` | `""` | no |
| <a name="input_use_helm_custom_values"></a> [use\_helm\_custom\_values](#input\_use\_helm\_custom\_values) | Use Helm Custom Values | `bool` | `false` | no |
| <a name="input_use_namespace_labels"></a> [use\_namespace\_labels](#input\_use\_namespace\_labels) | Use Namespace Labels | `bool` | `false` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->