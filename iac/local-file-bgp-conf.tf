resource "local_file" "foo" {
  content  = <<EOT
router bgp 65000
  bgp bestpath as-path multipath-relax
  no bgp ebgp-requires-policy
  bgp router-id 192.168.2.1
  neighbor k8s peer-group
  neighbor k8s remote-as external
  neighbor 192.168.8.10 peer-group k8s
  neighbor 192.168.8.11 peer-group k8s
  neighbor 192.168.8.12 peer-group k8s
  neighbor 192.168.8.13 peer-group k8s
  neighbor 192.168.8.14 peer-group k8s
  EOT
  filename = "${path.module}/bgp.conf"
}