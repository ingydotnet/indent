DOCKER_NAME := yamlio/indent
TARGETS := \
	all \
	all-am \
	all-recursive \
	install \
	install-am \
	install-data-am \
	install-exec-am \
	install-recursive \

default: all

$(TARGETS):
	make -f Makefile $@

build:
	docker build -t $(DOCKER_NAME) .

shell: build
	docker run -it $(DOCKER_NAME) bash

clean:
	git clean -dxf
