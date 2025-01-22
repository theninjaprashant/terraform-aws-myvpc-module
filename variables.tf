variable "vpc_config" {
  description = "Get CIDR and name of VPC from user"
  type = object({
    cidr_block = string
    name = string
  })

  validation {
    condition = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "Invalid cidr format provided by Prashant ${var.vpc_config.cidr_block}"
  }
}

variable "subnet_config" {
  description = "Get subnet cidr and AZ details"
  type = map(object({
    cidr_block =  string
    az = string
    public = optional(bool, false)
  }))

   validation {
    condition = alltrue([for i in var.subnet_config : can(cidrnetmask(i.cidr_block))])
    error_message = "Invalid cidr format provided by Prashant"
  }
}