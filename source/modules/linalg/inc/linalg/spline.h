#pragma once

#include "linalg/vector.h"

#include <Eigen/Core>
#include <unsupported/Eigen/Splines>

namespace linalg
{
namespace numeric
{
    // https://stackoverflow.com/questions/29822041/eigen-spline-interpolation-how-to-get-spline-y-value-at-arbitray-point-x
    class SplineFunction {
        // Scalar scaler for X value down to [0, 1]
        double scaled_value(double x) const;

        // Vectorized scaler for X values down to [0, 1]
        Eigen::RowVectorXd scaled_values(Eigen::VectorXd const &x_vec) const;

    public:
        SplineFunction(Vector const& x_vec, Vector const& y_vec);

        double operator()(double x) const;
        Vector operator()(Vector const& x) const;

    private:
        const double x_min;
        const double x_max;

        // Spline of one-dimensional "points."
        const Eigen::Spline<double, 1> spline_;
    };
} // namespace numeric
} // namespace linalg
