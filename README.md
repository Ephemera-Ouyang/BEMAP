The file format of csv is inconvenient to read, please refer to the same name file of jpg format.
---
BEMAP
=====
A Benchmark Suite Construction Methodology for Android Smart Phone Processor CPUs.
---

* Conetents:
  1. Overview
  2. microarchitecture Dependent Features Collection (MFC)
  3. Representative Feature Construction (RFC)
  4. Benchmark Suite Construction (BSC)
  5. SPBench
***

OVERVIEW
---
BEMAP is a benchmark suite construction methodology that constructs benchmark suites from real Android applications. It consists of three components: MFC, RFC, and BSC. **First**, MFC employs _AutoProfiler_ to automatically imitate interactive operations (e.g., screen sliding) for 100 Android applications and to collect the microarchitecture dependent features (e.g., cache misses) at the same time. **Second**, RFC leverages the _two-stage_ approach to construct a small set of representative features (_RepFeats_) from microarchitecture dependent features collected by MFC. **Third**, BSC performs clustering analysis on 100 real applications represented by _RepFeats_ and selects applications from the application groups as benchmarks. SPBench is a benchmark suite constructed by BEMAP.

Microarchitecture Dependent Features Collection (MFC)
---
Step 1: Installation for Ubuntu 16.04 LTS on a personal computer (PC) and make sure the following tool requirements are satisfied.
```Bash
# Update the packages.
$ sudo apt-get update

# Update Android Debug Bridge(ABD).
$ sudo apt-get install android-tools-adb

# Check ADB.
$ adb version

# Check Python.
$ python --version

```

Step 2: Root the smart phone and connect it to the personal computer with USB cable.

Step 3: Download BEMAP. https://anonymous.4open.science/r/BEMAP/

Step 4: Put SimplePerf into smart phone with ADB.
```Bash
$ cd BEMAP/MFC/Autoprofiler
$ adb push simpleperf /data/local/tmp/./
```

Step 5: Collect Microarchitecture Dependent Features with Autoprofiler.
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
Step 8: Identify important microarchitecture dependent features in terms of IPC.
```Bash
$ cd ../../RFC
$ python train_csv_sgbrt.py
```

Step 9: Representative features (RepFeats) construction.
```Bash
$ python ICADimensionReduction.py
$ python PCAandICACompressOriginal.py
```

Benchmark Suite Construction (BSC)
---
Step 10: Using K-means to cluster applications presented by Repfeats and select benchmarks
```Bash
$ cd ../BSC
$ python ICA_Kmeans.py
```

SPBench
---
Here are [Android application packages(APKs)](https://drive.google.com/drive/folders/1W1Y0coZDmBmbTkgHi4RrsbEj_Z2oWxN4?usp=sharing) of benchmarks in SPBench.
---
To use SPBench, follow these steps:

### 1. Download and Install APKs
- Access the provided [Google Drive link](https://drive.google.com/drive/folders/1W1Y0coZDmBmbTkgHi4RrsbEj_Z2oWxN4?usp=sharing) to download the benchmark APKs.
- Transfer the APK files and Autoprofiler to your Android device and install them by following steps 1 to 4.

### 2. Run Benchmarks
- Installing each benchmark application on your Android device using ADB.
```bash
   for apk in *.apk; do adb install "$apk"; done
- running SPBench
```Bash
# Identify your smart phone (e.g., mate30).
$ cd mate30
$ bash auto_all_SPBench.sh
``` 
- Note: users can modify the simulation files to adapt the scenarios to their needs. They can run these benchmarks for as long as they want by adjusting the time parameters of the profile in the `IPC4_cycle.sh` script.
