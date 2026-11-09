# Benchmarks

Run `./benchmark.sh` to print a Markdown table of elapsed times, a Mermaid
chart of minimum times, and each program's output. Redirect it to a file to
save the report:

```sh
./benchmark.sh > benchmark-results.md
```

The script requires Bash, GCC, a JDK (`javac` and `java`), Node.js, the
TypeScript compiler (`tsc`), and Python 3. It compiles C with `-O2`, Java,
and TypeScript into a temporary directory, which it removes on exit. Node.js
runs the compiled TypeScript output.

The table reports the median and minimum elapsed times from 10 runs, measured
to the nearest millisecond per run. The median is the average of the two
middle times. Measurements include process startup and output, but exclude
compilation. The report shows the output of the last run of each program.
The chart requires a Markdown viewer that supports Mermaid XY charts.

These are rough measurements: the programs do not perform
equivalent arithmetic because their numeric types handle large values
differently. In particular, the C program converts an out-of-range floating
point value to an integer, which has undefined behavior.