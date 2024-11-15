publish:
	./build/publish.sh

deploy:
	./build/deploy.sh $(VERSION)

teardown:
	./build/teardown.sh $(VERSION)

common-publish-arm:
	docker buildx build --shm-size 8g --platform linux/arm64/v8 . -f build/docker/common/ocaml/Dockerfile -t common_ocaml:latest
	docker buildx build --platform linux/arm64/v8 . -f build/docker/common/react/Dockerfile -t common_react:latest

common-publish:
	docker buildx build --shm-size 8g . -f build/docker/common/ocaml/Dockerfile -t common_ocaml:latest
	docker buildx build . -f build/docker/common/react/Dockerfile -t common_react:latest

