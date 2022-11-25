#pragma once

#include <Eigen/Core>

namespace linalg
{
    class Matrix;
    namespace numeric
    {
        class SplineFunction;
    } // namespace numeric
    

    class ops;

    class Vector
    {
    private:
        Eigen::VectorXd data_;

        Vector(Eigen::VectorXd const& data);

        Eigen::VectorXd const& get_data() const;
        Eigen::VectorXd& get_data_writable();
    public:
        Vector(int n = 0);

        double mean() const;
        double& operator()(size_t idx);
        double const& operator()(size_t idx) const;

        int size() const;
        std::vector<double> as_std_vector() const;
        Vector cumsum(bool start_with_zero = false) const;

        friend std::ostream& operator<<(std::ostream& os, const Vector& v);

        friend Vector ones(size_t size);
        friend Vector zeros(size_t size);
        friend Vector range(double begin, double end, size_t size);
        friend Vector interp(Vector const& xvals, Vector const& yvals, Vector const& x);
        friend double interp(Vector const& xvals, Vector const& yvals, double x);

        friend class numeric::SplineFunction;
        friend class ops;
    };

    std::ostream& operator<<(std::ostream& os, const Vector& v);
    Vector ones(size_t n);
    Vector zeros(size_t n);
    Vector range(double begin, double end, size_t size);
    Vector interp(Vector const& xvals, Vector const& yvals, Vector const& x);
    double interp(Vector const& xvals, Vector const& yvals, double x);
} // namespace linalg

// #include "../vector_impl.h"