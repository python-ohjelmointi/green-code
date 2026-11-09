#!/usr/bin/env bash
set -euo pipefail

for tool in gcc javac java node tsc python3; do
    if ! command -v "$tool" >/dev/null 2>&1; then
        printf 'Error: required command not found: %s\n' "$tool" >&2
        exit 1
    fi
done

root_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
src_dir="$root_dir/src"
temp_dir=$(mktemp -d)
trap 'rm -rf -- "$temp_dir"' EXIT

gcc -O2 "$src_dir/c.c" -o "$temp_dir/c"
javac -d "$temp_dir" "$src_dir/Java.java"
tsc --outDir "$temp_dir" "$src_dir/typescript.ts"

names=(C Java JavaScript TypeScript Python)
medians=()
minimums=()
max_minimum_ms=1
export LC_NUMERIC=C
TIMEFORMAT='%3R'

run_benchmark() {
    local name=$1
    shift
    local run elapsed seconds milliseconds value i median_half_ms
    local -a samples=()

    for ((run = 1; run <= 10; run++)); do
        if ! { time "$@" >"$temp_dir/$name.output" 2>&1; } 2>"$temp_dir/$name.time"; then
            printf 'Error: %s benchmark failed on run %d:\n' "$name" "$run" >&2
            cat "$temp_dir/$name.output" >&2
            return 1
        fi
        elapsed=$(<"$temp_dir/$name.time")
        seconds=${elapsed%.*}
        milliseconds=${elapsed#*.}
        value=$((10#$seconds * 1000 + 10#$milliseconds))
        i=${#samples[@]}
        while ((i > 0 && samples[i - 1] > value)); do
            samples[i]=${samples[i - 1]}
            i=$((i - 1))
        done
        samples[i]=$value
    done
    printf -v elapsed '%d.%03d' "$((samples[0] / 1000))" "$((samples[0] % 1000))"
    minimums+=("$elapsed")
    if ((samples[0] > max_minimum_ms)); then
        max_minimum_ms=${samples[0]}
    fi
    median_half_ms=$((samples[4] + samples[5]))
    printf -v elapsed '%d.%04d' "$((median_half_ms / 2000))" "$((median_half_ms % 2000 * 5))"
    medians+=("$elapsed")
}

run_benchmark C "$temp_dir/c"
run_benchmark Java java -cp "$temp_dir" Java
run_benchmark JavaScript node "$src_dir/javascript.js"
run_benchmark TypeScript node "$temp_dir/typescript.js"
run_benchmark Python python3 "$src_dir/python.py"

printf '| Language | Median elapsed time (seconds) | Minimum elapsed time (seconds) |\n'
printf '| --- | ---: | ---: |\n'
for i in "${!names[@]}"; do
    printf '| %s | %s | %s |\n' "${names[$i]}" "${medians[$i]}" "${minimums[$i]}"
done

printf '\n```mermaid\nxychart-beta\n'
printf '    title "Minimum execution time"\n'
printf '    x-axis ['
separator=''
for name in "${names[@]}"; do
    printf '%s"%s"' "$separator" "$name"
    separator=', '
done
printf ']\n'
printf '    y-axis "Seconds" 0 --> %d.%03d\n' "$((max_minimum_ms / 1000))" "$((max_minimum_ms % 1000))"
printf '    bar ['
separator=''
for minimum in "${minimums[@]}"; do
    printf '%s%s' "$separator" "$minimum"
    separator=', '
done
printf ']\n```\n'

for name in "${names[@]}"; do
    printf '\n### %s output (last run)\n\n' "$name"
    sed 's/^/    /' "$temp_dir/$name.output"
done
