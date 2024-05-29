# Initial results

Using the baseline pure-capability code generation combined with an unmodified
microarchitecture yields 30.48% geometric mean overhead for the training
workload of SPECint 2006.

Working around dependence on unpredicted PCC bounds when performing a
capability-based jump using the Benchmark ABI combined with an unmodified
microarchitecture, this is reduced to 15.17% geometric mean overhead (a 50.2%
reduction).

Applying a microarchitectural fix to the data-dependent exception issue, and
measuring using the Benchmark ABI yields a 7.72% geometric mean overhead (a
further 49.1% overhead reduction).

Increasing the size of the store queues, and measuring using the Benchmark ABI
yields a 6.28% geometric mean overhead (a futher 18.7% overhead reduction).

Using the P128 Forced GOT and P128 compilation modes gives an upper bound
estimated overhead of 3.2% and lower bound estimated overhead of 2.2%.

Performance-counter data gathered during these experiments suggests that
further non-essential architectural and microarchitectural overheads exist,
including inefficient code generation around the MADD instruction.

Assuming that the data-dependent exception issue is resolvable in at least one
of software and hardware, it is reasonable to project that the goal of 2%-3%
overhead for deterministic spatial and referential memory safety is achievable
with an optimized instruction-set architecture on a performance-optimized
microarchitecture.

![Chart: SPECint performance overheads across ABIs and hardware implementation
  variations (all measured on FPGA,
  dynamically-linked)](specint-detailed-results-dynamic.svg)

Using statically-linked code yields a similar pattern for the geometric mean
overheads across all the different ABIs and hardware configurations, albeit
each slightly lower than the dynamically-linked counterpart.

![Chart: Mean SPECint overheads for memory-safe code on Morello
  (FPGA, statically-linked)](specint-overhead-summary-static.svg)

Looking at individual benchmarks, we again see a similar picture as for
dynamically-linked code, with the overhead for baseline pure-capability code
generation being slightly lower for a couple of benchmarks that see very high
overhead without the Benchmark ABI.

![Chart: SPECint performance overheads across ABIs and hardware implementation
  variations (all measured on FPGA,
  statically-linked)](specint-detailed-results-static.svg)
