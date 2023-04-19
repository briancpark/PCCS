#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>
#define CL_TARGET_OPENCL_VERSION 120

#ifdef __APPLE__
#include <OpenCL/opencl.h>
#else
#include <CL/cl.h>
#endif

#define PROGRAM_FILE "kernel.cl"
#define KERNEL_FUNC  "ocl_kernel"

#define ERT_TRIALS_MIN      1
#define ERT_WORKING_SET_MIN 1
#define GBUNIT              (1024 * 1024 * 1024)

// Usage:
// make CFLAGS="-DERT_FLOP=64 -DFP32" && ./clcontention

// To observe the GPU utilization of Intel GPU:
// sudo intel_gpu_top
#define REP2(S)                                                                                    \
    S;                                                                                             \
    S
#define REP4(S)                                                                                    \
    REP2(S);                                                                                       \
    REP2(S)
#define REP8(S)                                                                                    \
    REP4(S);                                                                                       \
    REP4(S)
#define REP16(S)                                                                                   \
    REP8(S);                                                                                       \
    REP8(S)
#define REP32(S)                                                                                   \
    REP16(S);                                                                                      \
    REP16(S)
#define REP64(S)                                                                                   \
    REP32(S);                                                                                      \
    REP32(S)
#define REP128(S)                                                                                  \
    REP64(S);                                                                                      \
    REP64(S)
#define REP256(S)                                                                                  \
    REP128(S);                                                                                     \
    REP128(S)
#define REP512(S)                                                                                  \
    REP256(S);                                                                                     \
    REP256(S)

#define KERNEL1(a, b, c) ((a) = (a) * (b))
#define KERNEL2(a, b, c) ((a) = (a) * (b) + c)

#if FP64
void initialize(uint64_t nsize, double* __restrict__ A, double value)
#elif FP32
void initialize(uint64_t nsize, float* __restrict__ A, float value)
#elif FP16
void initialize(uint64_t nsize, __half* __restrict__ A, __half value)
#else
void initialize(uint64_t nsize, double* __restrict__ A, double value)
#endif
{
    uint64_t i;
    for (i = 0; i < nsize; ++i) {
        A[i] = value;
    }
}

#define MAX_SOURCE_SIZE (0x100000)

