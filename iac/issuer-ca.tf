resource "kubernetes_manifest" "ca_namespace" {
  manifest = {
    apiVersion = "v1"
    kind       = "Namespace"
    metadata = {
      name = "sandbox"
    }
  }
}

resource "kubernetes_manifest" "cluster_issuer" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"
    metadata = {
      name = "selfsigned-issuer"
    }
    spec = {
      selfSigned = {}
    }
  }
}

resource "kubernetes_manifest" "cluster_issuer_certificate" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "Issuer"
    metadata = {
      name      = "my-selfsigned-ca"
      namespace = "sandbox"
    }
    spec = {
      isCA       = true
      commonName = "my-selfsigned-ca"
      secretName = "root-secret"
      privateKey = {
        algorithm = "ECDSA"
        size      = 256
      }
      issuerRef = {
        name  = "selfsigned-issuer"
        kind  = "ClusterIssuer"
        group = "cert-manager.io"
      }
    }
  }
}



resource "kubernetes_manifest" "ca_issuer" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "Issuer"
    metadata = {
      name      = "my-ca-issuer"
      namespace = "sandbox"
    }
    spec = {
      ca = {
        secretName = "root-secret"
      }
    }
  }
}