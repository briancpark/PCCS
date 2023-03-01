CC = gcc
ARCH=sm_70
CFLAGS = -O3 -std=c++11
LDFLAGS =  -O3 -std=c++11

main : driver1.cu
	nvcc $(LDFLAGS) $(CFLAGS) -ccbin=$(CC) driver1.cu -arch=$(ARCH) -o gpucontention

clean :
	rm -f gpucontention


