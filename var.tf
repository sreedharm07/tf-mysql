variable "env" {}
variable "tags" {}
variable "subnets_ids" {}

variable "vpc_id" {}

variable "sg-ingress-cidr" {}
variable "sg_port" {}

variable "family" {}
variable "backup_retention_period" {}
variable "preferred_backup_window" {}
variable "engine_version" {}
variable "engine" {}
variable "skip_final_snapshot" {}
variable "kms_key_id" {}
