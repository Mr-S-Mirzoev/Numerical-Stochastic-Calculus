#include "linalg/spline.h"

namespace linalg
{
namespace numeric
{
SplineFunction::SplineFunction(
    Vector const& x_vec,
    Vector const& y_vec
) : x_min(x_vec.get_data().minCoeff()),
    x_max(x_vec.get_data().maxCoeff()),
    // Spline fitting here. X values are scaled down to [0, 1] for this.
    spline_(Eigen::SplineFitting<Eigen::Spline<double, 1>>::Interpolate(
                y_vec.get_data().transpose(),
                // No more than cubic spline, but accept short vectors.
                std::min<int>(x_vec.get_data().rows() - 1, 3),
                scaled_values(x_vec.get_data()))
    )
{
}

double SplineFunction::operator()(double x) const
{
    // x values need to be scaled down in extraction as well.
    return spline_(scaled_value(x))(0);
}

Vector SplineFunction::operator()(Vector const& x) const
{
    return Vector{x.get_data().unaryExpr([this](double x) { return this->operator()(x); })};
}

double SplineFunction::scaled_value(double x) const
{
    return (x - x_min) / (x_max - x_min);
}

Eigen::RowVectorXd SplineFunction::scaled_values(Eigen::VectorXd const &x_vec) const
{
    return x_vec.unaryExpr([this](double x) { return scaled_value(x); }).transpose();
}
} // namespace numeric
} // namespace linalg
