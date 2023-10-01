init:
	packer init .
	cd repo/ && terraform init
	cd cluster/ && terraform init
	cd nodes/ && terraform init

repository:
	cd repo && terraform apply

image:
	./build_image.sh

build:
	cd cluster && terraform apply
	cd nodes && terraform apply

teardown:
	cd cluster && terraform destroy
	cd nodes && terraform apply
