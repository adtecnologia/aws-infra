variable "region" {
  description = "Mapa de regiões AWS disponíveis"
  type        = map(string)
  default = {
    "brasil" = "sa-east-1"
    "us"     = "us-east-1"
  }
}