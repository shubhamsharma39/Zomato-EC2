variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1" 
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.medium"
}

variable "key_name" {
  description = "Existing key pair name for SSH"
  type        = string
  default     = "capstone" 
}
