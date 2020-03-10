#include "declarations.h"

void
t2(float *A, float *B) {
    for (int nl = 0; nl < 10000000; nl ++) {
      #pragma clang loop vectorize_width(5) interleave_count(2) distribute(enable)
        for (int i = 0; i < LEN2 - 4; i += 5) {
            A[i] = B[i] * A[i];
        }
        A[0] ++;
    }
}
