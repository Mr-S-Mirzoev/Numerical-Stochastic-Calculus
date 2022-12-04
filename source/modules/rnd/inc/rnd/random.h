#pragma once

#include "linalg/matrix.h"
#include "linalg/vector.h"

#include <random>

class rnd
{
    static std::random_device device_random_;
public:
    /**
     * returns if seeds are trully random
     * i.e. utilises random number generating
     * device, not pseudo-random number generator
    */
    static bool is_true_random();

    /**
     * returns a trully random seed, if possible
    */
    static int get_random_seed();

    /**
     * n-sized normal distribution with parameters (mu, sigma)
    */
    static linalg::Vector randn(size_t size, double mu, double sigma);

    /**
     * n-sized standard normal distribution
    */
    static linalg::Vector randn_std(size_t size);

    /**
     * \f$N_{v, Q}\f$ -distributed r.v.
    */
    static linalg::Matrix randn(size_t size, linalg::Vector const& v, linalg::Matrix const& Q);

    /**
     * n-sized poisson distribution with parameter (mu)
    */
    static linalg::Vector poisson(size_t size, double mean);
}; // class rnd
