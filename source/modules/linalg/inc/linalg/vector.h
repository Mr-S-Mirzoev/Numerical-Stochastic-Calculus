#pragma once

#include <Eigen/Core>

#define V_ASSIGNMENT_OPERATOR_DEF(op, rhs_type) Vector& operator op(rhs_type const& rhs);
#define V_OPERATOR_DEF(op, rhs_type) Vector operator op(rhs_type const& rhs) const;

namespace linalg
{
    // Forward declarations

    class Matrix;
    class Vector;

    namespace numeric
    {
        class SplineFunction;
    } // namespace numeric

    namespace vector_utils
    {
        Vector cmul(Vector const& lhs, Vector const& rhs);
        Vector floor(Vector const& v);
        Vector ceil(Vector const& v);
        Vector sqrt(Vector const& v);
    } // namespace vector_utils

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

        // Converters

        std::vector<double> as_std_vector() const;
        Matrix as_mat() const;

        // Arithmetical operations

        V_ASSIGNMENT_OPERATOR_DEF(+=, Vector);
        V_ASSIGNMENT_OPERATOR_DEF(-=, Vector);
        V_ASSIGNMENT_OPERATOR_DEF(*=, double);
        V_ASSIGNMENT_OPERATOR_DEF(/=, double);

        V_OPERATOR_DEF(+, Vector);
        V_OPERATOR_DEF(-, Vector);
        V_OPERATOR_DEF(*, double);
        V_OPERATOR_DEF(/, double);

        Vector cumsum(bool start_with_zero = false) const;

        friend std::ostream& operator<<(std::ostream& os, const Vector& v);

        // Custom constructors

        friend Vector ones(size_t size);
        friend Vector zeros(size_t size);

        // Utility functions

        friend Vector range(double begin, double end, size_t size);

        // Interpolation utils

        friend Vector interp(Vector const& xvals, Vector const& yvals, Vector const& x);
        friend double interp(Vector const& xvals, Vector const& yvals, double x);

        // Linear algebra utilities

        friend Vector vector_utils::cmul(Vector const& lhs, Vector const& rhs);
        friend Vector vector_utils::floor(Vector const& v);
        friend Vector vector_utils::ceil(Vector const& v);
        friend Vector vector_utils::sqrt(Vector const& v);

        friend class numeric::SplineFunction;
        friend class Matrix;
    };

    std::ostream& operator<<(std::ostream& os, const Vector& v);
    Vector ones(size_t n);
    Vector zeros(size_t n);
    Vector range(double begin, double end, size_t size);

    Vector interp(Vector const& xvals, Vector const& yvals, Vector const& x);
    double interp(Vector const& xvals, Vector const& yvals, double x);
} // namespace linalg
