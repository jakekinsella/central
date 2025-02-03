install:
	cd server && make install
	cd ui && make install

.PHONY: build
build:
	cd server && make build

clean:
	cd server && make clean


common-publish:
	make -f deploy/Makefile image IMAGE=common_ocaml DOCKERFILE=~/Personal/central/build/docker/common/ocaml/Dockerfile
	make -f deploy/Makefile image IMAGE=common_react DOCKERFILE=~/Personal/central/build/docker/common/react/Dockerfile

cluster-publish:
	make -f deploy/Makefile image publish IMAGE=server DOCKERFILE=~/Personal/central/build/docker/server/Dockerfile
	make -f deploy/Makefile image publish IMAGE=ui DOCKERFILE=~/Personal/central/build/docker/ui/Dockerfile


local-publish:
	make -f deploy/Makefile image CLUSTER=server DOCKERFILE=~/Personal/central/build/docker/server/Dockerfile

local-deploy:
	make -f build/local/Makefile deploy

local-teardown:
	make -f build/local/Makefile teardown


aws-init:
	cd build/aws && make init

aws-image:
	cd build/aws && make image

aws-repo:
	cd build/aws && make repository

aws-build:
	cd build/aws && make build

aws-teardown:
	cd build/aws && make teardown


publish:
	make -f deploy/Makefile publish IMAGE=$(CLUSTER) DOCKERFILE=$(DOCKERFILE)

deploy:
	make -f deploy/Makefile deploy CLUSTER=$(CLUSTER) VERSION=$(VERSION)

teardown:
	make -f deploy/Makefile CLUSTER=$(CLUSTER) teardown
