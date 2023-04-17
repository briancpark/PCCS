CC = gcc
CFLAGS = -O0 -g -lOpenCL -std=c11 
LDFLAGS = -O0 -g -lOpenCL -std=c11

main : driver.c
	$(CC) driver.c $(LDFLAGS) $(CFLAGS) -o clcontention
	
clean :
	rm -f clcontention

# vector addition code
#gcc main.c -lOpenCL -std=c++11 -o ocl_vector_addition.o
