locals {
	port = docker_container.created.ports[0].external
	host = docker_container.created.ports[0].ip
}

output "web_URL" {
	value = "http://${local.host}:${local.port}"
}