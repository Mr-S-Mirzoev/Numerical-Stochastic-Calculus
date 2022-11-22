#include "linalg/ops.h"
#include "linalg/matrix.h"
#include "linalg/vector.h"

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
} // namespace linalg
