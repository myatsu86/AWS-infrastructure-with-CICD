variable "env" {
    description = "Working/Developing env (dev,stage,prod)"
    type = string
}

variable "tf_backend_bucket" {
  description = "Name of the S3 bucket for Terraform state"
  type        = string
}