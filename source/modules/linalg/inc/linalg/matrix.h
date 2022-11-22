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

    public:
        Matrix(int m, int n);

        Matrix T() const;

        // Vector& operator()(size_t row_idx);
        double& operator()(size_t row_idx, size_t col_idx);
        // Vector const& operator()(size_t row_idx) const;
        double const& operator()(size_t row_idx, size_t col_idx) const;
        std::pair<int, int> size() const;

        friend Matrix ones(size_t size);
        friend Matrix zeros(size_t size);

        friend class algorithms;
        friend class ops;
    };

    Matrix ones(size_t size);
    Matrix zeros(size_t size);
} // namespace linalg

// #include "../matrix_impl.h"