variable "env" {
  description = "Environment name"
  type = string
}

variable "eks_name" {
 description = "Name of cluster"
 type = string
}

variable "enable_cluster_autoscaler" {
  description = "Determine whether to deploy cluster autoscaler"
  type = bool
  default = false
}

variable "enable_loadbalancer_controller" {
  description = "Determine whether to deploy loadbalancer controller"
  type = bool
  default = false
}
variable "cluster_autoscaler_helm_version" {
  description = "Cluster Autoscaler Helm version"
  type = string
}

variable "aws_lbc_helm_version" {
  description = "AWS Loadbalancer Helm version"
  type = string
}
