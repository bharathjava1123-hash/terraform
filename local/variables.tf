
variable "instance_names" {
    type        =  list(string)
    default     =  ["mysql", "backend", "frontend"]
}

variable "common_tags" {
    type = map
    default = {
        Project = "expense"
        Environment = "dev"
        Terraform = "true"
    }
}

variable "ami_id" {
  type        = string
  default     = "ami-0220d79f3f480ecf5"
  description = "ami id"
}

variable "environment" {
  type        = string
  default     = "prod"
}

variable "tag" {
  type        = string
  default     = "expense"
  description = "description"
}

variable "allow_ssh" {
  type        = string
  default     = "allow_ssh"
}

variable "port" {
  type        = number
  default     = 22
}


variable "protocol" {
  type        = string
  default     = "tcp"
}


