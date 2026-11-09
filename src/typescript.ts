


function mainTS(): void {
    const start: number = Date.now();

    let x: number = 1;
    let y: number = 1;

    for (let i = 0; i < 1_000; i++) {
        x *= 10;
        y += 1;
    }

    console.log(`Final value of x: ${x}`);
    console.log(`Final value of y: ${y}`);

    const end: number = Date.now();
    const duration: number = end - start;
    console.log("Execution time: " + duration + " ms");
}


mainTS();
