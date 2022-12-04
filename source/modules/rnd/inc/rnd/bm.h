#pragma once

#include "linalg/vector.h"

namespace brownian_motion
{
    /**
     * Function that returns the linear interpolation WInt of the values
     * \f$W_{t_ 0},W_{t_ 1},...,W_{T}\f$ with \f$t_i = i*T/N\f$ at the vector t
    */
    linalg::Vector incremental_interpolation(linalg::Vector const& t, double T, std::size_t N);

    /**
     * [NOT RECOMENDED FOR USE] Prefer vectorised version
     * Function that returns the linear interpolation WInt of the values
     * \f$W_{t_ 0},W_{t_ 1},...,W_{T}\f$ with \f$t_i = i*T/N\f$ at the point \f$t \in [0, T]\f$
    */
    double incremental_interpolation(double t, double T, std::size_t N);

    /**
     * Function that returns the bridge interpolation W_t of the values
     * \f$W_{t_ 0},W_{t_ 1},...,W_{T}\f$ with \f$t_i = i*T/N\f$ at the vector t
    */
    linalg::Vector bridge_interpolation(linalg::Vector const& t, double T, std::size_t N);
} // namespace brownian_motion
