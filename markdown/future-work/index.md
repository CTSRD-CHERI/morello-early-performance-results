# Future work

Our effort to analyze and optimize performance, starting with the original
taped-out Morello design, and now continuing on FPGA, remains at an early
stage, with many next steps to take.
These include:

* Enabling third-party use of the “Benchmark ABI” to allow reproduction of our
results, as well as application of the approach to other workloads.
This is an important step, as limitations on speculation for short function
executions can have a disproportionate impact on certain workloads, and is
also very sensitive to compiler and linker choices regarding code layout and
inlining.
Toolchain support for the Benchmark ABI will be made available in May 2023.
We anticipate that the next release of CheriBSD, targeted for mid-2023, will
support statically and dynamically linked binaries, as well as roughly 10K
open-source packages, compiled to the Benchmark ABI to support third-party
performance analysis on Morello.

* Improving the completeness of the P128 compilation mode and ABI, which will
allow us to better project future performance not just on the Morello design,
but also other non-CHERI-enabled microarchitectures (and architectures).
Specific goals here would include widening GOT entries and improving layout
decisions around spilled stack entries of unknown type (e.g., callee-save
registers).
It will also be important to compare the sets of optimizations being applied
to baseline aarch64 (legacy), P128, and aarch64c (pure-capability) code in
order to better understand potential performance comparisons.
We have not yet reached a decision on supporting third-party users of the P128
compilation mode on CheriBSD due to the complexity of supporting the ABI.

* Improving our understanding of security-performance tradeoffs and
optimization opportunities around the pure-capability ABIs and code
generation.
For example, currently all access to global variables from pure-capability
code is indirected through the GOT, whereas aarch64 is able to perform some
accesses via the program counter.
Indirecting via the GOT allows globals to be accessed via dedicated
capabilities, each with their own permissions and bounds, but comes at the
cost of indirection.
However, many of those accesses don’t involve direct use of pointers driven by
programmer code &mdash; this typically occurs only when a pointer is taken to
a global, or arbitrary array accesses occur.
It may be possible to safely restore use of read-only PC-relative access in
many cases, avoiding this indirection.

* Continuing improvements to the enhanced on-FPGA Morello implementation.
In the next stage of our work, we will be investigating (and retuning)
microarchitectural data structures that were left unchanged from the Neoverse
N1 design.
Of particular interest are store queue sizes, which track in-flight stores,
and which are seeing higher congestion as a result of larger capability
store-pair memory accesses.

* Develop and publicize a model based on performance counters for estimating
performance overhead contributions from various essential and non-essential
factors on Morello.
This may make it easier to estimate potential performance behavior for future
microarchitectures using measurements taken on the current microarchitecture.

As this work proceeds, we will continue to update this living document.
