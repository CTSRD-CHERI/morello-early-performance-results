# Caveats

We have presented early evaluation of the performance properties of the taped
out Morello prototype and modified Morello designs running on FPGA.
As a first-generation microarchitecture implementing CHERI support developed
against the existing Neoverse N1 microarchitecture, direct analysis of the
performance to predict future CHERI performance is challenging.
Immaturity of the ABIs and compiler toolchain also limits direct prediction of
performance for future mature microarchitectures.
Our analysis is aimed at identifying, characterizing, and addressing those
limitations incrementally through improvements to both Morello hardware and
its software stack.

Some care is required in comparing results across both modified hardware and
modified ABIs.
This FPGA implementation has generally strong performance fidelity, in that it
is built from the same RTL used in the shipped process, and offers
cycle-accurate implementation within core clusters and across the L1 and L2
caches.
It also models DRAM performance proportionately scaled to the FPGA design.
However, there are some areas with important differences from the fabricated
SoC &mdash; for example, relative timings of components (e.g., core clusters
vs system busses) is modestly different to accommodate a design spanning
multiple FPGAs.
Our experience in day-to-day use of Morello on both FPGA and fabricated ASIC
is that SPECint performance is extremely consistent due to identical memory
subsystem configurations.
The FPGA platform also provides a reasonable estimate of the effects of
microarchitecture modifications relative to the FPGA baseline without the
change &mdash; for example, relating to data-dependent exception modifications
we have described.
With respect to the “Benchmark ABI” and P128 implementation, these are early
software prototypes that have seen only limited use, and for which we continue
to improve fidelity as the work proceeds.

The SPECint benchmark is an important industry-accepted tool for measuring
performance, which we have configured in the "train" rather than "ref"
configuration for FPGA performance reasons.
However, it reflects a quite narrow workload &mdash; and one with a
significantly reduced memory footprint; when running "ref" on the actual SoC,
we see reduced overheads from CHERI due to the essential memory overheads
becoming more prominent.
We will seek to widen the set of benchmarks we use, as work proceeds, with
particular interest in application-layer benchmarks such as those targeting
JavaScript runtimes.
