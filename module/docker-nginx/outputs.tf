output "container_names" {
  value = [for c in docker_container.container : c.name]
}
