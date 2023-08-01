variable "region" {
  description = "Default AWS region"
  type        = string
}

variable "bucket" {
  description = "The name of the bucket"
  type        = string
  default     = ""
}

variable "origins" {
  description = "List of origins that can access the bucket"
  type        = list(string)
  default     = ["*"]
}
