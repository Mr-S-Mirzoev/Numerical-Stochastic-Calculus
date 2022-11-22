#pragma once

namespace linalg
{
    class Matrix;

    class algorithms
    {
    public:
        static Matrix cholesky(Matrix const& m);
    };
} // namespace linalg
