variable "image_name" {
	type = string
	description = "The literal of either 'nginx-docker:final' or 'flask-docker:final'." 

	validation {
		condition = var.image_name == "flask-docker:final" || var.image_name == "nginx-docker:final"
		error_message = "The image_name must be either 'flask-docker:final' or 'nginx-docker:final'."
	}
}

variable "network_config" {
	type = object({
			external_port = number
			url	= string
		})
	description = "The network_config variable is used to set desired proxy the docker container is to adopt. network_config.port as <number> specifies EXTERNAL_PORT for docker container, network_config.url as <string> denotes the host."	
	validation {
		condition = (var.network_config.external_port == 8081)
		error_message = "The external port is expected to be 8081."
	}
	validation {
		condition = (var.network_config.url == "localhost")
		error_message = "The URL is expected to be 'localhost'."
	}
}