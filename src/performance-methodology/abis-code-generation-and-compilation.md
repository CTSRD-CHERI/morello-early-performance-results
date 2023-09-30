# ABIs, code generation, and compilation

We now describe, in greater detail, the different compilation and
code-generation targets used in our measurements beyond the standard hybrid
aarch64 and pure-capability aarch64c targets.

## Benchmark ABI

As described above, the Morello branch-predictor was not expanded to predict
bounds.
As a result, a capability-based jump will stall later PCC-dependent
instructions until bounds are established.
This is particularly problematic across dynamically linked calls (and returns)
between libraries, which will change bounds to those covering the called (or
returned-to) library.
However, this effect is not limited to dynamic linking, as it also affects
jump-register instructions returning from statically linked code, as well as
C++ code that makes use of virtual methods.
These effects are masked for longer functions, and in particular those that do
not use the GOT early in their implementation, but this effect can be a
substantial tax on dynamic performance when capability protections are applied
to control flow.

To work around this behavior, we have developed a *Benchmark ABI*, which uses
global bounds for the program counter capability (PCC) and any return
capabilities throughout execution.
All other in-memory and in-register code capability values retain narrowed
bounds (e.g., those set up by the run-time linker), but code generation uses
integer rather than capability jumps, retaining global bounds in PCC
regardless of control flow.
In effect, this ABI substantially reduces control-flow protections and
encapsulation in return for more effective branch-prediction on the Morello
microarchitecture, which is likely to be representative of more mature future
microarchitectures.
To the greatest extent possible, we do not modify any other aspects of code
generation, and no in-memory data structures are changed &mdash; in
particular, function pointers, PLT GOT entries, and return addresses all
remain capability width, and are loaded, stored, and passed around as such,
despite being used as integers in branch instructions, retaining the in-memory
footprint essential to analyzing pure-capability performance overheads.

Using the Benchmark ABI requires a mildly patched kernel and recompilation of
code to use the new branching behavior.
To support dynamically linked code, the Benchmark ABI also requires minor
changes to the run-time linker.
We intend to provide this feature in the next release of CheriBSD for
third-party use in performance measurement.
It is important to note that the Benchmark ABI should not be used for security
analysis and experimentation, as its protections are intentionally reduced to
facilitate performance analysis and modeling.

A commercially deployed microarchitecture supporting CHERI architectural
extensions would introduce micro-architectural enhancements to address the
performance limitations; therefore the Benchmark ABI is a temporary measure to
facilitate comparisons using the Morello prototype.

## P128 and P128 Forced-GOT compilation

The intention of these code-generation modes is to enable performance
measurements for the essential overheads of pure-capability code, under the
assumption that pointer-size growth is the primary essential overhead to
CHERI.
In this C/C++ variant and code-generation mode, pointers and `[u]intptr_t` are
widened to 128 bits, the same size as a capability, but only the integer
portion is used by generated code.
This allows P128 code to exercise the more mature aarch64 microarchitecture
while tracking essential memory-growth overhead.

P128 code adopts the default aarch64 policy allowing access to global
variables via PC-derived pointers, a strictly more liberal policy than used in
the pure-capability compilation model, which may require access via the GOT in
order to provide bounds for the global variable.
P128 Forced GOT instead forces all global-variable accesses to be indirected
via the Global Offset Table (GOT), a strictly more conservative policy that
the pure-capability compilation model, as pure-capability code may (in the
future) avoid use of the GOT where pointers will not be taken to globals.

Even more so than the Benchmark ABI, it is important not to use this
compilation mode for security analysis and experimentation, since it makes no
additional use of CHERI capabilities compared with hybrid aarch64 code.
And, similarly, support for P128 currently consists of patches not intended to
be supported outside of the Cambridge/Arm research environment; we are working
to improve the quality of this implementation to make it suitable for
third-party use.
