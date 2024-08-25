variable "region" {
  type        = string
  default     = "ap-south-1"
  description = "this is region for ntt network"
}
variable "ntt-vpc" {
  type        = string
  default     = "192.168.0.0/16"
  description = "This is ntt-vpc cidr range"

}
variable "ntt-subnets" {
  type    = list(string)
  default = ["192.168.0.0/24", "192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
}
variable "ntt-subnets-az" {
  type    = list(string)
  default = ["a", "b", "a", "b"]
}
variable "subnet-tags" {
  type    = list(string)
  default = ["ntt-web1-subnet", "ntt-web2-subnet", "ntt-db1-subnet", "ntt-db2-subnet"]
}