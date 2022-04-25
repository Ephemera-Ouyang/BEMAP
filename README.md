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
BEMAP is a benchmark suite construction methodology that construct benchmark suites from real Android applications. It consists of three components: MFC, RFC, and BSC. **First**, MFC employs AutoProfiler to automatically imitate highly frequently used user operations (e.g., screen sliding) and to collect the micro-architecture dependent features (e.g., cache misses) at the same time. **Second**, RFC leverages the _two-stage_ approach to construct a small set of representative features (RepFeats) from micro-architecture dependent features collected by MFC. **Third**, BSC performs clustering analysis on 100 real applications represented by RepFeats and selects the common applications from the application groups as benchmarks.

STEP 1: Micro-architecture Dependent Features Collection (MFC)
---
First, 
STEP 2: Representative Feature Construction (RFC)
---

STEP 3: Benchmark Suite Construction (BSC)
---
