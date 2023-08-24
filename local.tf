locals {

  name_pre = "${var.env}-mysql"
  tags= merge(var.tags,{tf-module="mysql"},{env=var.env})
}