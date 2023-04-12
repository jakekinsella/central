# Central

Central auth server + component library for my personal apps.  

## Local Development

Barebones, totally local development environment.  

### Dependencies
 - opam
   - `brew install opam`
 - [dune](https://dune.build)
 - [yarn](https://yarnpkg.com)
 - postgres
 - libpq
   - `brew install libpq`
 - openssl
   - `brew install openssl`

### Initial Setup
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

### Run
`cd server && make start`  
`cd ui && make start`
  
Navigate to `http://localhost:3001`  

## todo
 - everything