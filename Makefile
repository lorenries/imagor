install:
	go get -u .

build:
	go build -o bin/imagor ./cmd/imagor/main.go

dev: build
	./bin/imagor -debug -imagor-unsafe

test:
	go test

docker-build-dev:
	docker build --build-arg IMAGOR_VERSION=dev -t shumc/imagor:dev .

docker-dev: docker-build-dev
	docker run -p 8000:8000 shumc/imagor:dev -debug -imagor-unsafe

docker-build:
	docker build --no-cache=true --build-arg IMAGOR_VERSION=$(VERSION) -t shumc/imagor:$(VERSION) .

docker-push:
	docker tag shumc/imagor:$(VERSION) shumc/imagor:latest
	docker push shumc/imagor:$(VERSION)
	docker push shumc/imagor:latest

docker: docker-build docker-push
