#pragma once

#include <Eigen/Core>

namespace linalg
{
    class Matrix;

    class ops;

    class Vector
    {
    private:
        Eigen::VectorXd data_;
    public:
        Vector(int n);

        double& operator()(size_t idx);
        double const& operator()(size_t idx) const;
        int size() const;

        friend class ops;
    };
} // namespace linalg

// #include "../vector_impl.h"