<!-- ANCHOR: cover -->

# Early performance results from the prototype Morello microarchitecture

* Robert N. M. Watson (University of Cambridge),
* Jessica Clarke (University of Cambridge),
* Peter Sewell (University of Cambridge),
* Jonathan Woodruff (University of Cambridge),
* Simon W. Moore (University of Cambridge),
* Graeme Barnes (Arm Limited),
* Richard Grisenthwaite (Arm Limited),
* Kathryn Stacer (Arm Limited),
* Silviu Baranga (Arm Limited), and
* Alexander Richardson (Google LLC)

*This is a living document; feedback and contributions are welcomed.
Please see our
[GitHub Repository](https://github.com/CTSRD-CHERI/morello-early-performance-results)
for source code and an issue tracker.
There is a [rendered version on the web](https://ctsrd-cheri.github.io/morello-early-performance-results/),
which is automatically updated when the git repository is committed to.*

## Acknowledgements

This work was supported by Innovate UK project "Digital Security by Design
(DSbD) Technology Platform Prototype", 105694.
We gratefully acknowledge UK Research and Innovation (UKRI), who sponsored the
creation of Morello, and also the significant investment by DARPA in
supporting the creation of CHERI and its earlier prototypes.
We also acknowledge Arm Limited and Google, Inc.

<!-- ANCHOR_END: cover -->

## Building

Building the book from the Markdown sources requires
[mdBook](https://github.com/rust-lang/mdBook). Once installed, `mdbook build`
will build the static HTML files in the `book/` directory, whilst `mdbook
serve` will build and serve them at `http://localhost:3000`. Please refer to
the mdBook documentation for futher options.

There is also a Makefile for building a PDF version of this book, which
additionally requires [pandoc](https://pandoc.org). Once pandoc is installed,
`make` will build a PDF called `book.pdf`.
