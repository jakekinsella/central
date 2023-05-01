publish:
	./build/publish.sh

deploy:
	./build/deploy.sh $(VERSION)

teardown:
	./build/teardown.sh $(VERSION)

common-publish:
		docker image build . -f build/docker/common/ocaml/Dockerfile -t common_ocaml:latest
		docker image build . -f build/docker/common/react/Dockerfile -t common_react:latest

