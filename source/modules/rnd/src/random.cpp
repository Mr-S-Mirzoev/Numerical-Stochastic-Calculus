#include "rnd/random.h"

#include "linalg/algorithms.h"

std::random_device rnd::device_random_{};

bool rnd::is_true_random()
{
    // A deterministic random number generator (e.g. a pseudo-random engine) has entropy zero.
    return rnd::device_random_.entropy() != 0;
}

int rnd::get_random_seed()
{
    return rnd::device_random_();
}

linalg::Vector rnd::randn(size_t size, double mu, double sigma)
{
    std::default_random_engine generator_(get_random_seed());
    std::normal_distribution<> distribution_(mu, sigma);

    linalg::Vector out(size);

    for (int counter_(0); counter_ < size; ++counter_)
        out(counter_) = distribution_(generator_);

    return out;
}

linalg::Vector rnd::randn_std(size_t size)
{
    return randn(size, 0.0, 1.0);
}

linalg::Matrix rnd::randn(size_t size, linalg::Vector const& v, linalg::Matrix const& Q)
{
    /**
     * Affine linear transformations of the normal distribution
     * \f$(\Omega,\mathcal{A}, P)\f$ be a probability space, let \f$d, m \in \mathbb{N}, v \in R^m, b \in R^d\f$
     * \f$A \in R^{d,m} \f$, let
     * \f$Q \in R^{m,m}\f$ be a nonnegative symmetric m × m-matrix, and let
     * \f$X : \Omega \to R^m\f$ be an \f$N_{\nu,Q}\f$ - distributed random variable. Then the random variable
     * \f$ (\omega \in \Omega) \to  A X(ω) + b \in R^d\f$ is \f$N_{A v + b, A Q A^{T}}\f$ -distributed.
    */

    // The idea is to apply affine linear transform to N standard normal r.v.s which
    // are by definition a n-dimensional standard normal random variable.
    // So by defining \f$Q_ = I_n\f$, and performing Cholesky transform to
    // original \f$Q = A * A^{T}\f$, setting \f$b = 0\f$ we get
    // a \f$N_{v, Q}\f$ -distributed r,v,

    // Generate n-dimensional standard normal random variable using the randn_std() function
    linalg::Vector const& x = randn_std(size);

    // Transform to general two-dimensional standard normal random variables
    auto const& A = linalg::algorithms::cholesky(Q).T();
    return A * x + v;
}

linalg::Vector rnd::poisson(size_t size, double mean)
{
    std::default_random_engine generator_(get_random_seed());
    std::poisson_distribution<int> distribution_(mean);

    linalg::Vector out(size);

    for (int counter_(0); counter_ < size; ++counter_)
        out(counter_) = distribution_(generator_);

    return out;
}
