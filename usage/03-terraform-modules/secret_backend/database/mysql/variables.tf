variable "mount_path" {
  description = "The path where the database auth method is mounted"
  type        = string
}

variable "mount_description" {
  description = "The description of the database auth method mount"
  type        = string
  default     = "MySQL database connection"
}

variable "host" {
  description = "The hostname of the database server"
  type        = string
  default     = "localhost"
}

variable "port" {
  description = "The port of the database server"
  type        = number
  default     = 3306
}

variable "database" {
  description = "The name of the database"
  type        = string
  default     = ""
}

variable "username" {
  description = "The username for the database user"
  type        = string
}

variable "password" {
  description = "The password for the database user"
  type        = string
  sensitive   = true
}

variable "allowed_roles" {
  type = map(object({
    creation_statements = list(string)
    default_ttl         = string
    max_ttl             = string
  }))
  default = {}
}
