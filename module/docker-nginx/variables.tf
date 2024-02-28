# Define variables

variable "is_remote" {
  description = "Flag to indicate whether to use a remote Docker host over SSH."
  type        = bool
  default     = false
}

variable "remote_docker" {
  description = "IP address or hostname of the remote Docker host."
  type        = string
  nullable    = true
  default     = "127.0.0.1"
}

variable "ssh_user" {
  description = "SSH user for connecting to the remote Docker host."
  type        = string
  nullable    = true
  default     = "devops"
}

variable "ssh_private_key_path" {
  description = "SSH private key file path"
  type        = string
  nullable    = true
  default     = "/home/user/.ssh/privkey"
}

variable "container_name" {
  description = "Name of the container."
  type        = string
  default     = "web-app"
}

variable "container_image" {
  description = "Image of the container."
  type        = string
  default     = "nginx"
  validation {
    condition     = can(regex("^nginx(:[a-zA-Z0-9-]+)?$", var.container_image))
    error_message = "Container image should be 'nginx' or 'nginx:tag' where tag is alphanumeric with hyphens allowed."
  }
}

variable "containers_number" {
  description = "Number of containers to spawn."
  type        = number
  default     = 2
}

variable "int_port" {
  description = "Internal port for container."
  type        = number
  default     = "80"
  validation {
    condition     = var.int_port >= 1 && var.int_port <= 65534
    error_message = "Internal port should be between TCP/1-65534."
  }
}

variable "ext_port" {
  description = "External port to use as starting point for containers"
  type        = number
  default     = "3000"
  validation {
    condition     = var.ext_port >= 3000
    error_message = "External port should be higher than TCP/3000."
  }
}

variable "container_network" {
  description = "Network for container."
  type        = string
  default     = "web_network"
}

variable "container_volume" {
  description = "Volume for container."
  type        = string
  default     = "web_data"
}

variable "container_memory" {
  description = "Allocated memory for container."
  type        = number
  default     = "256"
  validation {
    condition     = var.container_memory >= 64
    error_message = "Available memory for container should be higher than 64 MB."
  }
}

variable "container_restart" {
  description = "Restart policy for container."
  type        = string
  default     = "unless-stopped"
  validation {
    condition     = can(index(["no", "always", "unless-stopped", "on-failure"], var.container_restart) >= 0)
    error_message = "Restart policy for container should be one of: 'no', 'always', 'unless-stopped', or 'on-failure'."
  }
}

variable "container_puid" {
  description = "PUID for container."
  type        = number
  default     = "1000"
  validation {
    condition     = var.container_puid >= 0 && var.container_puid <= 65535
    error_message = "PUID shoud be between 0 and 65535."
  }
}

variable "container_pgid" {
  description = "PGID for container."
  type        = number
  default     = "1000"
  validation {
    condition     = var.container_pgid >= 0 && var.container_pgid <= 65535
    error_message = "PGID shoud be between 0 and 65535."
  }
}

variable "container_tz" {
  description = "Timzeone for container."
  type        = string
  default     = "Europe/Paris"
}

variable "container_privileged" {
  description = "Run container as privileged or not."
  type        = bool
  default     = false
}

variable "healthcheck_command" {
  description = "Healthcheck command"
  type        = list(string)
  default     = ["CMD", "curl", "-f", "localhost"]
}
