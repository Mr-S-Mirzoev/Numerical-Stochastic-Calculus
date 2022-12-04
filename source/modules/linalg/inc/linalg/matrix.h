#pragma once

#include <Eigen/Core>

#define M_ASSIGNMENT_OPERATOR_DEF(op, rhs_type) Matrix& operator op(rhs_type const& rhs);
#define M_OPERATOR_DEF(op, rhs_type) Matrix operator op(rhs_type const& rhs) const;

namespace linalg
{
    class Vector;

    class algorithms;
    class Vector;

    class Matrix
    {
    private:
        Eigen::MatrixXd data_;

        Matrix(Eigen::MatrixXd const& data);
        Eigen::MatrixXd const& get_data() const;
        Eigen::MatrixXd& get_data_writable();

    public:
        Matrix(int m = 0, int n = 0);

        Matrix T() const;

        double& operator()(size_t row_idx, size_t col_idx);
        double const& operator()(size_t row_idx, size_t col_idx) const;
        std::pair<int, int> size() const;

        // Arithmetical operations

        M_ASSIGNMENT_OPERATOR_DEF(+=, Matrix);
        M_ASSIGNMENT_OPERATOR_DEF(+=, Vector);
        M_ASSIGNMENT_OPERATOR_DEF(-=, Matrix);
        M_ASSIGNMENT_OPERATOR_DEF(-=, Vector);
        M_ASSIGNMENT_OPERATOR_DEF(*=, Matrix);
        M_ASSIGNMENT_OPERATOR_DEF(*=, Vector);
        M_ASSIGNMENT_OPERATOR_DEF(*=, double);

        M_OPERATOR_DEF(+, Matrix);
        M_OPERATOR_DEF(+, Vector);
        M_OPERATOR_DEF(-, Matrix);
        M_OPERATOR_DEF(-, Vector);
        M_OPERATOR_DEF(*, Matrix);
        M_OPERATOR_DEF(*, Vector);
        M_OPERATOR_DEF(*, double);

        // Output operator

        friend std::ostream& operator<<(std::ostream& os, const Matrix& m);

        // Special constructors

        friend Matrix ones(size_t m, size_t n);
        friend Matrix zeros(size_t m, size_t n);

        friend class Vector;
        friend class algorithms;
    };

    std::ostream& operator<<(std::ostream& os, const Matrix& m);

    Matrix ones(size_t m, size_t n);
    Matrix zeros(size_t m, size_t n);
} // namespace linalg
