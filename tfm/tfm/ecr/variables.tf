variable "env" {}

variable "additional_tags" {
  

  default = {
    ManagedBy = "Terraform"
  }
}

variable "repos" {
  type = list(string)
  default = [ "jom-fe", "jom-be" ]
}