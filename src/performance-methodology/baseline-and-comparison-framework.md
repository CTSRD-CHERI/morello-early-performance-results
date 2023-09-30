# Baseline and comparison framework

## Hardware

Despite being based on the Neoverse N1 configured as found in the N1SDP,
performance results gathered on Morello are not directly comparable.
Most importantly, cache sizes and other aspects of the memory subsystem differ
between the designs.
Instead, direct comparisons must be performed between multiple software
configurations on Morello.

In addition, measurements in this report are made on an FPGA-adapted
implementation of Morello, with three variants used:

* **Baseline Morello design** modeled on the shipped Morello SoC.
* **Modified Morello design with data-dependent exception fix** correcting a
  microarchitectural issue with exception delivery (see below for details).
* **Modified Morello design with data-dependent exception fix and increased
  store queue size** expanding the store queue sizes to address increased queue
  pressure due to the presence of capability stores, on top of the above
  modified design.

In general, third parties will only have access to unmodified Morello SoCs.
However, they should see similar results to those we describe for the baseline
Morello design on FPGA.

All Morello configurations operated at a fixed frequency during
benchmarks[^1], with execution time measured in clock cycles for the purposes
of calculating overheads.

## Software

In general, comparisons in this report seek to contrast the dynamic behavior
of memory-unsafe code with memory-safe code on Morello.
To understand the essential pointer-size costs of CHERI, we also introduce a
fourth form of code, P128, with two variations.
This will allow us to model ‘optimal’ performance with the current
microarchitecture.
Our experiments set up comparisons between five forms of code:

* **Hybrid (aarch64) code**, which employs capabilities only where explicitly
  annotated in C and C++.
* **Purecap ABI (aarch64c) code**, which employs capabilities ubiquitously in
  the implementation of CHERI C and C++, including both sub-language pointers
  (e.g., stack pointers, GOT pointers, and return addresses) and
  language-level pointers (e.g., pointer variables pointing at heap
  allocations, stack allocations, or functions).
* **Benchmark ABI (aarch64c) code**, which has modified code generation to
  work around a lack of capability-awareness in the shipped Morello branch
  predictor (described below).
  This code retains an identical memory footprint and near-identical code
  generation to pure-capability aarch64c C/C++ code, but has reduced
  protection behavior.
  See below for more information on this ABI.
* **P128 code**, which is a modified form of aarch64 code in which pointer
  footprints are widened to 128 bits from 64 bits, while still implemented as
  64-bit integers rather than capabilities.
  See below for more information on this compilation mode.
* **P128 Forced GOT code**, which, unlike P128, which allows access to global
  variables via PC-derived pointers, forces the indirection of all global
  access via a Global Offset Table (GOT) to emulate the potential worst-case
  addition of capability indirection that could be experienced with
  pure-capability code. See below for more information on this compilation
  mode.

We recommend that code be compiled with optimization for performance enabled,
which we believe currently achieves the best comparison; it is especially
important that code compiled with -O0 not be compared between ABIs, due to
current inefficiency in unoptimized CHERI code generation, eliminated with
even basic optimization.
With respect to -O1 and above, we are still coming to understand how some
optimization passes should interact with capabilities (e.g., SROA, global
merging, GVN, and others), and some optimisations are therefore presently
inhibited.

One implication of using the hybrid ABI rather than baseline aarch64 is that
library implementations of memory-copying routines that have been updated for
capability tag propagation, such as memcpy(), will be capability-aware and use
capability-based portions of the instruction set.
This maximizes comparability in an area where there has not yet been
substantial dynamic performance analysis and optimization, but with the
limitation that hybrid code might be able to achieve better performance if it
used highly optimized copying routines not yet available for CHERI-generated
code.
Another consideration is that the baseline Armv8.2-A architecture underlying
Morello predates [dedicated memory-copy
instructions](https://community.arm.com/arm-community-blogs/b/architectures-and-processors-blog/posts/arm-a-profile-architecture-developments-2021)
[[WEI21]](../bibliography/#WEI21).
If these new instructions were suitably adapted to handle CHERI alignment, tag
propagation, and bounds enforcement, they would enable comparable
hardware-based optimization for capability-enabled memory copying.

For the purposes of these measurements, which focus on userlevel performance,
we have used the CheriBSD 22.12 hybrid kernel.
Debugging features such as kernel invariants checking (INVARIANTS) and dynamic
kernel lock order verification (WITNESS) are left enabled, but should not
contribute significantly for these workloads.
Userlevel malloc debugging is disabled. CheriBSD is compiled with -O2,
including its system libraries.

The SPECint benchmark suite is compiled with -O3. SPEC is statically linked in
all presented results.

By default, CheriBSD 22.12 ships with unoptimized third-party libraries (compiled with -O0), to improve debugging in the initial release, and those would not be suitable for benchmarking; we intend to provide packages built with optimizations enabled in the future. SPECint does not have external software dependencies beyond those in the CheriBSD base system (e.g., `libc`, `libunwind`, `libcxxrt`, `libm`, and `libgcc_s`), and so our work is not affected. If we were dependent on third-party packages, as might be true of other benchmark suites, we would need to investigate optimization settings for those packages.

[^1]: The FPGA setup used in these measurements does not implement thermal
throttling.
