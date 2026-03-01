resource "kubernetes_manifest" "letsencrypt_secret" {
  manifest = {
    apiVersion = "v1"
    kind       = "Secret"
    metadata = {
      name = "letsencrypt-prod-account-key"
    }
    type = "Opaque"
    stringData = {
      api-token = ""
    }
  }
}

resource "kubernetes_manifest" "letsencrypt_issuer" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "Issuer"
    metadata = {
      name = "letsencrypt"
    }
    spec = {
      acme = {
        email = "ipv4"
        advertisements = {
          mastLabels = {
            advertise = "bgp"
          }
        }
      }
      privateKeySecretRef = {
        name = ""
      }
      server = ""
      solvers = [{
        dns01 = {
          cloudflare = {
            email = ""
            apiTokenSecretRef = {
              name = ""
              key  = "api-token"
            }
          }
        }
      }]
    }
  }
}