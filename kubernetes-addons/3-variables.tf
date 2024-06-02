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

variable "cluster_autoscaler_helm_version" {
  description = "Cluster Autoscaler Helm version"
  type = string
}

/*
variable "openid_provider_arn" {
  description = "IAM Openid Connect Provider ARN"
  type = string
}
*/