publish:
	mkdir -p tmp/build/docker/server
	mkdir -p tmp/build/docker/ui
	
	envsubst < build/docker/server/Dockerfile > tmp/build/docker/server/Dockerfile
	envsubst < build/docker/ui/Dockerfile > tmp/build/docker/ui/Dockerfile

	docker buildx build . -f tmp/build/docker/server/Dockerfile -t central:latest
	docker buildx build . -f tmp/build/docker/ui/Dockerfile -t central_ui:latest

deploy:
	./build/local/deploy.sh

teardown:
	./build/local/teardown.sh
