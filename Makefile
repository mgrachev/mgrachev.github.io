build:
	docker build -t blog .
PHONY: build

run:
	docker run --rm -it -p 4000:4000 -v `pwd`:/app blog
PHONY: run
