# Set the required provider and versions
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

# Configure the docker provider
provider "docker" {
  host = var.is_remote ? "ssh://${var.ssh_user}@${var.remote_docker}" : "unix:///var/run/docker.sock"
  ssh_opts = var.is_remote ? [
    "-o", "StrictHostKeyChecking=no",
    "-o", "UserKnownHostsFile=/dev/null",
    "-i", var.ssh_private_key_path
  ] : []
}

# Create a docker image resource
resource "docker_image" "image" {
  name         = var.container_image
  keep_locally = true
}

# Create a docker volume resource
resource "docker_volume" "volume" {
  count = var.containers_number
  name  = "${var.container_volume}-${count.index}"
}

# Create a docker network resource
resource "docker_network" "network" {
  name = var.container_network
}

# Create a docker container resource
resource "docker_container" "container" {
  count = var.containers_number
  name  = "${var.container_name}-${count.index}"
  hostname = "${var.container_name}-${count.index}"
  image = docker_image.image.image_id
  memory = var.container_memory
  privileged = var.container_privileged
  restart = var.container_restart

  env = [
    "PUID=${var.container_puid}",
    "PGID=${var.container_pgid}",
    "TZ=${var.container_tz}",
  ]
  
  ports {
    external = var.ext_port + count.index
    internal = var.int_port
  }

  volumes {
    volume_name    = docker_volume.volume[count.index].name
    container_path = "/usr/share/nginx/html"
    read_only      = false
  }

  networks_advanced {
    name    = docker_network.network.name
    aliases = [docker_network.network.name]
  }
 
  healthcheck {
    test = var.healthcheck_command
    interval = "3s"
    retries = 0
  }

  command = [
    "sh",
    "-c",
    "echo '<html><head><title>${var.container_name}-${count.index}</title></head><body><h1>Container Hostname: ${var.container_name}-${count.index}</h1></body></html>' > /usr/share/nginx/html/index.html && nginx -g 'daemon off;'"
  ]

}
