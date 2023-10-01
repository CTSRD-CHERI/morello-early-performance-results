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

## Citation

Please cite this report as:

Robert N. M. Watson, Jessica Clarke, Peter Sewell, Jonathan Woodruff,
Simon W. Moore, Graeme Barnes, Richard Grisenthwaite, Kathryn Stacer,
Silviu Baranga, and Alexander Richardson.  **Early performance results
from the prototype Morello microarchitecture**.  Technical Report
UCAM-CL-TR-986, University of Cambridge, Computer Laboratory, 30 September
2023.

Or in BibTeX:

```
@TechReport{UCAM-CL-TR-986,
  author =       {Watson, Robert N. M. and Clarke, Jessica and Sewell, Peter
                  and Woodruff, Jonathan and Moore, Simon W. and Barnes,
                  Graeme and Grisenthwaite, Richard and Stacer, Kathryn and
                  Baranga, Silviu and Richardson, Alexander},
  title =        {{Early performance results from the prototype Morello
                  microarchitecture}},
  institution =  {University of Cambridge, Computer Laboratory},
  address =      {15 JJ Thomson Avenue, Cambridge CB3 0FD, United Kingdom,
                  phone +44 1223 763500},
  month =        {September},
  year =         {2023},
  number =       {UCAM-CL-TR-986}
}
```

## Sponsorship

This work was supported by Innovate UK project "Digital Security by Design
(DSbD) Technology Platform Prototype", 105694.

Approved for public release; distribution is unlimited.
Sponsored by the Defense Advanced Research Projects Agency (DARPA) under
contract HR0011-22-C-0110 ("ETC").
The views, opinions, and/or findings contained in this report are those of
the authors and should not be interpreted as representing the official
views or policies, either expressed or implied, of the Department of
Defense or the U.S. Government.

We gratefully acknowledge UK Research and Innovation (UKRI), who sponsored the
creation of Morello, and the significant investment by DARPA in supporting the
creation of CHERI and its earlier prototypes.
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
