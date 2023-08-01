# Architectural integration

A key aim for the Morello Programme was to establish an integration of the
CHERI protection model with the baseline Armv8.2-A architecture that was
sympathetic to the instruction-set philosophy and its goals.
This aim was met through a set of adaptations to the CHERI approach including
a deemphasis of architectural exceptions during register-to-register
operations, the introduction of a “capability mode” that enables capability
addressing for existing load and store instructions to conserve opcode space,
and integrating CHERI with other contemporary architectural features such as
hypervisor extensions that had not been present in earlier MIPS-based CHERI
prototypes.

These architectural extensions are described in detail in Arm’s Morello
architecture specification[^1], with SRI International and the University of
Cambridge’s CHERI ISAv8[^2] providing more detailed rationale for aspects of
the design and its implications for microarchitecture.
Machine-checked formal proof ensures that the CHERI-extended Morello ISA
specification preserves key security properties for any possible code
sequence[^3]. Results to date give us strong confidence that CHERI support can
be tightly and cleanly integrated into future Arm architectures.

[^1]: Arm Limited. [Arm Architecture Reference Manual Supplement - Morello
  for A-profile
  Architecture](https://developer.arm.com/documentation/ddi0606/latest).

[^2]: Watson, et al. [Capability Hardware Enhanced RISC Instructions: CHERI
  Instruction-Set Architecture (Version
  8)](https://www.cl.cam.ac.uk/techreports/UCAM-CL-TR-951.pdf).

[^3]: Bauereiss et al., [Verified Security for the Morello Capability-enhanced
  Prototype Arm
  Architecture](http://www.cl.cam.ac.uk/~pes20/morello-proofs-esop2022.pdf),
  ESOP 2022
