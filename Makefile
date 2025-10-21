
platforms ?= linux/amd64,linux/arm64
tag ?= dev

# Für Docker-Image (app)
.PHONY: docker-build-release
docker-build-release:
	docker buildx build --platform $(platforms) \
		--build-arg VERSION=$(tag) \
		-t $(DOCKERHUB_IMAGE):$(tag) \
		--push .

# Für Release-Binaries (app + installer)
.PHONY: go-build-release
go-build-release:
	mkdir -p bin
	# app
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -trimpath -ldflags="-s -w -X main.version=$(tag)" -o bin/app-linux-amd64 ./cmd/app
	CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -trimpath -ldflags="-s -w -X main.version=$(tag)" -o bin/app-linux-arm64 ./cmd/app
	# installer
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -trimpath -ldflags="-s -w -X main.version=$(tag)" -o bin/installer-linux-amd64 ./cmd/installer
	CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -trimpath -ldflags="-s -w -X main.version=$(tag)" -o bin/installer-linux-arm64 ./cmd/installer
