// Making this a hard-coded conditional for now, because once we support prometheus it will become conditional based on prometheus
// since it is effectively replaced by the prometheus-adapter https://github.com/kubernetes-sigs/prometheus-adapter
module "metrics-server" {
  source = "../../../provisioners/terraform/modules/k8s-metrics-server"
  count  = true ? 1 : 0

  release   = "metrics-server"
  namespace = "md-observability"
}

// Making this a hard-coded conditional for now. Unless the user is running prometheus (or integrates an observability package like DD)
// there isn't much point to this service.
module "kube-state-metrics" {
  source = "../../../provisioners/terraform/modules/k8s-kube-state-metrics"
  count  = true ? 1 : 0

  md_metadata = var.md_metadata
  release     = "kube-state-metrics"
  namespace   = "md-observability"
}
