#include "linalg/ops.h"
#include "linalg/matrix.h"
#include "linalg/vector.h"

#include <cmath>

namespace linalg
{
Matrix ops::mul(Matrix const& lhs, Matrix const& rhs)
{
    return Matrix{lhs.get_data() * rhs.get_data()};
}

Matrix ops::mul(Matrix const& lhs, Vector const& rhs)
{
    return Matrix{lhs.get_data() * rhs.get_data()};
}

Vector ops::cmul(Vector const& lhs, Vector const& rhs)
{
    return Vector{lhs.get_data().cwiseProduct(rhs.get_data())};
}

Matrix ops::sum(Matrix const& lhs, Matrix const& rhs)
{
    return Matrix{lhs.get_data() + rhs.get_data()};
}

Matrix ops::sum(Matrix const& lhs, Vector const& rhs)
{
    return Matrix{lhs.get_data() + rhs.get_data()};
}

Matrix ops::sum(Vector const& rhs, Matrix const& lhs)
{
    return Matrix{lhs.get_data() + rhs.get_data()};
}

Vector ops::sum(Vector const& lhs, Vector const& rhs)
{
    return Vector{lhs.get_data() + rhs.get_data()};
}

Matrix ops::sub(Matrix const& lhs, Matrix const& rhs)
{
    return Matrix{lhs.get_data() - rhs.get_data()};
}

Matrix ops::sub(Matrix const& lhs, Vector const& rhs)
{
    return Matrix{lhs.get_data() - rhs.get_data()};
}

Matrix ops::sub(Vector const& lhs, Matrix const& rhs)
{
    return Matrix{lhs.get_data() - rhs.get_data()};
}

Vector ops::sub(Vector const& lhs, Vector const& rhs)
{
    return Vector{lhs.get_data() - rhs.get_data()};
}

Vector ops::div(Vector const& v, double scalar)
{
    return Vector{v.get_data() * (1. / scalar)};
}

Matrix ops::div(Matrix const& m, double scalar)
{
    return Matrix{m.get_data() * (1. / scalar)};
}

Vector ops::scale(Vector const& v, double scalar)
{
    return Vector{v.get_data() * scalar};
}

Matrix ops::scale(Matrix const& m, double scalar)
{
    return Matrix{m.get_data() * scalar};
}

Vector ops::floor(Vector const& v)
{
    return Vector{v.get_data().unaryExpr([](double x) { return ::floor(x); })};
}

Vector ops::ceil(Vector const& v)
{
    return Vector{v.get_data().unaryExpr([](double x) { return ::ceil(x); })};
}

Vector ops::sqrt(Vector const& v)
{
    return Vector{v.get_data().cwiseSqrt()};
}

void ops::mul(Matrix& lhs, Matrix const& rhs)
{
    lhs.get_data_writable() *= rhs.get_data();
}

void ops::mul(Matrix& lhs, Vector const& rhs)
{
    lhs.get_data_writable() *= rhs.get_data();
}

void ops::sum(Matrix& lhs, Matrix const& rhs)
{
    lhs.get_data_writable() += rhs.get_data();
}

void ops::sum(Matrix& lhs, Vector const& rhs)
{
    lhs.get_data_writable() += rhs.get_data();
}

void ops::sum(Vector& lhs, Matrix const& rhs)
{
    lhs.get_data_writable() += rhs.get_data();
}

void ops::sub(Matrix& lhs, Matrix const& rhs)
{
    lhs.get_data_writable() -= rhs.get_data();
}

void ops::sub(Matrix& lhs, Vector const& rhs)
{
    lhs.get_data_writable() -= rhs.get_data();
}

void ops::sub(Vector& lhs, Matrix const& rhs)
{
    lhs.get_data_writable() -= rhs.get_data();
}

void ops::assign_to_row(Matrix& lhs, std::size_t row_idx, Vector const& rhs)
{
    lhs.get_data_writable().row(row_idx) = rhs.get_data();
}

void ops::assign_to_col(Matrix& lhs, std::size_t col_idx, Vector const& rhs)
{
    lhs.get_data_writable().col(col_idx) = rhs.get_data();
}
} // namespace linalg
