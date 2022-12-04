#pragma once

namespace linalg
{
    class Matrix;

    class algorithms
    {
    public:
        /**
         * Standard Cholesky decomposition (LL^T) of a matrix and associated features
         * This function performs a LL^T Cholesky decomposition of a symmetric, positive definite
         * matrix A such that A = LL^* = U^*U, where L is lower triangular.
         *
         * Remember that Cholesky decompositions are not rank-revealing. This LLT decomposition is only stable on positive definite matrices,
         * use LDLT instead for the semidefinite case. Also, do not use a Cholesky decomposition to determine whether a system of equations
         * has a solution.
         *
         * \b Performance: for best performance, it is recommended to use a column-major storage format
         * with the Lower triangular part (the default), or, equivalently, a row-major storage format
         * with the Upper triangular part. Otherwise, you might get a 20% slowdown for the full factorization
         * step, and rank-updates can be up to 3 times slower.
         */
        static Matrix cholesky(Matrix const& m);
    };
} // namespace linalg
