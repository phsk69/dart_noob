#!/usr/bin/env sh
set -xe
dart format . && \
dart compile exe bin/aoc2015.dart -o aoc2015 --target-os macos && \
for i in {1..21}; do ./aoc2015 -m d${i} -i data/aoc2015_day${i}_input.txt; done