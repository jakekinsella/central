publish:
	./build/publish.sh

deploy:
	./build/deploy.sh $(VERSION)

teardown:
	./build/teardown.sh $(VERSION)

common-publish:
		docker buildx build --platform linux/arm64/v8 . -f build/docker/common/ocaml/Dockerfile -t common_ocaml:latest
		docker buildx build --platform linux/arm64/v8 . -f build/docker/common/react/Dockerfile -t common_react:latest

