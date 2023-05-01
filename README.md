# Central

Central auth server + component library for my personal apps.  

## Common
```
cd common && make install
cd common && make clean
cd common && make react-build ocaml-build
```

## Server

### Local Development

Barebones, totally local development environment.  

#### Dependencies
 - opam
   - `brew install opam`
 - [dune](https://dune.build)
 - [yarn](https://yarnpkg.com)
 - postgres
 - libpq
   - `brew install libpq`
 - openssl
   - `brew install openssl`

#### Initial Setup
`initdb data`  
`pg_ctl -D data -l logfile start`  
`createdb central`  
`make install`  
`cd server && make migrate`  
  
Create `database.env` at the root of the repository:
```
PGUSER=jakekinsella
PGPASSWORD=
PGHOST=localhost
PGPORT=5432
PGDATABASE=central
```

#### Run
`cd server && make start`  
`cd ui && make start`
  
Navigate to `http://localhost:3001`  

#### Other
*Refresh central dependencies:*  
`cd ui && make refresh start`  

### Local Deploy
Deployed as a Kubernetes cluster.  

#### Dependencies
 - [Docker Desktop](https://www.docker.com/products/docker-desktop/)
 - [minikube](https://minikube.sigs.k8s.io/docs/)
 - [dune](https://dune.build)
 - [yarn](https://yarnpkg.com)

#### Initial Setup

`minikube start`  
`eval $(minikube docker-env)`  
`minikube addons enable ingress`  
`minikube tunnel`  
`sudo sh -c 'echo "127.0.0.1       central.localhost" >> /etc/hosts'`
  
Create a certificate called `cert`:
```
openssl req -newkey rsa:4096 \
            -x509 \
            -sha256 \
            -days 3650 \
            -nodes \
            -out cert.crt \
            -keyout cert.key
```
  
Create `secrets.env` in the root of the repo:
```
USER_PASSWORD=???
```

#### Build+Deploy
`make local-publish`  
`make local-deploy`  

... some amount of waiting ...  
`kubectl get pods` should show the containers starting up  
  
Navigate to `https://central.localhost/login`  

## TODO
 - deploy
 - build base docker images with common package installed
 - scope token cookie to just domain
 - use real jwt secret