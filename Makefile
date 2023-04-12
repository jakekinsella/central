install:
	cd server && make install
	cd ui && make install

build:
	cd server && make build

clean:
	cd server && make clean
