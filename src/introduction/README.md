# Introduction

Arm’s Morello[^1] is a first-generation, CHERI-enabled prototype CPU based on
Arm’s Neoverse N1, as found in the N1SDP evaluation board.
CHERI[^2] is an architectural feature that promises to dramatically improve
software security through fine-grained memory protection and scalable
compartmentalization.
Supported by UKRI, Morello is a research platform to evaluate CHERI at an
industrial scale through composition with a rich, contemporary,
high-performance microarchitecture and full software stack at a scale
unobtainable via ISA emulators or hardware simulators.

Because of a 12-month project timeline, we opted to develop Morello as an
extension to the existing Neoverse N1 design.
This choice allowed us to work with an extremely mature and rich existing
production microarchitecture, and complete the work on a short timescale, but
had the downside of preventing certain design choices that might have been
accessible in a from-scratch design intended to support CHERI.
Despite this, Morello has allowed us to gain the first rich understanding of
the impact of CHERI on not just hardware, but also complete software
ecosystems.
It has already enabled experimentation with the protection model in
full-system designs ranging from server, desktop, and mobile software to
automotive, aerospace, and industrial control systems.

Morello development has continued following tapeout, allowing us to take
performance results and analysis from the shipped hardware platform and
explore microarchitectural variations not available on the original project
timeline.
This report therefore presents not just early experimental results for the
Morello microarchitecture as shipped, but also results from multiple Morello
processor variations that benefit from experience gained from 12 months of
real-world use of over 100 million lines of code (MLoC) of CHERI-enabled
software.
All results are taken from FPGA implementations based on the same RTL
implementing shipped hardware.
The report also provides guidance on performance analysis for others working
on the platform.

This report is a versioned living document, which will be updated (with change
notes) as our on-going work with Morello proceeds.
If you are performing performance experiments on the Morello platform and
would like to reach out to us for discussion of experimental design, or
guidance on interpreting results, please do not hesitate to contact us.

[^1]: [The Arm Morello Evaluation Platform—Validating CHERI-Based Security in
  a High-Performance System](https://ieeexplore.ieee.org/document/10123148)
  [[GRI23]](../bibliography/#GRI23).

[^2]: [An Introduction to
  CHERI](https://www.cl.cam.ac.uk/techreports/UCAM-CL-TR-941.pdf)
  [[WAT19]](../bibliography/#WAT19).
