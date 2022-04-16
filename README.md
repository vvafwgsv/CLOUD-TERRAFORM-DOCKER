# CLOUD-TERRAFORM-DOCKER
## Description

The repository contains a Terraform project aimed to automate the process of deploying a dockerized web server.

Docker images of **python-flask** [vvafwgsv/flask-docker](https://hub.docker.com/repository/docker/vvafwgsv/flask-docker) and **Nginx** [vvafwgsv/nginx-docker](https://hub.docker.com/repository/docker/vvafwgsv/nginx-docker) are hosted on separate repositories on _hub.docker.com_

## Source code for Docker images
Alongside the Terraform files, a python-flask project [flask-docker](https://github.com/vvafwgsv/CLOUD-TERRAFORM-DOCKER/tree/main/flask-docker) and Nginx static content [nginx-docker](https://github.com/vvafwgsv/CLOUD-TERRAFORM-DOCKER/tree/main/nginx-docker) were enclosed.

## How to run the Terraform module?
- The module accepts either of the Docker images: _flask-docker:final_ or  _nginx-docker:final_
- Currently one and only accepted network configuration (restricted via _validate_ instructions) is of such form: 
	
	> _localhost:8081_
	
- The Terraform module comes with predefined _input_variables_, located in _terraform-docker/terraform.tfvars_. One might adjust them before executing the module.

```
# exemplary variables, compliant with the task requirements

image_name = "nginx-docker:final"
network_config = {
	external_port = 8081
	url = "localhost"
}
```
- The variables can be defined on the run, and thus would take precedence over _terraform.tfvars_ 

```
{{}} blocks denote user input

terraform [COMMAND] -var "image_name={{ name of a Docker image as string }}" \
                    -var "network_config={\"url\":\"{{ host address as string }}\", \
                    \"external_port\":{{ number of external port of Docker container as number }}}"
```

- Runnig the module with CLI defined variables: 
```
# exemplary configuration
$ terraform plan -var "image_name=flask-docker:final" /
                    -var "network_config={\"url\":\"localhost\", /
                    \"external_port\":8081}" -out build_plan
 
$ terraform apply build_plan
…
$ terraform destroy
```

- One can omit defining the variables on the CLI, as they would be sourced from _terraform.tfvars_, and proceed.

```
$ git clone https://github.com/vvafwgsv/CLOUD-TERRAFORM-DOCKER.git .
$ cd terraform-docker/
$ terraform init
$ terraform plan -out build_plan
$ terraform apply build_plan
…
$ terraform destroy

```
## Room for improvement
### Terraform
The _main.tf_ code was tailored so as to meet the task requirements and presented expectations, i.e. localhost and 
port. However it could be adjusted to accept IPv4/6 (regex validation) host addresses, alongside the abolished external port restrictions.

The Terraform module execution might be automated (Interactive mode suppressed, -out configuration)

I believe that _main.tf_ might be of greater clarity if _variables_ {} declaration blocks were placed in a separate file. In fact, other components could granted with own files: _providers.tf_, _output.tf_.

Moreover _description_ and _error_message_ params could be more adjusted to describe the context in a more precise manner. 

### Docker
_flask-docker/Dockerfile_ might undergo further optimization, i.e. multi-staging, which was attempted (reducing size of pulled image, clearing cache, stripping _venv_ of any redundant files), yet rendered ineffective.


Given the lack of proficiency in the matter of Terraform / dockerizing, many otherwise apparent aspects, requiring improvement, might have been overlooked.
