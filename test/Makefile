tests=$(wildcard test-*)

all:
	@for p in $(tests) ; do if ! ./$$p ; then exit 1 ; fi ; done

clean:

.PHONY: all clean
