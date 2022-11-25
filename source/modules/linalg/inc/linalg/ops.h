#pragma once

#include <cstddef>

namespace linalg
{
    class Matrix;
    class Vector;

    class ops
    {
    public:
        static Matrix mul(Matrix const& lhs, Matrix const& rhs);
        static Matrix mul(Matrix const& lhs, Vector const& rhs);

        static Vector cmul(Vector const& lhs, Vector const& rhs);

        static Matrix sum(Matrix const& lhs, Matrix const& rhs);
        static Matrix sum(Matrix const& lhs, Vector const& rhs);
        static Matrix sum(Vector const& rhs, Matrix const& lhs);
        static Vector sum(Vector const& lhs, Vector const& rhs);

        static Matrix sub(Matrix const& lhs, Matrix const& rhs);
        static Matrix sub(Matrix const& lhs, Vector const& rhs);
        static Matrix sub(Vector const& lhs, Matrix const& rhs);
        static Vector sub(Vector const& lhs, Vector const& rhs);

        static Vector div(Vector const& v, double scalar);
        static Matrix div(Matrix const& m, double scalar);

        static Vector scale(Vector const& v, double scalar);
        static Matrix scale(Matrix const& m, double scalar);

        static Vector floor(Vector const& v);
        static Vector ceil(Vector const& v);
        static Vector sqrt(Vector const& v);

        static void mul(Matrix& lhs, Matrix const& rhs);
        static void mul(Matrix& lhs, Vector const& rhs);

        static void sum(Matrix& lhs, Matrix const& rhs);
        static void sum(Matrix& lhs, Vector const& rhs);
        static void sum(Vector& lhs, Matrix const& rhs);

        static void sub(Matrix& lhs, Matrix const& rhs);
        static void sub(Matrix& lhs, Vector const& rhs);
        static void sub(Vector& lhs, Matrix const& rhs);

        static void assign_to_row(Matrix& lhs, std::size_t row_idx, Vector const& rhs);
        static void assign_to_col(Matrix& lhs, std::size_t col_idx, Vector const& rhs);
    };
} // namespace linalg
