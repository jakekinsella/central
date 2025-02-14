install:
	cd server && make install
	cd ui && make install

.PHONY: build
build:
	cd server && make build

clean:
	cd server && make clean

common-publish:
	make -f build/Makefile common-publish

common-publish-arm:
	make -f build/Makefile common-publish-arm

local-publish:
	make -f build/local/Makefile publish

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

cluster-publish:
	make -f build/Makefile publish

cluster-deploy:
	make -f build/Makefile deploy VERSION=$(VERSION)

cluster-teardown:
	make -f build/Makefile teardown
