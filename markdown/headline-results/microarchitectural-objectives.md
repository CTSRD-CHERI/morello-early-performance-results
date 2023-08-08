# Microarchitectural objectives

A further central experimental goal of the Morello Programme has been to
establish the viability of CHERI-enabled microarchitecture when composed with
contemporary high-performance processor design.
The Morello SOC has 4 processor cores based on the Neoverse N1 processor, a
Mali G76 GPU, and a modified memory controller.
The modified N1 cores maintain the features in the Armv8.2 Neoverse N1 while
adding the 129-bit CHERI capability protection model.
Morello is backwards compatible with Armv8-A architecture systems in AArch64
(AArch32 support was disabled for simplicity).

The resulting design, despite being a first-generation prototype developed on
an accelerated timescale, achieved both frequency and microarchitectural
objectives, clocking at 2.5GHz and having a <6% area overhead in the core
clusters (CPU, L1, L2, and L3) as compared to the baseline Armv8.2-A-only
design (AArch32 support enabled).
Important microarchitectural concerns included the potential effects of
capability compression, bounds checking, and DDC/PCC control of memory
accesses on the critical path for the cores themselves.
All timing objectives for these paths were achieved.
