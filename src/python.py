from time import time


def main():
    start = time()

    x = 1
    y = 1

    for i in range(1_000):
        x *= 10
        y += 1


    print(f"Final value of x: {x}")
    print(f"Final value of y: {y}")

    end = time()
    duration = end - start
    print(f"Execution time: {duration * 1000} ms")


main()
