# Running the examples

Run these commands from the repository root. The compiled examples write their
build output to the `build` directory.

## C

```sh
mkdir -p build
gcc -O2 src/c.c -o build/c
./build/c
```

## Java

```sh
mkdir -p build/java
javac -d build/java src/Java.java
java -cp build/java Java
```

## JavaScript

```sh
node src/javascript.js
```

## TypeScript

Install the TypeScript compiler globally with npm:

```sh
npm install --global typescript
```

Compile and run the example:

```sh
mkdir -p build/typescript
tsc --outDir build/typescript src/typescript.ts
node build/typescript/typescript.js
```

## Python

```sh
python3 src/python.py
```
