


function mainJS() {
    const start = Date.now();

    let x = 1;
    let y = 1;

    for (let i = 0; i < 1_000; i++) {
        x *= 10;
        y += 1;
    }

    console.log("Final value of x: " + x);
    console.log("Final value of y: " + y);

    const end = Date.now();
    const duration = end - start;
    console.log("Execution time: " + duration + " ms");
}


mainJS();
