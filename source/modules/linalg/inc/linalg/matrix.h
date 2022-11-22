#pragma once

#include <Eigen/Core>

namespace linalg
{
    class Vector;

    class algorithms;
    class ops;

    class Matrix
    {
    private:
        Eigen::MatrixXd data_;

        Matrix(Eigen::MatrixXd const& data);
        Eigen::MatrixXd const& get_data() const;
        Eigen::MatrixXd& get_data_writable();

    public:
        Matrix(int m, int n);

        Matrix T() const;

        // Vector& operator()(size_t row_idx);
        double& operator()(size_t row_idx, size_t col_idx);
        // Vector const& operator()(size_t row_idx) const;
        double const& operator()(size_t row_idx, size_t col_idx) const;
        std::pair<int, int> size() const;

        friend std::ostream& operator<<(std::ostream& os, const Matrix& m);

        friend Matrix ones(size_t m, size_t n);
        friend Matrix zeros(size_t m, size_t n);

        friend class algorithms;
        friend class ops;
    };

    std::ostream& operator<<(std::ostream& os, const Matrix& m);

    Matrix ones(size_t m, size_t n);
    Matrix zeros(size_t m, size_t n);
} // namespace linalg

// #include "../matrix_impl.h"