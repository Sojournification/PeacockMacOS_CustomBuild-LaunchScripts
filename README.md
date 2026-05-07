# Peacock macOS Scripts 🍎

Two shell scripts that replace the "open four terminals and pray" setup for running [Peacock](https://github.com/thepeacockproject/Peacock) on macOS Apple Silicon.

Requires a legitimate Steam copy of Hitman WOA. Pirated copies won't work and neither will the App Store version.

---

## Prerequisites

- Apple Silicon Mac
- [Homebrew](https://brew.sh/)
- Node 20 via [nvm](https://github.com/nvm-sh/nvm)
- CMake via `brew install cmake`
- Peacock cloned, these scripts dropped into its root folder

---

## build.sh

Run once before using `start.sh`, and again after any Peacock update.

```
./build.sh
```

Installs Node dependencies and compiles the macOS patcher binary into `patcher-darwin/build/`.

---

## start.sh

```
./start.sh
```

Before running, launch Hitman WOA from Steam and wait at the main menu.

Uses `pfctl` to forward port 80 to 8080 so the server doesn't need root. Starts the Peacock server, waits for it, then runs the patcher. Cleans everything up when you quit.

---

Not affiliated with IO Interactive or the Peacock Project.
