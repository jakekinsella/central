#! /bin/bash

export IMAGE="central:latest"
export UI_IMAGE="central_ui:latest"
export IMAGE_POLICY="Never"
export POSTGRES_LB="---
apiVersion: v1
kind: Service
metadata:
  name: postgres
spec:
  selector:
    app: postgres
  ports:
    - port: 5432
      targetPort: 5432
  type: LoadBalancer"
export HOST="central.localhost"

kubectl create secret generic reader-secrets --from-env-file secrets.env
kubectl create secret tls reader-cert --key=cert.key --cert=cert.crt

for f in build/cluster/*.yaml; do envsubst < $f | kubectl apply -f -; done
