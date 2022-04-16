terraform {
	required_providers {
		docker = {
			source  = "kreuzwerker/docker"
			version = "~>2.13.0"
		}
	}
}

provider "docker" {}

resource "docker_image" "pulled_docker_image" {
	name = format("vvafwgsv/%s", var.image_name)
}

resource "docker_container" "created" {
	image = docker_image.pulled_docker_image.name
	name  = format("%s-%s", split(":",var.image_name)[0], "container")
	
	ports {
		external = var.network_config.external_port
		internal = (var.image_name == "flask-docker:final" ? 5000 : 80)
		ip = var.network_config.url
	}
}



