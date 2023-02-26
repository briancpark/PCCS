#include <cuda_runtime.h>
#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

// helper functions and utilities to work with CUDA
#define ERT_TRIALS_MIN      1
#define ERT_WORKING_SET_MIN 1
#define GBUNIT              (1024 * 1024 * 1024)

// Usage:
// make clean && make CFLAGS="-DERT_FLOP=64 -DFP32" && ./main

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

#define KERNEL2(a, b, c) ((a) = (a) * (b) + (c))
#define KERNEL1(a, b, c) ((a) = (b) + (c))

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

#if FP64
void gpuKernel(uint64_t nsize, uint64_t ntrials, double* __restrict__ array, int* bytes_per_elem,
               int* mem_accesses_per_elem);
#elif FP32
void gpuKernel(uint64_t nsize, uint64_t ntrials, float* __restrict__ array, int* bytes_per_elem,
               int* mem_accesses_per_elem);
#elif FP16
void gpuKernel(uint64_t nsize, uint64_t ntrials, __half* __restrict__ array, int* bytes_per_elem,
               int* mem_accesses_per_elem);
#else
void gpuKernel(uint64_t nsize, uint64_t ntrials, double* __restrict__ array, int* bytes_per_elem,
               int* mem_accesses_per_elem);
#endif

#if FP64
__global__ void block_stride(uint64_t ntrials, uint64_t nsize, double* A)
#elif FP32
__global__ void block_stride(uint64_t ntrials, uint64_t nsize, float* A)
#elif FP16
__global__ void block_stride(uint64_t ntrials, uint64_t nsize, __half* A)
#else
__global__ void block_stride(uint64_t ntrials, uint64_t nsize, double* A)
#endif
{
    uint64_t total_thr = gridDim.x * blockDim.x;
    uint64_t elem_per_thr = (nsize + (total_thr - 1)) / total_thr;
    uint64_t blockOffset = blockIdx.x * blockDim.x;

    uint64_t start_idx = blockOffset + threadIdx.x;
    uint64_t end_idx = start_idx + elem_per_thr * total_thr;
    uint64_t stride_idx = total_thr;

    if (start_idx > nsize) {
        start_idx = nsize;
    }

    if (end_idx > nsize) {
        end_idx = nsize;
    }

#if FP64
    double alpha = 0.5;
#elif FP32
    float alpha = 0.5;
#elif FP16
    __half alpha = 0.5;
#else
    double alpha = 0.5;
#endif

    uint64_t i, j;
    for (j = 0; j < ntrials; ++j) {
        for (i = start_idx; i < end_idx; i += stride_idx) {
#if FP64
            double beta = 0.8;
#elif FP32
            float beta = 0.8;
#elif FP16
            __half beta = 0.8;
#else
            double beta = 0.8;
#endif

#if ((ERT_FLOP & 1) == 1) /* add 1 flop */
            KERNEL1(beta, A[i], alpha);
#endif
#if ((ERT_FLOP & 2) == 2) /* add 2 flops */
            KERNEL2(beta, A[i], alpha);
#endif
#if ((ERT_FLOP & 4) == 4) /* add 4 flops */
            REP2(KERNEL2(beta, A[i], alpha));
#endif
#if ((ERT_FLOP & 8) == 8) /* add 8 flops */
            REP4(KERNEL2(beta, A[i], alpha));
#endif
#if ((ERT_FLOP & 16) == 16) /* add 16 flops */
            REP8(KERNEL2(beta, A[i], alpha));
#endif
#if ((ERT_FLOP & 32) == 32) /* add 32 flops */
            REP16(KERNEL2(beta, A[i], alpha));
#endif
#if ((ERT_FLOP & 64) == 64) /* add 64 flops */
            REP32(KERNEL2(beta, A[i], alpha));
#endif
#if ((ERT_FLOP & 128) == 128) /* add 128 flops */
            REP64(KERNEL2(beta, A[i], alpha));
#endif
#if ((ERT_FLOP & 256) == 256) /* add 256 flops */
            REP128(KERNEL2(beta, A[i], alpha));
#endif
#if ((ERT_FLOP & 512) == 512) /* add 512 flops */
            REP256(KERNEL2(beta, A[i], alpha));
#endif
#if ((ERT_FLOP & 1024) == 1024) /* add 1024 flops */
            REP512(KERNEL2(beta, A[i], alpha));
#endif

            A[i] = beta;
        }
        alpha = alpha * (1 - 1e-8);
    }
}
int gpu_blocks = 512;
int gpu_threads = 512;

#if FP64
void gpuKernel(uint64_t nsize, uint64_t ntrials, double* __restrict__ A, int* bytes_per_elem,
               int* mem_accesses_per_elem)
#elif FP32
void gpuKernel(uint64_t nsize, uint64_t ntrials, float* __restrict__ A, int* bytes_per_elem,
               int* mem_accesses_per_elem)
#elif FP16
void gpuKernel(uint64_t nsize, uint64_t ntrials, __half* __restrict__ A, int* bytes_per_elem,
               int* mem_accesses_per_elem)
#else
void gpuKernel(uint64_t nsize, uint64_t ntrials, double* __restrict__ A, int* bytes_per_elem,
               int* mem_accesses_per_elem)
