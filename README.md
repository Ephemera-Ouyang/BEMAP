BEMAP
=====
A Benchmark Suite Construction Methodology for Android Smart Phone Processors.
---

* Conetents:
  1. Overview
  2. Micro-architecture Dependent Features Collection (MFC)
  3. Representative Feature Construction (RFC)
  4. Benchmark Suite Construction (BSC)
***

OVERVIEW
---
BEMAP is a benchmark suite construction methodology that construct benchmark suites from real Android applications. It consists of three components: MFC, RFC, and BSC. **First**, MFC employs _AutoProfiler_ to automatically imitate interactive operations (e.g., screen sliding) for 100 Android applications and to collect the micro-architecture dependent features (e.g., cache misses) at the same time. **Second**, RFC leverages the _two-stage_ approach to construct a small set of representative features (_RepFeats_) from micro-architecture dependent features collected by MFC. **Third**, BSC performs clustering analysis on 100 real applications represented by _RepFeats_ and selects the common applications from the application groups as benchmarks.

Micro-architecture Dependent Features Collection (MFC)
---
Step 1: Installation for Ubuntu 16.04 LTS on personal computer (PC) and installation for Android Debug Bridge(ADB) on PC.
```Bash
# Update the packages.
$ sudo apt-get update

# Update Android Debug Bridge(ABD).
$ sudo apt-get install android-tools-adb

# Check ADB.
$ adb version
```

Step 2: Root the smart phone and connect it to the personal computer with USB cable.

Step 3: Put SimplePerf into smart phone with ADB.

Representative Feature Construction (RFC)
---


Benchmark Suite Construction (BSC)
---
