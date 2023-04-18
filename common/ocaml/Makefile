install:
	export C_INCLUDE_PATH=`ocamlc -where`:$C_INCLUDE_PATH
	export PKG_CONFIG_PATH=/usr/local/opt/zlib/lib/pkgconfig:/usr/local/opt/openssl/lib/pkgconfig
	export LDFLAGS="-L/usr/local/opt/libpq/lib"
	export CPPFLAGS="-I/usr/local/opt/libpq/include"
	opam pin add -yn common .
	opam install --deps-only common

build:
	dune build
	opam install common

clean:
	opam unpin common
	rm -rf _build
