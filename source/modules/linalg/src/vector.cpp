#include "linalg/matrix.h"
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

Matrix Vector::as_mat() const
{
    return Matrix{get_data()};
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

#define V_ASSIGNMENT_OPERATOR_IMPL(op, rhs_type)    \
Vector& Vector::operator op(rhs_type const& rhs)    \
{                                                   \
    get_data_writable() op rhs.get_data();          \
    return *this;                                   \
}

#define V_OPERATOR_IMPL(op, rhs_type)                    \
Vector Vector::operator op(rhs_type const& rhs) const    \
{                                                        \
    Vector copy{*this};                                  \
    return (copy op##= rhs);                             \
}

V_ASSIGNMENT_OPERATOR_IMPL(+=, Vector);
V_ASSIGNMENT_OPERATOR_IMPL(-=, Vector);

V_OPERATOR_IMPL(+, Vector);
V_OPERATOR_IMPL(-, Vector);

Vector& Vector::operator*=(double const& scalar)
{
    get_data_writable() *= scalar;
    return *this;
}

Vector& Vector::operator/=(double const& scalar)
{
    return *this *= 1. / scalar;
}

Vector Vector::operator*(double const& scalar) const
{
    Vector copy {*this};
    return copy *= scalar;
}

Vector Vector::operator/(double const& scalar) const
{
    Vector copy {*this};
    return copy /= scalar;
}

namespace vector_utils
{
Vector cmul(Vector const& lhs, Vector const& rhs)
{
    return Vector{lhs.get_data().cwiseProduct(rhs.get_data())};
}

Vector floor(Vector const& v)
{
    return Vector{v.get_data().unaryExpr([](double x) { return ::floor(x); })};
}

Vector ceil(Vector const& v)
{
    return Vector{v.get_data().unaryExpr([](double x) { return ::ceil(x); })};
}

Vector sqrt(Vector const& v)
{
    return Vector{v.get_data().cwiseSqrt()};
}
} // namespace vector_utils
} // namespace linalg
