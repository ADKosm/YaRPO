#include <stdio.h>
#include <xmmintrin.h>

//float asm_doc(float *A, float *B);

float build_dot(float *A, float *B) {
    __m128 a_part;
    __m128 b_part;

    __m128 part_sum;
    __m128 prod;
    part_sum = _mm_xor_ps(part_sum, part_sum);

    size_t i;

    for(i = 0; i < 2; ++i) {
        a_part = _mm_loadu_ps(A + i*4);
        b_part = _mm_loadu_ps(B + i*4);
        prod = _mm_mul_ps(a_part, b_part);
        part_sum = _mm_add_ps(part_sum, prod);
    }
    float partial_res[4];
    _mm_storeu_ps(partial_res, part_sum);
    float result = partial_res[0] + partial_res[1] + partial_res[2] + partial_res[3];
    return result;
}

float c_dot(float *A, float *B) {
    size_t i;
    float result = 0.0f;
    for(i = 0; i < 8; i++) {
        result += A[i] * B[i];
    }
    return result;
}

int main(int argc, char *argv[])
{
    float A[] = {1, 2, 3, 4, 5, 6, 7, 8};
    float B[] = {9, 10, 11, 12, 13, 15, 16};

    printf("C: %f\n", c_dot(A, B));
    printf("ASM: %f\n", build_dot(A, B));

    __asm__()

    return 0;
}
