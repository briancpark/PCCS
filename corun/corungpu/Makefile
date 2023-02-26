CC = gcc
ARCH=sm_35
CFLAGS = -O3 -std=c++11
LDFLAGS =  -O3 -std=c++11

main : driver1.cu
	nvcc $(LDFLAGS) $(CFLAGS) -ccbin=$(CC) driver1.cu -arch=$(ARCH) -o main 

clean :
	rm -f main


