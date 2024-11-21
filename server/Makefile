install:
	export C_INCLUDE_PATH=`ocamlc -where`:$C_INCLUDE_PATH
	export PKG_CONFIG_PATH=/usr/local/opt/zlib/lib/pkgconfig:/usr/local/opt/openssl/lib/pkgconfig
	export LDFLAGS="-L/usr/local/opt/libpq/lib"
	export CPPFLAGS="-I/usr/local/opt/libpq/include"
	opam pin add -yn central .
	opam install --deps-only central

build:
	dune build

start: build
	export `cat ../database.env` && export `cat ../secrets.env` && PORT=2001 dune exec central

rollback: build
	export `cat ../database.env` && export `cat ../secrets.env` && dune exec database rollback

migrate: build
	export `cat ../database.env` && export `cat ../secrets.env` && dune exec database migrate

clean:
	rm -rf _build
