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
  5. SPBench
***

OVERVIEW
---
BEMAP is a benchmark suite construction methodology that constructs benchmark suites from real Android applications. It consists of three components: MFC, RFC, and BSC. **First**, MFC employs _AutoProfiler_ to automatically imitate interactive operations (e.g., screen sliding) for 100 Android applications and to collect the micro-architecture dependent features (e.g., cache misses) at the same time. **Second**, RFC leverages the _two-stage_ approach to construct a small set of representative features (_RepFeats_) from micro-architecture dependent features collected by MFC. **Third**, BSC performs clustering analysis on 100 real applications represented by _RepFeats_ and selects the common applications from the application groups as benchmarks. SPBench is a benchmark suite constructed by BEMAP.

Micro-architecture Dependent Features Collection (MFC)
---
Step 1: Installation for Ubuntu 16.04 LTS on a personal computer (PC) and make sure the following tool requirements are satisfied.
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

Step 5: Collect Micro-architecture Dependent Features with Autoprofiler.
```Bash
# Identify your smart phone (e.g., mate30).
$ cd mate30
$ bash auto_all.sh
```

Step 6: Extract original features data from txt file into CSV file.
```Bash
$ cd ../../Original Data Processing
$ python extract.py
```

Step 7: Preprocess the data with data_division.ipynb

Representative Feature Construction (RFC)
---
Step 8: Identify important micro-architecture dependent features in terms of IPC.
```Bash
$ cd ../../RFC
$ python train_csv_sgbrt.py
```

Step 9: Representative features (RepFeats) construction.
```Bash
$ python ICADimensionReduction.py
```

Benchmark Suite Construction (BSC)
---
Step 10: Using K-means to clustering applications presented by Repfeats and select benchmarks
```Bash
$ cd ../BSC
$ python ICA_Kmeans.py
```

SPBench
---
Here are [Android application packages(APKs)]() of benchmarks in SPBench.