#endif
{
    *bytes_per_elem = sizeof(*A);
    *mem_accesses_per_elem = 2;
    // gpu_blocks = (nsize+1023)/1024;
    block_stride<<<gpu_blocks, gpu_threads>>>(ntrials, nsize, A);
}

double getTime() {
    double time;
    struct timeval tm;
    gettimeofday(&tm, NULL);
    time = tm.tv_sec + (tm.tv_usec / 1000000.0);
    return time;
}

int main(int argc, char* argv[]) {

    int rank = 0;
    int nprocs = 1;
    int nthreads = 1;
    int id = 0;

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

    {
        id = 0;
        nthreads = 1;

        int num_gpus = 0;
        int gpu;
        int gpu_id;
        int numSMs;

        cudaGetDeviceCount(&num_gpus);
        if (num_gpus < 1) {
            fprintf(stderr, "No CUDA device detected.\n");
            return -1;
        }

        for (gpu = 0; gpu < num_gpus; gpu++) {
            cudaDeviceProp dprop;
            cudaGetDeviceProperties(&dprop, gpu);
            /* printf("%d: %s\n",gpu,dprop.name); */
        }

        cudaSetDevice(id % num_gpus);
        cudaGetDevice(&gpu_id);
        cudaDeviceGetAttribute(&numSMs, cudaDevAttrMultiProcessorCount, gpu_id);

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
        uint64_t nid = nsize * id;

        // initialize small chunck of buffer within each thread
        initialize(nsize, &buf[nid], 1.0);

#if FP64
        double* d_buf;
        cudaMalloc((void**)&d_buf, nsize * sizeof(double));
        cudaMemset(d_buf, 0, nsize * sizeof(double));
#elif FP32
        float* d_buf;
        cudaMalloc((void**)&d_buf, nsize * sizeof(float));
        cudaMemset(d_buf, 0, nsize * sizeof(float));
#elif FP16
        __half* d_buf;
        cudaMalloc((void**)&d_buf, nsize * sizeof(__half));
        cudaMemset(d_buf, 0, nsize * sizeof(__half));
#else
        double* d_buf;
        cudaMalloc((void**)&d_buf, nsize * sizeof(double));
        cudaMemset(d_buf, 0, nsize * sizeof(double));
#endif

        cudaDeviceSynchronize();

        double startTime, endTime;
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
#if FP64
                cudaMemcpy(d_buf, &buf[nid], n * sizeof(double), cudaMemcpyHostToDevice);
#elif FP32
                cudaMemcpy(d_buf, &buf[nid], n * sizeof(float), cudaMemcpyHostToDevice);
#elif FP16
                cudaMemcpy(d_buf, &buf[nid], n * sizeof(__half), cudaMemcpyHostToDevice);
#else
                cudaMemcpy(d_buf, &buf[nid], n * sizeof(double), cudaMemcpyHostToDevice);
#endif

                cudaDeviceSynchronize();

                if ((id == 0) && (rank == 0)) {
                    startTime = getTime();
                }

                gpuKernel(n, t, d_buf, &bytes_per_elem, &mem_accesses_per_elem);
                cudaDeviceSynchronize();

                if ((id == 0) && (rank == 0)) {
                    endTime = getTime();
                    double seconds = (double)(endTime - startTime);
                    uint64_t working_set_size = n * nthreads * nprocs;
                    uint64_t total_bytes =
                        t * working_set_size * bytes_per_elem * mem_accesses_per_elem;
                    uint64_t total_flops = t * working_set_size * ERT_FLOP;
                    // printf("thread: %d\n", nthreads);
                    // nsize; trials; microseconds; bytes; single thread bandwidth; total bandwidth
                    printf("%lu,%lu,%.3lf,%lu,%lu,%.3lf,%.3lf\n", working_set_size * bytes_per_elem,
                           t, seconds * 1000000, total_bytes, total_flops,
                           total_flops / seconds / 1e9,
                           total_bytes * 1.0 / seconds / 1024 / 1024 / 1024);
                } // print

#if FP64
                cudaMemcpy(&buf[nid], d_buf, n * sizeof(double), cudaMemcpyDeviceToHost);
#elif FP32
                cudaMemcpy(&buf[nid], d_buf, n * sizeof(float), cudaMemcpyDeviceToHost);
#elif FP16
                cudaMemcpy(&buf[nid], d_buf, n * sizeof(__half), cudaMemcpyDeviceToHost);
#else
                cudaMemcpy(&buf[nid], d_buf, n * sizeof(double), cudaMemcpyDeviceToHost);
#endif
                cudaDeviceSynchronize();
            } // working set - ntrials

            nNew = 1.1 * n;
            if (nNew == n) {
                nNew = n + 1;
            }

            n = nNew;
            // no break brfore
            break;
        } // working set - nsize

        cudaFree(d_buf);

        if (cudaGetLastError() != cudaSuccess) {
            printf("Last cuda error: %s\n", cudaGetErrorString(cudaGetLastError()));
        }

        cudaDeviceReset();
    } // parallel region

    free(buf);

    printf("\n");
    printf("META_DATA\n");
    printf("FLOPS          %d\n", ERT_FLOP);

    printf("GPU_BLOCKS     %d\n", gpu_blocks);
    printf("GPU_THREADS    %d\n", gpu_threads);

    return 0;
}
