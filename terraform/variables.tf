variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}

variable "prefix" {
  type = string
  description = "Prefix for AWS resources"
}

variable "definition_file_path" {
  type = string
  description = "Relative path from `definitions/` with extension"
}
