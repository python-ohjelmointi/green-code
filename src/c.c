#include <stdio.h>
#include <time.h>

int main(void) {
	clock_t start = clock();

	int x = 1;
	int y = 1;

	for (int i = 0; i < 1000; i++) {
		x *= 10.0;
		y += 1;
	}

	printf("Final value of x: %d\n", x);
	printf("Final value of y: %d\n", y);

	clock_t end = clock();
	double duration = ((double)(end - start) * 1000.0) / CLOCKS_PER_SEC;
	printf("Execution time: %.3f ms\n", duration);

	return 0;
}
