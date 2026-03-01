resource "kubernetes_manifest" "bgp_control_plane" {
  manifest = {
    apiVersion = "cilium.io/v2"
    kind       = "CiliumBGPClusterConfig"
    metadata = {
      name = "cilium-bgp"
    }
    spec = {
      nodeSelector = {
        matchLabels = {
          bgp = "65020"
        }
      }
      bgpInstances = [{
        name = "65020"
        peers = [{
          name    = "udm-pro-65000"
          peerASN = 65000
          autoDiscovery = {
            mode = "DefaultGateway"
            defaultGateway = {
              addressFamily = "ipv4"
            }
          }
          peerConfigRef = {
            name = "cilium-peer"
          }
        }]
      }]
    }
  }
}

resource "kubernetes_manifest" "bgp_peer_config" {
  manifest = {
    apiVersion = "cilium.io/v2"
    kind       = "CiliumBGPPeerConfig"
    metadata = {
      name = "cilium-peer"
    }
    spec = {
      gracefulRestart = {
        matchLabels        = "true"
        restartTimeSeconds = 15
      }
      families = [{
        afi  = "ipv4"
        safi = "unicast"
        advertisements = {
          mastLabels = {
            advertise = "bgp"
          }
        }
      }]
    }
  }
}


resource "kubernetes_manifest" "bgp_advertisement" {
  manifest = {
    apiVersion = "cilium.io/v2"
    kind       = "CiliumBGPAdvertisement"
    metadata = {
      name = "bgp-advertisements"
      labels = {
        advertise = "bgp"
      }
    }
    spec = {
      advertisements = {
        matchLabels        = "true"
        restartTimeSeconds = 15
      }
      families = {
        afi  = "ipv4"
        safi = "unicast"
        advertisements = {
          mastLabels = {
            advertise = "bgp"
          }
        }
      }
    }
  }
}