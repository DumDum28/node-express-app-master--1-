terraform {

  required_providers {

    docker = {

      source = "kreuzwerker/docker"

      version = "2.13.0"

    }

  }

}

provider "docker" {

  host = "npipe:////./pipe/docker_engine"

}





resource "docker_image" "my_app" {

  name = "my-docker-app"

  keep_locally = true

}



resource "docker_container" "my_container" {

  name = "my-container"

  image = docker_image.my_app.name

  must_run = true

} 
