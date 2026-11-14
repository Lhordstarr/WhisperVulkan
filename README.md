# WhisperVulkan — whisper.cpp with Vulkan (GPU) acceleration

A prebuilt **whisper.cpp** (whisper 1.9.5) compiled with `-DGGML_VULKAN=ON`,
so transcription runs on the GPU via Vulkan instead of the CPU.

Upstream whisper.cpp only ships **CPU** builds for Linux/Windows, so anyone
who wants GPU transcription normally has to compile from source. This repo
packages a ready-to-use Vulkan build so you don't have to.

## How to use it after cloning

```bash
# 1. Clone
git clone https://github.com/<your-username>/WhisperVulkan.git
cd WhisperVulkan

# 2. Make the binary runnable (libraries live next to it)
chmod +x bin/whisper-cli setup.sh

# 3a. Run directly with the helper (sets LD_LIBRARY_PATH for you):
./setup.sh -m /path/to/ggml-base.bin -f audio.wav

# 3b. Or run the binary yourself:
export LD_LIBRARY_PATH="$(pwd)/bin:$LD_LIBRARY_PATH"
./bin/whisper-cli -m /path/to/ggml-base.bin -f audio.wav
```

`setup.sh` forwards all arguments to `whisper-cli`, so any whisper.cpp flag works:
```bash
./setup.sh -m model.bin -f audio.wav -l en -oj   # JSON output, English
```

## Contents

```
bin/
  whisper-cli          # transcribe a file
  whisper-server       # HTTP server mode
  libggml-vulkan.so*   # Vulkan GPU backend
  libggml-cpu.so*      # CPU fallback backend
  libggml.so*          # ggml core
  libwhisper.so*       # whisper library
setup.sh               # sets LD_LIBRARY_PATH and runs whisper-cli
```

## Use with StarShip (starr_mx)

Point the app at this folder so it uses the Vulkan build instead of its
CPU-only installer:

```bash
# in StarShip's .env
WHISPER_CPP_DIR=/path/to/WhisperVulkan
```

Or place this folder inside the StarShip project as `whisper.cpp/build-vulkan`
and the app auto-detects it.

## Requirements

- Linux x86_64
- A Vulkan-capable GPU + Vulkan drivers (`vulkaninfo` should list your device)
- A whisper.cpp model file (`ggml-*.bin`), e.g. from Hugging Face

## Build info

- whisper.cpp version: 1.9.5 (ggml 0.29.0)
- Backend: Vulkan (libggml-vulkan), CPU fallback included
- Platform: Linux x86_64
- Built with: `-DGGML_VULKAN=ON`

## Updating the binaries

Rebuild whisper.cpp with Vulkan enabled, then copy the `bin/` contents into
this folder, commit, and push:
```bash
cp -a /path/to/whisper.cpp/build-vulkan/bin/. ./bin/
git commit -am "Update Vulkan build" && git push
```
