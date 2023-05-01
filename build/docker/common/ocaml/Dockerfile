FROM ocaml/opam:alpine-ocaml-4.14

WORKDIR /home/opam/common

ADD common/ocaml/common.opam .
RUN opam pin add -yn common . && \
    opam depext common && \
    opam install --deps-only common

ADD common/ocaml/ .
RUN sudo chown -R opam:nogroup . && \
    opam config exec make build && \
    opam depext -ln common > depexts
