# Numerical Stochastic Calculus Library

Simple Library for Numerical Stochastic Calculus in C++. Based on [ETH NASODE](http://www.vvz.ethz.ch/Vorlesungsverzeichnis/lerneinheit.view?lerneinheitId=169823&semkez=2022W&ansicht=LEHRVERANSTALTUNGEN&lang=en) course

## Setting up the project

To install dependencies, run

```bash
chmod +x ./install_deps.sh
./install_deps.sh
```

To build run the following cmake command for release:

```bash
cmake -B build/main/Release/ -DCMAKE_BUILD_TYPE=RELEASE
```

Or debug:

```bash
cmake -B build/main/Debug/ -DCMAKE_BUILD_TYPE=DEBUG
```

And then run build:

```bash
cmake --build build/main/Debug/ -j8
```