int main(void) {
    int nprocs = 1;
    int nthreads = 1;

    uint64_t TSIZE = 1 << 30;
    uint64_t PSIZE = TSIZE / nprocs;

#if FP64
    double* buf = (double*)malloc(PSIZE);
#elif FP32
    float* buf = (float*)malloc(PSIZE);
#elif FP16
    __half* buf = (__half*)malloc(PSIZE);
#else
    double* buf = (double*)malloc(PSIZE);
#endif

    printf("nsize,trials,microseconds,bytes,single_thread_bandwidth,total_bandwidth,GFLOPS,"
           "bandwidth(GB/s)\n");

    if (buf == NULL) {
        fprintf(stderr, "Out of memory!\n");
        return -1;
    }

    nthreads = 1;

    int num_gpus = 0;
    int gpu;
    int gpu_id;
    int numSMs;

    uint64_t nsize = PSIZE / nthreads;
    nsize = nsize & (~(64 - 1));
#if FP64
    nsize = nsize / sizeof(double);
#elif FP32
    nsize = nsize / sizeof(float);
#elif FP16
    nsize = nsize / sizeof(__half);
#else
    nsize = nsize / sizeof(double);
#endif
    uint64_t nid = nsize * 0;
    // initialize small chunck of buffer within each thread
    initialize(nsize, &buf[nid], 1.0);

#if FP64
    double* d_buf;
    d_buf = (double*)malloc(nsize * sizeof(double));
    memset(d_buf, 0, nsize * sizeof(double));
#elif FP32
    float* d_buf;
    d_buf = (float*)malloc(nsize * sizeof(float));
    memset(d_buf, 0, nsize * sizeof(float));
#elif FP16
    __half* d_buf;
    d_buf = (__half*)malloc(nsize * sizeof(__half));
    memset(d_buf, 0, nsize * sizeof(__half));
#else
    double* d_buf;
    d_buf = (double*)malloc(nsize * sizeof(double));
    memset(d_buf, 0, nsize * sizeof(double));
#endif

    // Load the OpenCL kernel
    FILE* fp;
    char* source_str;
    size_t source_size;

    fp = fopen(PROGRAM_FILE, "r");
    if (!fp) {
        fprintf(stderr, "Failed to load kernel.\n");
        exit(1);
    }
    source_str = (char*)malloc(MAX_SOURCE_SIZE);
    source_size = fread(source_str, 1, MAX_SOURCE_SIZE, fp);
    fclose(fp);

    // Get platform and device information
    cl_platform_id platform_id = NULL;
    cl_device_id device_id = NULL;
    cl_uint ret_num_devices;
    cl_uint ret_num_platforms;
    cl_int ret = clGetPlatformIDs(1, &platform_id, &ret_num_platforms);
    ret = clGetDeviceIDs(platform_id, CL_DEVICE_TYPE_GPU, 1, &device_id, &ret_num_devices);

    cl_int err = 0;
    cl_uint num_platforms;
    cl_platform_id platforms[16]; // Can be on stack!
    err = clGetPlatformIDs(16, platforms, &num_platforms);
    // Check err and num_platforms
    if (err != CL_SUCCESS) {
        printf("Error: Failed to find an OpenCL platform!\n");
        printf("Test failed\n");
        return EXIT_FAILURE;
    }
    // print the number of platforms and the platform names
    printf("Number of platforms: %d\n", num_platforms);
    for (size_t i = 0; i < num_platforms; i++) {
        char buffer[10240];
        printf("Platform %lu: ", i);
        err = clGetPlatformInfo(platforms[i], CL_PLATFORM_NAME, 10240, buffer, NULL);
        // Check err
        printf("%s\n", buffer);
    }

    // set the device_id to Intel GPU
    for (size_t i = 0; i < num_platforms; i++) {
        char buffer[10240];
        err = clGetPlatformInfo(platforms[i], CL_PLATFORM_NAME, 10240, buffer, NULL);
        // Check err
        if (strstr(buffer, "Intel(R) OpenCL HD Graphics")) {
            printf("Using the backend: %s\n", buffer);
            platform_id = platforms[i];
            err = clGetDeviceIDs(platform_id, CL_DEVICE_TYPE_GPU, 1, &device_id, &ret_num_devices);
            break;
        }
    }

    // Create an OpenCL context
    cl_context context = clCreateContext(NULL, 1, &device_id, NULL, NULL, &ret);

    // Create a command queue
    cl_command_queue command_queue = clCreateCommandQueue(context, device_id, 0, &ret);

    cl_mem buf_mem_obj =
        clCreateBuffer(context, CL_MEM_READ_WRITE, nsize * sizeof(double), NULL, &ret);
    if (ret != CL_SUCCESS) {
        printf("Error: Failed to allocate device memory!\n");
        printf("Test failed\n");
        return EXIT_FAILURE;
    }

    cl_program program = clCreateProgramWithSource(context, 1, (const char**)&source_str,
                                                   (const size_t*)&source_size, &ret);
    if (ret != CL_SUCCESS) {
        printf("Error: Failed to create compute program!\n");
        printf("Test failed\n");
        return EXIT_FAILURE;
    }
    char build_args[80];
#ifdef FP16
#define PRECISION "FP16"
#elif FP32
#define PRECISION "FP32"
#else
#define PRECISION "FP64"
#endif
    sprintf(build_args, "-D%s -DERT_FLOP=%d", PRECISION, ERT_FLOP);
    ret = clBuildProgram(program, 1, &device_id, build_args, NULL, NULL);
    if (ret != CL_SUCCESS) {
        printf("Error: Failed to build program executable!\n");
        printf("Test failed\n");
        return EXIT_FAILURE;
    }
    // Create the OpenCL kernel
    cl_kernel kernel = clCreateKernel(program, KERNEL_FUNC, &ret);
    if (ret != CL_SUCCESS) {
        printf("Error: Failed to create compute kernel!\n");
        printf("Test failed\n");
        return EXIT_FAILURE;
    }

    uint64_t n, nNew;
    uint64_t t;
    int bytes_per_elem;
    int mem_accesses_per_elem;

    n = 1 << 22;
    while (n <= nsize) { // working set - nsize
        uint64_t ntrials = nsize / n;
        if (ntrials < 1)
            ntrials = 1;
        // 600 original
        for (t = 1; t <= 600; t = t + 1) { // working set - ntrials

            // Set the arguments of the kernel
            ret = clSetKernelArg(kernel, 0, sizeof(uint64_t), (void*)&nsize);
            if (ret != CL_SUCCESS) {
                printf("Error: Failed to set kernel arg 0!\n");
                printf("Test failed\n");
                return EXIT_FAILURE;
            }
            ret = clSetKernelArg(kernel, 1, sizeof(uint64_t), (void*)&ntrials);
            if (ret != CL_SUCCESS) {
                printf("Error: Failed to set kernel arg 1!\n");
                printf("Test failed\n");
                return EXIT_FAILURE;
            }
            ret = clSetKernelArg(kernel, 2, sizeof(cl_mem), (void*)&buf_mem_obj);
            if (ret != CL_SUCCESS) {
                printf("Error: Failed to set kernel arg 2!\n");
                printf("Test failed\n");
                return EXIT_FAILURE;
            }
            // ret = clSetKernelArg(kernel, 3, sizeof(int), (void*)&bytes_per_elem);
            // if (ret != CL_SUCCESS) {
            //     printf("Error: Failed to set kernel arg 3!\n");
            //     printf("Test failed\n");
            //     return EXIT_FAILURE;
            // }
            // ret = clSetKernelArg(kernel, 4, sizeof(int), (void*)&mem_accesses_per_elem);
            // if (ret != CL_SUCCESS) {
            //     printf("Error: Failed to set kernel arg 4!\n");
            //     printf("Test failed\n");
            //     return EXIT_FAILURE;
            // }

            size_t global_item_size = nsize; // Process the entire lists
            size_t local_item_size = 64;     // Process in groups of 64

            struct timeval start, end;
            gettimeofday(&start, NULL);
            // run the kernel
            ret = clEnqueueNDRangeKernel(command_queue, kernel, 1, NULL, &global_item_size,
                                         &local_item_size, 0, NULL, NULL);

            // read buffer
            // ret = clEnqueueReadBuffer(command_queue, buf_mem_obj, CL_TRUE, 0,
            //                           nsize * sizeof(double), buf, 0, NULL, NULL);

            ret = clFinish(command_queue);

            gettimeofday(&end, NULL);
            double startTime = start.tv_sec + start.tv_usec / 1000000.0;
            double endTime = end.tv_sec + end.tv_usec / 1000000.0;
            double seconds = (double)(endTime - startTime);
            uint64_t working_set_size = n * nthreads * nprocs;
            uint64_t total_bytes = t * working_set_size * bytes_per_elem * mem_accesses_per_elem;
            uint64_t total_flops = t * working_set_size * ERT_FLOP;
            printf("%lu,%lu,%.3lf,%lu,%lu,%.3lf,%.3lf\n", working_set_size * bytes_per_elem, t,
                   seconds * 1000000, total_bytes, total_flops, total_flops / seconds / 1e9,
                   total_bytes * 1.0 / seconds / 1024 / 1024 / 1024);
        }
    }
    ret = clFlush(command_queue);
    ret = clReleaseKernel(kernel);
    ret = clReleaseProgram(program);
    ret = clReleaseMemObject(buf_mem_obj);
    ret = clReleaseCommandQueue(command_queue);
    ret = clReleaseContext(context);
    free(source_str);
    free(buf);
    return 0;
}