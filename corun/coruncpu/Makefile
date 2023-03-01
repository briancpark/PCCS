CC = gcc
CFLAGS = -fopenmp -O3 -funsafe-math-optimizations -ffast-math -flto -march=armv8-a+crypto -mcpu=cortex-a57+crypto
LDFLAGS = -fopenmp -O3 -funsafe-math-optimizations -ffast-math -flto -march=armv8-a+crypto -mcpu=cortex-a57+crypto
main : driver1.c
	$(CC) $(LDFLAGS) $(CFLAGS) driver1.c -o cpucontention

clean :
	rm -f cpucontention
