terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
            version = "3.0.2"
        }
        null = {
            source = "hashicorp/null"
            version = "3.1.0"
        }
    }
}

provider "docker" {
    host = "npipe:////./pipe/docker_engine"
}

resource "null_resource" "execute_scripts" {
    provisioner "local-exec" {
        command = "powershell.exe ./buildImg.ps1"
        working_dir = "${path.module}"
    }
}

resource "docker_image" "my_app" {
    name = "node-express-app:latest"
    depends_on = [ null_resource.execute_scripts ]
}

resource "docker_container" "my_container" {
    name = "my-express-app"
    image = docker_image.my_app.name
    ports {
        internal = 3002
        external = 80
    }
}