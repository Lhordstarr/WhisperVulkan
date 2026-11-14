# WaspaValkon — whisper.cpp with Vulkan (GPU) acceleration

A prebuilt **whisper.cpp** binary and its shared libraries, compiled with
`-DGGML_VULKAN=ON`, so transcription runs on the GPU via Vulkan instead of
the CPU.

Upstream whisper.cpp only ships **CPU** builds for Linux/Windows, so anyone
who wants GPU transcription normally has to compile from source. This repo
packages a ready-to-use Vulkan build so you don't have to.

## Contents

```
bin/
  whisper-cli          # the CLI (transcribe a file)
  whisper-server       # HTTP server mode
  libggml-vulkan.so*   # Vulkan backend
  libggml-cpu.so*      # CPU fallback backend
  libggml.so*          # ggml core
  libwhisper.so*       # whisper library
```

## Usage

```bash
# Set the library path so the binary finds its .so files, then run:
export LD_LIBRARY_PATH="$(pwd)/bin:$LD_LIBRARY_PATH"
./bin/whisper-cli -m /path/to/ggml-base.bin -f audio.wav
```

## Use with StarShip (starr_mx)

Point the app at this folder so it uses the Vulkan build instead of its
CPU-only installer:

```bash
# in your .env
WHISPER_CPP_DIR=/path/to/WaspaValkon
```

Or place this folder inside the StarShip project as `whisper.cpp/build-vulkan`
and the app auto-detects it.

## Build info

- whisper.cpp version: 1.9.5 (ggml 0.29.0)
- Backend: Vulkan (libggml-vulkan)
- Platform: Linux x86_64
- Built with: `-DGGML_VULKAN=ON`

## Publishing updates

To refresh the binaries, rebuild whisper.cpp with Vulkan enabled and copy the
`bin/` contents into this folder, then commit and push.
