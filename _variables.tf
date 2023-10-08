variable "region" {
  default = "us-east-1"
}
variable "cluster_name" {
  type = string
}
variable "cidr" {
  type = string
}
variable "cluster_version" {
  type = string
}
variable "cluster_endpoint_public_access" {
  type = bool
}
variable "azs" {
  description = "A list of AZs inside the VPC"
  type        = list(string)
  default     = []
}
variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}
variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}