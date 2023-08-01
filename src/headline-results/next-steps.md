## Next steps

At the time of writing, we are continuing several projects to better
understand and optimize Morello performance to converge, as much as possible,
with essential CHERI performance:

* Further tuning the Morello microarchitecture on FPGA, including tuning store
  queues that were tuned for the pre-CHERI N1SDP design.
  This problem has been highlighted in memory-store-intensive benchmarks that
  see greater congestion with rapid sequential capability-width stores.
  This issue in particular is believed to reduce the throughput of load- and
  store-pair capability instructions frequently used in stack push and pop
  operations.
* Continuing to improve code generation around specific architectural gaps or
  inconsistencies relative to the baseline aarch64 &mdash; for example, around
  the use of the MADD instruction, for which improved code generation
  substantially affects the performance of the SPECint 2006 gobmk benchmark.
* Continuing to improve application binary interface (ABI) definitions to
  enable improved code generation, especially around global variable access.
* Enabling further compiler optimization passes as performance and protection
  tradeoffs are better understood, and longer-term engineering efforts come to
  fruition (e.g., around efficient access to global variables, which are
  always indirected via the GOT in pure-capability code, but some of which can
  be accessed safely via PCC).
* Improving our models of optimized P128 code generation to better mirror
  tradeoffs in CHERI-enabled calling conventions and data layouts, allowing us
  to refine our estimated future microarchitecture results.
* Taking advantage of now rich workloads and better optimized toolchain to
  continue to explore the impacts of ISA design choices and their impacts on
  ABIs and code generation, and their effects on performance.

The data extracted from these understandings point to further possible
enhancements to a Capability Extension to the Arm architecture (and other
ISAs) that could be deployed commercially.

In the remainder of this report, we explore the performance methodology
employed in this work in greater detail, both to explain our results and also
enable others to apply it.
Further details on the next steps above may be found at the end of the report
in the Future Directions section.
