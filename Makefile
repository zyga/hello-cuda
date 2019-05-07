.PHONY: all
all: hello-cuda

.PHONY: clean
clean:
	rm -f hello-cuda

.PHONY:
fmt: hello-cuda.cu | .clang-format
	clang-format -i $^

prefix ?= /usr/local
bindir ?= $(prefix)/bin
libdir ?= $(prefix)/lib
DESTDIR ?=

.PHONY: install
install:: hello-cuda | $(DESTDIR)$(bindir)
	install --strip -m 755 $< $|
install:: run-snap-cuda-selector | $(DESTDIR)$(bindir)
	install -m 755 $< $|

install:: | $(DESTDIR)$(libdir)/gpu-support

hello-cuda: %: %.cu
	nvcc -o $@ $^

$(addprefix $(DESTDIR),$(bindir) $(libdir)/gpu-support):
	install -m 755 -d $@
