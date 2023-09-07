# Initial results

Using the baseline pure-capability code generation combined with an unmodified
microarchitecture yields 28.01% geometric mean overhead for the training
workload of SPECint 2006.

Working around dependence on unpredicted PCC bounds when performing a
capability jump register using the Benchmark ABI combined with an unmodified
microarchitecture, this is reduced to 14.97% geometric mean overhead (a 46.6%
reduction).

Applying a microarchitectural fix to the data-dependent exception issue, and
measuring using the Benchmark ABI yields a 7.40% geometric mean overhead (a
further 50.1% overhead reduction).

Increasing the size of the store queues, and measuring using the Benchmark ABI
yields a 5.70% geometric mean overhead (a futher 23.0% overhead reduction).

Using the P128 Forced GOT and P128 compilation modes gives an upper bound
estimated overhead of 3.0% and lower bound estimated overhead of 1.8%.

Performance-counter data gathered during these experiments suggests that
further non-essential architectural and microarchitectural overheads exist,
including inefficient code generation around the MADD instruction.

Assuming that the data-dependent exception issue is resolvable in at least one
of software and hardware, it is reasonable to project that the goal of 2%-3%
overhead for deterministic spatial and referential memory safety is achievable
with an optimized instruction-set architecture on a performance-optimized
microarchitecture.

![Chart: SPECint performance overheads across ABIs and hardware implementation
  variations (all measured on FPGA)](specint-detailed-results.svg)
