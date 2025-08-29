variable "region" {
  type = map(string)
  default = {
    "brasil" = "sa-east-1"
    "us"     = "us-east-1"
  }
}