#pragma once

namespace linalg
{
    class Matrix;
    class Vector;

    class ops
    {
    public:
        static Matrix mul(Matrix const& lhs, Matrix const& rhs);
        static Matrix mul(Matrix const& lhs, Vector const& rhs);
        static Matrix sum(Matrix const& lhs, Matrix const& rhs);
        static Matrix sub(Matrix const& lhs, Matrix const& rhs);

        static void mul(Matrix& lhs, Matrix const& rhs);
        static void mul(Matrix& lhs, Vector const& rhs);
        static void sum(Matrix& lhs, Matrix const& rhs);
        static void sub(Matrix& lhs, Matrix const& rhs);
    };
} // namespace linalg
