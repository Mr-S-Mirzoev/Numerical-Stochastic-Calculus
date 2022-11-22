#include "linalg/vector.h"
#include "linalg/matrix.h"

namespace linalg
{
Matrix::Matrix(Eigen::MatrixXd const& data): data_(data)
{
}

Matrix::Matrix(int m, int n): data_(m, n)
{
}

Eigen::MatrixXd const& Matrix::get_data() const
{
    return data_;
}

Eigen::MatrixXd& Matrix::get_data_writable()
{
    return data_;
}

Matrix Matrix::T() const
{
    Eigen::MatrixXd data_T = data_.transpose();
    return data_T;
}

// Vector& Matrix::operator()(size_t row_idx)
// {
//     return data_[row_idx];
// }

// Vector<Type> const& Matrix::operator()(size_t row_idx) const
// {
//     return data_[row_idx];
// }

double& Matrix::operator()(size_t row_idx,  size_t col_idx)
{
    return data_(row_idx, col_idx);
}

double const& Matrix::operator()(size_t row_idx,  size_t col_idx) const
{
    return data_(row_idx, col_idx);
}

std::pair<int, int> Matrix::size() const
{
    return {data_.rows(), data_.cols()};
}

Matrix ones(size_t m, size_t n)
{
    return Matrix(Eigen::MatrixXd::Identity(m, n));
}

Matrix zeros(size_t m, size_t n)
{
    return Matrix(Eigen::MatrixXd::Zero(m, n));
}

std::ostream& operator<<(std::ostream& os, const Matrix& m)
{
    os << m.data_;
    return os;
}
} // namespace linalg
