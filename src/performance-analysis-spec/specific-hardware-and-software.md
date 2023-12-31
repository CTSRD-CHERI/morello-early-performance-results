# Specific hardware and software configurations

The following software and hardware configurations were used in these
benchmarks.
Some hardware configurations employ one or both of microarchitectural changes
to eliminate a data-dependent exception issue or adjust store-queue depths, as
noted above.

## Hybrid (aarch64) baseline ABI

This configuration is the baseline for overhead calculations.
It reflects the performance of legacy aarch64 (64-bit) code on Morello.
Each ABI below is compared against this configuration run on the corresponding
Morello design.

## Purecap ABI (w/o data-dependency fix) (w/o larger store queue)

This configuration presents worst-case performance for the shipping Morello
design, as it contains no improvements to the microarchitecture relative to
the taped-out implementation, and also no software adaptations for limitations
to the microarchitectural implementation.
In this mode, capabilities are used for all pointers, implied (e.g., program
counter, stack pointer, GOT entries, etc.) and explicit (e.g., language-level
pointers to structures and arrays).
Further, all global accesses are via the GOT, to ensure every global is
accessed through a dedicated capability carrying variable-specific permissions
and bounds.
This configuration is known to trigger the PCC branch-prediction issue during
calls into short functions and function returns.
Jump tables are implemented as integer jumps and so do not suffer from this
issue, but would if they used capability-relative jumps.

## Benchmark ABI (w/o data-dependency fix) (w/o larger store queue)

This configuration is based on the purecap configuration, but with a shift to
the "Benchmark ABI", which modifies default bounds on code pointers to be
global.
The benchmark ABI shifts code generation to use integer jump instructions,
avoiding triggering of stalls stemming from PCC-relative accesses depending on
new PCC bounds as described in [Morello microarchitectural
limitations](../performance-methodology/morello-microarchitectural-limitations.md).
This workaround should especially recover non-essential overhead associated
with calls into short functions.

## Benchmark ABI (w/ data-dependency fix) (w/o larger store queue)

This configuration is based on the Benchmark ABI configuration, only run with
a modified microarchitecture that addresses the data-dependent exception issue
described in [Morello microarchitectural
limitations](../performance-methodology/morello-microarchitectural-limitations.md).
The data-dependency fix avoids undesirable (and likely unnecessary in more
recent baseline microarchitectures) stalls on capability stores.

## Benchmark ABI (w/ data-dependency fix) (w/ larger store queue)

This configuration is based on the Benchmark ABI configuration, run with a
further modified microarchitecture that also expands the store queue size to
address the queue pressure issue described in [Morello microarchitectural
limitations](../performance-methodology/morello-microarchitectural-limitations.md),
on top of addressing the data-dependent exception issue.

## P128 Forced GOT (w/ data-dependency fix) (w/ larger store queue)

This configuration is based on the P128 compilation mode, which widens
language-level pointers to capability width (128 bits) to emulate the
essential overhead of pointer-size growth without exercising capability
portions of the microarchitecture, which are less mature than 64-bit portions.
This compilation mode is known not to experience problems with MADD code
generation, for example.
It also does not encounter problems with PCC branch prediction.
In this mode, all global accesses other than constant pools are via a GOT, and
PC-relative access to globals is not used, forcing indirection that
corresponds to purecap global access.

We treat this configuration as the **upper bound** for estimated performance
overhead of an optimized CHERI implementation against the Morello baseline
(Neoverse N1) microarchitecture with elimination of the data-dependent
exception issue and alleviating the store queue pressure issue.
The data-dependence microarchitectural change should not, however, affect this
workload.
There are important limitations to the current fidelity of this work.
With respect to the stack, storage for language-level pointers is widened, but
only 64-bit values are loaded and stored.
For implied register saves and restores, storage is not widened.
GOT entries, including those used for the PLT, remain 64 bit.

## P128 (w/ data-dependency fix) (w/ larger store queue)

This configuration is identical to the P128 Forced GOT configuration except
that access to globals is sometimes performed via PC, bypassing GOT entries
in configurations where aarch64 would offer the same choice
&mdash; e.g., when performing read-only accesses to globals within the current
shared object.
If this optimization were used with pure-capability code, it could lead to
inadequate bounds enforcement for read-only global variables whose pointers
are taken, or when the compiler cannot prove that dynamically chosen indices
to global arrays remain in bounds.
We treat this configuration as the **lower bound** for estimated performance
overhead of an optimized CHERI implementation against the Morello baseline
(Neoverse N1) microarchitecture with elimination of the data-dependent
exception issue; as above, the microarchitectural change should not affect
this workload.
