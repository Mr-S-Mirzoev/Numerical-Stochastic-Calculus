#include "linalg/vector.h"

namespace linalg
{
Vector::Vector(int n): data_(n)
{
}

Vector::Vector(Eigen::VectorXd const& data): data_(data)
{
}

Eigen::VectorXd const& Vector::get_data() const
{
    return data_;
}

Eigen::VectorXd& Vector::get_data_writable()
{
    return data_;
}

double Vector::mean() const
{
    return data_.mean();
}

double& Vector::operator()(size_t idx)
{
    return data_[idx];
}

double const& Vector::operator()(size_t idx) const
{
    return data_[idx];
}

int Vector::size() const
{
    return data_.size();
}

Vector ones(size_t n)
{
    return Vector(Eigen::MatrixXd::Identity(n, 1));
}

Vector zeros(size_t n)
{
    return Vector(Eigen::MatrixXd::Zero(n, 1));
}

std::ostream& operator<<(std::ostream& os, const Vector& v)
{
    os << v.data_;
    return os;
}
} // namespace linalg
