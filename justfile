# Variables
DOCKER_USER := "pyrogn"
IMAGE_NAME := "seleniumbase"
TAG := "latest"
DOCKERFILE_PATH := "."
DOCKER_IMAGE := DOCKER_USER + "/" + IMAGE_NAME + ":" + TAG

# Default recipe
default:
    just build

# Build the Docker image
build:
    docker build --platform linux/amd64 -t {{DOCKER_IMAGE}} {{DOCKERFILE_PATH}}

# Publish the Docker image to Docker Hub
publish: build
    echo "Publishing {{DOCKER_IMAGE}} to Docker Hub..."
    docker login -u {{DOCKER_USER}}
    docker push {{DOCKER_IMAGE}}

# Clean up local Docker images
clean:
    docker rmi {{DOCKER_IMAGE}}

# Run the Docker container
run:
    docker run --platform linux/amd64 -it {{DOCKER_IMAGE}}

# Help message
help:
    @echo "Justfile for building and publishing Docker image"
    @echo ""
    @echo "Usage:"
    @echo "  just build       Build the Docker image"
    @echo "  just publish     Publish the Docker image to Docker Hub"
    @echo "  just clean       Remove the Docker image from local"
    @echo "  just run         Run the Docker container"
    @echo "  just help        Show this help message"
