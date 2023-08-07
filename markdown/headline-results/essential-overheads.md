# Essential overheads

A key question in the CHERI research since inception has been what the
essential performance overheads are &mdash; i.e., those that are innate to the
CHERI protection model &mdash; as opposed to the design choices of a specific
prototype or commercial implementation.

Morello has allowed us to answer this question with reasonable confidence:
the widening of pointers in capability-centric code generation models is the
key overhead, rather than other architectural impacts (for example)
substantially harming code density or limiting instruction concurrency.
Other than the register file, Morello structures (e.g., buses) were generally
not widened, yet generally performed well without substantial re-tuning.
One known exception to this was in branch prediction, where the lack of
prediction of the bounds of PC has performance impact on some workloads, which
can be addressed in a future mature implementation.
As described later in this report, a Benchmark ABI allows us to utilize more
mature integer-address (non-CHERI) branch prediction to explore how a better
optimized implementation would enable greater performance, while retaining
CHERI’s essential pointer-size overheads.
We continue to explore other potential overheads arising from opportunities to
better tune the Morello architecture to CHERI’s requirements, including the
sizing of store queues.

Morello has also allowed us to develop new performance methodology clearly
differentiating effects arising from design choices of this specific
implementation from those essential costs, although limitations on software
maturity (e.g., unoptimized ABI and compiler toolchain &mdash; for example,
being unable to optimize certain global accesses that could occur directly via
PCC rather than via the GOT) also limit accuracy on our projections.
These are explored in greater detail in the remainder of this report.
