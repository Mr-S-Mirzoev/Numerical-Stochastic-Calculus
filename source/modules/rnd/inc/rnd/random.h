#pragma once

#include "linalg/matrix.h"
#include "linalg/vector.h"

namespace rnd
{
    linalg::Vector randn(size_t size, double mu, double sigma);

    linalg::Vector randn_std(size_t size);

    linalg::Matrix randn(size_t size, linalg::Matrix const& Q);

    linalg::Matrix randn_std_mat(size_t size);
} // namespace rand
