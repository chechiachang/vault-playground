variable "organization" {
  type = string
}

variable "path" {
  type = string
}

variable "description" {
  type = string
}

variable "teams" {
  type = map(object({
    team     = string
    policies = list(string)
  }))
  default     = {}
  description = "List of teams to create"
}

variable "users" {
  type = map(object({
    user     = string
    policies = list(string)
  }))
  default     = {}
  description = "List of users to create"
}

