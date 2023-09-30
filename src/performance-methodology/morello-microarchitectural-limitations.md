# Morello microarchitectural limitations

The following microarchitecture limitations arose due to the constrained timeline of the Morello development process. All are believed resolvable with a full-length design and optimization cycle used with production hardware.

* **PCC branch-prediction** This issue prevents proper speculation around
  changes in PC bounds &mdash; due to limitations in changes that could be
  made relative to the baseline design in this research programme.
  As a result, additional stalls are incurred when performing inter-library
  pure-capability function calls or returns when the results of any updated
  bounds on PCC are depended on.
  This occurs, for example, when PC-relative accesses to globals, or function
  calls or returns, depend on the value of PCC.
  This can be worked around via the "Benchmark ABI", which avoids
  capability-based jumps and hence additional stalls; see below for details of
  this ABI.
* **Data-dependent exception** support during capability stores introduces a
  stall in address translation.
  This exception is motivated by MMU support for capability tracking, used for
  heap temporal memory safety in CHERI.
  The underlying Armv8.2-A architecture targeted by the initial Neoverse N1 has
  no concept of data-dependent exceptions on stores, and that
  micro-architecture does not have a structure that supports data-dependent
  exceptions for stores in an efficient way.
  Arm's Memory Tagging Extensions (MTE) have a similar requirement and so more
  recent Arm microarchitectures are much more optimized in this regard.
* **Untuned store throughput and buffer sizes** due to memory buses not having
  been widened.
  Whereas store-pair instructions from 64-bit Armv8-A can execute in one cycle
  and occupy a single store-buffer entry, store-pair instructions for 128-bit
  capabilities execute in two cycles and occupy two store-buffer entries.
  Store throughput and the store buffer were sized based on aarch64 code
  measurements, and can become congested when storing capability pairs as a
  result of retaining that size in Morello.  
* **The MADD instruction**, which performs a multiply-and-add, is used both
  for matrix operations and to calculate array and data-structure offsets.
  In Morello, a version operating on capabilities is omitted, leading to
  code-generation inefficiency when performing some types of memory accesses
  (seen particularly in the SPECint gobmk benchmark).

More generally, when comparing performance, consideration should be made for
the differing levels of optimisation between baseline 64-bit Armv8-A
instructions in the Neoverse N1, and instructions added as part of the Morello
architecture.
As a result, there may be further microarchitectural optimizations that do not
properly apply when using CHERI-enabled code.
For example, we have not yet reviewed the full set of memory prefetchers to
make sure they behave well with pure-capability code.
We have ongoing investigations in a number of these areas (see below for
examples).
