.PHONY: all
all: book.pdf

.PHONY: clean
clean:
	rm -rf book.pdf pdf/

ifeq (,$(filter clean,$(MAKECMDGOALS)))
PANDOCFLAGS+=	--metadata-file book.yaml
PANDOCFLAGS+=	--fail-if-warning

pdf:
	mkdir -p $@

pdf/book.pdf: book.yaml

book.pdf: pdf/book.pdf
	cp $^ $@

pdf/book.mk: src/SUMMARY.md lua/mdbook-mk.lua | pdf
	pandoc -t lua/mdbook-mk.lua -M mdbook.srcdir=src -M mdbook.bookdir=book -M mdbook.outdir=pdf -M mdbook.luadir=lua -o $@ -f markdown -- $<

include pdf/book.mk
endif
