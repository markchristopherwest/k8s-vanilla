resource "helm_release" "example" {
  name       = "cilium"
  repository = "https://helm.cilium.io/"
  chart      = "cilium"
  version    = "1.18.6"

  # Pass values from the local values.yaml file
  values = [
    file("./../helm/values-cilium.yaml")
  ]

  # set = [
  #   {
  #     name  = "cluster.enabled"
  #     value = "true"
  #   },
  #   {
  #     name  = "metrics.enabled"
  #     value = "true"
  #   },
  #   {
  #     name  = "service.annotations.prometheus\\.io/port"
  #     value = "9127"
  #     type  = "string"
  #   }
  # ]
}