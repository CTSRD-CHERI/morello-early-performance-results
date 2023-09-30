# Software ecosystem enablement

The primary aim of the Morello Programme has been to enable creation of, and
experimentation with, a large CHERI-enabled software ecosystem.
Prior to Morello, research implementations of CHERI were entirely on FPGA
(clocking around 100MHz), or were emulated with QEMU.
While valuable in early research, these platforms could not enable "at scale"
exploration of the impact of CHERI on large software corpora such as full
operating systems, major desktop applications, or full server software stacks.
In contrast, Morello operates at 2.5GHz, has a quad-core superscalar design,
includes an on-chip GPU, supports up to 64GiB of DRAM, and provides
high-performance I/O via PCIe.

Over the past year, Morello has supported a vast increase in the size of the
CHERI software ecosystem, driven by over 70 companies, universities, and
governmental organizations, which have collectively adapted over 100MLoC of
open-source software to CHERI memory safety, according to current estimates.
This includes memory-safe FreeBSD kernel and userlevel, Linux BusyBox, Wayland
window server and KDE Plasma desktop, and approaching ten thousand open-source
software packages.
At the time of writing, there is a significant in-progress effort to adapt the
Chromium web browser and V8 JavaScript runtime to compile with [memory-safe
CHERI C/C++
languages](https://www.cl.cam.ac.uk/techreports/UCAM-CL-TR-947.pdf) [[WAT20B]](../bibliography/#WAT20B).
In addition to announced programme partners such as
Google and Microsoft, dozens of companies supported by UKRI’s Technology
Access Programme (TAP) have also adapted millions of lines of open-source and
proprietary code to the platform.

This enablement has allowed realistic experimentation with server,
workstation, industrial control, and automotive workloads running under memory
safety, and also early work on fine-grained software compartmentalisation as
research prototypes mature.
