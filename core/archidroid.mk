#     _             _     _ ____            _     _
#    / \   _ __ ___| |__ (_)  _ \ _ __ ___ (_) __| |
#   / _ \ | '__/ __| '_ \| | | | | '__/ _ \| |/ _` |
#  / ___ \| | | (__| | | | | |_| | | | (_) | | (_| |
# /_/   \_\_|  \___|_| |_|_|____/|_|  \___/|_|\__,_|
#
# Copyright 2015 Łukasz "JustArchi" Domeradzki
# Contact: JustArchi@JustArchi.net
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# GCC

# General optimization level of target ARM compiled with GCC. Default: -O2
ARCHIDROID_GCC_CFLAGS_ARM := -O3

# General optimization level of target THUMB compiled with GCC. Default: -Os
ARCHIDROID_GCC_CFLAGS_THUMB := -O3

# Additional flags passed to all C targets compiled with GCC
ARCHIDROID_GCC_CFLAGS := -Wno-error=array-bounds -Wno-error=clobbered -Wno-error=maybe-uninitialized -Wno-error=strict-overflow

# If your arm-linux-androideabi includes support for graphite optimization flags (CLooG), enable additional flags
# You should set -ftree-parallelize-loops=N flag to number of the number of your threads (cores) of your CPU
ARCHIDROID_GCC_CFLAGS += -fgraphite-identity -floop-block -floop-interchange -floop-nest-optimize -floop-strip-mine -floop-parallelize-all -ftree-parallelize-loops=4

# Flags passed to all C++ targets compiled with GCC
ARCHIDROID_GCC_CPPFLAGS := -O3 $(ARCHIDROID_CFLAGS)

# Flags passed to linker (ld) of all C and C++ targets compiled with GCC
ARCHIDROID_GCC_LDFLAGS := -Wl,-O3 -Wl,--relax -Wl,--sort-common


# CLANG

# Flags passed to all C targets compiled with CLANG
ARCHIDROID_CLANG_CFLAGS := -O3 -Qunused-arguments -Wno-unknown-warning-option

# Flags passed to all C++ targets compiled with CLANG
ARCHIDROID_CLANG_CPPFLAGS := $(ARCHIDROID_CLANG_CFLAGS)

# Flags passed to linker (ld) of all C and C++ targets compiled with CLANG
ARCHIDROID_CLANG_LDFLAGS := -Wl,-O3 -Wl,--relax -Wl,--sort-common

# Flags that are used by GCC, but are unknown to CLANG. If you get "argument unused during compilation" error, add the flag here
ARCHIDROID_CLANG_UNKNOWN_FLAGS := \
  -mvectorize-with-neon-double \
  -mvectorize-with-neon-quad \
  -fgcse-after-reload \
  -fgcse-las \
  -fgcse-sm \
  -fgraphite-identity \
  -fipa-pta \
  -floop-block \
  -floop-interchange \
  -floop-nest-optimize \
  -floop-parallelize-all \
  -ftree-parallelize-loops=2 \
  -ftree-parallelize-loops=4 \
  -ftree-parallelize-loops=8 \
  -ftree-parallelize-loops=16 \
  -floop-strip-mine \
  -fmodulo-sched \
  -fmodulo-sched-allow-regmoves \
  -frerun-cse-after-loop \
  -frename-registers \
  -fsection-anchors \
  -ftree-loop-im \
  -ftree-loop-ivcanon \
  -funsafe-loop-optimizations \
  -fweb


# General

# Most of the flags are increasing code size of the output binaries, especially O3 instead of Os for target THUMB
# This may become problematic for small blocks, especially for boot or recovery blocks (ramdisks)
# If you don't care about the size of recovery.img, e.g. you have no use of it, and you want to silence the
# error "image too large" for recovery.img, use this definition
#
# NOTICE: It's better to use device-based flag TARGET_NO_RECOVERY instead, but some devices may have
# boot + recovery combo (e.g. Sony Xperias), and we must build recovery for them, so we can't set TARGET_NO_RECOVERY globally
# Therefore, this seems like a safe approach (will only ignore check on recovery.img, without doing anything else)
# However, if you use compiled recovery.img for your device, please disable this flag (comment or set to false), and lower
# optimization levels instead
ARCHIDROID_IGNORE_RECOVERY_SIZE := true
