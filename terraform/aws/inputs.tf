variable "region" {
  type        = string
  default     = "ap-south-1"
  description = "this is region for ntt network"
}
variable "ntt-vpc-info" {
  type = object({
    ntt-vpc-cidr  = string
    ntt-subnet-az = list(string)
    subnet-names  = list(string)
  })
  default = {
    ntt-vpc-cidr  = "192.168.0.0/24"
    ntt-subnet-az = ["a", "b", "a", "b"]
    subnet-names  = ["ntt-web1-subnet", "ntt-web2-subnet", "ntt-db1-subnet", "ntt-db2-subnet"]
  }
}