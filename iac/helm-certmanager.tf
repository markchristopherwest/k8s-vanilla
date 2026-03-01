resource "helm_release" "certmanager" {
  name       = "jetstack"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "1.19.2"

  values = [
    file("./../helm/values-certmanager.yaml")
  ]

  # set = [
  #   {
  #     name  = "crds.enabled"
  #     value = "true"
  #   },
  #   {
  #     name  = "extraArgs"
  #     value = "- --acme-http01-solver-nameservers=8.8.8.8:53,1.1.1.1:53"
  #   },
  #   {
  #     name  = "config.apiVersion"
  #     value = "controller.config.cert-manager.io/v1alpha1"
  #   },
  #   {
  #     name  = "config.kind"
  #     value = "ControllerConfiguration"
  #   },
  #   {
  #     name  = "config.logging.verbosity"
  #     value = 2
  #   },
  #   {
  #     name  = "config.logging.format"
  #     value = "text"
  #   },
  #   {
  #     name  = "config.leaderElectionConfig.namespace"
  #     value = "kube-system"
  #   },
  #   {
  #     name  = "config.kubernetesAPIQPS"
  #     value = 9000
  #   },
  #   {
  #     name  = "config.kubernetesAPIBurst"
  #     value = 9000
  #   },
  #   {
  #     name  = "config.numberOfConcurrentWorkers"
  #     value = 200
  #   },
  #   {
  #     name  = "config.enableGatewayAPI"
  #     value = true
  #   },
  #   {
  #     name  = "prometheus.enabled"
  #     value = "true"
  #   }
  # ]
}