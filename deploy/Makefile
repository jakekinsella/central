image:
	./deploy/publish.sh $(IMAGE) $(DOCKERFILE)

publish:
	./deploy/push-image.sh $(IMAGE) $(DOCKERFILE)

deploy:
	./deploy/deploy.sh $(CLUSTER) $(VERSION)

teardown:
	./deploy/teardown.sh $(CLUSTER)
