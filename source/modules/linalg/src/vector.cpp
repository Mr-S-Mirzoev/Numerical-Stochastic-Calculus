#include "linalg/vector.h"
#include "linalg/spline.h"

#include <vector>

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

std::vector<double> Vector::as_std_vector() const
{
    std::vector<double> copy(size());
    Eigen::VectorXd::Map(&copy[0], size()) = data_;

    return copy;
}

Vector Vector::cumsum(bool start_with_zero) const
{
    std::size_t end = size();
    std::size_t begin = start_with_zero ? 1 : 0;

    // TODO: check that sz is not 0;
    Vector out(begin + end);
    for (auto i = begin; i < end; ++i)
        out(i) += data_(i - begin);

    return out;
}

Vector ones(size_t n)
{
    return Vector(Eigen::MatrixXd::Identity(n, 1));
}

Vector zeros(size_t n)
{
    return Vector(Eigen::MatrixXd::Zero(n, 1));
}

Vector range(double begin, double end, std::size_t size)
{
    return Vector{Eigen::VectorXd::LinSpaced(size, begin, end)};
}

Vector interp(Vector const& xvals, Vector const& yvals, Vector const& x)
{
    numeric::SplineFunction s(xvals, yvals);
    return s(x);
}

double interp(Vector const& xvals, Vector const& yvals, double x)
{
    numeric::SplineFunction s(xvals, yvals);
    return s(x);
}

std::ostream& operator<<(std::ostream& os, const Vector& v)
{
    os << v.data_;
    return os;
}
} // namespace linalg
