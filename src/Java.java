public class Java {

    public static void main(String[] args) {
        long start = System.currentTimeMillis();

        long x = 1;
        long y = 1;

        for (int i = 0; i < 1_000; i++) {
            x *= 10;
            y += 1;
        }

        System.out.println("Final value of x: " + x);
        System.out.println("Final value of y: " + y);

        long end = System.currentTimeMillis();
        long duration = end - start;
        System.out.println("Execution time: %d ms".formatted(duration));
    }
}
