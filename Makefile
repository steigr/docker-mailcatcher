TAG      ?= $(shell git rev-parse HEAD 2>/dev/null)
IMAGE    ?= quay.io/steigr/$(shell basename $(PWD))

image:
	docker build $(DOCKER_ARGS) --tag="$(IMAGE):$(TAG)" .

push: image
	docker push "$(IMAGE):$(TAG)"

release:
	@DOCKER_ARGS="--no-cache" TAG="$(shell git describe --tags)" \
	make image push
	@UPX_ARGS="$(UPX_ARGS)" TAG=latest \
	make image push