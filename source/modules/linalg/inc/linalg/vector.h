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

        Vector(Eigen::VectorXd const& data);

        Eigen::VectorXd const& get_data() const;
        Eigen::VectorXd& get_data_writable();
    public:
        Vector(int n);

        double mean() const;
        double& operator()(size_t idx);
        double const& operator()(size_t idx) const;

        int size() const;

        friend std::ostream& operator<<(std::ostream& os, const Vector& v);

        friend Vector ones(size_t size);
        friend Vector zeros(size_t size);

        friend class ops;
    };

    std::ostream& operator<<(std::ostream& os, const Vector& v);
    Vector ones(size_t n);
    Vector zeros(size_t n);
} // namespace linalg

// #include "../vector_impl.h"