The file format of csv is inconvenient to read, please refer to the same name file of jpg format.
---
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
Step 1: Installation for Ubuntu 16.04 LTS on personal computer (PC) and make sure the following tool requirements are statisfied.
```Bash
# Update the packages.
$ sudo apt-get update

# Update Android Debug Bridge(ABD).
$ sudo apt-get install android-tools-adb

# Check ADB.
$ adb version

# Check Python
$ python --version

```

Step 2: Root the smart phone and connect it to the personal computer with USB cable.

Step 3: Download BEMAP. https://anonymous.4open.science/r/BEMAP/

Step 4: Put SimplePerf into smart phone with ADB.
```Bash
$ cd BEMAP/MFC/Autoprofiler
$ adb push simpleperf /data/local/tmp/./
```

Step 5: Collection Micro-architecture Dependent Features with Autoprofiler.
```
# Identify your smart phone (e.g., mate30).
$ cd mate30
$ bash auto_all.sh
```

Representative Feature Construction (RFC)
---


Benchmark Suite Construction (BSC)
---
