# SPECint 2006 benchmark suite

SPECint 2006 is an industry-standard benchmark suite consisting of a series of
individual benchmarks representing integer-centric workloads such as code
compilation, data compression, protein sequence analysis, and XML processing.
Most SPECint benchmarks compile with CHERI memory safety, and run on Morello,
without modification.
The benchmark suite supports various data sets (test, training, and
reference), and we make use of the training configuration due to implementing
Morello on FPGA, which due to a roughly 10MHz clock takes approximately a week
to complete.
Due to reproducibility requirements on published SPECint results, we omit
SPECint results requiring source-code modifications from this study.
Results from the following benchmarks are included:

| Benchmark     | Description                     | Status                  |
|---------------|---------------------------------|-------------------------|
| 401.bzip2     | Data compression                | Compiled as CHERI C/C++ |
| 445.gobmk     | Game of Go with AI participants | Compiled as CHERI C/C++ |
| 456.hmmer     | Protein sequence analysis       | Compiled as CHERI C/C++ |
| 464.h264ref   | Video compression               | Compiled as CHERI C/C++ |
| 471.omnetpp   | Discrete event simulation       | Compiled as CHERI C/C++ |
| 473.astar     | Path-finding algorithms         | Compiled as CHERI C/C++ |
| 483.xalancbmk | XML document translation        | Compiled as CHERI C/C++ |

The following benchmarks were not used either due to complex but incomplete
adaptations to CHERI C/C++ preventing them from running (e.g., due to having
only adapted more recent versions of gcc and perl), due to requiring
unofficial patches that prevent us from distributing results, or due to known
but as-yet unresolved compiler issues affecting comparability:

| Benchmark      | Description                     | Status                  |
|----------------|---------------------------------|-------------------------|
| 400.perlbench  | Various Perl language workloads | Old version of perl not adapted to CHERI C/C++ |
| 403.gcc        | C compiler workload             | Old version of gcc not adapted to CHERI C/C++ |
| 429.mcf        | Vehicle scheduling              | CHERI C/C++ adaptations fixing undefined behavior relating to realloc() are unofficial, and further changes to mitigate additional CHERI-induced padding due to pointer alignment mean that results are less comparable to stock SPECint 2006. |
| 462.libquantum | Quantum computer simulation     | P128 benchmark runs 30% faster than the aarch64 version since 128-bit integer pointers inhibit vectorization in a case where vectorization turns out to be harmful on the N1SDP microarchitecture. |

All benchmark binaries are compiled at -O3, and are statically linked.
