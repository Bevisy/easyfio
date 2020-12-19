IMAGE_NAME = fio
IMAGE_VERSION = latest

.PHONY: \
    build-image \
    clean

build-image: 
    docker build $(IMAGE_NAME):$(IMAGE_VERSION) -f Dockerfile

clean:
    docker rmi $(IMAGE_NAME):$(IMAGE_VERSION)