#include "rnd/random.h"

#include "linalg/algorithms.h"
#include "linalg/ops.h"

#include <random>

namespace rnd
{
linalg::Vector randn(size_t size, double mu, double sigma)
{
    std::random_device device_random_;
    std::default_random_engine generator_(device_random_());
    std::normal_distribution<> distribution_(mu, sigma);

    linalg::Vector out(size);

    for (int counter_(0); counter_ < size; ++counter_)
    {
        out(counter_) = distribution_(generator_);
    }

    return out;
}

linalg::Vector randn_std(size_t size)
{
    return randn(size, 0.0, 1.0);
}

linalg::Matrix randn(size_t size, linalg::Vector const& v, linalg::Matrix const& Q)
{
    using _op = linalg::ops;

    // Generate n-dimensional standard normal random variables using the randn() function
    linalg::Vector const& x = randn_std(size);

    // Transform to general two-dimensional standard normal random variables
    auto const& A = linalg::algorithms::cholesky(Q).T();
    return _op::sum(v, _op::mul(A, x));
}

linalg::Matrix randn_std_mat(size_t size)
{
    return randn(size, linalg::zeros(size), linalg::ones(size, size));
}
} // namespace rand
