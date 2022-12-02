#include "rnd/bm.h"
#include "rnd/random.h"

#include "linalg/vector.h"

#include <iostream>

namespace brownian_motion
{
linalg::Vector incremental_interpolation(linalg::Vector const& t, double T, std::size_t N)
{
    using namespace linalg::vector_utils;

    // Simulation of values at discrete time grid
    auto delta_t = T / N;
    auto BM = rnd::randn_std(N).cumsum(true) * sqrt(delta_t);

    // Linear interpolation
    auto t_i = linalg::range(0, T, N);
    return linalg::interp(t_i, BM, t);
}

/**
 * Function that returns the linear interpolation WInt of the values
 * \f$W_{t_ 0},W_{t_ 1},...,W_{T}\f$ with \f$t_i = i*T/N\f$ at the point \f$t \in [0, T]\f$
*/
double incremental_interpolation(double t, double T, std::size_t N)
{
    using namespace linalg::vector_utils;

    // Simulation of values at discrete time grid
    double delta_t = T / N;
    linalg::Vector BM = rnd::randn_std(N).cumsum(true) * sqrt(delta_t);

    // Linear interpolation
    linalg::Vector t_i = linalg::range(0, T, delta_t);
    return linalg::interp(t_i, BM, t);
}

linalg::Vector bridge_interpolation(linalg::Vector const& t, double T, std::size_t N)
{
    using namespace linalg::vector_utils;

    // Simulation of values at discrete time grid
    double delta_t = T / N;

    // Brownian bridge simulation

    // mean values corresponds to linear interpolation
    linalg::Vector mean = incremental_interpolation(t, T,  N);

    // Calculating variances
    // sigma_squared = (t - floor(t/DeltaT)*DeltaT) .*(ceil(t/DeltaT)*DeltaT-t)/DeltaT;
    auto sigma_squared = cmul(
        t - floor(t / delta_t) * delta_t,
        (ceil(t / delta_t) * delta_t - t) / delta_t
    );

    // W = mean + sqrt(sigma_squared) .* randn_std(t.size());
    return mean + cmul(sqrt(sigma_squared), rnd::randn_std(t.size()));
}
} // namespace brownian_motion
