variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
  default = "East US"
}

variable "vnet_name" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
  type = string
  sensitive = true
}
