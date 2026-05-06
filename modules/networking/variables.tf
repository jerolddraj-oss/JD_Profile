variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "cidr_block_hub" {
  type = string
  # e.g., 10.0.0.0/16
}

variable "cidr_block_spoke1" {
  type = string
  # e.g., 10.1.0.0/16
}

variable "cidr_block_spoke2" {
  type = string
  # e.g., 10.2.0.0/16
}
