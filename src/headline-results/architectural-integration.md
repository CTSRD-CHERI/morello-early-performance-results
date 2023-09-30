# Architectural integration

A key aim for the Morello Programme was to establish an integration of the
CHERI protection model with the baseline Armv8.2-A architecture that was
sympathetic to the instruction-set philosophy and its goals.
This aim was met through a set of adaptations to the CHERI approach including
a deemphasis of architectural exceptions during register-to-register
operations, the introduction of a “capability mode” that enables capability
addressing for existing load and store instructions to conserve opcode space,
and integrating CHERI with other contemporary architectural features such as
hypervisor extensions that were not present in earlier MIPS-based CHERI
prototypes.

These architectural extensions are described in detail in [Arm’s Morello
architecture
specification](https://developer.arm.com/documentation/ddi0606/latest)
[[ARM22]](../bibliography/#ARM22), with SRI International and the University
of Cambridge’s [CHERI
ISAv8](https://www.cl.cam.ac.uk/techreports/UCAM-CL-TR-951.pdf)
[[WAT20A]](../bibliography/#WAT20A) providing more detailed rationale for
aspects of the design and its implications for microarchitecture.
[Machine-checked formal
proof](http://www.cl.cam.ac.uk/~pes20/morello-proofs-esop2022.pdf)
[[BAU22]](../bibliography/#BAU22) ensures that the CHERI-extended Morello ISA
specification preserves key security properties for any possible code
sequence. Results to date give us strong confidence that CHERI support can
be tightly and cleanly integrated into future Arm architectures.
